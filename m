From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] Add --author and --committer match to rev-list and
 rev-tree.
Date: Sat, 14 May 2005 21:57:47 -0700
Message-ID: <7vk6m1xf04.fsf@assigned-by-dhcp.cox.net>
References: <7vpsvu2ksd.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 15 06:58:37 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DXBD1-0003It-EY
	for gcvg-git@gmane.org; Sun, 15 May 2005 06:58:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261469AbVEOE6k (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 15 May 2005 00:58:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261487AbVEOE6k
	(ORCPT <rfc822;git-outgoing>); Sun, 15 May 2005 00:58:40 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:30657 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S261469AbVEOE5t (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 May 2005 00:57:49 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050515045747.QCML12158.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 15 May 2005 00:57:47 -0400
To: pasky@ucw.cz, torvalds@osdl.org
In-Reply-To: <7vpsvu2ksd.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
 message of "Sat, 14 May 2005 02:56:18 -0700")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Zack Brown wondered if handling author match at core GIT level
would make cg-log -u go faster (JIT also can use this in jit-log
--author).  Later Peter Baudis wanted to have --committer match
similar to it.

This version is improved from the one I posted to GIT list
earlier in that:

 (1) I bit the bullet and added author and committer names to
     the commit object, so there is no double unpacking anymore.
     The strings are shared across multiple commits so consider
     them intern'ed and do not free them.

 (2) Determination of if author and committer names are
     "interesting" is done only once per name, not per commit.
     This version uses simple "substring" logic, but it is
     easily extendable for more interesting match such as
     regexps.

This also fixes documentation of git-rev-list which did not
describe its already existing options.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

*** The previous round that has not been merged to git-pb should
*** be discarded.  This is a patch against the tip of git-pb as
*** of this writing.

Documentation/git-rev-list.txt    |   19 +++++
Documentation/git-rev-tree.txt    |    8 +-
commit.c                          |  135 +++++++++++++++++++++++++++++++++-----
commit.h                          |   18 ++++-
rev-list.c                        |   18 ++++-
rev-tree.c                        |   27 +++++++
t/t6010-rev-tree-author-commit.sh |   98 +++++++++++++++++++++++++++
t/t6110-rev-list-author-commit.sh |   97 +++++++++++++++++++++++++++
8 files changed, 396 insertions(+), 24 deletions(-)
t/t6010-rev-tree-author-commit.sh (. --> 100755)
t/t6110-rev-list-author-commit.sh (. --> 100755)

--- a/Documentation/git-rev-list.txt
+++ b/Documentation/git-rev-list.txt
@@ -9,7 +9,7 @@
 
 SYNOPSIS
 --------
-'git-rev-list' <commit>
+'git-rev-list' [--author=author] [--committer=committer] [--max-count=count] [--max-age=unixtime] [--min-age=unixtime] <commit>
 
 DESCRIPTION
 -----------
@@ -18,6 +18,23 @@
 useful to produce human-readable log output.
 
 
+OPTIONS
+-------
+--author::
+	Limit the final output to commits written by the author.
+
+--committer::
+	Limit the final output to commits committed by the author.
+
+--max-count::
+	Stop after showing the specified number of commits.
+
+--max-age::
+	Stop before showing the commits older than specified time.
+
+--min-age::
+	Do not show the commits newer than specified time.
+
 Author
 ------
 Written by Linus Torvalds <torvalds@osdl.org>
--- a/Documentation/git-rev-tree.txt
+++ b/Documentation/git-rev-tree.txt
@@ -9,7 +9,7 @@
 
 SYNOPSIS
 --------
-'git-rev-tree' [--edges] [--cache <cache-file>] [^]<commit> [[^]<commit>]
+'git-rev-tree' [--author author] [--committer committer] [--edges] [--cache <cache-file>] [^]<commit> [[^]<commit>]
 
 DESCRIPTION
 -----------
@@ -17,6 +17,12 @@
 
 OPTIONS
 -------
+--author::
+	Limit the final output to commits written by the author.
+
+--committer::
+	Limit the final output to commits committed by the author.
+
 --edges::
 	Show edges (ie places where the marking changes between parent
 	and child)
--- a/commit.c
+++ b/commit.c
@@ -23,22 +23,111 @@
 	return (struct commit *) obj;
 }
 
