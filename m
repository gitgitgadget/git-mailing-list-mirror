From: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
Subject: [PATCH] rebase: use @{upstream} if no upstream specified
Date: Mon,  7 Feb 2011 19:37:55 -0500
Message-ID: <1297125475-19151-1-git-send-email-martin.von.zweigbergk@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Yann Dirson <ydirson@altern.org>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 08 01:38:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pmbb8-0000eW-85
	for gcvg-git-2@lo.gmane.org; Tue, 08 Feb 2011 01:38:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755412Ab1BHAiV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Feb 2011 19:38:21 -0500
Received: from mail-vx0-f174.google.com ([209.85.220.174]:61008 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754212Ab1BHAiT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Feb 2011 19:38:19 -0500
Received: by vxb37 with SMTP id 37so1957593vxb.19
        for <git@vger.kernel.org>; Mon, 07 Feb 2011 16:38:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer;
        bh=gSmkjySO6V9yENhymzxVRrfa3hJPRhvzai258cNfwu4=;
        b=iadE0VN+DlkWXNbyFmipFPZ/zASfSpXAbDqvRobAmqfwRIP50uHeRRBXGWpmeUA26q
         uJnY6eV0t7BLcCkf1YjIKEunZWuKC9U8LKVrCvujok34qLEa3I+J2GoUbQ0GivqikpXn
         EWIXIFCzD4z58x6HwTRkcLQoCXPesaGCEefN0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=dt3mg6ZWQ5ylAxbVUWCx80zNFtga2Tu+MJmA+/4VWjioAJRJoO1lXt+mzN0SM0O9Os
         QOoHpjLsCO3KyyYKytqmIAg58Z3MsrC/0IEuKbmZ1T0bXIbA6zEGC0e+80hxvG+NHrz+
         CH2r7jJ67wJTSA30EnHzKW1EavpF+9AkBJ4d0=
Received: by 10.220.182.71 with SMTP id cb7mr4647856vcb.73.1297125496606;
        Mon, 07 Feb 2011 16:38:16 -0800 (PST)
Received: from localhost.localdomain (modemcable151.183-178-173.mc.videotron.ca [173.178.183.151])
        by mx.google.com with ESMTPS id h18sm3700541vbr.14.2011.02.07.16.38.13
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 07 Feb 2011 16:38:15 -0800 (PST)
X-Mailer: git-send-email 1.7.4.rc2.33.g8a14f
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166316>

'git rebase' without arguments is currently not supported. Make it
default to 'git rebase @{upstream}'. That is also what 'git pull
[--rebase]' defaults to, so it only makes sense that 'git rebase'
defaults to the same thing.

Defaulting to @{upstream} will make it possible to run e.g. 'git
rebase -i' without arguments, which is probably a quite common use
case. It also improves the scenario where you have multiple branches
that rebase against a remote-tracking branch, where you currently have
to choose between the extra network delay of 'git pull' or the
slightly awkward keys to enter 'git rebase @{u}'.

Helped-by: Yann Dirson <ydirson@altern.org>
Signed-off-by: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
---
Applies on top of the rebase refactoring series I sent yesterday, see
http://thread.gmane.org/gmane.comp.version-control.git/166161/

 Documentation/config.txt     |    2 +-
 Documentation/git-rebase.txt |   11 +++++++++--
 git-rebase.sh                |   35 +++++++++++++++++++++++++++++------
 t/t3400-rebase.sh            |   25 +++++++++++++++++--------
 4 files changed, 56 insertions(+), 17 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index c5e1835..b4e65b8 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -646,7 +646,7 @@ branch.<name>.remote::
 
 branch.<name>.merge::
 	Defines, together with branch.<name>.remote, the upstream branch
-	for the given branch. It tells 'git fetch'/'git pull' which
+	for the given branch. It tells 'git fetch'/'git pull'/'git rebase' which
 	branch to merge and can also affect 'git push' (see push.default).
 	When in branch <name>, it tells 'git fetch' the default
 	refspec to be marked for merging in FETCH_HEAD. The value is
diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index 96680c8..d3e998d 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -9,7 +9,7 @@ SYNOPSIS
 --------
 [verse]
 'git rebase' [-i | --interactive] [options] [--onto <newbase>]
-	<upstream> [<branch>]
+	[<upstream>] [<branch>]
 'git rebase' [-i | --interactive] [options] --onto <newbase>
 	--root [<branch>]
 
@@ -21,6 +21,12 @@ If <branch> is specified, 'git rebase' will perform an automatic
 `git checkout <branch>` before doing anything else.  Otherwise
 it remains on the current branch.
 
+If <upstream> is not specified, the upstream configured in
+branch.<name>.remote and branch.<name>.merge options will be used; see
+linkgit:git-config[1] for details.  If you are currently not on any
+branch or if the current branch does not have a configured upstream,
+the rebase will abort.
+
 All changes made by commits in the current branch but that are not
 in <upstream> are saved to a temporary area.  This is the same set
 of commits that would be shown by `git log <upstream>..HEAD` (or
@@ -216,7 +222,8 @@ leave out at most one of A and B, in which case it defaults to HEAD.
 
 <upstream>::
 	Upstream branch to compare against.  May be any valid commit,
-	not just an existing branch name.
+	not just an existing branch name. Defaults to the configured
+	upstream for the current branch.
 
 <branch>::
 	Working branch; defaults to HEAD.
diff --git a/git-rebase.sh b/git-rebase.sh
index be9ec2a..5975642 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -3,7 +3,7 @@
 # Copyright (c) 2005 Junio C Hamano.
 #
 
-USAGE='[--interactive | -i] [-v] [--force-rebase | -f] [--no-ff] [--onto <newbase>] (<upstream>|--root) [<branch>] [--quiet | -q]'
+USAGE='[--interactive | -i] [-v] [--force-rebase | -f] [--no-ff] [--onto <newbase>] [<upstream>|--root] [<branch>] [--quiet | -q]'
 LONG_USAGE='git-rebase replaces <branch> with a new branch of the
 same name.  When the --onto option is provided the new branch starts
 out with a HEAD equal to <newbase>, otherwise it is equal to <upstream>
@@ -144,6 +144,25 @@ run_pre_rebase_hook () {
 	fi
 }
 
+error_on_missing_default_upstream () {
+	branch_name=$(git symbolic-ref -q HEAD)
+	if test -z "$branch_name"
+	then
+		die "You are not currently on a branch, so I cannot use any
+'branch.<branchname>.merge' in your configuration file.
+Please specify which upstream branch you want to use on the command
+line and try again (e.g. 'git rebase <upstream branch>').
+See git-rebase(1) for details."
+	else
+		die "You asked me to rebase without telling me which branch you
+want to rebase against, and 'branch.${branch_name#refs/heads/}.merge' in
+your configuration file does not tell me, either. Please
+specify which branch you want to use on the command line and
+try again (e.g. 'git rebase <upstream branch>').
+See git-rebase(1) for details."
+	fi
+}
+
 test -f "$apply_dir"/applying &&
 	die 'It looks like git-am is in progress. Cannot rebase.'
 
@@ -345,8 +364,6 @@ and run me again.  I am stopping in case you still have something
 valuable there.'
 fi
 
-test $# -eq 0 && test -z "$rebase_root" && usage
-
 if test -n "$interactive_rebase"
 then
 	type=interactive
@@ -362,9 +379,15 @@ fi
 
 if test -z "$rebase_root"
 then
-	# The upstream head must be given.  Make sure it is valid.
-	upstream_name="$1"
-	shift
+	case "$#" in
+	0)
+		upstream_name=$(git rev-parse --symbolic-full-name --verify -q \
+		@{upstream}) || error_on_missing_default_upstream
+		;;
+	*)	upstream_name="$1"
+		shift
+		;;
+	esac
 	upstream=`git rev-parse --verify "${upstream_name}^0"` ||
 	die "invalid upstream $upstream_name"
 	upstream_arg="$upstream_name"
