From: John Keeping <john@keeping.me.uk>
Subject: [PATCH v2 2/2] submodule: drop the top-level requirement
Date: Tue,  9 Apr 2013 21:29:22 +0100
Message-ID: <4a6394e9e7124c2ad5a3ce232dc746e85cb1c600.1365539059.git.john@keeping.me.uk>
References: <cover.1365364193.git.john@keeping.me.uk>
 <cover.1365539059.git.john@keeping.me.uk>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Junio C Hamano <gitster@pobox.com>,
	John Keeping <john@keeping.me.uk>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 09 22:30:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UPfBN-0006LC-3O
	for gcvg-git-2@plane.gmane.org; Tue, 09 Apr 2013 22:30:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936290Ab3DIUaB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Apr 2013 16:30:01 -0400
Received: from pichi.aluminati.org ([72.9.246.58]:43073 "EHLO
	pichi.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S936275Ab3DIUaA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Apr 2013 16:30:00 -0400
Received: from localhost (localhost [127.0.0.1])
	by pichi.aluminati.org (Postfix) with ESMTP id C5F60161E790;
	Tue,  9 Apr 2013 21:29:59 +0100 (BST)
X-Quarantine-ID: <7zROel89FQM9>
X-Virus-Scanned: Debian amavisd-new at aluminati.org
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "References"
X-Spam-Flag: NO
X-Spam-Score: -2.9
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, BAYES_00=-1.9] autolearn=ham
Received: from pichi.aluminati.org ([127.0.0.1])
	by localhost (pichi.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7zROel89FQM9; Tue,  9 Apr 2013 21:29:58 +0100 (BST)
Received: from river.lan (mink.aluminati.org [10.0.7.180])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by pichi.aluminati.org (Postfix) with ESMTPSA id 70327161E7AD;
	Tue,  9 Apr 2013 21:29:47 +0100 (BST)
X-Mailer: git-send-email 1.8.2.694.ga76e9c3.dirty
In-Reply-To: <cover.1365539059.git.john@keeping.me.uk>
In-Reply-To: <cover.1365539059.git.john@keeping.me.uk>
References: <cover.1365539059.git.john@keeping.me.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220630>

Use the new rev-parse --prefix option to process all paths given to the
submodule command, dropping the requirement that it be run from the
top-level of the repository.

Signed-off-by: John Keeping <john@keeping.me.uk>
---
 git-submodule.sh             |  7 +++++++
 t/t7400-submodule-basic.sh   | 26 ++++++++++++++++++++++++++
 t/t7401-submodule-summary.sh |  9 +++++++++
 3 files changed, 42 insertions(+)

diff --git a/git-submodule.sh b/git-submodule.sh
index 79bfaac..bbf7983 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -14,10 +14,13 @@ USAGE="[--quiet] add [-b <branch>] [-f|--force] [--name <name>] [--reference <re
    or: $dashless [--quiet] foreach [--recursive] <command>
    or: $dashless [--quiet] sync [--recursive] [--] [<path>...]"
 OPTIONS_SPEC=
+SUBDIRECTORY_OK=Yes
 . git-sh-setup
 . git-sh-i18n
 . git-parse-remote
 require_work_tree
+wt_prefix=$(git rev-parse --show-prefix)
+cd_to_toplevel
 
 command=
 branch=
@@ -112,6 +115,7 @@ resolve_relative_url ()
 #
 module_list()
 {
+	eval "set $(git rev-parse --sq --prefix "$wt_prefix" -- "$@")"
 	(
 		git ls-files --error-unmatch --stage -- "$@" ||
 		echo "unmatched pathspec exists"
@@ -335,6 +339,8 @@ cmd_add()
 		usage
 	fi
 
+	sm_path="$wt_prefix$sm_path"
+
 	# assure repo is absolute or relative to parent
 	case "$repo" in
 	./*|../*)
@@ -942,6 +948,7 @@ cmd_summary() {
 	fi
 
 	cd_to_toplevel
+	eval "set $(git rev-parse --sq --prefix "$wt_prefix" -- "$@")"
 	# Get modified modules cared by user
 	modules=$(git $diff_cmd $cached --ignore-submodules=dirty --raw $head -- "$@" |
 		sane_egrep '^:([0-7]* )?160000' |
diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
index ff26535..7795f21 100755
--- a/t/t7400-submodule-basic.sh
+++ b/t/t7400-submodule-basic.sh
@@ -212,6 +212,23 @@ test_expect_success 'submodule add with ./, /.. and // in path' '
 	test_cmp empty untracked
 '
 
+test_expect_success 'submodule add in subdir' '
+	echo "refs/heads/master" >expect &&
+	>empty &&
+	(
+		mkdir addtest/sub &&
+		cd addtest/sub &&
+		git submodule add "$submodurl" ../realsubmod3 &&
+		git submodule init
+	) &&
+
+	rm -f heads head untracked &&
+	inspect addtest/realsubmod3 ../.. &&
+	test_cmp expect heads &&
+	test_cmp expect head &&
+	test_cmp empty untracked
+'
+
 test_expect_success 'setup - add an example entry to .gitmodules' '
 	GIT_CONFIG=.gitmodules \
 	git config submodule.example.url git://example.com/init.git
@@ -319,6 +336,15 @@ test_expect_success 'status should be "up-to-date" after update' '
 	grep "^ $rev1" list
 '
 
+test_expect_success 'status works correctly from a subdirectory' '
+	mkdir sub &&
+	(
+		cd sub &&
+		git submodule status >../list
+	) &&
+	grep "^ $rev1" list
+'
+
 test_expect_success 'status should be "modified" after submodule commit' '
 	(
 		cd init &&
diff --git a/t/t7401-submodule-summary.sh b/t/t7401-submodule-summary.sh
index 30b429e..8f5c1e0 100755
--- a/t/t7401-submodule-summary.sh
+++ b/t/t7401-submodule-summary.sh
@@ -45,6 +45,15 @@ EOF
 	test_cmp expected actual
 "
 
+test_expect_success 'run summary from subdir' '
+	mkdir sub &&
+	(
+		cd sub &&
+		git submodule summary >../actual
+	) &&
+	test_cmp expected actual
+'
+
 commit_file sm1 &&
 head2=$(add_file sm1 foo3)
 
-- 
1.8.2.694.ga76e9c3.dirty
