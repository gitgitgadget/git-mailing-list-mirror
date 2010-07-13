From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: [PATCH v3] add configuration variable for --autosquash option of
	interactive rebase
Date: Tue, 13 Jul 2010 13:24:40 +0200
Message-ID: <20100713112316.GA758@book.hvoigt.net>
References: <20100709124659.GA17559@book.hvoigt.net> <m27hl4zg99.fsf@igel.home> <20100710091517.GA27323@book.hvoigt.net> <7vk4p1fdlg.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andreas Schwab <schwab@linux-m68k.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 13 13:24:48 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OYdbT-00074X-Eb
	for gcvg-git-2@lo.gmane.org; Tue, 13 Jul 2010 13:24:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755532Ab0GMLYn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Jul 2010 07:24:43 -0400
Received: from darksea.de ([83.133.111.250]:56381 "HELO darksea.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755391Ab0GMLYm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Jul 2010 07:24:42 -0400
Received: (qmail 13376 invoked from network); 13 Jul 2010 13:24:40 +0200
Received: from unknown (HELO localhost) (127.0.0.1)
  by localhost with SMTP; 13 Jul 2010 13:24:40 +0200
Content-Disposition: inline
In-Reply-To: <7vk4p1fdlg.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150897>

If you use this feature regularly you can now enable it by default. In
case the user wants to override this config on the commandline
--no-autosquash can be used to force disabling.

Signed-off-by: Heiko Voigt <hvoigt@hvoigt.net>
---
On Sun, Jul 11, 2010 at 10:55:55PM -0700, Junio C Hamano wrote:
> Heiko Voigt <hvoigt@hvoigt.net> writes:
> 
> > If you use this feature regularly you can now enable it by default.
> 
> And if you use this often _but_ you sometimes need to countermand from the
> command line, do you provide a way to do so (I didn't bother to check).

No I did not see the exact use case because you could simply not prefix
you commits with 'fixup!' or 'squash!' and if your project regularly
uses those on commits you probably would like to configure different
prefixes.

On the other hand I think it is a good convention to always provide a
--no-... option for things you can enable in the config and it does not
hurt to do so. So here is a new patch implementing this. I also fixed
some places with missing && in the testcases I implemented.

cheers Heiko

 Documentation/git-rebase.txt |    8 ++++++++
 git-rebase--interactive.sh   |    4 ++++
 t/t3415-rebase-autosquash.sh |   40 ++++++++++++++++++++++++++++++++--------
 3 files changed, 44 insertions(+), 8 deletions(-)

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index be23ad2..d357ab1 100644
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
@@ -335,6 +338,11 @@ idea unless you know what you are doing (see BUGS below).
 +
 This option is only valid when the '--interactive' option is used.
 
+--no-autosquash::
+	If the '--autosquash' option is enabled by default using the
+	configuration variable `rebase.autosquash` this option can be
+	used to override and disable this setting.
+
 --no-ff::
 	With --interactive, cherry-pick all rebased commits instead of
 	fast-forwarding over the unchanged ones.  This ensures that the
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
