From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: [PATCH] add configuration variable for --autosquash option of
	interactive rebase
Date: Fri, 9 Jul 2010 14:47:08 +0200
Message-ID: <20100709124659.GA17559@book.hvoigt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jul 09 14:47:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OXCzC-00048p-1x
	for gcvg-git-2@lo.gmane.org; Fri, 09 Jul 2010 14:47:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755750Ab0GIMrM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Jul 2010 08:47:12 -0400
Received: from darksea.de ([83.133.111.250]:52977 "HELO darksea.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753941Ab0GIMrL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Jul 2010 08:47:11 -0400
Received: (qmail 27347 invoked from network); 9 Jul 2010 14:47:08 +0200
Received: from unknown (HELO localhost) (127.0.0.1)
  by localhost with SMTP; 9 Jul 2010 14:47:08 +0200
Content-Disposition: inline
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150658>

If you use this feature regularly you can now enable it by default.

Signed-off-by: Heiko Voigt <hvoigt@hvoigt.net>
---
 Documentation/git-rebase.txt |    3 +++
 git-rebase--interactive.sh   |    1 +
 t/t3415-rebase-autosquash.sh |   38 ++++++++++++++++++++++++++++++--------
 3 files changed, 34 insertions(+), 8 deletions(-)

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index be23ad2..8849758 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -199,6 +199,9 @@ rebase.stat::
 	Whether to show a diffstat of what changed upstream since the last
 	rebase. False by default.
 
+rebase.autosquash::
+	If set to true enable --autosquash option by default.
+
 OPTIONS
 -------
 <newbase>::
diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 6b86abc..54dc983 100755
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -111,6 +111,7 @@ VERBOSE=
 OK_TO_SKIP_PRE_REBASE=
 REBASE_ROOT=
 AUTOSQUASH=
+test "$(git config --bool rebase.autosquash)" == "true" && AUTOSQUASH=t
 NEVER_FF=
 
 GIT_CHERRY_PICK_HELP="  After resolving the conflicts,
diff --git a/t/t3415-rebase-autosquash.sh b/t/t3415-rebase-autosquash.sh
index b63f4e2..ccc5e44 100755
--- a/t/t3415-rebase-autosquash.sh
+++ b/t/t3415-rebase-autosquash.sh
@@ -21,38 +21,60 @@ test_expect_success setup '
 	git tag base
 '
 
-test_expect_success 'auto fixup' '
+test_auto_fixup() {
 	git reset --hard base &&
 	echo 1 >file1 &&
 	git add -u &&
 	test_tick &&
 	git commit -m "fixup! first"
 
-	git tag final-fixup &&
+	git tag $1 &&
 	test_tick &&
-	git rebase --autosquash -i HEAD^^^ &&
+	git rebase $2 -i HEAD^^^ &&
 	git log --oneline >actual &&
 	test 3 = $(wc -l <actual) &&
-	git diff --exit-code final-fixup &&
+	git diff --exit-code $1 &&
 	test 1 = "$(git cat-file blob HEAD^:file1)" &&
 	test 1 = $(git cat-file commit HEAD^ | grep first | wc -l)
+}
+
+test_expect_success 'auto fixup (option)' '
+	test_auto_fixup final-fixup-option --autosquash
+'
+
+test_expect_success 'auto fixup (config)' '
+	git config rebase.autosquash true &&
+	test_auto_fixup final-fixup-config-true
+	git config rebase.autosquash false &&
+	test_must_fail test_auto_fixup final-fixup-config-false
 '
 
-test_expect_success 'auto squash' '
+test_auto_squash() {
 	git reset --hard base &&
 	echo 1 >file1 &&
 	git add -u &&
 	test_tick &&
 	git commit -m "squash! first"
 
-	git tag final-squash &&
+	git tag $1 &&
 	test_tick &&
-	git rebase --autosquash -i HEAD^^^ &&
+	git rebase $2 -i HEAD^^^ &&
 	git log --oneline >actual &&
 	test 3 = $(wc -l <actual) &&
-	git diff --exit-code final-squash &&
+	git diff --exit-code $1 &&
 	test 1 = "$(git cat-file blob HEAD^:file1)" &&
 	test 2 = $(git cat-file commit HEAD^ | grep first | wc -l)
+}
+
+test_expect_success 'auto squash (option)' '
+	test_auto_squash final-squash --autosquash
+'
+
+test_expect_success 'auto squash (config)' '
+	git config rebase.autosquash true &&
+	test_auto_squash final-squash-config-true
+	git config rebase.autosquash false &&
+	test_must_fail test_auto_squash final-squash-config-false
 '
 
 test_expect_success 'misspelled auto squash' '
-- 
1.7.2.rc2.1.geb6d9
