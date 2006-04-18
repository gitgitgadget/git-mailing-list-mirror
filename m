From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] diff --stat: make sure to set recursive.
Date: Tue, 18 Apr 2006 11:33:19 -0700
Message-ID: <7v7j5mg2ds.fsf_-_@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0604161433000.3701@g5.osdl.org>
	<7vbqv1oxie.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0604171149330.3701@g5.osdl.org>
	<7vodyzkehq.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0604171647380.3701@g5.osdl.org>
	<7vejzvka09.fsf@assigned-by-dhcp.cox.net>
	<7v7j5nk9bf.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0604171751540.3701@g5.osdl.org>
	<7vd5ffig70.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0604180827040.3701@g5.osdl.org>
	<Pine.LNX.4.64.0604180854550.3701@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 18 20:33:35 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FVv10-0004N0-TF
	for gcvg-git@gmane.org; Tue, 18 Apr 2006 20:33:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932101AbWDRSdV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 18 Apr 2006 14:33:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932237AbWDRSdV
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Apr 2006 14:33:21 -0400
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:22403 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S932101AbWDRSdU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Apr 2006 14:33:20 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060418183320.XKF17757.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 18 Apr 2006 14:33:20 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0604180854550.3701@g5.osdl.org> (Linus Torvalds's
	message of "Tue, 18 Apr 2006 09:06:02 -0700 (PDT)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18868>

Linus Torvalds <torvalds@osdl.org> writes:

> Junio, I just tested the "master" branch, and "git log --stat" doesn't 
> work there. You may _think_ it works because you've tested it on the git 
> tree, were it looks like it is working, but it's missing setting 
> "recursive", so it won't actually go into any subdirectories (so it mostly 
> works for git itself which has most stuff in the top-level directory, but 
> it almost completely doesn't work for linux)

True.  It shows that I usually install and use "next" version
exclusively, which is fine during the normal development phase,
but it was a wrong thing to keep doing just before the release.

I think diff-tree --stat has the same problem in "master", so
I'd do it slightly differently.

-- >8 --
Just like "patch" format always needs recursive, "diffstat"
format does not make sense without setting recursive.

Signed-off-by: Junio C Hamano <junkio@cox.net>

---

 diff-tree.c |    3 ---
 diff.c      |   10 ++++++++++
 git.c       |    2 --
 3 files changed, 10 insertions(+), 5 deletions(-)

f56ef54174598d5362d0446c5a560cb5892537c2
diff --git a/diff-tree.c b/diff-tree.c
index 7015b06..d1c61c8 100644
--- a/diff-tree.c
+++ b/diff-tree.c
@@ -117,9 +117,6 @@ int main(int argc, const char **argv)
 	if (opt->dense_combined_merges)
 		opt->diffopt.output_format = DIFF_FORMAT_PATCH;
 
-	if (opt->diffopt.output_format == DIFF_FORMAT_PATCH)
-		opt->diffopt.recursive = 1;
-
 	diff_tree_setup_paths(get_pathspec(prefix, argv), &opt->diffopt);
 	diff_setup_done(&opt->diffopt);
 
diff --git a/diff.c b/diff.c
index b54bbfa..3a1e6ce 100644
--- a/diff.c
+++ b/diff.c
@@ -1029,6 +1029,16 @@ int diff_setup_done(struct diff_options 
 	     options->detect_rename != DIFF_DETECT_COPY) ||
 	    (0 <= options->rename_limit && !options->detect_rename))
 		return -1;
+
+	/*
+	 * These cases always need recursive; we do not drop caller-supplied
+	 * recursive bits for other formats here.
+	 */
+	if ((options->output_format == DIFF_FORMAT_PATCH) ||
+	    (options->output_format == DIFF_FORMAT_DIFFSTAT) ||
+	    (options->with_stat))
+		options->recursive = 1;
+
 	if (options->detect_rename && options->rename_limit < 0)
 		options->rename_limit = diff_rename_limit_default;
 	if (options->setup & DIFF_SETUP_USE_CACHE) {
diff --git a/git.c b/git.c
index 140ed18..5209b04 100644
--- a/git.c
+++ b/git.c
@@ -344,8 +344,6 @@ static int cmd_log(int argc, const char 
 			opt.ignore_merges = 0;
 		if (opt.dense_combined_merges)
 			opt.diffopt.output_format = DIFF_FORMAT_PATCH;
-		if (opt.diffopt.output_format == DIFF_FORMAT_PATCH)
-			opt.diffopt.recursive = 1;
 		if (!full_diff && rev.prune_data)
 			diff_tree_setup_paths(rev.prune_data, &opt.diffopt);
 		diff_setup_done(&opt.diffopt);
-- 
1.3.0.rc4.g8060