diff --git a/t/t3400-rebase.sh b/t/t3400-rebase.sh
index 349eebd..3bd4a84 100755
--- a/t/t3400-rebase.sh
+++ b/t/t3400-rebase.sh
@@ -158,15 +158,24 @@ test_expect_success 'Show verbose error when HEAD could not be detached' '
 '
 rm -f B
 
-test_expect_success 'dump usage when upstream arg is missing' '
-	git checkout -b usage topic &&
+test_expect_success 'fail when upstream arg is missing and not on branch' '
+	git checkout topic &&
 	test_must_fail git rebase 2>error1 &&
-	grep "[Uu]sage" error1 &&
-	test_must_fail git rebase --abort 2>error2 &&
-	grep "No rebase in progress" error2 &&
-	test_must_fail git rebase --onto master 2>error3 &&
-	grep "[Uu]sage" error3 &&
-	! grep "can.t shift" error3
+	grep "You are not currently on a branch" error1
+'
+
+test_expect_success 'fail when upstream arg is missing and not configured' '
+	git checkout -b no-config topic &&
+	test_must_fail git rebase 2>error2 &&
+	grep "branch.no-config.merge" error2
+'
+
+test_expect_success 'default to @{upstream} when upstream arg is missing' '
+	git checkout -b default topic &&
+	git config branch.default.remote .
+	git config branch.default.merge refs/heads/master
+	git rebase &&
+	test "$(git rev-parse default~1)" = "$(git rev-parse master)"
 '
 
 test_expect_success 'rebase -q is quiet' '
-- 
1.7.4.rc2.33.g8a14f