-static unsigned long parse_commit_date(const char *buf)
-{
-	unsigned long date;
+static struct person_name **person_name;
+static int person_nr;
+static int person_alloc;
+
+static const char *interesting_author = NULL;
+static const char *interesting_committer = NULL;
+
+void commit_author_committer_match_initialize(const char *author,
+					      const char *committer)
+{
+	interesting_author = author;
+	interesting_committer = committer;
+}
+
+static int person_name_pos(const char *name)
+{
+	int first, last;
+
+	first = 0;
+	last = person_nr;
+	while (last > first) {
+		int next = (last + first) >> 1;
+		struct person_name *pn = person_name[next];
+		int cmp = strcmp(name, pn->name);
+		if (!cmp)
+			return next;
+		if (cmp < 0) {
+			last = next;
+			continue;
+		}
+		first = next+1;
+	}
+	return -first-1;
+}
 
-	if (memcmp(buf, "author", 6))
-		return 0;
-	while (*buf++ != '\n')
-		/* nada */;
-	if (memcmp(buf, "committer", 9))
-		return 0;
-	while (*buf++ != '>')
-		/* nada */;
-	date = strtoul(buf, NULL, 10);
-	if (date == ULONG_MAX)
-		date = 0;
-	return date;
+#define INTERESTING_AUTHOR    01
+#define INTERESTING_COMMITTER 02
+
+static struct person_name *person_name_lookup(const char *name)
+{
+	int pos = person_name_pos(name);
+	struct person_name *pn; 
+	if (0 <= pos)
+		return person_name[pos];
+	pos = -pos-1;
+	pn = xmalloc(sizeof(*pn) + strlen(name) + 1);
+	strcpy(pn->name, name);
+	pn->mark = 0;
+
+	/*
+	 * When we decide we want to go fancier, strstr() below
+	 * can be replaced with something like regexp match to
+	 * pick up more than one author or committer.  For now
+	 * let's try simple substring find and see what happens.
+	 * Note that not specifying anybody means we are interested
+	 * in everybody.
+	 */
+	if (!interesting_author || strstr(name, interesting_author))
+		pn->mark |= INTERESTING_AUTHOR;
+	if (!interesting_committer || strstr(name, interesting_committer))
+		pn->mark |= INTERESTING_COMMITTER;
+
+	if (person_nr == person_alloc) {
+		person_alloc = alloc_nr(person_alloc);
+		person_name = xrealloc(person_name, person_alloc *
+				       sizeof(struct person_name *));
+	}
+	person_nr++;
+	if (pos < person_nr)
+		memmove(person_name + pos + 1, person_name + pos,
+			(person_nr - pos - 1) * sizeof(pn));
+	person_name[pos] = pn;
+	return pn;
+}
+
+static void *parse_commit_nametime(char *ptr, const char *ep,
+				   const char *field,
+				   unsigned long *date,
+				   struct person_name **name)
+{
+	unsigned long d;
+	char *cp;
+	int fldlen = strlen(field);
+	if (ptr == NULL || memcmp(ptr, field, fldlen) || ptr[fldlen] != ' ') {
+		*date = 0;
+		*name = NULL;
+		return NULL; /* malformed commit */
+	}
+	for (cp = ptr + fldlen + 1; cp < ep && *cp != '>'; cp++)
+		; /* skip */
+	if (*cp != '>' || *++cp != ' ') {
+		*date = 0;
+		*name = NULL;
+		return NULL; /* malformed commit */
+	}
+	*cp = 0;
+	*name = person_name_lookup(ptr + fldlen + 1);
+	*cp++ = ' ';
+	d = strtoul(cp, NULL, 10);
+	if (d == ULONG_MAX)
+		d = 0;
+	*date = d;
+	while (cp < ep && *cp++ != '\n')
+		; /* skip */
+	return cp;
 }
 
 int parse_commit_buffer(struct commit *item, void *buffer, unsigned long size)
@@ -63,7 +152,13 @@
 		}
 		bufptr += 48;
 	}
-	item->date = parse_commit_date(bufptr);
+	
+	bufptr = parse_commit_nametime(bufptr, (char *)buffer + size,
+				       "author", &item->author_date,
+				       &item->author);
+	parse_commit_nametime(bufptr, (char *)buffer + size,
+			      "committer", &item->date,
+			      &item->committer);
 	return 0;
 }
 
