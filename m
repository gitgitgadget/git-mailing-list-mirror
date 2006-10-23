From: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH] Built-in cherry
Date: Tue, 24 Oct 2006 01:01:57 +0200
Message-ID: <453D49E5.3050902@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Yann Dirson <ydirson@altern.org>
X-From: git-owner@vger.kernel.org Tue Oct 24 01:02:20 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Gc8oB-00073n-K0
	for gcvg-git@gmane.org; Tue, 24 Oct 2006 01:02:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932302AbWJWXCM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 23 Oct 2006 19:02:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932360AbWJWXCM
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Oct 2006 19:02:12 -0400
Received: from static-ip-217-172-187-230.inaddr.intergenia.de ([217.172.187.230]:13475
	"EHLO neapel230.server4you.de") by vger.kernel.org with ESMTP
	id S932302AbWJWXCK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Oct 2006 19:02:10 -0400
Received: from [10.0.1.3] (p508E6206.dip.t-dialin.net [80.142.98.6])
	by neapel230.server4you.de (Postfix) with ESMTP id B809D8016;
	Tue, 24 Oct 2006 01:02:06 +0200 (CEST)
User-Agent: Thunderbird 1.5.0.7 (Windows/20060909)
To: Junio C Hamano <junkio@cox.net>
X-Enigmail-Version: 0.94.0.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29897>

This replaces the shell script git-cherry with a version written in C.

The behaviour of the new version differs from the original in two
points: it has no long help any more, and it is handling the (optional)
third parameter a bit differently.  Basically, it does the equivalent
of

   ours=`git-rev-list $ours ^$limit ^$upstream`

instead of

   ours=`git-rev-list $ours ^$limit`

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
---

I'm not really sure if the limit behaviour change matches the original
intent of this feature; Yann, please holler if it doesn't.

 Makefile      |    4 +-
 builtin-log.c |  106 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 builtin.h     |    1 +
 git-cherry.sh |   91 -------------------------------------------------
 git.c         |    1 +
 5 files changed, 110 insertions(+), 93 deletions(-)

diff --git a/Makefile b/Makefile
index 66c8b4b..2b53747 100644
--- a/Makefile
+++ b/Makefile
@@ -157,7 +157,7 @@ BASIC_LDFLAGS =
 
 SCRIPT_SH = \
 	git-bisect.sh git-branch.sh git-checkout.sh \
-	git-cherry.sh git-clean.sh git-clone.sh git-commit.sh \
+	git-clean.sh git-clone.sh git-commit.sh \
 	git-fetch.sh \
 	git-ls-remote.sh \
 	git-merge-one-file.sh git-parse-remote.sh \
@@ -210,7 +210,7 @@ # Empty...
 EXTRA_PROGRAMS =
 
 BUILT_INS = \
-	git-format-patch$X git-show$X git-whatchanged$X \
+	git-format-patch$X git-show$X git-whatchanged$X git-cherry$X \
 	git-get-tar-commit-id$X \
 	$(patsubst builtin-%.o,git-%$X,$(BUILTIN_OBJS))
 
diff --git a/builtin-log.c b/builtin-log.c
index 9d1ceae..840c742 100644
--- a/builtin-log.c
+++ b/builtin-log.c
@@ -437,3 +437,109 @@ int cmd_format_patch(int argc, const cha
 	return 0;
 }
 
