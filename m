From: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
Subject: [PATCH] rebase: use @{upstream} if no upstream specified
Date: Wed,  9 Feb 2011 20:54:02 -0500
Message-ID: <1297302842-11296-1-git-send-email-martin.von.zweigbergk@gmail.com>
References: <1297125475-19151-1-git-send-email-martin.von.zweigbergk@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Yann Dirson <ydirson@altern.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 10 02:56:01 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PnLlI-0004HV-16
	for gcvg-git-2@lo.gmane.org; Thu, 10 Feb 2011 02:56:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753503Ab1BJBzy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Feb 2011 20:55:54 -0500
Received: from mail-vw0-f46.google.com ([209.85.212.46]:40116 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751806Ab1BJBzx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Feb 2011 20:55:53 -0500
Received: by vws16 with SMTP id 16so549456vws.19
        for <git@vger.kernel.org>; Wed, 09 Feb 2011 17:55:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=4TNweLtrg7/kubJtxTGYfgYy/U+c3AUBLgfTCOYxpSQ=;
        b=c5+m40TP4nHkXmKe45JOeJjZ14AtrqQL0XAoTou1Ug7epG1hoX7Q57Zi6zYC4fFKAz
         gQyxn9JTXort1NyMEE+PoZ2CIeFIRYWKO4dee3qvG6M7xk5eQrqJMVS015hjEJOjSUCW
         xNXUtrAwTdcUj14d1bDiabnU9/0r0et5v20/E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=tsPWB0VBysqHkbIWJkkC7Ph0AI3g6hcaBNXu4s3SJrga5QZA+eZihIkyFqWliDOlrG
         t+bPSbhl9gMXeaIcTTWLpkcG5t4o1RyIlTk0GyOpnjI21a6mugu0NR97cL3wOl4I9dxk
         HrrWEbLalZNo/I1z3LEN1l7J9XrVxtXdR10Jc=
Received: by 10.220.110.38 with SMTP id l38mr5304126vcp.238.1297302951963;
        Wed, 09 Feb 2011 17:55:51 -0800 (PST)
Received: from localhost.localdomain (modemcable151.183-178-173.mc.videotron.ca [173.178.183.151])
        by mx.google.com with ESMTPS id r7sm635563vbx.9.2011.02.09.17.55.49
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 09 Feb 2011 17:55:50 -0800 (PST)
X-Mailer: git-send-email 1.7.4.rc2.33.g8a14f
In-Reply-To: <1297125475-19151-1-git-send-email-martin.von.zweigbergk@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166462>

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

The error reporting when no upstream is configured for the current
branch or when no branch is checked out is reused from git-pull.sh. A
function is extracted into git-parse-remote.sh for this purpose.

Helped-by: Yann Dirson <ydirson@altern.org>
Helped-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
---

Changes since v1:

 * Extracted error reporting shared with git-pull.sh as suggested by
   Jonathan.

 * Now discards stderr from "git rev-parse -q @{upstream}", since it's
   not quite quiet when there is no upstream.


 Documentation/config.txt     |    2 +-
 Documentation/git-rebase.txt |   11 +++++++++--
 git-parse-remote.sh          |   38 ++++++++++++++++++++++++++++++++++++++
 git-pull.sh                  |   32 ++++----------------------------
 git-rebase.sh                |   21 +++++++++++++++------
 t/t3400-rebase.sh            |   27 ++++++++++++++++++---------
 6 files changed, 85 insertions(+), 46 deletions(-)

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
diff --git a/git-parse-remote.sh b/git-parse-remote.sh
index 1cc2ba6..be17ecb 100644
--- a/git-parse-remote.sh
+++ b/git-parse-remote.sh
@@ -99,3 +99,41 @@ get_remote_merge_branch () {
 	    esac
 	esac
 }
+
+error_on_missing_default_upstream () {
+	cmd="$1"
+	op_type="$2"
+	op_prep="$3"
+	example="$4"
+	branch_name=$(git symbolic-ref -q HEAD)
+	if test -z "$branch_name"
+	then
+		echo "You are not currently on a branch, so I cannot use any
+'branch.<branchname>.merge' in your configuration file.
+Please specify which branch you want to $op_type $op_prep on the command
+line and try again (e.g. '$example').
+See git-${cmd}(1) for details."
+	else
+		echo "You asked me to $cmd without telling me which branch you
+want to $op_type $op_prep, and 'branch.${branch_name#refs/heads/}.merge' in
+your configuration file does not tell me, either. Please
+specify which branch you want to use on the command line and
+try again (e.g. '$example').
+See git-${cmd}(1) for details.
+
+If you often $op_type $op_prep the same branch, you may want to
+use something like the following in your configuration file:
+    [branch \"${branch_name#refs/heads/}\"]
+    remote = <nickname>
+    merge = <remote-ref>"
+		test rebase = "$op_type" &&
+		echo "    rebase = true"
+		echo "
+    [remote \"<nickname>\"]
+    url = <url>
+    fetch = <refspec>
+
+See git-config(1) for details."
+	fi
+	exit 1
+}
diff --git a/git-pull.sh b/git-pull.sh
index eb87f49..2cdea26 100755
--- a/git-pull.sh
+++ b/git-pull.sh
@@ -163,34 +163,10 @@ error_on_no_merge_candidates () {
 		echo "You asked to pull from the remote '$1', but did not specify"
 		echo "a branch. Because this is not the default configured remote"
 		echo "for your current branch, you must specify a branch on the command line."
-	elif [ -z "$curr_branch" ]; then
-		echo "You are not currently on a branch, so I cannot use any"
-		echo "'branch.<branchname>.merge' in your configuration file."
-		echo "Please specify which remote branch you want to use on the command"
-		echo "line and try again (e.g. 'git pull <repository> <refspec>')."
-		echo "See git-pull(1) for details."
-	elif [ -z "$upstream" ]; then
-		echo "You asked me to pull without telling me which branch you"
-		echo "want to $op_type $op_prep, and 'branch.${curr_branch}.merge' in"
-		echo "your configuration file does not tell me, either. Please"
-		echo "specify which branch you want to use on the command line and"
-		echo "try again (e.g. 'git pull <repository> <refspec>')."
-		echo "See git-pull(1) for details."
-		echo
-		echo "If you often $op_type $op_prep the same branch, you may want to"
-		echo "use something like the following in your configuration file:"
-		echo
-		echo "    [branch \"${curr_branch}\"]"
-		echo "    remote = <nickname>"
-		echo "    merge = <remote-ref>"
-		test rebase = "$op_type" &&
-			echo "    rebase = true"
-		echo
-		echo "    [remote \"<nickname>\"]"
-		echo "    url = <url>"
-		echo "    fetch = <refspec>"
-		echo
-		echo "See git-config(1) for details."
+	elif [ -z "$curr_branch" -o -z "$upstream" ]; then
+		. git-parse-remote
+		error_on_missing_default_upstream "pull" $op_type $op_prep \
+			"git pull <repository> <refspec>"
 	else
 		echo "Your configuration specifies to $op_type $op_prep the ref '${upstream#refs/heads/}'"
 		echo "from the remote, but no such ref was fetched."
diff --git a/git-rebase.sh b/git-rebase.sh
index be9ec2a..a040ab5 100755
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
@@ -345,8 +345,6 @@ and run me again.  I am stopping in case you still have something
 valuable there.'
 fi
 
-test $# -eq 0 && test -z "$rebase_root" && usage
-
 if test -n "$interactive_rebase"
 then
 	type=interactive
@@ -362,9 +360,20 @@ fi
 
 if test -z "$rebase_root"
 then
-	# The upstream head must be given.  Make sure it is valid.
-	upstream_name="$1"
-	shift
+	case "$#" in
+	0)
+		if ! upstream_name=$(git rev-parse --symbolic-full-name \
+			--verify -q @{upstream} 2>/dev/null)
+		then
+			. git-parse-remote
+			error_on_missing_default_upstream "rebase" "rebase" \
+				"against" "git rebase <upstream branch>"
+		fi
+		;;
+	*)	upstream_name="$1"
+		shift
+		;;
+	esac
 	upstream=`git rev-parse --verify "${upstream_name}^0"` ||
 	die "invalid upstream $upstream_name"
 	upstream_arg="$upstream_name"
diff --git a/t/t3400-rebase.sh b/t/t3400-rebase.sh
index 349eebd..6eaecec 100755
--- a/t/t3400-rebase.sh
+++ b/t/t3400-rebase.sh
@@ -158,15 +158,24 @@ test_expect_success 'Show verbose error when HEAD could not be detached' '
 '
 rm -f B
 
-test_expect_success 'dump usage when upstream arg is missing' '
-	git checkout -b usage topic &&
-	test_must_fail git rebase 2>error1 &&
-	grep "[Uu]sage" error1 &&
-	test_must_fail git rebase --abort 2>error2 &&
-	grep "No rebase in progress" error2 &&
-	test_must_fail git rebase --onto master 2>error3 &&
-	grep "[Uu]sage" error3 &&
-	! grep "can.t shift" error3
+test_expect_success 'fail when upstream arg is missing and not on branch' '
+	git checkout topic &&
+	test_must_fail git rebase >output.out &&
+	grep "You are not currently on a branch" output.out
+'
+
+test_expect_success 'fail when upstream arg is missing and not configured' '
+	git checkout -b no-config topic &&
+	test_must_fail git rebase >output.out &&
+	grep "branch.no-config.merge" output.out
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
