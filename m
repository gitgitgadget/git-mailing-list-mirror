From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] git-branch: add --sort-by-date option
Date: Wed, 28 Mar 2007 01:03:57 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0703280056140.4045@wbgn013.biozentrum.uni-wuerzburg.de>
References: <17929.37382.984339.742025@lisa.zopyra.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Bill Lear <rael@zopyra.com>
X-From: git-owner@vger.kernel.org Wed Mar 28 01:04:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HWKiB-0005K2-7o
	for gcvg-git@gmane.org; Wed, 28 Mar 2007 01:04:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933187AbXC0XEB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Mar 2007 19:04:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933230AbXC0XEB
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Mar 2007 19:04:01 -0400
Received: from mail.gmx.net ([213.165.64.20]:52260 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S933187AbXC0XD7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Mar 2007 19:03:59 -0400
Received: (qmail invoked by alias); 27 Mar 2007 23:03:58 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO wbgn013.biozentrum.uni-wuerzburg.de) [132.187.25.13]
  by mail.gmx.net (mp054) with SMTP; 28 Mar 2007 01:03:58 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/VFel21VbVxSJhGsut/JGr1TsQq/WbtBVr5hsw7F
	MxoOmbPRiuxx1J
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <17929.37382.984339.742025@lisa.zopyra.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43317>


With `--sort-by-date`, git-branch prints the refs sorted by date of the
refs' tips (newest first). If this option is combined with `-v`, also
print the dates of the tips.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

	On Tue, 27 Mar 2007, Bill Lear wrote:

	> [...] I sometimes forget what the contents of a topic branch 
	> are, how old it is, etc.  As to content, I can make better 
	> branch names, but I think it would be useful to be able to query 
	> git as to the creation time of all of my branches, perhaps 
	> sorted from newest to oldest.

	This is only lightly tested, and I will not have time to work any 
	more on this. So, if this does not what you want, you will have to 
	fix it yourself.

 Documentation/git-branch.txt |    5 +++-
 builtin-branch.c             |   52 +++++++++++++++++++++++++++++++++--------
 2 files changed, 46 insertions(+), 11 deletions(-)

diff --git a/Documentation/git-branch.txt b/Documentation/git-branch.txt
index 603f87f..ca32d5d 100644
--- a/Documentation/git-branch.txt
+++ b/Documentation/git-branch.txt
@@ -9,7 +9,7 @@ SYNOPSIS
 --------
 [verse]
 'git-branch' [--color | --no-color] [-r | -a]
-	   [-v [--abbrev=<length> | --no-abbrev]]
+	   [-v [--abbrev=<length> | --no-abbrev]] [--sort-by-date]
 'git-branch' [--track | --no-track] [-l] [-f] <branchname> [<start-point>]
 'git-branch' (-m | -M) [<oldbranch>] <newbranch>
 'git-branch' (-d | -D) [-r] <branchname>...
@@ -91,6 +91,9 @@ OPTIONS
 --no-abbrev::
 	Display the full sha1s in output listing rather than abbreviating them.
 
+--sort-by-date::
+	Instead of sorting by name, sort the refs by date of their tips.
+
 <branchname>::
 	The name of the branch to create or delete.
 	The new branch name must pass all checks defined by
diff --git a/builtin-branch.c b/builtin-branch.c
index a4494ee..8deb155 100644
--- a/builtin-branch.c
+++ b/builtin-branch.c
@@ -12,7 +12,7 @@
 #include "builtin.h"
 
 static const char builtin_branch_usage[] =
-  "git-branch [-r] (-d | -D) <branchname> | [--track | --no-track] [-l] [-f] <branchname> [<start-point>] | (-m | -M) [<oldbranch>] <newbranch> | [--color | --no-color] [-r | -a] [-v [--abbrev=<length> | --no-abbrev]]";
+  "git-branch [-r] (-d | -D) <branchname> | [--track | --no-track] [-l] [-f] <branchname> [<start-point>] | (-m | -M) [<oldbranch>] <newbranch> | [--color | --no-color] [-r | -a] [-v [--abbrev=<length> | --no-abbrev]] [--sort-by-date]";
 
 #define REF_UNKNOWN_TYPE    0x00
 #define REF_LOCAL_BRANCH    0x01
@@ -236,8 +236,26 @@ static int ref_cmp(const void *r1, const void *r2)
 	return strcmp(c1->name, c2->name);
 }
 
