From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 3/3] pull: introduce --[no-]autostash and pull.autostash
Date: Sun, 14 Apr 2013 02:45:29 +0530
Message-ID: <1365887729-9630-4-git-send-email-artagnon@gmail.com>
References: <1365887729-9630-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Apr 13 23:16:07 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UR7nq-0001HY-LL
	for gcvg-git-2@plane.gmane.org; Sat, 13 Apr 2013 23:16:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932162Ab3DMVP5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Apr 2013 17:15:57 -0400
Received: from mail-pa0-f46.google.com ([209.85.220.46]:63618 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753788Ab3DMVP4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Apr 2013 17:15:56 -0400
Received: by mail-pa0-f46.google.com with SMTP id lb1so1988882pab.19
        for <git@vger.kernel.org>; Sat, 13 Apr 2013 14:15:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=bNZBTjds9UMypv9Jrl4szBXG8MiCPs2X2FW/U1pID10=;
        b=HAIXEg4woWVQpPJiQ73IXxyepHs1OJu61koQjYavVmbn49BzSqzNeYzhGXp7HpxcPJ
         PVSsAL5LSUB1xgD/SlgrwpDv/sturX5YQDMybv+54wKUrJxFMU5o4bCEfpUk8inEc6LU
         5SUM3c9qOvD0yrVQ1afMrVEBRg7DtaUNyZjnOgpVB9l8p1O1MlZnk0GdgxQAuW9BysRb
         U6L2xlQnHL03Ua7yRZ7isteNQyzae4wRnR5P2D9phBQpBQw0ThCC9vZuisFc2hDm81wr
         BYtc3jW4s1Rcg+qhVa5V9l4/cDYo6ELcXb9aGYN6o0Haypcu7KZ4mHXXk2ioXpTS0ly3
         btMg==
X-Received: by 10.66.157.195 with SMTP id wo3mr22091203pab.79.1365887756134;
        Sat, 13 Apr 2013 14:15:56 -0700 (PDT)
Received: from localhost.localdomain ([122.164.25.24])
        by mx.google.com with ESMTPS id fb7sm15112193pab.16.2013.04.13.14.15.54
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 13 Apr 2013 14:15:55 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.1.392.g6943ea6
In-Reply-To: <1365887729-9630-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221071>

Currently, executing a 'git pull' on a dirty worktree gives the
following annoying message:

    # User doesn't notice dirty worktree
    $ git pull

    ... # fetch operation

    error: Your local changes to the following files would be overwritten by merge:
        quux
    Please, commit your changes or stash them before you can merge.
    Aborting

At which point the user will stash her changes, re-execute git pull,
and pop the stash.  This process can easily be automated out for a
smooth:

    $ git pull

    ... # fetch operation

    Saved working directory and index state WIP on master: 8ea73ed baz
    HEAD is now at 8ea73ed baz

    ... # The merge/rebase process

    Dropped refs/stash@{0} (83f47fbfb07a741817633f9191dc4a1530f79249)

If there is a conflict during the merge/rebase process, the user has
to pop the stash by hand after committing the conflict resolution:

    $ git pull

    ... # fetch operation

    Saved working directory and index state WIP on master: 8ea73ed baz
    HEAD is now at 8ea73ed baz

    ... # The merge/rebase process

    Automatic merge failed; fix conflicts and then commit the result.
    Please run 'git stash pop' after commiting the conflict resolution.

Introduce a new configuration variable pull.autostash that does
exactly this.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 Documentation/config.txt   |  5 ++++
 Documentation/git-pull.txt |  7 ++++++
 git-pull.sh                | 33 ++++++++++++++++++++++--
 t/t5521-pull-options.sh    | 63 ++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 106 insertions(+), 2 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 3d750e0..6c5cd8e 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1804,6 +1804,11 @@ pull.rebase::
 it unless you understand the implications (see linkgit:git-rebase[1]
 for details).
 
+pull.autostash::
+	When true, automatically stash all changes before attempting
+	to merge/rebase, and pop the stash after a successful
+	merge/rebase.
+
 pull.octopus::
 	The default merge strategy to use when pulling multiple branches
 	at once.
diff --git a/Documentation/git-pull.txt b/Documentation/git-pull.txt
index 24ab07a..1c5384b 100644
--- a/Documentation/git-pull.txt
+++ b/Documentation/git-pull.txt
@@ -94,6 +94,13 @@ must be given before the options meant for 'git fetch'.
 	has to be called afterwards to bring the work tree up to date with the
 	merge result.
 
+--[no-]autostash::
+	When turned on, automatically stash all changes before
+	attempting to merge/rebase, and pop the stash after a
+	successful merge/rebase.  Useful for people who want to pull
+	with a dirty worktree.  This option can also be set via the
+	`pull.autostash` configuration variable.
+
 Options related to merging
 ~~~~~~~~~~~~~~~~~~~~~~~~~~
 
diff --git a/git-pull.sh b/git-pull.sh
index 5fe69fa..4edc06a 100755
--- a/git-pull.sh
+++ b/git-pull.sh
@@ -48,6 +48,7 @@ if test -z "$rebase"
 then
 	rebase=$(git config --bool pull.rebase)
 fi
+autostash=$(git config --bool pull.autostash || echo false)
 dry_run=
 while :
 do
@@ -116,6 +117,12 @@ do
 	--no-r|--no-re|--no-reb|--no-reba|--no-rebas|--no-rebase)
 		rebase=false
 		;;
