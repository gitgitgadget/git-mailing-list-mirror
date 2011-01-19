From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 39/47] setup: limit get_git_work_tree()'s to explicit
 setup case only
Date: Wed, 19 Jan 2011 08:58:46 +0700
Message-ID: <AANLkTi=bm6KO24XTMA+LM+xnszgFHJiV0inXZ-RJwwd-@mail.gmail.com>
References: <1290785563-15339-1-git-send-email-pclouds@gmail.com>
 <1290785563-15339-40-git-send-email-pclouds@gmail.com> <20110118074400.GA4185@burratino>
 <7v1v4aknij.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 19 02:59:23 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PfNKV-0001X9-18
	for gcvg-git-2@lo.gmane.org; Wed, 19 Jan 2011 02:59:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753383Ab1ASB7S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Jan 2011 20:59:18 -0500
Received: from mail-wy0-f174.google.com ([74.125.82.174]:41924 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753351Ab1ASB7R (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Jan 2011 20:59:17 -0500
Received: by wyb28 with SMTP id 28so362595wyb.19
        for <git@vger.kernel.org>; Tue, 18 Jan 2011 17:59:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=NMIBgnsH+SchBv1vurdh4ZRc/KM+Y5qQC3KRZEVssnM=;
        b=AuesDjXAu6NSSl9f4lE4DSDtCRKZ8dIfkydbnD2Q9k3DYQm64o56u9ymn3T6vkOhAg
         VB4uxO/6sNTZTJVWrN233wh7Xa769wqiiLp8tz1kjFqDwaAxAJQkN2F/suLtj4rEKnCQ
         5EKP9M9SDOnYlDjpS5G8b2VJSuvQP1A+fRA98=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=rgSfZDrZPGLgIMOHBqYZtF3vCaAhQhB600SHLOgOYGaf7lAYwdJmabXndVvptHdrUp
         NSvA41nzMao17TmB4wWQ2o3z3Cuw8HoMtdj/Gu0dMWHi33S3aJB2jiPQgMmtBnrDxO9F
         GAv8sUvHb2WCxsRPVW8+eFZvAHJQ0MZmVMwBY=
Received: by 10.216.49.193 with SMTP id x43mr77805web.19.1295402356134; Tue,
 18 Jan 2011 17:59:16 -0800 (PST)
Received: by 10.216.63.14 with HTTP; Tue, 18 Jan 2011 17:58:46 -0800 (PST)
In-Reply-To: <7v1v4aknij.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165236>

2011/1/19 Junio C Hamano <gitster@pobox.com>:
> This is for people who do "cd .git && GIT_WORK_TREE=.. git cmd". I have to
> wonder what happens to the pathspec given to the cmd---you are clearly
> outside of your working tree.

pathspecs are relative to worktree's root because prefix is NULL in
this case. Not very intuitive. And pathspecs that are supposed to take
files relative to user's cwd simply fail.

> Do we make sure that whatever GIT_WORK_TREE we end up with using is an
> ancestor directory of the $CWD when we require us to be inside the working
> tree?

We don't for most of commands (i.e. blindly chdir(worktree) in
setup_work_tree()). Only two commands (ls-files and rev-parse) seem to
do that.

> I think we should, as I don't think of a sane use case otherwise
> (unless you call "cd ../neigh; GIT_WORK_TREE=../work git diff ../work/foo"
> a sane way to futz with the file "foo" in the working tree "work" from a
> directory "neigh" that is unrelated to the repository).

But we don't strictly need that for whole tree operations. If
pathspecs are not given, wherever worktree is compared to cwd does not
matter much. The tricky thing is, when setup code does not know in
advance whether pathspecs are given. Perhaps something (untested) like
this for a start? Some commands like commit can also have
WHOLE_WORK_TREE, but it needs to check for is_inside_work_tree() by
itself it pathspec is given.

diff --git a/git.c b/git.c
index 68334f6..28abbdd 100644
--- a/git.c
+++ b/git.c
@@ -248,6 +248,10 @@ const char git_version_string[] = GIT_VERSION;
  * RUN_SETUP for reading from the configuration file.
  */
 #define NEED_WORK_TREE		(1<<3)
+/*
+ * This command only works on work tree as a whole
+ */
+#define WHOLE_WORK_TREE         (1<<4)

 struct cmd_struct {
 	const char *cmd;
@@ -283,7 +287,7 @@ static int run_builtin(struct cmd_struct *p, int
argc, const char **argv)
 	commit_pager_choice();

 	if (!help && p->option & NEED_WORK_TREE)
-		setup_work_tree();
+		setup_work_tree(p->option & WHOLE_WORK_TREE);

 	trace_argv_printf(argv, "trace: built-in: git");

@@ -328,7 +332,7 @@ static void handle_internal_command(int argc,
const char **argv)
 		{ "check-ref-format", cmd_check_ref_format },
 		{ "check-attr", cmd_check_attr, RUN_SETUP },
 		{ "cherry", cmd_cherry, RUN_SETUP },
-		{ "cherry-pick", cmd_cherry_pick, RUN_SETUP | NEED_WORK_TREE },
+		{ "cherry-pick", cmd_cherry_pick, RUN_SETUP | NEED_WORK_TREE |
WHOLE_WORK_TREE },
 		{ "clone", cmd_clone },
 		{ "clean", cmd_clean, RUN_SETUP | NEED_WORK_TREE },
 		{ "commit", cmd_commit, RUN_SETUP | NEED_WORK_TREE },
@@ -362,7 +366,7 @@ static void handle_internal_command(int argc,
const char **argv)
 		{ "ls-remote", cmd_ls_remote, RUN_SETUP_GENTLY },
 		{ "mailinfo", cmd_mailinfo },
 		{ "mailsplit", cmd_mailsplit },
-		{ "merge", cmd_merge, RUN_SETUP | NEED_WORK_TREE },
+		{ "merge", cmd_merge, RUN_SETUP | NEED_WORK_TREE | WHOLE_WORK_TREE },
 		{ "merge-base", cmd_merge_base, RUN_SETUP },
 		{ "merge-file", cmd_merge_file, RUN_SETUP_GENTLY },
 		{ "merge-index", cmd_merge_index, RUN_SETUP },
@@ -397,13 +401,13 @@ static void handle_internal_command(int argc,
const char **argv)
 		{ "reset", cmd_reset, RUN_SETUP },
 		{ "rev-list", cmd_rev_list, RUN_SETUP },
 		{ "rev-parse", cmd_rev_parse },
-		{ "revert", cmd_revert, RUN_SETUP | NEED_WORK_TREE },
+		{ "revert", cmd_revert, RUN_SETUP | NEED_WORK_TREE | WHOLE_WORK_TREE },
 		{ "rm", cmd_rm, RUN_SETUP },
 		{ "send-pack", cmd_send_pack, RUN_SETUP },
 		{ "shortlog", cmd_shortlog, RUN_SETUP_GENTLY | USE_PAGER },
 		{ "show-branch", cmd_show_branch, RUN_SETUP },
 		{ "show", cmd_show, RUN_SETUP },
-		{ "status", cmd_status, RUN_SETUP | NEED_WORK_TREE },
+		{ "status", cmd_status, RUN_SETUP | NEED_WORK_TREE | WHOLE_WORK_TREE },
 		{ "stripspace", cmd_stripspace },
 		{ "symbolic-ref", cmd_symbolic_ref, RUN_SETUP },
 		{ "tag", cmd_tag, RUN_SETUP },
diff --git a/setup.c b/setup.c
index 3d73269..c14e55c 100644
--- a/setup.c
+++ b/setup.c
@@ -208,7 +208,7 @@ int is_inside_work_tree(void)
 	return inside_work_tree;
 }

-void setup_work_tree(void)
+void setup_work_tree(int gently)
 {
 	const char *work_tree, *git_dir;
 	static int initialized = 0;
@@ -219,7 +219,11 @@ void setup_work_tree(void)
 	git_dir = get_git_dir();
 	if (!is_absolute_path(git_dir))
 		git_dir = make_absolute_path(git_dir);
-	if (!work_tree || chdir(work_tree))
+	if (work_tree && (gently || is_inside_work_tree()))
+		; 		/* Good */
+	else
+		die("This operation must be run in a work tree");
+	if (chdir(work_tree))
 		die("This operation must be run in a work tree");

 	/*

-- 
Duy