+static int ref_cmp_by_author_date(const void *r1, const void *r2)
+{
+	struct ref_item *i1 = (struct ref_item *)r1;
+	struct ref_item *i2 = (struct ref_item *)r2;
+	struct commit *c1 = lookup_commit(i1->sha1);
+	struct commit *c2 = lookup_commit(i2->sha1);
+	if (!c1 || parse_commit(c1))
+		return +1;
+	if (!c2 || parse_commit(c2))
+		return -1;
+	if (c1->date < c2->date)
+		return +1;
+	else if (c1->date > c2->date)
+		return -1;
+	return 0;
+}
+
+
 static void print_ref_item(struct ref_item *item, int maxwidth, int verbose,
-			   int abbrev, int current)
+			   int abbrev, int current, int show_author_date)
 {
 	char c;
 	int color;
@@ -264,11 +282,17 @@ static void print_ref_item(struct ref_item *item, int maxwidth, int verbose,
 
 	if (verbose) {
 		commit = lookup_commit(item->sha1);
-		if (commit && !parse_commit(commit))
+		if (commit && !parse_commit(commit)) {
+			int offset = 0;
+			if (show_author_date)
+				offset = snprintf(subject, sizeof(subject),
+					"%s ", show_date(commit->date, 0,
+					DATE_SHORT));
 			pretty_print_commit(CMIT_FMT_ONELINE, commit, ~0,
-					    subject, sizeof(subject), 0,
+					    subject + offset,
+					    sizeof(subject) - offset, 0,
 					    NULL, NULL, 0);
-		else
+		} else
 			strcpy(subject, " **** invalid ref ****");
 		printf("%c %s%-*s%s %s %s\n", c, branch_get_color(color),
 		       maxwidth, item->name,
@@ -280,7 +304,8 @@ static void print_ref_item(struct ref_item *item, int maxwidth, int verbose,
 	}
 }
 
-static void print_ref_list(int kinds, int detached, int verbose, int abbrev)
+static void print_ref_list(int kinds, int detached, int verbose, int abbrev,
+	int sort_by_date)
 {
 	int i;
 	struct ref_list ref_list;
@@ -289,7 +314,8 @@ static void print_ref_list(int kinds, int detached, int verbose, int abbrev)
 	ref_list.kinds = kinds;
 	for_each_ref(append_ref, &ref_list);
 
-	qsort(ref_list.list, ref_list.index, sizeof(struct ref_item), ref_cmp);
+	qsort(ref_list.list, ref_list.index, sizeof(struct ref_item),
+		sort_by_date ? ref_cmp_by_author_date : ref_cmp);
 
 	detached = (detached && (kinds & REF_LOCAL_BRANCH));
 	if (detached) {
@@ -299,7 +325,8 @@ static void print_ref_list(int kinds, int detached, int verbose, int abbrev)
 		hashcpy(item.sha1, head_sha1);
 		if (strlen(item.name) > ref_list.maxwidth)
 			      ref_list.maxwidth = strlen(item.name);
-		print_ref_item(&item, ref_list.maxwidth, verbose, abbrev, 1);
+		print_ref_item(&item, ref_list.maxwidth, verbose, abbrev, 1,
+			sort_by_date);
 		free(item.name);
 	}
 
@@ -308,7 +335,7 @@ static void print_ref_list(int kinds, int detached, int verbose, int abbrev)
 			(ref_list.list[i].kind == REF_LOCAL_BRANCH) &&
 			!strcmp(ref_list.list[i].name, head);
 		print_ref_item(&ref_list.list[i], ref_list.maxwidth, verbose,
-			       abbrev, current);
+			       abbrev, current, sort_by_date);
 	}
 
 	free_ref_list(&ref_list);
@@ -530,6 +557,7 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 	int verbose = 0, abbrev = DEFAULT_ABBREV, detached = 0;
 	int reflog = 0, track;
 	int kinds = REF_LOCAL_BRANCH;
+	int sort_by_date = 0;
 	int i;
 
 	git_config(git_branch_config);
@@ -610,6 +638,10 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 			branch_use_color = 0;
 			continue;
 		}
+		if (!strcmp(arg, "--sort-by-date")) {
+			sort_by_date = 1;
+			continue;
+		}
 		usage(builtin_branch_usage);
 	}
 
@@ -632,7 +664,7 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 	if (delete)
 		return delete_branches(argc - i, argv + i, force_delete, kinds);
 	else if (i == argc)
-		print_ref_list(kinds, detached, verbose, abbrev);
+		print_ref_list(kinds, detached, verbose, abbrev, sort_by_date);
 	else if (rename && (i == argc - 1))
 		rename_branch(head, argv[i], force_rename);
 	else if (rename && (i == argc - 2))
-- 
1.5.1.rc2.2330.g2388