+static int add_pending_commit(const char *arg, struct rev_info *revs, int flags)
+{
+	unsigned char sha1[20];
+	if (get_sha1(arg, sha1) == 0) {
+		struct commit *commit = lookup_commit_reference(sha1);
+		if (commit) {
+			commit->object.flags |= flags;
+			add_pending_object(revs, &commit->object, arg);
+			return 0;
+		}
+	}
+	return -1;
+}
+
+static const char cherry_usage[] =
+"git-cherry [-v] <upstream> [<head>] [<limit>]";
+int cmd_cherry(int argc, const char **argv, const char *prefix)
+{
+	struct rev_info revs;
+	struct diff_options patch_id_opts;
+	struct commit *commit;
+	struct commit_list *list = NULL;
+	const char *upstream;
+	const char *head = "HEAD";
+	const char *limit = NULL;
+	int verbose = 0;
+
+	if (argc > 1 && !strcmp(argv[1], "-v")) {
+		verbose = 1;
+		argc--;
+		argv++;
+	}
+
+	switch (argc) {
+	case 4:
+		limit = argv[3];
+		/* FALLTHROUGH */
+	case 3:
+		head = argv[2];
+		/* FALLTHROUGH */
+	case 2:
+		upstream = argv[1];
+		break;
+	default:
+		usage(cherry_usage);
+	}
+
+	init_revisions(&revs, prefix);
+	revs.diff = 1;
+	revs.combine_merges = 0;
+	revs.ignore_merges = 1;
+	revs.diffopt.recursive = 1;
+
+	if (add_pending_commit(head, &revs, 0))
+		die("Unknown commit %s", head);
+	if (add_pending_commit(upstream, &revs, UNINTERESTING))
+		die("Unknown commit %s", upstream);
+
+	/* Don't say anything if head and upstream are the same. */
+	if (revs.pending.nr == 2) {
+		struct object_array_entry *o = revs.pending.objects;
+		if (hashcmp(o[0].item->sha1, o[1].item->sha1) == 0)
+			return 0;
+	}
+
+	get_patch_ids(&revs, &patch_id_opts, prefix);
+
+	if (limit && add_pending_commit(limit, &revs, UNINTERESTING))
+		die("Unknown commit %s", limit);
+
+	/* reverse the list of commits */
+	prepare_revision_walk(&revs);
+	while ((commit = get_revision(&revs)) != NULL) {
+		/* ignore merges */
+		if (commit->parents && commit->parents->next)
+			continue;
+
+		commit_list_insert(commit, &list);
+	}
+
+	while (list) {
+		unsigned char sha1[20];
+		char sign = '+';
+
+		commit = list->item;
+		if (!get_patch_id(commit, &patch_id_opts, sha1) &&
+		    lookup_object(sha1))
+			sign = '-';
+
+		if (verbose) {
+			static char buf[16384];
+			pretty_print_commit(CMIT_FMT_ONELINE, commit, ~0,
+			                    buf, sizeof(buf), 0, NULL, NULL, 0);
+			printf("%c %s %s\n", sign, 
+			       sha1_to_hex(commit->object.sha1), buf);
+		}
+		else {
+			printf("%c %s\n", sign,
+			       sha1_to_hex(commit->object.sha1));
+		}
+
+		list = list->next;
+	}
+
+	return 0;
+}
diff --git a/builtin.h b/builtin.h
index f71b962..285d98f 100644
--- a/builtin.h
+++ b/builtin.h
@@ -19,6 +19,7 @@ extern int cmd_archive(int argc, const c
 extern int cmd_cat_file(int argc, const char **argv, const char *prefix);
 extern int cmd_checkout_index(int argc, const char **argv, const char *prefix);
 extern int cmd_check_ref_format(int argc, const char **argv, const char *prefix);
+extern int cmd_cherry(int argc, const char **argv, const char *prefix);
 extern int cmd_commit_tree(int argc, const char **argv, const char *prefix);
 extern int cmd_count_objects(int argc, const char **argv, const char *prefix);
 extern int cmd_diff_files(int argc, const char **argv, const char *prefix);
diff --git a/git-cherry.sh b/git-cherry.sh
deleted file mode 100755
index 8832573..0000000
--- a/git-cherry.sh
+++ /dev/null
@@ -1,91 +0,0 @@
-#!/bin/sh
-#
-# Copyright (c) 2005 Junio C Hamano.
-#
-
-USAGE='[-v] <upstream> [<head>] [<limit>]'
-LONG_USAGE='             __*__*__*__*__> <upstream>
-            /
-  fork-point
-            \__+__+__+__+__+__+__+__> <head>
-
-Each commit between the fork-point (or <limit> if given) and <head> is
-examined, and compared against the change each commit between the
-fork-point and <upstream> introduces.  If the change seems to be in
-the upstream, it is shown on the standard output with prefix "+".
-Otherwise it is shown with prefix "-".'
-. git-sh-setup
-
-case "$1" in -v) verbose=t; shift ;; esac 
-
-case "$#,$1" in
-1,*..*)
-    upstream=$(expr "z$1" : 'z\(.*\)\.\.') ours=$(expr "z$1" : '.*\.\.\(.*\)$')
-    set x "$upstream" "$ours"
-    shift ;;
-esac
-
-case "$#" in
-1) upstream=`git-rev-parse --verify "$1"` &&
-   ours=`git-rev-parse --verify HEAD` || exit
-   limit="$upstream"
-   ;;
-2) upstream=`git-rev-parse --verify "$1"` &&
-   ours=`git-rev-parse --verify "$2"` || exit
-   limit="$upstream"
-   ;;
-3) upstream=`git-rev-parse --verify "$1"` &&
-   ours=`git-rev-parse --verify "$2"` &&
-   limit=`git-rev-parse --verify "$3"` || exit
-   ;;
-*) usage ;;
-esac
-
-# Note that these list commits in reverse order;
-# not that the order in inup matters...
-inup=`git-rev-list ^$ours $upstream` &&
-ours=`git-rev-list $ours ^$limit` || exit
-
-tmp=.cherry-tmp$$
-patch=$tmp-patch
-mkdir $patch
-trap "rm -rf $tmp-*" 0 1 2 3 15
-
-for c in $inup
-do
-	git-diff-tree -p $c
-done | git-patch-id |
-while read id name
-do
-	echo $name >>$patch/$id
-done
-
-LF='
-'
-
-O=
-for c in $ours
-do
-	set x `git-diff-tree -p $c | git-patch-id`
-	if test "$2" != ""
-	then
-		if test -f "$patch/$2"
-		then
-			sign=-
-		else
-			sign=+
-		fi
-		case "$verbose" in
-		t)
-			c=$(git-rev-list --pretty=oneline --max-count=1 $c)
-		esac
-		case "$O" in
-		'')	O="$sign $c" ;;
-		*)	O="$sign $c$LF$O" ;;
-		esac
-	fi
-done
-case "$O" in
-'') ;;
-*)  echo "$O" ;;
-esac
diff --git a/git.c b/git.c
index e089b53..f8c991f 100644
--- a/git.c
+++ b/git.c
@@ -224,6 +224,7 @@ static void handle_internal_command(int 
 		{ "cat-file", cmd_cat_file, RUN_SETUP },
 		{ "checkout-index", cmd_checkout_index, RUN_SETUP },
 		{ "check-ref-format", cmd_check_ref_format },
+		{ "cherry", cmd_cherry, RUN_SETUP },
 		{ "commit-tree", cmd_commit_tree, RUN_SETUP },
 		{ "count-objects", cmd_count_objects, RUN_SETUP },
 		{ "diff", cmd_diff, RUN_SETUP | USE_PAGER },