@@ -152,3 +247,11 @@
 	}
 	return ret;
 }
+
+int commit_author_committer_match(struct commit *item)
+{
+	return ( ((item->author != NULL) &&
+		  (item->author->mark & INTERESTING_AUTHOR)) &&
+		 ((item->committer != NULL) &&
+		  (item->committer->mark & INTERESTING_COMMITTER)) );
+}
--- a/commit.h
+++ b/commit.h
@@ -11,8 +11,9 @@
 
 struct commit {
 	struct object object;
-	unsigned long date;
+	unsigned long author_date, date;
 	struct commit_list *parents;
+	struct person_name *author, *committer; 
 	struct tree *tree;
 };
 
@@ -36,4 +37,19 @@
 struct commit *pop_most_recent_commit(struct commit_list **list, 
 				      unsigned int mark);
 
+struct person_name {
+	char mark;
+	char name[0];
+};
+
+/* This function must be called before fetching any commit object
+ * if commit-author-committer-match function is to be used to filter
+ * commits for output.  Passing NULL is permitted, which makes all
+ * authors (or committers) "interesting".
+ */
+void commit_author_committer_match_initialize(const char *, const char *);
+
+/* Returns true only if author and committer are "interesting". */
+int commit_author_committer_match(struct commit *);
+
 #endif /* COMMIT_H */
--- a/rev-list.c
+++ b/rev-list.c
@@ -11,6 +11,8 @@
 	unsigned long max_age = -1;
 	unsigned long min_age = -1;
 	int max_count = -1;
+	const char *author = NULL;
+	const char *committer = NULL;
 
 	for (i = 1 ; i < argc; i++) {
 		char *arg = argv[i];
@@ -21,6 +23,10 @@
 			max_age = atoi(arg + 10);
 		} else if (!strncmp(arg, "--min-age=", 10)) {
 			min_age = atoi(arg + 10);
+		} else if (!strncmp(arg, "--author=", 9)) {
+			author = arg + 9;
+		} else if (!strncmp(arg, "--committer=", 12)) {
+			committer = arg + 12;
 		} else {
 			commit_arg = arg;
 		}
@@ -28,9 +34,13 @@
 
 	if (!commit_arg || get_sha1(commit_arg, sha1))
 		usage("usage: rev-list [OPTION] commit-id\n"
-		      "  --max-count=nr\n"
-		      "  --max-age=epoch\n"
-		      "  --min-age=epoch\n");
+		      "  --author=author\n"
+		      "  --committer=committer\n"
+		      "  --max-count=number\n"
+		      "  --max-age=unixtime\n"
+		      "  --min-age=unixtime\n");
+
+	commit_author_committer_match_initialize(author, committer);
 
 	commit = lookup_commit(sha1);
 	if (!commit || parse_commit(commit) < 0)
@@ -44,6 +54,8 @@
 			continue;
 		if (max_age != -1 && (commit->date < max_age))
 			break;
+		if (!commit_author_committer_match(commit))
+			continue;
 		if (max_count != -1 && !max_count--)
 			break;
 		printf("%s\n", sha1_to_hex(commit->object.sha1));
