From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 3/3] git-pull.sh: introduce --[no-]autostash and pull.autostash
Date: Fri, 22 Mar 2013 17:59:59 +0530
Message-ID: <1363955399-13153-4-git-send-email-artagnon@gmail.com>
References: <1363955399-13153-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Mar 22 13:29:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UJ165-0005Jm-Kc
	for gcvg-git-2@plane.gmane.org; Fri, 22 Mar 2013 13:29:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932247Ab3CVM26 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Mar 2013 08:28:58 -0400
Received: from mail-da0-f52.google.com ([209.85.210.52]:40847 "EHLO
	mail-da0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753719Ab3CVM2z (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Mar 2013 08:28:55 -0400
Received: by mail-da0-f52.google.com with SMTP id f10so2255372dak.11
        for <git@vger.kernel.org>; Fri, 22 Mar 2013 05:28:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=yuOItPNv0wZOloT3Xw06zfO5lHTMUNhiCbBTzRu3x+I=;
        b=biau0aiZufsIC+H77PtJ6p/xxrJSk+7awVk3wkrpOW7IFNHnSJBHXg8i1quDYgOqsm
         H1q2k9lX/jGMt5wMXopGyUFjnqh61Htgk68UCsWA4zg4+rmYmoePRSWzqGhGqfdsPZKC
         HuBzGA2SzJrBNxcpX9ZiLCFu+PDAWNmIGO0EZnYK2t5nmrytQ49QHt4uCHvp74ukA9zG
         Ksq7bqU+S4yKXXCgIAN5MGA4/2Nd1Lfw4E9UsuDo1zwd5frurOXEKj3y9laFDvuF51SD
         Br3ra75nKjEXFEpobc/gLPhFQFRRlgEt4omdOjpvi+XbtB+5xNzbXZn/Nu94v0nstavm
         oliA==
X-Received: by 10.66.156.68 with SMTP id wc4mr2944533pab.58.1363955334832;
        Fri, 22 Mar 2013 05:28:54 -0700 (PDT)
Received: from luneth.maa.corp.collab.net ([182.71.239.158])
        by mx.google.com with ESMTPS id ve7sm2839591pab.11.2013.03.22.05.28.52
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 22 Mar 2013 05:28:54 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.141.gad203c2.dirty
In-Reply-To: <1363955399-13153-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218795>

This new configuration variable executes 'git stash' before attempting
to merge/rebase, and 'git stash pop' after a successful merge/rebase.
It makes it convenient for people to pull with dirty worktrees.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 Documentation/config.txt   |  5 ++++
 Documentation/git-pull.txt |  7 ++++++
 git-pull.sh                | 26 ++++++++++++++++++--
 t/t5521-pull-options.sh    | 59 ++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 95 insertions(+), 2 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index c1f435f..0becafe 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1786,6 +1786,11 @@ pull.rebase::
 	of merging the default branch from the default remote when "git
 	pull" is run. See "branch.<name>.rebase" for setting this on a
 	per-branch basis.
+
+pull.autostash::
+	When true, automatically stash all changes before attempting to
+	merge/rebase, and pop the stash after a successful
+	merge/rebase.
 +
 *NOTE*: this is a possibly dangerous operation; do *not* use
 it unless you understand the implications (see linkgit:git-rebase[1]
diff --git a/Documentation/git-pull.txt b/Documentation/git-pull.txt
index c975743..bb57c86 100644
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
index 37e1cd4..ad8e494 100755
--- a/git-pull.sh
+++ b/git-pull.sh
@@ -48,6 +48,7 @@ if test -z "$rebase"
 then
 	rebase=$(git config --bool pull.rebase)
 fi
+autostash=$(git config --bool pull.autostash)
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
@@ -196,7 +203,8 @@ test true = "$rebase" && {
 		then
 			die "$(gettext "updating an unborn branch with changes added to the index")"
 		fi
-	else
+	elif test "$autostash" = false
+	then
 		require_clean_work_tree "pull with rebase" "Please commit or stash them."
 	fi
 	oldremoteref= &&
@@ -213,6 +221,12 @@ test true = "$rebase" && {
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
@@ -288,4 +302,12 @@ true)
 	eval="$eval \"\$merge_name\" HEAD $merge_head"
 	;;
 esac
-eval "exec $eval"
+
+if test "$autostash" = true && stash_required
+then
+	git stash
+	eval "$eval"
+	test $? = 0 && git stash pop
+else
+	eval "exec $eval"
+fi
diff --git a/t/t5521-pull-options.sh b/t/t5521-pull-options.sh
index 4a804f0..cecacbc 100755
--- a/t/t5521-pull-options.sh
+++ b/t/t5521-pull-options.sh
@@ -90,4 +90,63 @@ test_expect_success 'git pull --all' '
 	)
 '
 
+test_expect_success 'pull --autostash with clean worktree' '
+	mkdir clonedautostash &&
+	(cd clonedautostash &&
+	git init &&
+	git pull --autostash ../parent &&
+	test_must_fail test_path_is_file .git/refs/stash
+	test_commit one
+	) &&
+	rm -rf clonedautostash
+'
+
+test_expect_success 'pull.autostash with clean worktree' '
+	mkdir clonedautostash &&
+	(cd clonedautostash &&
+	git init &&
+	test_config pull.autostash true &&
+	git pull ../parent &&
+	test_must_fail test_path_is_file .git/refs/stash
+	test_commit one
+	) &&
+	rm -rf clonedautostash
+'
+
+test_expect_success 'pull.autostash without conflict' '
+	mkdir clonedautostash &&
+	(cd clonedautostash &&
+	git init &&
+	test_commit "root_commit" &&
+	cat >quux <<-\EOF &&
+	this is a non-conflicting file
+	EOF
+	git add quux &&
+	test_config pull.autostash true &&
+	git pull ../parent &&
+	test_must_fail test_path_is_file .git/refs/stash &&
+	test_path_is_file quux &&
+	test_commit one
+	) &&
+	rm -rf clonedautostash
+'
+
+test_expect_success 'pull.autostash with conflict' '
+	mkdir clonedautostash &&
+	(cd clonedautostash &&
+	git init &&
+	test_commit "will_conflict" file "this is a conflicting file" &&
+	cat >quux <<-\EOF &&
+	this is a non-conflicting file
+	EOF
+	git add quux &&
+	test_config pull.autostash true &&
+	test_must_fail git pull ../parent &&
+	test_must_fail test_commit one &&
+	test_path_is_file .git/refs/stash &&
+	test_must_fail test_path_is_file quux
+	) &&
+	rm -rf clonedautostash
+'
+
 test_done
-- 
1.8.2.141.gad203c2.dirty
