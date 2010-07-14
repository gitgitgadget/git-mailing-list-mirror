From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: [PATCH v4] add configuration variable for --autosquash option of
	interactive rebase
Date: Wed, 14 Jul 2010 13:59:57 +0200
Message-ID: <20100714115957.GC15316@book.hvoigt.net>
References: <20100709124659.GA17559@book.hvoigt.net> <m27hl4zg99.fsf@igel.home> <20100710091517.GA27323@book.hvoigt.net> <7vk4p1fdlg.fsf@alter.siamese.dyndns.org> <20100713112316.GA758@book.hvoigt.net> <4C3D4802.2010707@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andreas Schwab <schwab@linux-m68k.org>, git@vger.kernel.org,
	Santi =?iso-8859-1?Q?B=E9jar?= <santi@agolina.net>,
	Stephen Boyd <bebarino@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 14 14:00:09 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OZ0dD-0002iO-Ob
	for gcvg-git-2@lo.gmane.org; Wed, 14 Jul 2010 14:00:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753551Ab0GNMAA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Jul 2010 08:00:00 -0400
Received: from darksea.de ([83.133.111.250]:44855 "HELO darksea.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752185Ab0GNL77 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Jul 2010 07:59:59 -0400
Received: (qmail 18463 invoked from network); 14 Jul 2010 13:59:57 +0200
Received: from unknown (HELO localhost) (127.0.0.1)
  by localhost with SMTP; 14 Jul 2010 13:59:57 +0200
Content-Disposition: inline
In-Reply-To: <4C3D4802.2010707@gmail.com>
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150982>

If you use this feature regularly you can now enable it by default. In
case the user wants to override this config on the commandline
--no-autosquash can be used to force disabling.

Signed-off-by: Heiko Voigt <hvoigt@hvoigt.net>
---

Changes since v3:

  * Add documentation of configuration variable to config.txt
  * Merge description of --no-autosquash with the one of --autosquash

 Documentation/config.txt     |    3 +++
 Documentation/git-rebase.txt |    8 ++++++++
 git-rebase--interactive.sh   |    4 ++++
 t/t3415-rebase-autosquash.sh |   40 ++++++++++++++++++++++++++++++++--------
 4 files changed, 47 insertions(+), 8 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 72949e7..d0c985e 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1531,6 +1531,9 @@ rebase.stat::
 	Whether to show a diffstat of what changed upstream since the last
 	rebase. False by default.
 
+rebase.autosquash::
+	If set to true enable '--autosquash' option by default.
+
 receive.autogc::
 	By default, git-receive-pack will run "git-gc --auto" after
 	receiving data from git-push and updating refs.  You can stop
diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index be23ad2..1e2a564 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -199,6 +199,9 @@ rebase.stat::
 	Whether to show a diffstat of what changed upstream since the last
 	rebase. False by default.
 
+rebase.autosquash::
+	If set to true enable '--autosquash' option by default.
+
 OPTIONS
 -------
 <newbase>::
@@ -326,6 +329,7 @@ idea unless you know what you are doing (see BUGS below).
 	instead.
 
 --autosquash::
+--no-autosquash::
 	When the commit log message begins with "squash! ..." (or
 	"fixup! ..."), and there is a commit whose title begins with
 	the same ..., automatically modify the todo list of rebase -i
@@ -334,6 +338,10 @@ idea unless you know what you are doing (see BUGS below).
 	commit from `pick` to `squash` (or `fixup`).
 +
 This option is only valid when the '--interactive' option is used.
++
+If the '--autosquash' option is enabled by default using the
+configuration variable `rebase.autosquash` this option can be
+used to override and disable this setting.
 
 --no-ff::
 	With --interactive, cherry-pick all rebased commits instead of
diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 6b86abc..7b35f80 100755
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -111,6 +111,7 @@ VERBOSE=
 OK_TO_SKIP_PRE_REBASE=
 REBASE_ROOT=
 AUTOSQUASH=
+test "$(git config --bool rebase.autosquash)" = "true" && AUTOSQUASH=t
 NEVER_FF=
 
 GIT_CHERRY_PICK_HELP="  After resolving the conflicts,
@@ -795,6 +796,9 @@ first and then run 'git rebase --continue' again."
 	--autosquash)
 		AUTOSQUASH=t
 		;;
+	--no-autosquash)
+		AUTOSQUASH=
+		;;
 	--onto)
 		shift
 		ONTO=$(parse_onto "$1") ||
diff --git a/t/t3415-rebase-autosquash.sh b/t/t3415-rebase-autosquash.sh
index b63f4e2..37cb89a 100755
--- a/t/t3415-rebase-autosquash.sh
+++ b/t/t3415-rebase-autosquash.sh
@@ -21,38 +21,62 @@ test_expect_success setup '
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
+	test_auto_fixup final-fixup-config-true &&
+	test_must_fail test_auto_fixup fixup-config-true-no --no-autosquash &&
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
+	test_auto_squash final-squash-config-true &&
+	test_must_fail test_auto_squash squash-config-true-no --no-autosquash &&
+	git config rebase.autosquash false &&
+	test_must_fail test_auto_squash final-squash-config-false
 '
 
 test_expect_success 'misspelled auto squash' '
-- 
1.7.2.rc2.1.gf1735.dirty