--- a/rev-tree.c
+++ b/rev-tree.c
@@ -64,7 +64,7 @@
 }
 
 /*
- * Usage: rev-tree [--edges] [--cache <cache-file>] <commit-id> [<commit-id2>]
+ * Usage: rev-tree [--edges] [--author <author>] [--cache <cache-file>] <commit-id> [<commit-id2>]
  *
  * The cache-file can be quite important for big trees. This is an
  * expensive operation if you have to walk the whole chain of
@@ -75,6 +75,9 @@
 	int i;
 	int nr = 0;
 	unsigned char sha1[MAX_COMMITS][20];
+	const char *author = NULL; 
+	const char *committer = NULL;
+	int initialized_author_commiter = 0;
 
 	/*
 	 * First - pick up all the revisions we can (both from
@@ -83,6 +86,16 @@
 	for (i = 1; i < argc ; i++) {
 		char *arg = argv[i];
 
+		if (!strcmp(arg, "--author")) {
+			author = argv[++i];
+			continue;
+		}
+
+		if (!strcmp(arg, "--committer")) {
+			committer = argv[++i];
+			continue;
+		}
+
 		if (!strcmp(arg, "--cache")) {
 			read_cache_file(argv[++i]);
 			continue;
@@ -98,7 +111,14 @@
 			basemask |= 1<<nr;
 		}
 		if (nr >= MAX_COMMITS || get_sha1(arg, sha1[nr]))
-			usage("rev-tree [--edges] [--cache <cache-file>] <commit-id> [<commit-id>]");
+			usage("rev-tree [--edges] [--author <author>] [--committer <committer>] [--cache <cache-file>] <commit-id> [<commit-id>]");
+
+		if (!initialized_author_commiter) {
+			commit_author_committer_match_initialize(author,
+								 committer);
+			initialized_author_commiter = 1;
+		}
+
 		process_commit(sha1[nr]);
 		nr++;
 	}
@@ -125,6 +145,9 @@
 		if (!interesting(commit))
 			continue;
 
+		if (!commit_author_committer_match(commit))
+			continue;
+
 		printf("%lu %s:%d", commit->date, sha1_to_hex(obj->sha1), 
 		       obj->flags);
 		p = commit->parents;
--- a/t/t6010-rev-tree-author-commit.sh
+++ b/t/t6010-rev-tree-author-commit.sh
@@ -0,0 +1,98 @@
+#!/bin/sh
+#
+# Copyright (c) 2005 Junio C Hamano
+#
+
+test_description='git-rev-tree --author and --committer flags.
+'
+
+. ./test-lib.sh
+
+export_them () {
+export GIT_AUTHOR_NAME GIT_AUTHOR_EMAIL GIT_COMMITTER_NAME GIT_COMMITTER_EMAIL
+}
+
+set_author_zero () {
+    GIT_AUTHOR_NAME="A U Thor" &&
+    GIT_AUTHOR_EMAIL="<author@example.xz>"
+}
+set_author_one () {
+    GIT_AUTHOR_NAME="R O Htua" &&
+    GIT_AUTHOR_EMAIL="<rohtua@example.xz>"
+}
+set_committer_zero () {
+    GIT_COMMITTER_NAME="C O Mmitter" &&
+    GIT_COMMITTER_EMAIL="<committer@example.xz>"
+}
+set_committer_one () {
+    GIT_COMMITTER_NAME="R E Ttimmoc" &&
+    GIT_COMMITTER_EMAIL="<rettimmoc@example.xz>"
+}
+
+# read rev-tree output, and find the author|committer of commit object
+pick_actor () {
+    sed -e 's/^[^ ]* //;s/:.*//' |
+    xargs -r -n1 git-cat-file commit |
+    sed -ne 's/^\('"$1"'\) \([^>]*>\).*/\2/p'
+}
+
+test_expect_success \
+    'preparation' '
+echo frotz >path0 &&
+git-update-cache --add path0 &&
+tree0=$(git-write-tree) &&
+
+set_author_zero &&
+set_committer_zero &&
+export_them &&
+commit0=$(echo frotz | git-commit-tree $tree0) &&
+
+set_author_zero &&
+set_committer_one &&
+export_them &&
+commit1=$(echo frotz | git-commit-tree $tree0 -p $commit0) &&
+
+set_author_one &&
+set_committer_zero &&
+export_them &&
+commit2=$(echo frotz | git-commit-tree $tree0 -p $commit1) &&
+
+set_author_one &&
+set_committer_one &&
+export_them &&
+commit3=$(echo frotz | git-commit-tree $tree0 -p $commit2)'
+
+test_expect_success \
+    'without restriction git-rev-tree should report all four commits.' \
+    'test $(git-rev-tree $commit3 | wc -l) == 4'
+
+test_expect_success \
+    'limiting to A U Thor (two commits)' '
+    case "$(git-rev-tree --author "A U Thor" $commit3 |
+          pick_actor "author" | sort -u)" in
+    "A U Thor <author@example.xz>") : ;;
+    *) (exit 1) ;;
+    esac'
+
+test_expect_success \
+    'limiting to R E Ttimmoc (two commits)' '
+    case "$(git-rev-tree --committer "R E Ttimmoc" $commit3 |
+          pick_actor "committer" | sort -u)" in
+    "R E Ttimmoc <rettimmoc@example.xz>") : ;;
+    *) (exit 1) ;;
+    esac'
+
+LF='
+'
+
+test_expect_success \
+    'limiting to A U Thor and C O Mmitter (one commit)' '
+    case "$(git-rev-tree --author "A U Thor" --committer "C O Mmitter" \
+            $commit3 | pick_actor "committer\\|author" | sort -u)" in
+    "A U Thor <author@example.xz>${LF}C O Mmitter <committer@example.xz>")
+        : ;;
+    *) (exit 1) ;;
+    esac
+'
+
+test_done
--- a/t/t6110-rev-list-author-commit.sh
+++ b/t/t6110-rev-list-author-commit.sh
@@ -0,0 +1,97 @@
+#!/bin/sh
+#
+# Copyright (c) 2005 Junio C Hamano
+#
+
+test_description='git-rev-list --author and --committer flags.
+'
+
+. ./test-lib.sh
+
+export_them () {
+export GIT_AUTHOR_NAME GIT_AUTHOR_EMAIL GIT_COMMITTER_NAME GIT_COMMITTER_EMAIL
+}
+
+set_author_zero () {
+    GIT_AUTHOR_NAME="A U Thor" &&
+    GIT_AUTHOR_EMAIL="<author@example.xz>"
+}
+set_author_one () {
+    GIT_AUTHOR_NAME="R O Htua" &&
+    GIT_AUTHOR_EMAIL="<rohtua@example.xz>"
+}
+set_committer_zero () {
+    GIT_COMMITTER_NAME="C O Mmitter" &&
+    GIT_COMMITTER_EMAIL="<committer@example.xz>"
+}
+set_committer_one () {
+    GIT_COMMITTER_NAME="R E Ttimmoc" &&
+    GIT_COMMITTER_EMAIL="<rettimmoc@example.xz>"
+}
+
+# read rev-list output, and find the author|committer of commit object
+pick_actor () {
+    xargs -r -n1 git-cat-file commit |
+    sed -ne 's/^\('"$1"'\) \([^>]*>\).*/\2/p'
+}
+
+test_expect_success \
+    'preparation' '
+echo frotz >path0 &&
+git-update-cache --add path0 &&
+tree0=$(git-write-tree) &&
+
+set_author_zero &&
+set_committer_zero &&
+export_them &&
+commit0=$(echo frotz | git-commit-tree $tree0) &&
+
+set_author_zero &&
+set_committer_one &&
+export_them &&
+commit1=$(echo frotz | git-commit-tree $tree0 -p $commit0) &&
+
+set_author_one &&
+set_committer_zero &&
+export_them &&
+commit2=$(echo frotz | git-commit-tree $tree0 -p $commit1) &&
+
+set_author_one &&
+set_committer_one &&
+export_them &&
+commit3=$(echo frotz | git-commit-tree $tree0 -p $commit2)'
+
+test_expect_success \
+    'without restriction git-rev-tree should report all four commits.' \
+    'test $(git-rev-list $commit3 | wc -l) == 4'
+
+test_expect_success \
+    'limiting to A U Thor (two commits)' '
+    case "$(git-rev-list --author="A U Thor" $commit3 |
+          pick_actor "author" | sort -u)" in
+    "A U Thor <author@example.xz>") : ;;
+    *) (exit 1) ;;
+    esac'
+
+test_expect_success \
+    'limiting to R E Ttimmoc (two commits)' '
+    case "$(git-rev-list --committer="R E Ttimmoc" $commit3 |
+          pick_actor "committer" | sort -u)" in
+    "R E Ttimmoc <rettimmoc@example.xz>") : ;;
+    *) (exit 1) ;;
+    esac'
+
+LF='
+'
+
+test_expect_success \
+    'limiting to A U Thor and C O Mmitter (one commit)' '
+    case "$(git-rev-list --author="A U Thor" --committer="C O Mmitter" \
+            $commit3 | pick_actor "committer\\|author" | sort -u)" in
+    "A U Thor <author@example.xz>${LF}C O Mmitter <committer@example.xz>")
+        : ;;
+    *) (exit 1) ;;
+    esac
+'
+
+test_done
------------------------------------------------

