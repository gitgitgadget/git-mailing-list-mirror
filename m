From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH] Add support for author-oriented git-rev-list switches [rev 10]
Date: Fri, 10 Jun 2005 13:35:04 +1000
Message-ID: <20050610033504.9452.qmail@blackcubes.dyndns.org>
Cc: jon.seymour@gmail.com
X-From: git-owner@vger.kernel.org Fri Jun 10 05:35:02 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DgaIO-0002iK-9B
	for gcvg-git@gmane.org; Fri, 10 Jun 2005 05:35:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262425AbVFJDjB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 9 Jun 2005 23:39:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262417AbVFJDjB
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Jun 2005 23:39:01 -0400
Received: from 203-166-247-224.dyn.iinet.net.au ([203.166.247.224]:23680 "HELO
	blackcubes.dyndns.org") by vger.kernel.org with SMTP
	id S262425AbVFJDfJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Jun 2005 23:35:09 -0400
Received: (qmail 9462 invoked by uid 500); 10 Jun 2005 03:35:04 -0000
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


This patch is a complete replacement for the previous --wrt 
and --wrt-author patches; it adds support for --wrt-author, 
--prune-at-author and --author switches to git-rev-list.

These switches perform various sorting and filtering operations that
help any git user reconstruct a linear view of merge history from 
the point of view of any given change author.

When --wrt-author is specified, --merge-order is implied but 
the linearisation of non-linear epochs is adjusted so that branches
contributed to by the author sort after branches contributed to by
others. This has the effect of presenting a linear history of changes as seen
by the author's own workspace.

For example, given this commit history:

a4 ---
| \   \
|  b4 |
|/ |  |
a3 |  |
|  |  |
a2 |  |
|  |  c3
|  |  |
|  |  c2
|  b3 |
|  | /|
|  b2 |
|  |  c1
|  | /
|  b1    <-- commit authored by author@domain
a1 |
|  |
a0 |
| /
root

--merge-order alone would sort it as follows:

= a4
| c3
| c2
| c1
^ b4
| b3
| b2
| b1
^ a3
| a2
| a1
| a0
= root

however, with --wrt-author --author=author@domain, git-rev-list sorts as follows:

= a4
| c3
| c2
| c1
^ b4
| a3
| a2
| a1
| a0
^ b3
| b2
| b1
= root

This has the effect of showing the first 3 of author@domain's changes 
occuring before any of the changes in other branches. This is the 
order in which author@domain perceived change occurring - changes 
a0->a3 weren't visible in author@domain's workspace until the merge at b4.

If --prune-at-author is specified, then git-rev-list behaves as if a 
^argument had been added for each commit authored by the author.

The --prune-at-author option allows an author to see a brief summary of 
changes since they last made a contribution to the commit graph. For example:

      git-rev-list --prune-at-author --pretty HEAD 

To configure which author git-rev-list uses when processing the --wrt-author 
and --prune-at-author switches, use the --author=author@domain option. If this 
option is not specified, git-rev-list uses GIT_AUTHOR_EMAIL or a value
derived from the local user, host and domain names 
(per git-commit-tree's algorithm)

To support this change, some additional functions were added to commit.c to 
allow the extraction of author from the commit header.

Also, --show-breaks, like --wrt-author now implies --merge-order rather than 
requires it.

This change also updates Documentation/git-rev-list.txt to include 
documentation for --wrt-author and other git-rev-list options not currently 
documented.

A test case has been included in t/t6001-rev-list-merge-order.sh to 
verify this change works as expected.

Use of --wrt-author implies a small overhead (linear with respect to nodes 
printed) compared with --merge-order.

This change extracts real email id formatting functions from commit-tree.c 
into user.c and user.h.

Signed-off-by: Jon Seymour <jon.seymour@gmail.com>

---

NOTE TO REVIEWERS: please pay special attention to get_real_identity() 
which was extracted from commit-tree.c and placed into user.c. It was 
essentially a cut and paste, but since this has the potential to affect the 
operation of git-commit-tree, it would be worth being very careful about 
checking this change.

[rev 1]   * original patch
[rev 2-4] * various cleanups
[rev 5]   * --merge-order bug fixes already merged with Linus.
[rev 6]   * remerged with Linus' head (98a96b00b88ee35866cd0b1e94697db76bd5ddf9)
          * changed name of --exclude-author switch to --prune-at-author
	  * reformatted to be more consistent with preferred coding style, namely:
	        * aggressive elimination of intra-block blank lines
                  except immediately after declarations
                * declarations at top of block
                * one statement blocks without braces
                * everything except first line of function declaration 
                  wrapped at <= 80 columns
          * [ undone in rev 8 ] modified test cases to use /dev/urandom to get 
	    some entropy for commit text so that closely spaced commits aren't identical
          * added struct epoch_methods to gather 3 function pointers now used
            by merge order logic
          * added a comment to commit.c to indicate that epoch.c is assuming
            that parse_commit stacks parents read from the commit header
            rather than queues them
[rev 7]   * further whitespace and style edits
[rev 8]   * d'oh - don't need /dev/urandom at all - re-written and simplified
            test cases
[rev 9]   * oops, missed some whitespace in my commit.c edits - begone!
          * slight change to semantics of --prune-at-author - includes the
            author changes, but prunes the parents of the author. This helps put
            the cut points into some kind of context when the author has contributions
            in multiple branches.
[rev 10]  * added a function to commit.c to make dependency on commit header order
            explicit. now if parse_commit changes, any caller who uses copy_parents_in_header_order
            won't need to change provided copy_parents_in_header_order is updated appropriately.
          * simplified sort_first_epoch by putting termination tests near top
          * changed sort_list_in_local_last_order to sort_list_in_local_first_order
            and made the code more concise
          * added some more tests to check behaviour on degenerate graphs on 1,2 or 3 nodes.

This revision [rev 10] reposted to the list because the changes since [rev 6], particularly in [rev 9, 10]
have been non-trivial. 

Diverged from 98a96b00b88ee35866cd0b1e94697db76bd5ddf9 by Linus Torvalds <torvalds@ppc970.osdl.org>

diff --git a/Documentation/git-rev-list.txt b/Documentation/git-rev-list.txt
--- a/Documentation/git-rev-list.txt
+++ b/Documentation/git-rev-list.txt
@@ -9,65 +9,114 @@ git-rev-list - Lists commit objects in r
 
 SYNOPSIS
 --------
-'git-rev-list' [ *--max-count*=number ] [ *--max-age*=timestamp ] [ *--min-age*=timestamp ] [ *--merge-order* [ *--show-breaks* ] ] <commit>
+'git-rev-list' [ *--max-count*=number ] [ *--max-age*=timestamp ] 
+[ *--min-age*=timestamp ] [ *--pretty* ] [ *--parents* ] [ *--header* ] 
+[ *--merge-order* ] [ *--show-breaks* ] [ *--wrt-author* ] 
+[ *--prune-at-author* ] [ *--author=author@domain* ]  
+<head-to-include> <head-to-include> ... 
+^<base-to-prune> 
+^<base-to-prune> ...
 
 DESCRIPTION
 -----------
-Lists commit objects in reverse chronological order starting at the
-given commit, taking ancestry relationship into account.  This is
-useful to produce human-readable log output.
-
-If *--merge-order* is specified, the commit history is decomposed into a
-unique sequence of minimal, non-linear epochs and maximal, linear epochs.
-Non-linear epochs are then linearised by sorting them into merge order, which
+
+Lists commit objects in reverse chronological order starting at the commits 
+specified by head-to-include values, taking ancestry relationship into account.  
+git-rev-list will not print any commits that are reachable by any of the 
+base-to-prune values. 
+
+If *--max-count* is specified, the number of commits output is 
+limited to the number specified.
+
+If *--max-age* is specified, commits older than the date specified 
+(in seconds since Jan 1, 1970) are excluded from the output.
+
+If *--min-age* is specified, commits younger than the date specified 
+(in seconds since Jan 1, 1970) are excluded from the output.
+
+If *--pretty* is specified, git-rev-list prints a short summary of each 
+commit on stdout. This can be usefully parsed by git-shortlog to produce a 
+short log of changes.
+
+If *--parents* is specified, git-rev-list prints a space separated list 
+of parents on the same line as the commit identifier.
+
+If *--header* is specified, git-rev-list prints to stdout, on lines after 
+the identifier of each commit, the contents of the commit's header followed by 
+a trailing NUL.
+
+If *--merge-order* is specified, the commit history is decomposed into a 
+unique sequence of minimal, non-linear epochs and maximal, linear epochs. 
+Non-linear epochs are then linearised by sorting them into merge order, which 
 is described below.
 
-Maximal, linear epochs correspond to periods of sequential development.
-Minimal, non-linear epochs correspond to periods of divergent development
-followed by a converging merge. The theory of epochs is described in more
-detail at
+Maximal, linear epochs correspond to periods of sequential development. 
+Minimal, non-linear epochs correspond to periods of divergent development 
+followed by a converging merge. The theory of epochs is described in more 
+detail at 
 link:http://blackcubes.dyndns.org/epoch/[http://blackcubes.dyndns.org/epoch/].
 
-The merge order for a non-linear epoch is defined as a linearisation for which
-the following invariants are true:
-
-    1. if a commit P is reachable from commit N, commit P sorts after commit N
-       in the linearised list.
-    2. if Pi and Pj are any two parents of a merge M (with i < j), then any
-       commit N, such that N is reachable from Pj but not reachable from Pi,
-       sorts before all commits reachable from Pi.
-
-Invariant 1 states that later commits appear before earlier commits they are
-derived from.
+The merge order for a non-linear epoch is defined as a linearisation for 
+which the following invariants are true:
 
-Invariant 2 states that commits unique to "later" parents in a merge, appear
-before all commits from "earlier" parents of a merge.
+    1. if a commit P is reachable from commit N, commit P sorts after 
+       commit N in the linearised list.
+    2. if Pi and Pj are any two parents of a merge M (with i < j), then 
+       any commit N, such that N is reachable from Pj but not reachable from 
+       Pi, sorts before all commits reachable from Pi.
+   
+Invariant 1 states that later commits appear before earlier commits 
+they are derived from.
+
+Invariant 2 states that commits unique to "later" parents in a merge, 
+appear before all commits from "earlier" parents of a merge.
+
+If *--show-breaks* is specified, each item of the list is output with a 
+2-character prefix consisting of one of:  (|), (^), (=) followed by a space. 
+ 
+Commits marked with (=) represent the boundaries of minimal, non-linear 
+epochs and correspond either to the start of a period of divergent development 
+or to the end of such a period. 
 
-If *--show-breaks* is specified, each item of the list is output with a
-2-character prefix consisting of one of: (|), (^), (=) followed by a space.
-
-Commits marked with (=) represent the boundaries of minimal, non-linear epochs
-and correspond either to the start of a period of divergent development or to
-the end of such a period.
-
-Commits marked with (|) are direct parents of commits immediately preceding
+Commits marked with (|) are direct parents of commits immediately preceding 
 the marked commit in the list.
 
-Commits marked with (^) are not parents of the immediately preceding commit.
-These "breaks" represent necessary discontinuities implied by trying to
+Commits marked with (^) are not parents of the immediately preceding commit. 
+These "breaks" represent necessary discontinuities implied by trying to 
 represent an arbtirary DAG in a linear form.
 
-*--show-breaks* is only valid if *--merge-order* is also specified.
+If *--wrt-author* is specified, then git-rev-list sorts commits so that 
+contemporaneously developed commits appear to occur after (that is, sort before) 
+any commits authored by the author specified by *--author*. This reflects the 
+order in which that author sees contemporaneously developed commits appear 
+in her own workspace.
+
+If *--prune-at-author* is specified, then the parent of any commit 
+authored by the author is marked as uninteresting as if it had been 
+specified with ^ on the command line. This option restricts git-rev-list's 
+output to just the changes including and following the last change
+contributed by any author in a given branch.
+
+The *--author* option is used to specify the author used by the 
+*--wrt-author* and *--prune-at-author* switches. If an *--author* option is 
+not specified, the author used is derived from GIT_AUTHOR_EMAIL or, ultimately, 
+from the local user, host and domain names as per the logic used by 
+git-commit-tree.
+
+Use of *--show-breaks*, *--prune-at-author* or *--wrt-author* 
+implies *--merge-order*.
 
 Author
 ------
 Written by Linus Torvalds <torvalds@osdl.org>
 
-Original *--merge-order* logic by Jon Seymour <jon.seymour@gmail.com>
+Original *--merge-order*, *--wrt-author* and *--prune-at-author* logic 
+by Jon Seymour <jon.seymour@gmail.com>
 
 Documentation
 --------------
-Documentation by David Greaves, Junio C Hamano and the git-list <git@vger.kernel.org>.
+Documentation by David Greaves, Junio C Hamano, Jon Seymour and 
+the git-list <git@vger.kernel.org>.
 
 GIT
 ---
diff --git a/Makefile b/Makefile
--- a/Makefile
+++ b/Makefile
@@ -42,9 +42,9 @@ install: $(PROG) $(SCRIPTS)
 
 LIB_OBJS=read-cache.o sha1_file.o usage.o object.o commit.o tree.o blob.o \
 	 tag.o delta.o date.o index.o diff-delta.o patch-delta.o entry.o \
-	 epoch.o refs.o
+	 epoch.o refs.o user.o
 LIB_FILE=libgit.a
-LIB_H=cache.h object.h blob.h tree.h commit.h tag.h delta.h epoch.h
+LIB_H=cache.h object.h blob.h tree.h commit.h tag.h delta.h epoch.h user.h
 
 LIB_H += strbuf.h
 LIB_OBJS += strbuf.o
@@ -140,6 +140,7 @@ diffcore-pickaxe.o : $(LIB_H) diffcore.h
 diffcore-break.o : $(LIB_H) diffcore.h
 diffcore-order.o : $(LIB_H) diffcore.h
 epoch.o: $(LIB_H)
+user.o: $(LIB_H)
 
 test: all
 	$(MAKE) -C t/ all
diff --git a/commit-tree.c b/commit-tree.c
--- a/commit-tree.c
+++ b/commit-tree.c
@@ -4,8 +4,8 @@
  * Copyright (C) Linus Torvalds, 2005
  */
 #include "cache.h"
+#include "user.h"
 
-#include <pwd.h>
 #include <time.h>
 #include <ctype.h>
 
@@ -100,17 +100,16 @@ static char *commit_tree_usage = "git-co
 
 int main(int argc, char **argv)
 {
-	int i, len;
+	int i;
 	int parents = 0;
 	unsigned char tree_sha1[20];
 	unsigned char parent_sha1[MAXPARENT][20];
 	unsigned char commit_sha1[20];
 	char *gecos, *realgecos, *commitgecos;
-	char *email, *commitemail, realemail[1000];
+	char *email, *commitemail, *realemail;
 	char date[50], realdate[50];
 	char *audate, *cmdate;
 	char comment[1000];
-	struct passwd *pw;
 	char *buffer;
 	unsigned int size;
 
@@ -128,19 +127,7 @@ int main(int argc, char **argv)
 	}
 	if (!parents)
 		fprintf(stderr, "Committing initial tree %s\n", argv[1]);
-	pw = getpwuid(getuid());
-	if (!pw)
-		die("You don't exist. Go away!");
-	realgecos = pw->pw_gecos;
-	len = strlen(pw->pw_name);
-	memcpy(realemail, pw->pw_name, len);
-	realemail[len] = '@';
-	gethostname(realemail+len+1, sizeof(realemail)-len-1);
-	if (!strchr(realemail+len+1, '.')) {
-		strcat(realemail, ".");
-		getdomainname(realemail+strlen(realemail), sizeof(realemail)-strlen(realemail)-1);
-	}
-
+	get_real_identity(&realemail, &realgecos);
 	datestamp(realdate, sizeof(realdate));
 	strcpy(date, realdate);
 
diff --git a/commit.c b/commit.c
--- a/commit.c
+++ b/commit.c
@@ -76,6 +76,12 @@ int parse_commit_buffer(struct commit *i
 	       !get_sha1_hex(bufptr + 7, parent)) {
 		struct commit *new_parent = lookup_commit(parent);
 		if (new_parent) {
+			/** 
+                         * note to maintainers - 
+                         * please read and modify copy_parents_in_header_order
+                         * if this behaviour ever changes from stacking
+                         * to queueing behaviour.
+			 */
 			commit_list_insert(new_parent, &item->parents);
 			add_ref(&item->object, &new_parent->object);
 		}
@@ -302,3 +308,69 @@ int count_parents(struct commit * commit
         return count;
 }
 
+int copy_commit_header(struct commit * commit, char * header, int index, char * buffer, int len)
+{
+	char * p = commit->buffer;
+
+	while (*p != '\n') {		
+		char * q = header;
+		int matched;
+
+		for (matched = 1; *p != ' ' && *p != '\n'; p++, q++) {
+			matched = matched && (*q==*p);
+		}
+		if (matched && index) {
+			/*
+			 * if we matched but we haven't seen the 
+			 * index'th element yet, just decrement 
+			 * the index then pretend we didn't match
+			 */
+			index--;
+			matched = 0;
+		}
+		if (!matched) {			
+			/* skip to start of next header line */			
+			for (;*p!='\n';p++)
+				;
+			p++;
+		} else {			
+			int count = 0; /* number of characters in value */
+			if (*p == ' ') {				
+				p++;
+				count = 0;
+				while(*p != '\n') {
+					if (len > 0)
+						*buffer++=*p;				
+					p++;
+					count++;
+					len--;
+				}					
+			} 
+			if (len > 0)
+				*buffer = 0;
+			return (len > 0) ? count+1 : -(count+1);
+		}			
+	}
+	return 0;
+}
+
+int copy_author(struct commit * commit, char * buffer, int len)
+{
+	return copy_commit_header(commit, "author", 0, buffer, len);
+}
+
+/*
+ * Always produces a list of parents in the order they actually
+ * appear in the commit header. The correct implementation 
+ * of this function depends on decisions made in parse_commit().
+ */
+struct commit_list * copy_parents_in_header_order(struct commit * commit)
+{
+	struct commit_list * parents = commit->parents;
+        struct commit_list * result = NULL;
+
+	for (parents = commit->parents;parents;parents = parents->next) {
+		commit_list_insert(parents->item, &result);
+	}
+	return result;
+}
diff --git a/commit.h b/commit.h
--- a/commit.h
+++ b/commit.h
@@ -53,4 +53,35 @@ struct commit *pop_most_recent_commit(st
 struct commit *pop_commit(struct commit_list **stack);
 
 int count_parents(struct commit * commit);
+
+/*
+ * Copies the value of the (index+1)'th commit header matching the name 
+ * specified into the buffer supplied and append a trailing NUL.
+ *
+ * Returns n<0 if the buffer was too short, where -n is the required length.
+ * 
+ * Returns 0 if the header doesn't exist.
+ * 
+ * Returns n>0 where n is the length of the copied zero-terminated value, 
+ * including the terminating zero.
+ */
+int copy_commit_header(struct commit * commit, char * header, int index, char * buffer, int len);
+
+/*
+ * Copies the commit's author value into the buffer supplied. 
+ * Return values as per copy_commit_header.
+ */
+int copy_author(struct commit * commit, char * buffer, int len);
+
+/*
+ * Make a copy of the parents in header order. This is the
+ * reverse of the parse order. Callers who need guarantees
+ * about parents being in header order should use this 
+ * call whose semantics will never change even if the
+ * implementation of parse_commit does.
+ *
+ * Callers are expected to destroy the copied list when
+ * they are finished with it.
+ */
+struct commit_list * copy_parents_in_header_order(struct commit * commit);
 #endif /* COMMIT_H */
diff --git a/epoch.c b/epoch.c
--- a/epoch.c
+++ b/epoch.c
@@ -8,7 +8,6 @@
  *
  */
 #include <stdlib.h>
-
 /* Provides arbitrary precision integers required to accurately represent
  * fractional mass: */
 #include <openssl/bn.h>
@@ -22,17 +21,33 @@ struct fraction {
 	BIGNUM denominator;
 };
 
-#define HAS_EXACTLY_ONE_PARENT(n) ((n)->parents && !(n)->parents->next)
-
 static BN_CTX *context = NULL;
 static struct fraction *one = NULL;
 static struct fraction *zero = NULL;
 
+#define HAS_EXACTLY_ONE_PARENT(n) ((n)->parents && !(n)->parents->next)
+#define IS_UNINTERESTING(c) ((c)->object.flags & UNINTERESTING)
+#define IS_VISITED(c) ((c)->object.flags & VISITED)
+#define IS_BASE(c) ((c)->object.flags & BASE)
+#define IS_LOCAL(c) ((c)->object.flags & LOCAL)
+#define IS_DISCONTINUITY(c) ((c)->object.flags & DISCONTINUITY)
+#define ASSERT(x,m,c) if (!(x)) { assertion_failed(__LINE__, __FUNCTION__, m, c); }
+
+static void assertion_failed(int line, char * function, char * message, struct commit * item)
+{
+	die(	"%s:%d:%s: assertion_failed: %s: commit %s, flags %x",
+		__FILE__, 
+		line, 
+		function,
+		message,
+		item ? sha1_to_hex(item->object.sha1) : "[]",
+		item ? item->object.flags : 0xFFFFFFFF);
+}
+			
 static BN_CTX *get_BN_CTX()
 {
-	if (!context) {
+	if (!context)
 		context = BN_CTX_new();
-	}
 	return context;
 }
 
@@ -58,10 +73,10 @@ static struct fraction *divide(struct fr
 
 	BN_init(&bn_divisor);
 	BN_set_word(&bn_divisor, divisor);
-
 	BN_copy(&result->numerator, &fraction->numerator);
-	BN_mul(&result->denominator, &fraction->denominator, &bn_divisor, get_BN_CTX());
-
+	BN_mul(	&result->denominator, 
+		&fraction->denominator, 
+		&bn_divisor, get_BN_CTX());
 	BN_clear(&bn_divisor);
 	return result;
 }
@@ -86,9 +101,8 @@ static struct fraction *get_one()
 
 static struct fraction *get_zero()
 {
-	if (!zero) {
+	if (!zero)
 		zero = new_zero();
-	}
 	return zero;
 }
 
@@ -99,28 +113,44 @@ static struct fraction *copy(struct frac
 	return to;
 }
 
-static struct fraction *add(struct fraction *result, struct fraction *left, struct fraction *right)
+static struct fraction *inc(struct fraction *left, struct fraction *right)
 {
 	BIGNUM a, b, gcd;
 
 	BN_init(&a);
 	BN_init(&b);
 	BN_init(&gcd);
-
-	BN_mul(&a, &left->numerator, &right->denominator, get_BN_CTX());
-	BN_mul(&b, &left->denominator, &right->numerator, get_BN_CTX());
-	BN_mul(&result->denominator, &left->denominator, &right->denominator, get_BN_CTX());
-	BN_add(&result->numerator, &a, &b);
-
-	BN_gcd(&gcd, &result->denominator, &result->numerator, get_BN_CTX());
-	BN_div(&result->denominator, NULL, &result->denominator, &gcd, get_BN_CTX());
-	BN_div(&result->numerator, NULL, &result->numerator, &gcd, get_BN_CTX());
-
+	BN_mul(	&a, 
+		&left->numerator, 
+		&right->denominator, 
+		get_BN_CTX());
+	BN_mul(	&b, 
+		&left->denominator, 
+		&right->numerator, 
+		get_BN_CTX());
+	BN_mul( &left->denominator, 
+		&left->denominator, 
+		&right->denominator, 
+		get_BN_CTX());
+	BN_add(	&left->numerator, 
+		&a, 
+		&b);
+	BN_gcd(	&gcd, 
+		&left->denominator, 
+		&left->numerator, 
+		get_BN_CTX());
+	BN_div(	&left->denominator, 
+		NULL, &left->denominator, 
+		&gcd, 
+		get_BN_CTX());
+	BN_div(	&left->numerator, 
+		NULL, &left->numerator, 
+		&gcd, 
+		get_BN_CTX());
 	BN_clear(&a);
 	BN_clear(&b);
 	BN_clear(&gcd);
-
-	return result;
+	return left;
 }
 
 static int compare(struct fraction *left, struct fraction *right)
@@ -130,15 +160,11 @@ static int compare(struct fraction *left
 
 	BN_init(&a);
 	BN_init(&b);
-
 	BN_mul(&a, &left->numerator, &right->denominator, get_BN_CTX());
 	BN_mul(&b, &left->denominator, &right->numerator, get_BN_CTX());
-
 	result = BN_cmp(&a, &b);
-
 	BN_clear(&a);
 	BN_clear(&b);
-
 	return result;
 }
 
@@ -150,21 +176,15 @@ struct mass_counter {
 static struct mass_counter *new_mass_counter(struct commit *commit, struct fraction *pending)
 {
 	struct mass_counter *mass_counter = xmalloc(sizeof(*mass_counter));
-	memset(mass_counter, 0, sizeof(*mass_counter));
 
+	ASSERT(!commit->object.util, "not already initialized", commit);
+
+	memset(mass_counter, 0, sizeof(*mass_counter));
 	init_fraction(&mass_counter->seen);
 	init_fraction(&mass_counter->pending);
-
 	copy(&mass_counter->pending, pending);
 	copy(&mass_counter->seen, get_zero());
-
-	if (commit->object.util) {
-		die("multiple attempts to initialize mass counter for %s",
-		    sha1_to_hex(commit->object.sha1));
-	}
-
 	commit->object.util = mass_counter;
-
 	return mass_counter;
 }
 
@@ -218,73 +238,63 @@ static int find_base_for_list(struct com
 	struct commit_list *cleaner = NULL;
 	struct commit_list *pending = NULL;
 	struct fraction injected;
-	init_fraction(&injected);
-	*boundary = NULL;
 
+	*boundary = NULL;
+	init_fraction(&injected);
 	for (; list; list = list->next) {
 		struct commit *item = list->item;
 
-		if (item->object.util) {
-			die("%s:%d:%s: logic error: this should not have happened - commit %s",
-			    __FILE__, __LINE__, __FUNCTION__,
-			    sha1_to_hex(item->object.sha1));
-		}
-
+		ASSERT(!item->object.util, "no duplicates in list", item);
 		new_mass_counter(list->item, get_one());
-		add(&injected, &injected, get_one());
-
+		inc(&injected, get_one());
 		commit_list_insert(list->item, &cleaner);
 		commit_list_insert(list->item, &pending);
 	}
-
 	while (!*boundary && pending && !ret) {
 		struct commit *latest = pop_commit(&pending);
-		struct mass_counter *latest_node = (struct mass_counter *) latest->object.util;
+		struct mass_counter *latest_node;		
 		int num_parents;
-
-		if ((ret = parse_commit(latest)))
+		
+		ret = parse_commit(latest);
+		if (ret)
 			continue;
-		add(&latest_node->seen, &latest_node->seen, &latest_node->pending);
-
+		latest_node = (struct mass_counter *) latest->object.util;
+		inc(&latest_node->seen, &latest_node->pending);
 		num_parents = count_parents(latest);
 		if (num_parents) {
-			struct fraction distribution;
-			struct commit_list *parents;
-
-			divide(init_fraction(&distribution), &latest_node->pending, num_parents);
+			struct fraction div;
+			struct commit_list *parents = latest->parents;
 
-			for (parents = latest->parents; parents; parents = parents->next) {
-				struct commit *parent = parents->item;
-				struct mass_counter *parent_node = (struct mass_counter *) parent->object.util;
-
-				if (!parent_node) {
-					parent_node = new_mass_counter(parent, &distribution);
-					insert_by_date(&pending, parent);
-					commit_list_insert(parent, &cleaner);
-				} else {
-					if (!compare(&parent_node->pending, get_zero()))
-						insert_by_date(&pending, parent);
-					add(&parent_node->pending, &parent_node->pending, &distribution);
-				}
+			divide(	init_fraction(&div), 
+				&latest_node->pending, 
+				num_parents);
+			while (parents) {
+				struct mass_counter * pmc;
+				struct commit *pc = parents->item;
+				
+				pmc = (struct mass_counter *) pc->object.util;
+				if (!pmc) {
+					pmc = new_mass_counter(pc, get_zero());
+					commit_list_insert(pc, &cleaner);
+				}				
+				if (!compare(&pmc->pending, get_zero()))
+					insert_by_date(&pending, pc);					
+				inc(&pmc->pending, &div);
+				parents = parents->next;
 			}
-
-			clear_fraction(&distribution);
+			clear_fraction(&div);
 		}
-
 		if (!compare(&latest_node->seen, &injected))
 			*boundary = latest;
 		copy(&latest_node->pending, get_zero());
 	}
-
 	while (cleaner) {
 		struct commit *next = pop_commit(&cleaner);
 		free_mass_counter((struct mass_counter *) next->object.util);
 		next->object.util = NULL;
 	}
-
 	if (pending)
 		free_commit_list(pending);
-
 	clear_fraction(&injected);
 	return ret;
 }
@@ -305,7 +315,6 @@ static int find_base(struct commit *head
 	}
 	ret = find_base_for_list(pending, boundary);
 	free_commit_list(pending);
-
 	return ret;
 }
 
@@ -313,19 +322,15 @@ static int find_base(struct commit *head
  * This procedure traverses to the boundary of the first epoch in the epoch
  * sequence of the epoch headed at head_of_epoch. This is either the end of
  * the maximal linear epoch or the base of a minimal non-linear epoch.
- *
- * The queue of pending nodes is sorted in reverse date order and each node
- * is currently in the queue at most once.
  */
 static int find_next_epoch_boundary(struct commit *head_of_epoch, struct commit **boundary)
 {
-	int ret;
 	struct commit *item = head_of_epoch;
+	int ret;
 
 	ret = parse_commit(item);
 	if (ret)
 		return ret;
-
 	if (HAS_EXACTLY_ONE_PARENT(item)) {
 		/*
 		 * We are at the start of a maximimal linear epoch.
@@ -336,7 +341,6 @@ static int find_next_epoch_boundary(stru
 			ret = parse_commit(item);
 		}
 		*boundary = item;
-
 	} else {
 		/*
 		 * Otherwise, we are at the start of a minimal, non-linear
@@ -344,7 +348,6 @@ static int find_next_epoch_boundary(stru
 		 */
 		ret = find_base(item, boundary);
 	}
-
 	return ret;
 }
 
@@ -354,34 +357,19 @@ static int find_next_epoch_boundary(stru
 static int is_parent_of(struct commit *parent, struct commit *child)
 {
 	struct commit_list *parents;
-	for (parents = child->parents; parents; parents = parents->next) {
-		if (!memcmp(parent->object.sha1, parents->item->object.sha1,
-		            sizeof(parents->item->object.sha1)))
+
+	for (parents = child->parents; parents; parents = parents->next)
+		if (!memcmp(parent->object.sha1, 
+			    parents->item->object.sha1,
+			    sizeof(parents->item->object.sha1)))
 			return 1;
-	}
 	return 0;
 }
 
 /*
- * Pushes an item onto the merge order stack. If the top of the stack is
- * marked as being a possible "break", we check to see whether it actually
- * is a break.
- */
-static void push_onto_merge_order_stack(struct commit_list **stack, struct commit *item)
-{
-	struct commit_list *top = *stack;
-	if (top && (top->item->object.flags & DISCONTINUITY)) {
-		if (is_parent_of(top->item, item)) {
-			top->item->object.flags &= ~DISCONTINUITY;
-		}
-	}
-	commit_list_insert(item, stack);
-}
-
-/*
  * Marks all interesting, visited commits reachable from this commit
  * as uninteresting. We stop recursing when we reach the epoch boundary,
- * an unvisited node or a node that has already been marking uninteresting.
+ * an unvisited node or a node that has already been marked uninteresting.
  *
  * This doesn't actually mark all ancestors between the start node and the
  * epoch boundary uninteresting, but does ensure that they will eventually
@@ -397,7 +385,6 @@ static void mark_ancestors_uninteresting
 	struct commit_list *next;
 
 	commit->object.flags |= UNINTERESTING;
-
 	/*
 	 * We only need to recurse if
 	 *      we are not on the boundary and
@@ -413,95 +400,89 @@ static void mark_ancestors_uninteresting
 	 * uninteresting or will be once the sort_first_epoch
 	 * traverse reaches them.
 	 */
-
 	if (uninteresting || boundary || !visited)
 		return;
-
 	for (next = commit->parents; next; next = next->next)
 		mark_ancestors_uninteresting(next->item);
 }
 
 /*
- * Sorts the nodes of the first epoch of the epoch sequence of the epoch headed at head
- * into merge order.
+ * Sorts the nodes of the first epoch of the epoch sequence of the epoch 
+ * headed at head into merge order.
  */
-static void sort_first_epoch(struct commit *head, struct commit_list **stack)
+static void sort_first_epoch(struct commit *head, struct commit_list **stack, struct epoch_methods * methods)
 {
-	struct commit_list *parents;
-	struct commit_list *reversed_parents = NULL;
+	struct commit_list *reversed = NULL;
+        struct commit * top = *stack?(*stack)->item:NULL;
 
+	if (IS_VISITED(head)) 
+		return;
 	head->object.flags |= VISITED;
 
 	/*
-	 * parse_commit() builds the parent list in reverse order with respect
-	 * to the order of the git-commit-tree arguments. So we need to reverse
-	 * this list to output the oldest (or most "local") commits last.
-	 */
-	for (parents = head->parents; parents; parents = parents->next)
-		commit_list_insert(parents->item, &reversed_parents);
-
-	/*
-	 * TODO: By sorting the parents in a different order, we can alter the
-	 * merge order to show contemporaneous changes in parallel branches
-	 * occurring after "local" changes. This is useful for a developer
-	 * when a developer wants to see all changes that were incorporated
-	 * into the same merge as her own changes occur after her own
-	 * changes.
-	 */
-
-	while (reversed_parents) {
-		struct commit *parent = pop_commit(&reversed_parents);
+         * give the sort tactics a chance to mark this commit uninteresting
+         */
+	if (methods->marker)
+		(*(methods->marker)) (head);
 
-		if (head->object.flags & UNINTERESTING) {
+        if (IS_BASE(head)) {
+		ASSERT(!top, "stack empty on visit to base", head);
+	} else {
+		/*
+		 * Reverse the parents so that "local" parents are pushed first
+		 * and hence print last. 
+		 */
+		if (!head->object.util) {
 			/*
-			 * Propagates the uninteresting bit to all parents.
-			 * if we have already visited this parent, then
-			 * the uninteresting bit will be propagated to each
-			 * reachable commit that is still not marked
-			 * uninteresting and won't otherwise be reached.
+			 * make a copy of the parents, but don't destroy them
 			 */
-			mark_ancestors_uninteresting(parent);
+                        reversed = copy_parents_in_header_order(head);
+		} else {
+			/*
+                         * sort_list_in_local_first_order already does this
+			 */
+			reversed = (struct commit_list *)head->object.util;
+                        head->object.util = NULL;
 		}
+		while (reversed) {
+			struct commit *parent = pop_commit(&reversed);
 
-		if (!(parent->object.flags & VISITED)) {
-			if (parent->object.flags & BOUNDARY) {
-				if (*stack) {
-					die("something else is on the stack - %s",
-					    sha1_to_hex((*stack)->item->object.sha1));
-				}
-				push_onto_merge_order_stack(stack, parent);
-				parent->object.flags |= VISITED;
-
-			} else {
-				sort_first_epoch(parent, stack);
-				if (reversed_parents) {
-					/*
-					 * This indicates a possible
-					 * discontinuity it may not be be
-					 * actual discontinuity if the head
-					 * of parent N happens to be the tail
-					 * of parent N+1.
-					 *
-					 * The next push onto the stack will
-					 * resolve the question.
-					 */
-					(*stack)->item->object.flags |= DISCONTINUITY;
-				}
+			if (IS_UNINTERESTING(head)) {
+				/*
+				 * Propagates the uninteresting bit to all parents.
+				 * If we have already visited this parent, then
+				 * the uninteresting bit will be propagated to each
+				 * reachable commit that is still not marked
+				 * uninteresting and won't otherwise be reached by
+				 * this traversal.
+				 */
+				mark_ancestors_uninteresting(parent);
+			}
+			sort_first_epoch(parent, stack, methods);
+			top=(*stack)?(*stack)->item:NULL;
+			if (reversed) {
+				/*
+				 * This indicates a possible discontinuity it 
+                                 * may not be be actual discontinuity if the head
+				 * of parent N happens to be the tail of 
+                                 * parent N+1. The next push onto the stack will
+				 * resolve the question.
+				 */
+				top->object.flags |= DISCONTINUITY;
 			}
 		}
-	}
-
-	push_onto_merge_order_stack(stack, head);
+        }
+	if (top && IS_DISCONTINUITY(top) && is_parent_of(top, head))
+		top->object.flags &= ~DISCONTINUITY;
+	commit_list_insert(head, stack);
 }
 
 /*
  * Emit the contents of the stack.
- *
  * The stack is freed and replaced by NULL.
- *
  * Sets the return value to STOP if no further output should be generated.
  */
-static int emit_stack(struct commit_list **stack, emitter_func emitter)
+static int emit_stack(struct commit_list **stack, struct epoch_methods * methods)
 {
 	unsigned int seen = 0;
 	int action = CONTINUE;
@@ -510,15 +491,98 @@ static int emit_stack(struct commit_list
 		struct commit *next = pop_commit(stack);
 		seen |= next->object.flags;
 		if (*stack)
-			action = (*emitter) (next);
+			action = (*(methods->emitter)) (next);
 	}
-
 	if (*stack) {
 		free_commit_list(*stack);
 		*stack = NULL;
+	}	
+	if (seen & UNINTERESTING) {
+		/**
+		 * We stop at the base of the stack, rather than
+		 * when we encounter the first UNINTERESTING flag.
+		 * 
+		 * The reason is that there may still be interesting
+		 * stuff on the stack but once we reach the base
+		 * there can be no more interesting stuff by definition
+		 * of what the base of an epoch is - everything reachable
+		 * from the base is also reachable from the UNINTERESTING
+		 * node and hence is uninteresting.
+		 */		 
+		action = STOP;
 	}
+	return action;
+}
 
-	return (action == STOP || (seen & UNINTERESTING)) ? STOP : CONTINUE;
+/*
+ * Copy the parents of the commit and store the head of the list
+ * in object.util. Return the address of object.util itself.
+ */
+static struct commit_list ** copy_and_store_parents(struct commit * commit)
+{
+	struct commit_list * copied=copy_parents_in_header_order(commit);
+
+        commit->object.util = copied;
+	return (struct commit_list **)&commit->object.util;
+}
+
+/*
+ * Sort a list of commits in local first order. A commit is "local" 
+ * if any of its ancestors (except the base) causes (*local_test)() to 
+ * return a non-zero value.
+ *
+ * The sorted list is returned in *sorted. A side effect of this function 
+ * is to set each object.util pointer in each ancestor up until the base 
+ * to a list of parents is sorted in local first order.
+ *
+ * Does nothing if the list is empty.
+ * 
+ * The return value contains LOCAL if any of the list is local or had a 
+ * local ancestor.
+ */
+static unsigned int sort_list_in_local_first_order(struct commit_list ** list, struct epoch_methods * methods)
+{
+	struct commit_list *local = NULL;
+	struct commit_list **local_tail = &local;
+	struct commit_list **non_local_ptr = list;
+
+	ASSERT(methods->local_test, "only called if there is a local test", NULL);
+	if (!*list) {
+		return 0;
+	}
+	for (non_local_ptr = list; *non_local_ptr; ) {
+		struct commit *item = (*non_local_ptr)->item;
+		struct commit_list ** copied;
+
+		/*
+		 * We don't descend past the base or visit
+		 * a commit we have already visited.
+                 */
+		if (!IS_BASE(item) && !item->object.util) {
+			if ((*(methods->local_test)) (item))
+				item->object.flags |= LOCAL;
+			copied=copy_and_store_parents(item);
+			item->object.flags |= sort_list_in_local_first_order(copied, methods);
+		}
+		/**
+		 * Move any local item onto the local list.
+                 */
+		if (IS_LOCAL(item)) {
+			*local_tail = *non_local_ptr;
+			*non_local_ptr = (*non_local_ptr)->next;
+			(*local_tail)->next = NULL;
+			local_tail = &(*local_tail)->next;
+		} else {
+			non_local_ptr = &(*non_local_ptr)->next;
+		}
+	}
+	/*
+         * Splice the non-local list onto the end and
+         * return with the LOCAL flag from the first item.
+         */
+        *local_tail = *list;
+        *list = local;
+	return ((*list)->item->object.flags & LOCAL);
 }
 
 /*
@@ -528,51 +592,53 @@ static int emit_stack(struct commit_list
  * Note: this algorithm currently leaves traces of its execution in the
  * object flags of nodes it discovers. This should probably be fixed.
  */
-static int sort_in_merge_order(struct commit *head_of_epoch, emitter_func emitter)
+static int sort_in_merge_order(struct commit *head_of_epoch, struct epoch_methods * methods)
 {
 	struct commit *next = head_of_epoch;
 	int ret = 0;
 	int action = CONTINUE;
 
-	ret = parse_commit(head_of_epoch);
-
+	ret = parse_commit(next);
+        next->object.flags |= BOUNDARY;
 	while (next && next->parents && !ret && (action != STOP)) {
 		struct commit *base = NULL;
 
 		ret = find_next_epoch_boundary(next, &base);
 		if (ret)
 			return ret;
-		next->object.flags |= BOUNDARY;
+		next->object.flags &= ~(BASE|VISITED);
 		if (base)
-			base->object.flags |= BOUNDARY;
-
+			base->object.flags |= (BOUNDARY|BASE);
 		if (HAS_EXACTLY_ONE_PARENT(next)) {
 			while (HAS_EXACTLY_ONE_PARENT(next)
 			       && (action != STOP)
 			       && !ret) {
-				if (next->object.flags & UNINTERESTING) {
+				if (methods->marker)
+					(*(methods->marker)) (next);
+
+				if (IS_UNINTERESTING(next))
 					action = STOP;
-				} else {
-					action = (*emitter) (next);
-				}
+				else
+					action = (*(methods->emitter)) (next);
+
 				if (action != STOP) {
 					next = next->parents->item;
 					ret = parse_commit(next);
 				}
 			}
-
 		} else {
 			struct commit_list *stack = NULL;
-			sort_first_epoch(next, &stack);
-			action = emit_stack(&stack, emitter);
+			if (methods->local_test) 
+				sort_list_in_local_first_order(
+					copy_and_store_parents(next),
+					methods);
+			sort_first_epoch(next, &stack, methods);
+			action = emit_stack(&stack, methods);
 			next = base;
 		}
 	}
-
-	if (next && (action != STOP) && !ret) {
-		(*emitter) (next);
-	}
-
+	if (next && (action != STOP) && !ret)
+		(*(methods->emitter))(next);
 	return ret;
 }
 
@@ -582,68 +648,65 @@ static int sort_in_merge_order(struct co
  * in this subgraph using the sort_first_epoch algorithm. Once we have
  * reached the base we can continue sorting using sort_in_merge_order.
  */
-int sort_list_in_merge_order(struct commit_list *list, emitter_func emitter)
+int sort_list_in_merge_order(struct commit_list *list, struct epoch_methods * methods)
 {
 	struct commit_list *stack = NULL;
+	struct commit_list *filtered = NULL;
 	struct commit *base;
 	int ret = 0;
 	int action = CONTINUE;
-	struct commit_list *reversed = NULL;
 
+	if (!methods) 
+		die("methods argument must not be null");
+	if (!methods->emitter)
+		die("an emitter method must be supplied");
+	/**
+         * Filter the list by removing all uninteresting
+         * and duplicate items. Removing duplicates
+         * prevents an assertion failure in find_base_for_list
+	 */
 	for (; list; list = list->next) {
 		struct commit *next = list->item;
 
-		if (!(next->object.flags & UNINTERESTING)) {
-			if (next->object.flags & DUPCHECK) {
-				fprintf(stderr, "%s: duplicate commit %s ignored\n",
-					__FUNCTION__, sha1_to_hex(next->object.sha1));
-			} else {
-				next->object.flags |= DUPCHECK;
-				commit_list_insert(list->item, &reversed);
-			}
+		if (!(next->object.flags & (UNINTERESTING|DUPCHECK))) {
+			next->object.flags |= DUPCHECK;
+			commit_list_insert(list->item, &filtered);
 		}
 	}
-
-	if (!reversed->next) {
-		/*
-		 * If there is only one element in the list, we can sort it
-		 * using sort_in_merge_order.
-		 */
-		base = reversed->item;
-	} else {
+	/**
+	 * Find the common base of the listed commits and
+         * sort up until that base.
+	 */
+	if (!filtered->next)		
+		base = filtered->item; /* sort with sort_in_merge_order */
+	else {
 		/*
 		 * Otherwise, we search for the base of the list.
-		 */
-		ret = find_base_for_list(reversed, &base);
+		 */		 
+		ret = find_base_for_list(filtered, &base);
 		if (ret)
 			return ret;
 		if (base)
-			base->object.flags |= BOUNDARY;
-
-		while (reversed) {
-			sort_first_epoch(pop_commit(&reversed), &stack);
-			if (reversed) {
-				/*
-				 * If we have more commits to push, then the
-				 * first push for the next parent may (or may
-				 * not) represent a discontinuity with respect
-				 * to the parent currently on the top of
-				 * the stack.
-				 *
-				 * Mark it for checking here, and check it
-				 * with the next push. See sort_first_epoch()
-				 * for more details.
-				 */
+			base->object.flags |= (BOUNDARY|BASE);
+		if (methods->local_test)
+			sort_list_in_local_first_order(&filtered, methods);
+		while (filtered) {
+			sort_first_epoch(pop_commit(&filtered), &stack, methods);
+			/* per discontintuity logic in sort_first_epoch */
+			if (filtered)
 				stack->item->object.flags |= DISCONTINUITY;
-			}
 		}
-
-		action = emit_stack(&stack, emitter);
-	}
-
-	if (base && (action != STOP)) {
-		ret = sort_in_merge_order(base, emitter);
+		action = emit_stack(&stack, methods);
 	}
-
+        /**
+         * Sort the rest with the sort_in_merge_order algorithm.
+         */
+	if (base && (action != STOP))
+		ret = sort_in_merge_order(base, methods);
 	return ret;
 }
+
+void init_epoch_methods(struct epoch_methods * methods)
+{
+	memset(methods, 0, sizeof(*methods));
+}
diff --git a/epoch.h b/epoch.h
--- a/epoch.h
+++ b/epoch.h
@@ -1,20 +1,56 @@
 #ifndef EPOCH_H
 #define EPOCH_H
 
-
-// return codes for emitter_func
-#define STOP     0
-#define CONTINUE 1
-#define DO       2
-typedef int (*emitter_func) (struct commit *); 
-
-int sort_list_in_merge_order(struct commit_list *list, emitter_func emitter);
-
+/**
+ * Flags used by merge order logic and also by rev-list.c
+ */
 #define UNINTERESTING  (1u<<2)
 #define BOUNDARY       (1u<<3)
 #define VISITED        (1u<<4)
 #define DISCONTINUITY  (1u<<5)
 #define DUPCHECK       (1u<<6)
+#define LOCAL          (1u<<7)
+#define BASE           (1u<<8)
 
+/**
+ * Return codes for emitter method. Also used by rev-list.c
+ */
+#define STOP     0
+#define CONTINUE 1
+#define DO       2
 
-#endif				/* EPOCH_H */
+struct epoch_methods {
+	/*
+	 * Returns 0 if traversal should stop, non-zero if it should continue.
+	 */
+	int (*emitter)(struct commit *);
+	/* 
+	 * Returns non-zero if the commit is regarded "local", 0 otherwise.
+	 */
+	int (*local_test)(struct commit *);
+	/* 
+	 * Implementers may use this method to mark commits uninteresting
+	 * according to some locally determined criteria. The tree
+	 * will be pruned at any commit so marked.
+	 */
+	void (*marker)(struct commit *);
+};
+
+/**
+ * Initializes an epoch_methods structure which
+ * may be customized by the caller by overriding any of the method pointers.
+ */
+extern void init_epoch_methods(struct epoch_methods *);
+
+/**
+ * Sorts the list of commits in merge order, using the methods specified
+ * to customize the tactics of the search.
+ * 
+ * The prune points should be marked with the UNINTERESTING flags. 
+ * 
+ * Note: this algorithm is dirty in the sense that it leaves traces
+ * of its execution in the object.flags word of some or all of the commits
+ * visited.
+ */
+extern int sort_list_in_merge_order(struct commit_list *list, struct epoch_methods * methods);
+#endif	/* EPOCH_H */
diff --git a/rev-list.c b/rev-list.c
--- a/rev-list.c
+++ b/rev-list.c
@@ -1,18 +1,24 @@
 #include "cache.h"
 #include "commit.h"
 #include "epoch.h"
+#include "user.h"
 
 #define SEEN		(1u << 0)
 #define INTERESTING	(1u << 1)
 
 static const char rev_list_usage[] =
 	"usage: git-rev-list [OPTION] commit-id <commit-id>\n"
-		      "  --max-count=nr\n"
-		      "  --max-age=epoch\n"
-		      "  --min-age=epoch\n"
-		      "  --header\n"
-		      "  --pretty\n"
-		      "  --merge-order [ --show-breaks ]";
+			"  --max-count=nr\n"
+			"  --max-age=epoch\n"
+			"  --min-age=epoch\n"
+			"  --header\n"
+			"  --parents\n"
+			"  --pretty\n"
+			"  --merge-order\n"
+			"  --wrt-author\n"
+			"  --prune-at-author\n"
+			"  --author=author@domain\n"
+			"  --show-breaks ]";
 
 static int verbose_header = 0;
 static int show_parents = 0;
@@ -24,6 +30,9 @@ static int max_count = -1;
 static enum cmit_fmt commit_format = CMIT_FMT_RAW;
 static int merge_order = 0;
 static int show_breaks = 0;
+static char * local_author = NULL;
+static int prune_at_author = 0;
+static int wrt_author = 0;
 
 static void show_commit(struct commit *commit)
 {
@@ -147,6 +156,26 @@ static enum cmit_fmt get_commit_format(c
 	usage(rev_list_usage);	
 }			
 
+static int is_local_author(struct commit * commit)
+{
+	static char author[16384];
+	if (copy_author(commit, author, sizeof(author)) > 0) {
+		if (strstr(author, local_author)) {
+			return 1;
+		}
+	}
+	return 0;
+}
+
+static void mark_authors_own_uninteresting(struct commit * commit)
+{
+        if (is_local_author(commit)) {
+		struct commit_list * parents = commit->parents;
+		for (;parents;parents=parents->next) {
+			parents->item->object.flags |= UNINTERESTING;
+		}
+        }
+}
 
 int main(int argc, char **argv)
 {
@@ -186,14 +215,26 @@ int main(int argc, char **argv)
 			show_parents = 1;
 			continue;
 		}
-		if (!strncmp(arg, "--merge-order", 13)) {
+		if (!strcmp(arg, "--merge-order")) {
 		        merge_order = 1;
 			continue;
 		}
-		if (!strncmp(arg, "--show-breaks", 13)) {
+		if (!strcmp(arg, "--show-breaks")) {
 			show_breaks = 1;
 			continue;
 		}
+		if (!strncmp(arg, "--author=", 9)) {
+                        local_author=strdup(&arg[9]);
+			continue;
+		}
+		if (!strcmp(arg, "--wrt-author")) {
+		        wrt_author = 1;
+			continue;
+		}
+		if (!strcmp(arg, "--prune-at-author")) {
+		        prune_at_author = 1;
+			continue;
+		}
 
 		flags = 0;
 		if (*arg == '^') {
@@ -201,7 +242,7 @@ int main(int argc, char **argv)
 			arg++;
 			limited = 1;
 		}
-		if (get_sha1(arg, sha1) || (show_breaks && !merge_order))
+		if (get_sha1(arg, sha1))
 			usage(rev_list_usage);
 		commit = lookup_commit_reference(sha1);
 		if (!commit || parse_commit(commit) < 0)
@@ -213,14 +254,38 @@ int main(int argc, char **argv)
 	if (!list)
 		usage(rev_list_usage);
 
+        if (!merge_order) 
+        	merge_order = wrt_author || prune_at_author || show_breaks;        	
+
 	if (!merge_order) {		
 	        if (limited)
 			list = limit_list(list);
 		show_commit_list(list);
-	} else {
-		if (sort_list_in_merge_order(list, &process_commit)) {
-			  die("merge order sort failed\n");
-		}
+	} else {		
+		struct epoch_methods methods;
+	
+		init_epoch_methods(&methods);
+		if ((prune_at_author|wrt_author) && !local_author) {
+			local_author = gitenv("GIT_AUTHOR_EMAIL") ? : NULL;			    
+			if (!local_author)
+				 get_real_identity(&local_author, NULL);
+			else
+				 local_author = strdup(local_author);
+		}		
+		if (local_author) {
+			/* add delimiters to improve accuracy of match */
+			char * tmp=xmalloc(strlen(local_author)+3);
+			sprintf(tmp, "<%s>", local_author);
+			free(local_author);
+			local_author = tmp;
+		}		 
+		methods.emitter = &process_commit;		  
+		if (wrt_author)
+			methods.local_test = &is_local_author;
+		if (prune_at_author)
+			methods.marker = &mark_authors_own_uninteresting;
+		if (sort_list_in_merge_order(list, &methods))
+			die("merge order sort failed\n");
 	}
 
 	return 0;
diff --git a/t/t6001-rev-list-merge-order.sh b/t/t6001-rev-list-merge-order.sh
old mode 100644
new mode 100755
--- a/t/t6001-rev-list-merge-order.sh
+++ b/t/t6001-rev-list-merge-order.sh
@@ -6,10 +6,53 @@
 test_description='Test rev-list --merge-order
 '
 . ./test-lib.sh
+[ -d .git/refs/tags ] || mkdir -p .git/refs/tags
 
-function do_commit
+sed_script="";
+
+function tag
+{
+	local _tag=$1
+	[ -f .git/refs/tags/$_tag ] || error "tag: \"$_tag\" does not exist"
+	cat .git/refs/tags/$_tag
+}
+
+function commit
+{
+	local _tag=$1
+        local _tree=$2
+	shift 2
+    	echo $_tag | git-commit-tree $(tag $_tree) "$@"
+}
+
+function save_tag
 {
-    git-commit-tree "$@" </dev/null
+	local _tag=$1	
+	[ -n "$_tag" ] || error "usage: do_commit tag commit-args ..."
+	shift 1
+    	"$@" >.git/refs/tags/$_tag
+    	sed_script="s/$(tag $_tag)/$_tag/g${sed_script+;}$sed_script"
+}
+
+function entag
+{
+	sed "$sed_script"
+}
+
+function as_author
+{
+	local _author=$1
+	shift 1
+        local _save=$GIT_AUTHOR_EMAIL
+
+	export GIT_AUTHOR_EMAIL="$_author"
+	"$@"
+        export GIT_AUTHOR_EMAIL="$_save"
+}
+
+function hide_error
+{
+	"$@" 2>/dev/null
 }
 
 function check_adjacency
@@ -28,43 +71,97 @@ function check_adjacency
     done
 }
 
-function sed_script
+function check_output
 {
-   for c in root a0 a1 a2 a3 a4 b1 b2 b3 b4 c1 c2 c3 l0 l1 l2 l3 l4 l5
-   do
-       echo -n "s/${!c}/$c/;"
-   done
+	local _name=$1
+	shift 1
+	if "$@" | entag > $_name.actual
+	then
+		diff $_name.expected $_name.actual
+	else
+		return 1;
+	fi
+	
+}
+
+function name_from_description
+{
+        tr "'" '.' | tr '~`!@#$%^&*()_+={}[]|\;:"<>,/?-' '.' | tr -s '.' | tr ' ' '-' | tr '[A-Z]' '[a-z]'
+}
+
+#
+# stdin contains expected result
+#
+function test_output_expect_success
+{	
+	local _description=$1
+	shift 1
+        local _name=$(echo $_description | name_from_description)
+	cat > $_name.expected
+	test_expect_success "$_description" "check_output $_name $*" 
 }
 
 date >path0
 git-update-cache --add path0
-tree=$(git-write-tree)
-root=$(do_commit $tree 2>/dev/null)
-export GIT_COMMITTER_NAME=foobar  # to guarantee that the commit is different
-l0=$(do_commit $tree -p $root)
-l1=$(do_commit $tree -p $l0)
-l2=$(do_commit $tree -p $l1)
-a0=$(do_commit $tree -p $l2)
-a1=$(do_commit $tree -p $a0)
-export GIT_COMMITTER_NAME=foobar2 # to guarantee that the commit is different
-b1=$(do_commit $tree -p $a0)
-c1=$(do_commit $tree -p $b1)
-export GIT_COMMITTER_NAME=foobar3 # to guarantee that the commit is different
-b2=$(do_commit $tree -p $b1)
-b3=$(do_commit $tree -p $b2)
-c2=$(do_commit $tree -p $c1 -p $b2)
-c3=$(do_commit $tree -p $c2)
-a2=$(do_commit $tree -p $a1)
-a3=$(do_commit $tree -p $a2)
-b4=$(do_commit $tree -p $b3 -p $a3)
-a4=$(do_commit $tree -p $a3 -p $b4 -p $c3)
-l3=$(do_commit $tree -p $a4)
-l4=$(do_commit $tree -p $l3)
-l5=$(do_commit $tree -p $l4)
-echo $l5 > .git/HEAD
+save_tag tree git-write-tree
+hide_error save_tag root commit root tree
+save_tag l0 commit l0 tree -p root
+save_tag l1 commit l1 tree -p l0
+save_tag l2 commit l2 tree -p l1
+save_tag a0 commit a0 tree -p l2
+save_tag a1 commit a1 tree -p a0
+save_tag b1 commit b1 tree -p a0
+save_tag c1 commit c1 tree -p b1
+as_author foobar@example.com save_tag b2 commit b2 tree -p b1
+save_tag b3 commit b2 tree -p b2
+save_tag c2 commit c2 tree -p c1 -p b2
+save_tag c3 commit c3 tree -p c2
+save_tag a2 commit a2 tree -p a1
+save_tag a3 commit a3 tree -p a2
+save_tag b4 commit b4 tree -p b3 -p a3
+save_tag a4 commit a4 tree -p a3 -p b4 -p c3
+save_tag l3 commit l3 tree -p a4
+save_tag l4 commit l4 tree -p l3
+save_tag l5 commit l5 tree -p l4
+hide_error save_tag e1 as_author e@example.com commit e1 tree
+save_tag e2 as_author e@example.com commit e2 tree -p e1
+save_tag f1 as_author f@example.com commit f1 tree -p e1
+save_tag e3 as_author e@example.com commit e3 tree -p e2
+save_tag f2 as_author f@example.com commit f2 tree -p f1
+save_tag e4 as_author e@example.com commit e4 tree -p e3 -p f2
+save_tag e5 as_author e@example.com commit e5 tree -p e4
+save_tag f3 as_author f@example.com commit f3 tree -p f2
+save_tag f4 as_author f@example.com commit f4 tree -p f3
+save_tag e6 as_author e@example.com commit e6 tree -p e5 -p f4
+save_tag f5 as_author f@example.com commit f5 tree -p f4
+save_tag f6 as_author f@example.com commit f6 tree -p f5 -p e6
+save_tag e7 as_author e@example.com commit e7 tree -p e6
+save_tag e8 as_author e@example.com commit e8 tree -p e7
+save_tag e9 as_author e@example.com commit e9 tree -p e8
+save_tag f7 as_author f@example.com commit f7 tree -p f6
+save_tag f8 as_author f@example.com commit f8 tree -p f7
+save_tag f9 as_author f@example.com commit f9 tree -p f8
+save_tag e10 as_author e@example.com commit e1 tree -p e9 -p f8
+tag l5 > .git/HEAD
+
+#
+# cd to t/trash and use 
+#
+#    git-rev-list ... 2>&1 | sed "$(cat sed.script)" 
+#
+# if you ever want to manually debug the operation of git-rev-list
+#
+echo $sed_script > sed.script
+
+test_expect_success 'Testing that the rev-list has correct number of entries' 'git-rev-list HEAD | wc -l | tr -s " "' <<EOF
+19
+EOF
+
+normal_adjacency_count=$(git-rev-list HEAD | check_adjacency | grep -c "\^" | tr -d ' ')
+merge_order_adjacency_count=$(git-rev-list --merge-order HEAD | check_adjacency | grep -c "\^" | tr -d ' ')
+test_expect_success 'Testing that --merge-order produces as many or fewer discontinuities' '[ $merge_order_adjacency_count -le $normal_adjacency_count ]'
 
-git-rev-list --merge-order --show-breaks HEAD | sed "$(sed_script)" > actual-merge-order
-cat > expected-merge-order <<EOF
+test_output_expect_success 'Simple Merge Order Test' 'git-rev-list --merge-order --show-breaks HEAD' <<EOF
 = l5
 | l4
 | l3
@@ -86,15 +183,7 @@ cat > expected-merge-order <<EOF
 = root
 EOF
 
-git-rev-list HEAD | check_adjacency | sed "$(sed_script)" > actual-default-order
-normal_adjacency_count=$(git-rev-list HEAD | check_adjacency | grep -c "\^" | tr -d ' ')
-merge_order_adjacency_count=$(git-rev-list --merge-order HEAD | check_adjacency | grep -c "\^" | tr -d ' ')
-
-test_expect_success 'Testing that the rev-list has correct number of entries' '[ $(git-rev-list HEAD | wc -l) -eq 19 ]'
-test_expect_success 'Testing that --merge-order produces the correct result' 'diff expected-merge-order actual-merge-order'
-test_expect_success 'Testing that --merge-order produces as many or fewer discontinuities' '[ $merge_order_adjacency_count -le $normal_adjacency_count ]'
-
-cat > expected-merge-order-1 <<EOF
+test_output_expect_success 'Multiple heads' 'git-rev-list --merge-order a3 b3 c3' <<EOF
 c3
 c2
 c1
@@ -111,10 +200,7 @@ l0
 root
 EOF
 
-git-rev-list --merge-order $a3 $b3 $c3 | sed "$(sed_script)" > actual-merge-order-1
-test_expect_success 'Testing multiple heads' 'diff expected-merge-order-1 actual-merge-order-1'
-
-cat > expected-merge-order-2 <<EOF
+test_output_expect_success 'Prune at a1' 'git-rev-list --merge-order a3 b3 c3 ^a1' <<EOF
 c3
 c2
 c1
@@ -125,10 +211,7 @@ a3
 a2
 EOF
 
-git-rev-list --merge-order $a3 $b3 $c3 ^$a1 | sed "$(sed_script)" > actual-merge-order-2
-test_expect_success 'Testing stop' 'diff expected-merge-order-2 actual-merge-order-2'
-
-cat > expected-merge-order-3 <<EOF
+test_output_expect_success 'Prune at l1' 'git-rev-list --merge-order a3 b3 c3 ^l1' <<EOF
 c3
 c2
 c1
@@ -142,10 +225,26 @@ a0
 l2
 EOF
 
-git-rev-list --merge-order $a3 $b3 $c3 ^$l1 | sed "$(sed_script)" > actual-merge-order-3
-test_expect_success 'Testing stop in linear epoch' 'diff expected-merge-order-3 actual-merge-order-3'
+test_output_expect_success 'Head at l5, Prune at l1' 'git-rev-list --merge-order l5 ^l1' <<EOF
+l5
+l4
+l3
+a4
+c3
+c2
+c1
+b4
+b3
+b2
+b1
+a3
+a2
+a1
+a0
+l2
+EOF
 
-cat > expected-merge-order-4 <<EOF
+test_output_expect_success 'Duplicated head arguments' 'git-rev-list --merge-order l5 l5 ^l1' <<EOF
 l5
 l4
 l3
@@ -164,12 +263,136 @@ a0
 l2
 EOF
 
-git-rev-list --merge-order $l5 ^$l1 | sed "$(sed_script)" > actual-merge-order-4
-test_expect_success 'Testing start in linear epoch, stop after non-linear epoch' 'diff expected-merge-order-4 actual-merge-order-4'
+test_output_expect_success 'Prune near merge' 'git-rev-list --merge-order a4 ^c3' <<EOF
+a4
+b4
+b3
+a3
+a2
+a1
+EOF
+
+test_output_expect_success '--wrt-author foobar@example.com' 'git-rev-list --merge-order --show-breaks --wrt-author --author=foobar@example.com HEAD' <<EOF
+= l5
+| l4
+| l3
+= a4
+| c3
+| c2
+| c1
+^ b4
+| a3
+| a2
+| a1
+^ b3
+| b2
+| b1
+= a0
+| l2
+| l1
+| l0
+= root
+EOF
+
+test_output_expect_success "Prune at foobar@example.com" 'git-rev-list --show-breaks --wrt-author --author=foobar@example.com --prune-at-author HEAD' <<EOF
+= l5
+| l4
+| l3
+= a4
+| c3
+| c2
+| c1
+^ b4
+| a3
+| a2
+| a1
+^ b3
+| b2
+EOF
+
+test_output_expect_success "w.r.t e@example.com" 'git-rev-list --show-breaks --wrt-author --author=e@example.com e10 f9' <<EOF
+| f9
+^ e10
+| f8
+| f7
+| f6
+| f5
+^ e9
+| e8
+| e7
+| e6
+| f4
+| f3
+^ e5
+| e4
+| f2
+| f1
+^ e3
+| e2
+= e1
+EOF
 
-git-rev-list --merge-order $l5 $l5 ^$l1 2>/dev/null | sed "$(sed_script)" > actual-merge-order-5
-test_expect_success 'Testing duplicated start arguments' 'diff expected-merge-order-4 actual-merge-order-5'
 
-test_expect_success 'Testing exclusion near merge' 'git-rev-list --merge-order $a4 ^$c3 2>/dev/null'
+test_output_expect_success "w.r.t f@example.com" 'git-rev-list --show-breaks --wrt-author --author=f@example.com e10 f9' <<EOF
+| f9
+^ e10
+| f8
+| f7
+| f6
+| f5
+^ e9
+| e8
+| e7
+| e6
+| f4
+| f3
+^ e5
+| e4
+| e3
+| e2
+^ f2
+| f1
+= e1
+EOF
+
+as_author "" test_output_expect_success "w.r.t nobody" 'git-rev-list --show-breaks --wrt-author f9 e10' <<EOF
+| e10
+| e9
+| e8
+| e7
+^ f9
+| f8
+| f7
+| f6
+| e6
+| e5
+| e4
+| e3
+| e2
+^ f5
+| f4
+| f3
+| f2
+| f1
+= e1
+EOF
+
+test_output_expect_success "head has no parent" 'git-rev-list --show-breaks root' <<EOF
+= root
+EOF
+
+test_output_expect_success "two nodes - one head, one base" 'git-rev-list --show-breaks l0' <<EOF
+= l0
+= root
+EOF
+
+test_output_expect_success "three nodes one head, one internal, one base" 'git-rev-list --show-breaks l1' <<EOF
+= l1
+| l0
+= root
+EOF
 
+#
+#
+#
 test_done
diff --git a/user.c b/user.c
new file mode 100644
--- /dev/null
+++ b/user.c
@@ -0,0 +1,29 @@
+#include "cache.h"
+#include "user.h"
+#include <string.h>
+#include <pwd.h>
+
+void get_real_identity(char **email, char **gecos)
+{
+	static char buffer[1000];
+	struct passwd *pw;
+	int len;
+
+	pw = getpwuid(getuid());
+	if (!pw)
+		die("You don't exist. Go away!");
+
+	len = strlen(pw->pw_name);
+	memcpy(buffer, pw->pw_name, len);
+	buffer[len] = '@';
+	gethostname(buffer + len + 1, sizeof(buffer) - len - 1);
+	if (!strchr(buffer + len + 1, '.')) {
+		strcat(buffer, ".");
+		getdomainname(buffer + strlen(buffer), 
+				sizeof(buffer) - strlen(buffer) - 1);
+	}
+	if (gecos)
+		*gecos = strdup(pw->pw_gecos);
+	if (email)
+		*email = strdup(buffer);
+}
diff --git a/user.h b/user.h
new file mode 100644
--- /dev/null
+++ b/user.h
@@ -0,0 +1,8 @@
+#ifndef USER_H
+#define USER_H
+/*
+ * Allocates two new strings to contain the real email and
+ * name of the current user.
+ */
+extern void get_real_identity(char **email, char **gecos);
+#endif