+	--autostash)
+		autostash=true
+		;;
+	--no-autostash)
+		autostash=false
+		;;
 	--recurse-submodules)
 		recurse_submodules=--recurse-submodules
 		;;
@@ -202,7 +209,8 @@ test true = "$rebase" && {
 		then
 			die "$(gettext "updating an unborn branch with changes added to the index")"
 		fi
-	else
+	elif test "$autostash" = false
+	then
 		require_clean_work_tree "pull with rebase" "Please commit or stash them."
 	fi
 	oldremoteref= &&
@@ -219,6 +227,12 @@ test true = "$rebase" && {
 		fi
 	done
 }
+
+stash_required () {
+	! (git diff-files --quiet --ignore-submodules &&
+	git diff-index --quiet --cached HEAD --ignore-submodules)
+}
+
 orig_head=$(git rev-parse -q --verify HEAD)
 git fetch $verbosity $progress $dry_run $recurse_submodules --update-head-ok "$@" || exit 1
 test -z "$dry_run" || exit 0
@@ -294,4 +308,19 @@ true)
 	eval="$eval \"\$merge_name\" HEAD $merge_head"
 	;;
 esac
-eval "exec $eval"
+
+if test "$autostash" = true && stash_required
+then
+	git stash || die "$(gettext "Cannot autostash")" &&
+	require_clean_work_tree "pull" "Please commit or stash them." &&
+	if eval "$eval"
+	then
+		git stash pop || die "$(gettext "Cannot pop stash")"
+	else
+		exit_code=$?
+		echo "Please run 'git stash pop' after commiting the conflict resolution."
+		exit $exit_code
+	fi
+else
+	eval "exec $eval"
+fi
diff --git a/t/t5521-pull-options.sh b/t/t5521-pull-options.sh
index 3bdfe82..4545671 100755
--- a/t/t5521-pull-options.sh
+++ b/t/t5521-pull-options.sh
@@ -117,4 +117,67 @@ test_expect_success 'git pull --all' '
 	)
 '
 
+test_expect_success 'pull --autostash with clean worktree' '
+	mkdir clonedautostash &&
+	(
+		cd clonedautostash &&
+		git init &&
+		git pull --autostash ../parent &&
+		test_must_fail test_path_is_file .git/refs/stash
+		test_commit one
+	) &&
+	rm -rf clonedautostash
+'
+
+test_expect_success 'pull.autostash with clean worktree' '
+	mkdir clonedautostash &&
+	(
+		cd clonedautostash &&
+		git init &&
+		test_config pull.autostash true &&
+		git pull ../parent &&
+		test_must_fail test_path_is_file .git/refs/stash
+		test_commit one
+	) &&
+	rm -rf clonedautostash
+'
+
+test_expect_success 'pull.autostash without conflict' '
+	mkdir clonedautostash &&
+	(
+		cd clonedautostash &&
+		git init &&
+		test_commit "root_commit" &&
+		cat >quux <<-\EOF &&
+		this is a non-conflicting file
+		EOF
+		git add quux &&
+		test_config pull.autostash true &&
+		git pull ../parent &&
+		test_must_fail test_path_is_file .git/refs/stash &&
+		test_path_is_file quux &&
+		test_commit one
+	) &&
+	rm -rf clonedautostash
+'
+
+test_expect_success 'pull.autostash with conflict' '
+	mkdir clonedautostash &&
+	(
+		cd clonedautostash &&
+		git init &&
+		test_commit "will_conflict" file "this is a conflicting file" &&
+		cat >quux <<-\EOF &&
+		this is a non-conflicting file
+		EOF
+		git add quux &&
+		test_config pull.autostash true &&
+		test_must_fail git pull ../parent &&
+		test_must_fail test_commit one &&
+		test_path_is_file .git/refs/stash &&
+		test_must_fail test_path_is_file quux
+	) &&
+	rm -rf clonedautostash
+'
+
 test_done
-- 
1.8.2.1.392.g6943ea6
