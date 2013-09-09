From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v3 1/5] pull: rename pull.rename to pull.mode
Date: Sun,  8 Sep 2013 20:23:12 -0500
Message-ID: <1378689796-19305-2-git-send-email-felipe.contreras@gmail.com>
References: <1378689796-19305-1-git-send-email-felipe.contreras@gmail.com>
Cc: Andreas Krey <a.krey@gmx.de>, John Keeping <john@keeping.me.uk>,
	Jeff King <peff@peff.net>, Richard Hansen <rhansen@bbn.com>,
	Philip Oakley <philipoakley@iee.org>,
	sandals@crustytoothpaste.net,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 09 03:28:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VIqHb-0001W6-5J
	for gcvg-git-2@plane.gmane.org; Mon, 09 Sep 2013 03:28:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751302Ab3IIB2e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Sep 2013 21:28:34 -0400
Received: from mail-ob0-f179.google.com ([209.85.214.179]:47561 "EHLO
	mail-ob0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751210Ab3IIB20 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Sep 2013 21:28:26 -0400
Received: by mail-ob0-f179.google.com with SMTP id fb19so5321130obc.24
        for <git@vger.kernel.org>; Sun, 08 Sep 2013 18:28:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=A+BhphA16FEyMCXuaDgFjglrc80/2PW2a5LTXrFRT8Q=;
        b=Zi4x0Ib67nM9FPKuzNMpT5RGH13bGaoWdPse1++ic5e8NP5571sDcYtRc+r/fyInKr
         mV4YbqCmgdOxxwbFCx9dBhQN5KaJtA0FVY6BroNE050kVMTrdvM7cyJQqhIh82DstEi2
         cPfhqBVApjMrM0gT6kcFLwXKy9xqRQDWwTcbjALgTAKF90F1Z7/6diNzyBb7mdzLxPdz
         ZWFv2n9Y0NvsMvdoFE2lSeCPpduS5DN3mY1CT0X3DHT/fXSfUMjmPVizDmFHxfx9xve6
         vzxhYNMBFCtLgJnxEURiTAQonMGY/WLDgE9gWlWLksN2Ua0a+/97ZOK1uEauOI+05uVu
         rodw==
X-Received: by 10.60.93.105 with SMTP id ct9mr166176oeb.42.1378690105973;
        Sun, 08 Sep 2013 18:28:25 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id ts4sm10452226obb.5.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 08 Sep 2013 18:28:25 -0700 (PDT)
X-Mailer: git-send-email 1.8.4-338-gefd7fa6
In-Reply-To: <1378689796-19305-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234299>

Also 'branch.<name>.rebase' to 'branch.<name>.pullmode'.

This way 'pull.mode' can be set to 'merge', and the default can be
something else.

The old configurations still work, but get deprecated.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 Documentation/config.txt   | 22 +++++++++++-----------
 Documentation/git-pull.txt |  2 +-
 branch.c                   |  4 ++--
 git-pull.sh                | 18 ++++++++++++++++--
 t/t3200-branch.sh          | 40 ++++++++++++++++++++--------------------
 t/t5520-pull.sh            | 26 ++++++++++++++++++++++++++
 t/t5601-clone.sh           |  4 ++--
 7 files changed, 78 insertions(+), 38 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index ec57a15..9489a59 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -706,7 +706,7 @@ branch.autosetupmerge::
 branch.autosetuprebase::
 	When a new branch is created with 'git branch' or 'git checkout'
 	that tracks another branch, this variable tells Git to set
-	up pull to rebase instead of merge (see "branch.<name>.rebase").
+	up pull to rebase instead of merge (see "branch.<name>.pullmode").
 	When `never`, rebase is never automatically set to true.
 	When `local`, rebase is set to true for tracked branches of
 	other local branches.
@@ -760,11 +760,11 @@ branch.<name>.mergeoptions::
 	option values containing whitespace characters are currently not
 	supported.
 
-branch.<name>.rebase::
-	When true, rebase the branch <name> on top of the fetched branch,
-	instead of merging the default branch from the default remote when
-	"git pull" is run. See "pull.rebase" for doing this in a non
-	branch-specific manner.
+branch.<name>.pullmode::
+	When "git pull" is run, this determines if it would either merge or
+	rebase the fetched branch. The possible values are 'merge' and
+	'rebase'. See "pull.mode" for doing this in a non branch-specific
+	manner.
 +
 *NOTE*: this is a possibly dangerous operation; do *not* use
 it unless you understand the implications (see linkgit:git-rebase[1]
@@ -1820,11 +1820,11 @@ pretty.<name>::
 	Note that an alias with the same name as a built-in format
 	will be silently ignored.
 
-pull.rebase::
-	When true, rebase branches on top of the fetched branch, instead
-	of merging the default branch from the default remote when "git
-	pull" is run. See "branch.<name>.rebase" for setting this on a
-	per-branch basis.
+pull.mode::
+	When "git pull" is run, this determines if it would either merge or
+	rebase the fetched branch. The possible values are 'merge' and
+	'rebase'. See "branch.<name>.pullmode" for doing this in a non
+	branch-specific manner.
 +
 *NOTE*: this is a possibly dangerous operation; do *not* use
 it unless you understand the implications (see linkgit:git-rebase[1]
diff --git a/Documentation/git-pull.txt b/Documentation/git-pull.txt
index 6ef8d59..991352f 100644
--- a/Documentation/git-pull.txt
+++ b/Documentation/git-pull.txt
@@ -109,7 +109,7 @@ include::merge-options.txt[]
 	fetched, the rebase uses that information to avoid rebasing
 	non-local changes.
 +
-See `pull.rebase`, `branch.<name>.rebase` and `branch.autosetuprebase` in
+See `pull.mode`, `branch.<name>.pullmode` and `branch.autosetuprebase` in
 linkgit:git-config[1] if you want to make `git pull` always use
 `--rebase` instead of merging.
 +
diff --git a/branch.c b/branch.c
index c5c6984..c6b70c2 100644
--- a/branch.c
+++ b/branch.c
@@ -71,8 +71,8 @@ void install_branch_config(int flag, const char *local, const char *origin, cons
 
 	if (rebasing) {
 		strbuf_reset(&key);
-		strbuf_addf(&key, "branch.%s.rebase", local);
-		git_config_set(key.buf, "true");
+		strbuf_addf(&key, "branch.%s.pullmode", local);
+		git_config_set(key.buf, "rebase");
 	}
 	strbuf_release(&key);
 
diff --git a/git-pull.sh b/git-pull.sh
index f0df41c..de57c1d 100755
--- a/git-pull.sh
+++ b/git-pull.sh
@@ -43,10 +43,24 @@ log_arg= verbosity= progress= recurse_submodules= verify_signatures=
 merge_args= edit=
 curr_branch=$(git symbolic-ref -q HEAD)
 curr_branch_short="${curr_branch#refs/heads/}"
-rebase=$(git config --bool branch.$curr_branch_short.rebase)
+mode=$(git config branch.${curr_branch_short}.pullmode)
+if test -z "$mode"
+then
+	mode=$(git config pull.mode)
+fi
+test "$mode" == 'rebase' && rebase="true"
 if test -z "$rebase"
 then
-	rebase=$(git config --bool pull.rebase)
+	rebase=$(git config --bool branch.$curr_branch_short.rebase)
+	if test -z "$rebase"
+	then
+		rebase=$(git config --bool pull.rebase)
+	fi
+	if test "$rebase" = 'true'
+	then
+		echo "The configurations pull.rebase and branch.<name>.rebase are deprecated."
+		echo "Please use pull.mode and branch.<name>.pullmode instead."
+	fi
 fi
 dry_run=
 while :
diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index 44ec6a4..b620798 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -557,7 +557,7 @@ test_expect_success 'autosetuprebase local on a tracked local branch' '
 	git branch --track myr1 mybase &&
 	test "$(git config branch.myr1.remote)" = . &&
 	test "$(git config branch.myr1.merge)" = refs/heads/mybase &&
-	test "$(git config branch.myr1.rebase)" = true
+	test "$(git config branch.myr1.pullmode)" = rebase
 '
 
 test_expect_success 'autosetuprebase always on a tracked local branch' '
@@ -569,7 +569,7 @@ test_expect_success 'autosetuprebase always on a tracked local branch' '
 	git branch --track myr2 mybase &&
 	test "$(git config branch.myr2.remote)" = . &&
 	test "$(git config branch.myr2.merge)" = refs/heads/mybase &&
-	test "$(git config branch.myr2.rebase)" = true
+	test "$(git config branch.myr2.pullmode)" = rebase
 '
 
 test_expect_success 'autosetuprebase remote on a tracked local branch' '
@@ -581,7 +581,7 @@ test_expect_success 'autosetuprebase remote on a tracked local branch' '
 	git branch --track myr3 mybase2 &&
 	test "$(git config branch.myr3.remote)" = . &&
 	test "$(git config branch.myr3.merge)" = refs/heads/mybase2 &&
-	! test "$(git config branch.myr3.rebase)" = true
+	! test "$(git config branch.myr3.pullmode)" = rebase
 '
 
 test_expect_success 'autosetuprebase never on a tracked local branch' '
@@ -593,7 +593,7 @@ test_expect_success 'autosetuprebase never on a tracked local branch' '
 	git branch --track myr4 mybase2 &&
 	test "$(git config branch.myr4.remote)" = . &&
 	test "$(git config branch.myr4.merge)" = refs/heads/mybase2 &&
-	! test "$(git config branch.myr4.rebase)" = true
+	! test "$(git config branch.myr4.pullmode)" = rebase
 '
 
 test_expect_success 'autosetuprebase local on a tracked remote branch' '
@@ -604,7 +604,7 @@ test_expect_success 'autosetuprebase local on a tracked remote branch' '
 	git branch --track myr5 local/master &&
 	test "$(git config branch.myr5.remote)" = local &&
 	test "$(git config branch.myr5.merge)" = refs/heads/master &&
-	! test "$(git config branch.myr5.rebase)" = true
+	! test "$(git config branch.myr5.pullmode)" = rebase
 '
 
 test_expect_success 'autosetuprebase never on a tracked remote branch' '
@@ -615,7 +615,7 @@ test_expect_success 'autosetuprebase never on a tracked remote branch' '
 	git branch --track myr6 local/master &&
 	test "$(git config branch.myr6.remote)" = local &&
 	test "$(git config branch.myr6.merge)" = refs/heads/master &&
-	! test "$(git config branch.myr6.rebase)" = true
+	! test "$(git config branch.myr6.pullmode)" = rebase
 '
 
 test_expect_success 'autosetuprebase remote on a tracked remote branch' '
@@ -626,7 +626,7 @@ test_expect_success 'autosetuprebase remote on a tracked remote branch' '
 	git branch --track myr7 local/master &&
 	test "$(git config branch.myr7.remote)" = local &&
 	test "$(git config branch.myr7.merge)" = refs/heads/master &&
-	test "$(git config branch.myr7.rebase)" = true
+	test "$(git config branch.myr7.pullmode)" = rebase
 '
 
 test_expect_success 'autosetuprebase always on a tracked remote branch' '
@@ -637,7 +637,7 @@ test_expect_success 'autosetuprebase always on a tracked remote branch' '
 	git branch --track myr8 local/master &&
 	test "$(git config branch.myr8.remote)" = local &&
 	test "$(git config branch.myr8.merge)" = refs/heads/master &&
-	test "$(git config branch.myr8.rebase)" = true
+	test "$(git config branch.myr8.pullmode)" = rebase
 '
 
 test_expect_success 'autosetuprebase unconfigured on a tracked remote branch' '
@@ -648,7 +648,7 @@ test_expect_success 'autosetuprebase unconfigured on a tracked remote branch' '
 	git branch --track myr9 local/master &&
 	test "$(git config branch.myr9.remote)" = local &&
 	test "$(git config branch.myr9.merge)" = refs/heads/master &&
-	test "z$(git config branch.myr9.rebase)" = z
+	test "z$(git config branch.myr9.pullmode)" = z
 '
 
 test_expect_success 'autosetuprebase unconfigured on a tracked local branch' '
@@ -659,7 +659,7 @@ test_expect_success 'autosetuprebase unconfigured on a tracked local branch' '
 	git branch --track myr10 mybase2 &&
 	test "$(git config branch.myr10.remote)" = . &&
 	test "$(git config branch.myr10.merge)" = refs/heads/mybase2 &&
-	test "z$(git config branch.myr10.rebase)" = z
+	test "z$(git config branch.myr10.pullmode)" = z
 '
 
 test_expect_success 'autosetuprebase unconfigured on untracked local branch' '
@@ -669,7 +669,7 @@ test_expect_success 'autosetuprebase unconfigured on untracked local branch' '
 	git branch --no-track myr11 mybase2 &&
 	test "z$(git config branch.myr11.remote)" = z &&
 	test "z$(git config branch.myr11.merge)" = z &&
-	test "z$(git config branch.myr11.rebase)" = z
+	test "z$(git config branch.myr11.pullmode)" = z
 '
 
 test_expect_success 'autosetuprebase unconfigured on untracked remote branch' '
@@ -679,7 +679,7 @@ test_expect_success 'autosetuprebase unconfigured on untracked remote branch' '
 	git branch --no-track myr12 local/master &&
 	test "z$(git config branch.myr12.remote)" = z &&
 	test "z$(git config branch.myr12.merge)" = z &&
-	test "z$(git config branch.myr12.rebase)" = z
+	test "z$(git config branch.myr12.pullmode)" = z
 '
 
 test_expect_success 'autosetuprebase never on an untracked local branch' '
@@ -690,7 +690,7 @@ test_expect_success 'autosetuprebase never on an untracked local branch' '
 	git branch --no-track myr13 mybase2 &&
 	test "z$(git config branch.myr13.remote)" = z &&
 	test "z$(git config branch.myr13.merge)" = z &&
-	test "z$(git config branch.myr13.rebase)" = z
+	test "z$(git config branch.myr13.pullmode)" = z
 '
 
 test_expect_success 'autosetuprebase local on an untracked local branch' '
@@ -701,7 +701,7 @@ test_expect_success 'autosetuprebase local on an untracked local branch' '
 	git branch --no-track myr14 mybase2 &&
 	test "z$(git config branch.myr14.remote)" = z &&
 	test "z$(git config branch.myr14.merge)" = z &&
-	test "z$(git config branch.myr14.rebase)" = z
+	test "z$(git config branch.myr14.pullmode)" = z
 '
 
 test_expect_success 'autosetuprebase remote on an untracked local branch' '
@@ -712,7 +712,7 @@ test_expect_success 'autosetuprebase remote on an untracked local branch' '
 	git branch --no-track myr15 mybase2 &&
 	test "z$(git config branch.myr15.remote)" = z &&
 	test "z$(git config branch.myr15.merge)" = z &&
-	test "z$(git config branch.myr15.rebase)" = z
+	test "z$(git config branch.myr15.pullmode)" = z
 '
 
 test_expect_success 'autosetuprebase always on an untracked local branch' '
@@ -723,7 +723,7 @@ test_expect_success 'autosetuprebase always on an untracked local branch' '
 	git branch --no-track myr16 mybase2 &&
 	test "z$(git config branch.myr16.remote)" = z &&
 	test "z$(git config branch.myr16.merge)" = z &&
-	test "z$(git config branch.myr16.rebase)" = z
+	test "z$(git config branch.myr16.pullmode)" = z
 '
 
 test_expect_success 'autosetuprebase never on an untracked remote branch' '
@@ -734,7 +734,7 @@ test_expect_success 'autosetuprebase never on an untracked remote branch' '
 	git branch --no-track myr17 local/master &&
 	test "z$(git config branch.myr17.remote)" = z &&
 	test "z$(git config branch.myr17.merge)" = z &&
-	test "z$(git config branch.myr17.rebase)" = z
+	test "z$(git config branch.myr17.pullmode)" = z
 '
 
 test_expect_success 'autosetuprebase local on an untracked remote branch' '
@@ -745,7 +745,7 @@ test_expect_success 'autosetuprebase local on an untracked remote branch' '
 	git branch --no-track myr18 local/master &&
 	test "z$(git config branch.myr18.remote)" = z &&
 	test "z$(git config branch.myr18.merge)" = z &&
-	test "z$(git config branch.myr18.rebase)" = z
+	test "z$(git config branch.myr18.pullmode)" = z
 '
 
 test_expect_success 'autosetuprebase remote on an untracked remote branch' '
@@ -756,7 +756,7 @@ test_expect_success 'autosetuprebase remote on an untracked remote branch' '
 	git branch --no-track myr19 local/master &&
 	test "z$(git config branch.myr19.remote)" = z &&
 	test "z$(git config branch.myr19.merge)" = z &&
-	test "z$(git config branch.myr19.rebase)" = z
+	test "z$(git config branch.myr19.pullmode)" = z
 '
 
 test_expect_success 'autosetuprebase always on an untracked remote branch' '
@@ -767,7 +767,7 @@ test_expect_success 'autosetuprebase always on an untracked remote branch' '
 	git branch --no-track myr20 local/master &&
 	test "z$(git config branch.myr20.remote)" = z &&
 	test "z$(git config branch.myr20.merge)" = z &&
-	test "z$(git config branch.myr20.rebase)" = z
+	test "z$(git config branch.myr20.pullmode)" = z
 '
 
 test_expect_success 'autosetuprebase always on detached HEAD' '
diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
index ed4d9c8..978a3c1 100755
--- a/t/t5520-pull.sh
+++ b/t/t5520-pull.sh
@@ -284,4 +284,30 @@ test_expect_success 'git pull --rebase against local branch' '
 	test file = "$(cat file2)"
 '
 
+test_expect_success 'pull.mode' '
+	git checkout to-rebase &&
+	git reset --hard before-rebase &&
+	test_config pull.mode rebase &&
+	git pull . copy &&
+	test $(git rev-parse HEAD^) = $(git rev-parse copy) &&
+	test new = $(git show HEAD:file2)
+'
+
+test_expect_success 'branch.to-rebase.pullmode' '
+	git reset --hard before-rebase &&
+	test_config branch.to-rebase.pullmode rebase &&
+	git pull . copy &&
+	test $(git rev-parse HEAD^) = $(git rev-parse copy) &&
+	test new = $(git show HEAD:file2)
+'
+
+test_expect_success 'branch.to-rebase.pullmode should override pull.mode' '
+	git reset --hard before-rebase &&
+	test_config pull.mode rebase &&
+	test_config branch.to-rebase.pullmode merge &&
+	git pull . copy &&
+	test $(git rev-parse HEAD^) != $(git rev-parse copy) &&
+	test new = $(git show HEAD:file2)
+'
+
 test_done
diff --git a/t/t5601-clone.sh b/t/t5601-clone.sh
index 0629149..6c888ae 100755
--- a/t/t5601-clone.sh
+++ b/t/t5601-clone.sh
@@ -191,8 +191,8 @@ test_expect_success 'clone respects global branch.autosetuprebase' '
 		rm -fr dst &&
 		git clone src dst &&
 		cd dst &&
-		actual="z$(git config branch.master.rebase)" &&
-		test ztrue = $actual
+		actual="$(git config branch.master.pullmode)" &&
+		test "$actual" = rebase
 	)
 '
 
-- 
1.8.4-338-gefd7fa6
