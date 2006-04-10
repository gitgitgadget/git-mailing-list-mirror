From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] git log --full-diff
Date: Mon, 10 Apr 2006 16:44:06 -0700
Message-ID: <7vek05808p.fsf_-_@assigned-by-dhcp.cox.net>
References: <7v7j5zce7x.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0604090950590.9504@g5.osdl.org>
	<7vodz980az.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Tue Apr 11 01:44:28 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FT63J-000158-Bq
	for gcvg-git@gmane.org; Tue, 11 Apr 2006 01:44:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932200AbWDJXoK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 10 Apr 2006 19:44:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932202AbWDJXoK
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Apr 2006 19:44:10 -0400
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:24532 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S932200AbWDJXoI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Apr 2006 19:44:08 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060410234407.RMTP20441.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 10 Apr 2006 19:44:07 -0400
To: git@vger.kernel.org
In-Reply-To: <7vodz980az.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Mon, 10 Apr 2006 16:42:44 -0700")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18597>

Without this flag, "git log -p paths..." shows commits that
touch the specified paths, and diffs about the same specified
paths.  With this, the full diff is shown for commits that touch
the specified paths.

Signed-off-by: Junio C Hamano <junkio@cox.net>

---

 git.c |   13 ++++++++++++-
 1 files changed, 12 insertions(+), 1 deletions(-)

fd3ed3d9667e034b90aad02b4f9e5efcc61f1ce3
diff --git a/git.c b/git.c
index 8776088..ad896da 100644
--- a/git.c
+++ b/git.c
@@ -288,7 +288,9 @@ static int cmd_log(int argc, const char 
 	int abbrev_commit = 0;
 	const char *commit_prefix = "commit ";
 	struct log_tree_opt opt;
+	int shown = 0;
 	int do_diff = 0;
+	int full_diff = 0;
 
 	init_log_tree_opt(&opt);
 	argc = setup_revisions(argc, argv, &rev, "HEAD");
@@ -315,6 +317,10 @@ static int cmd_log(int argc, const char 
 			else if (40 < abbrev)
 				abbrev = 40;
 		}
+		else if (!strcmp(arg, "--full-diff")) {
+			do_diff = 1;
+			full_diff = 1;
+		}
 		else {
 			int cnt = log_tree_opt_parse(&opt, argv+1, argc-1);
 			if (0 < cnt) {
@@ -328,6 +334,7 @@ static int cmd_log(int argc, const char 
 
 		argc--; argv++;
 	}
+
 	if (do_diff) {
 		opt.diffopt.abbrev = abbrev;
 		opt.verbose_header = 0;
@@ -339,12 +346,16 @@ static int cmd_log(int argc, const char 
 			opt.diffopt.output_format = DIFF_FORMAT_PATCH;
 		if (opt.diffopt.output_format == DIFF_FORMAT_PATCH)
 			opt.diffopt.recursive = 1;
+		if (!full_diff && rev.prune_data)
+			diff_tree_setup_paths(rev.prune_data, &opt.diffopt);
 		diff_setup_done(&opt.diffopt);
 	}
 
 	prepare_revision_walk(&rev);
 	setup_pager();
 	while ((commit = get_revision(&rev)) != NULL) {
+		if (commit_format != CMIT_FMT_ONELINE && shown)
+			putchar('\n');
 		fputs(commit_prefix, stdout);
 		if (abbrev_commit && abbrev)
 			fputs(find_unique_abbrev(commit->object.sha1, abbrev),
@@ -377,9 +388,9 @@ static int cmd_log(int argc, const char 
 		pretty_print_commit(commit_format, commit, ~0, buf,
 				    LOGSIZE, abbrev);
 		printf("%s\n", buf);
-
 		if (do_diff)
 			log_tree_commit(&opt, commit);
+		shown = 1;
 	}
 	free(buf);
 	return 0;
-- 
1.3.0.rc3.g910a
