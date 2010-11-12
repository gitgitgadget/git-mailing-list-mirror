From: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
Subject: [RFC] rebase: use @{upstream} if no upstream specified
Date: Fri, 12 Nov 2010 21:55:49 +0100
Message-ID: <1289595349-12589-1-git-send-email-martin.von.zweigbergk@gmail.com>
Cc: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 13 03:58:07 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PH6Ja-0001AN-Ux
	for gcvg-git-2@lo.gmane.org; Sat, 13 Nov 2010 03:58:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751211Ab0KMC4A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Nov 2010 21:56:00 -0500
Received: from mail-qw0-f46.google.com ([209.85.216.46]:43505 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750837Ab0KMC4A (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Nov 2010 21:56:00 -0500
Received: by qwh5 with SMTP id 5so96298qwh.19
        for <git@vger.kernel.org>; Fri, 12 Nov 2010 18:55:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=hPtwli8yO+OKDCp4wBMnO7Mv+eofg4Ms07zeQVPoLAM=;
        b=RBAnf+gjNjlJYb5E0HinqNIzqib8q5Br422rdGsVj3jgao3Af4YZWYlyoSaxowxqrw
         02eb5SWqyYoEl4c/kc2s3LQnv6lfouqG+Uqr2XlkKZkPXa8sBytiU7ZcvsmkU9BU1oXj
         VjiZEkVsJhrYBjUnaYgasnJCrzkNYSnbQT3lQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=N6si79KN2mj50QCCqW7NIX/G+ffrIXrPJxdxZOeRvUEp+bqlGggVznAPuWYXuArgaQ
         h00ZyoFt41vwL20vCcueyUIrf/4m3upWfgMHMsgdzCFadpSlE9Bez9PU1Ni1Q/0KtKLJ
         2bZLLlTy75vrMlnep4Ctv9/vK4BUCulfPKCUc=
Received: by 10.224.193.194 with SMTP id dv2mr1228419qab.192.1289616959002;
        Fri, 12 Nov 2010 18:55:59 -0800 (PST)
Received: from localhost.localdomain (modemcable151.183-178-173.mc.videotron.ca [173.178.183.151])
        by mx.google.com with ESMTPS id n7sm3561416qcu.4.2010.11.12.18.55.58
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 12 Nov 2010 18:55:58 -0800 (PST)
X-Mailer: git-send-email 1.7.3.2.167.ga361b
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161382>

With 'git pull --rebase', the user can configure the upstream repository
to fetch from and reference to rebase against if none is specified on
the command line.

However, if, instead of 'git pull --rebase', the user were to do 'git
fetch' followed by 'git rebase', the upstream branch would need to be
specified on the command line. This patch teaches 'git rebase' to
default to the same configured upstream ref as 'git pull --rebase'
uses.

'git rebase' currently require at least one argument, so this change does
not cause any ambiguity. Defaulting to @{upstream} will make it possible
to run e.g. 'git rebase -i' without arguments, which is probably a quite
common use case. It also improves the scenario where you have multiple
branches that rebase against a remote-tracking branch, where you
currently have to choose between the extra network delay of 'git pull' or
the awkward keys to enter 'git rebase @{u}'.
---
Another RFC in the same vein as my previous one, namely making
'git fetch+rebase' more similar to 'git pull --rebase'.

Junio, don't apply this patch yet, as I will rebase it on top of the
refactored rebase code once I'm done with that (to make it work with
interactive rebase as well).

However, it should apply cleanly on top of the patches in
http://thread.gmane.org/gmane.comp.version-control.git/160682/, and maybe
even right on top of master.

The obvious extension would be to make @{u} the default for 'git merge'
as well. Any opinions?

I was apparently very lazy with the testing, so I will have to improve on
that before this becomes a "PATCH v1". I will add a test case that checks
that it works when the upstream actually is configured.

 Documentation/git-rebase.txt |    6 +++++-
 git-rebase.sh                |   37 ++++++++++++++++++++++++++-----------
 t/t3400-rebase.sh            |    4 ++--
 3 files changed, 33 insertions(+), 14 deletions(-)

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index 1baddd2..42d13a0 100644
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
 
@@ -21,6 +21,10 @@ If <branch> is specified, 'git rebase' will perform an automatic
 `git checkout <branch>` before doing anything else.  Otherwise
 it remains on the current branch.
 
+If <upstream> is not specified, the upstream configured in
+branch.<name>.remote and branch.<name>.merge options will be used; see
+linkgit:git-config[1] for details.
+
 All changes made by commits in the current branch but that are not
 in <upstream> are saved to a temporary area.  This is the same set
 of commits that would be shown by `git log <upstream>..HEAD` (or
diff --git a/git-rebase.sh b/git-rebase.sh
index fade99a..7eb1a6e 100755
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
@@ -369,13 +369,6 @@ do
 done
 test $# -gt 2 && usage
 
-if test $# -eq 0 && test -z "$rebase_root"
-then
-	test -d "$merge_dir" -o -d "$apply_dir" || usage
-	test -d "$merge_dir" -o -f "$apply_dir"/rebasing &&
-		die 'A rebase is in progress, try --continue, --skip or --abort.'
-fi
-
 # Make sure we do not have $apply_dir or $merge_dir
 if test -z "$do_merge"
 then
@@ -416,9 +409,31 @@ esac
 
 if test -z "$rebase_root"
 then
-	# The upstream head must be given.  Make sure it is valid.
-	upstream_name="$1"
-	shift
+	case "$#" in
+	0)	branch_name=$(git symbolic-ref -q HEAD) &&
+		upstream_name=$(git for-each-ref \
+			--format='%(upstream)' ${branch_name})
+		if test -z $branch_name
+		then
+			die "You are not currently on a branch, so I cannot use any
+'branch.<branchname>.merge' in your configuration file.
+Please specify which upstream branch you want to use on the command
+line and try again (e.g. 'git rebase <upstream branch>').
+See git-rebase(1) for details."
+		elif test -z $upstream_name
+		then
+			die "You asked me to rebase without telling me which branch you
+want to rebase against, and 'branch.${branch_name#refs/heads/}.merge' in
+your configuration file does not tell me, either. Please
+specify which branch you want to use on the command line and
+try again (e.g. 'git rebase <upstream branch>').
+See git-rebase(1) for details."
+		fi
+		;;
+	*)	upstream_name="$1"
+		shift
+		;;
+	esac
 	upstream=`git rev-parse --verify "${upstream_name}^0"` ||
 	die "invalid upstream $upstream_name"
 	unset root_flag
diff --git a/t/t3400-rebase.sh b/t/t3400-rebase.sh
index b64df31..5b0a29b 100755
--- a/t/t3400-rebase.sh
+++ b/t/t3400-rebase.sh
@@ -161,11 +161,11 @@ rm -f B
 test_expect_success 'dump usage when upstream arg is missing' '
 	git checkout -b usage topic &&
 	test_must_fail git rebase 2>error1 &&
-	grep "[Uu]sage" error1 &&
+	grep "branch.usage.merge" error1 &&
 	test_must_fail git rebase --abort 2>error2 &&
 	grep "No rebase in progress" error2 &&
 	test_must_fail git rebase --onto master 2>error3 &&
-	grep "[Uu]sage" error3 &&
+	grep "branch.usage.merge" error3 &&
 	! grep "can.t shift" error3
 '
 
-- 
1.7.3.2.167.ga361b
