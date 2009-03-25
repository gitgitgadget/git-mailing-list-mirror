From: Johan Herland <johan@herland.net>
Subject: [PATCH/RFC 5/7] Add tests for "core.restrictedRepository" and
 "git init --restricted"
Date: Wed, 25 Mar 2009 22:40:43 +0100
Message-ID: <200903252240.44049.johan@herland.net>
References: <200903250105.05808.johan@herland.net>
 <7v63hybaqd.fsf@gitster.siamese.dyndns.org>
 <200903252236.03010.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 25 22:42:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lmars-0007Mj-1P
	for gcvg-git-2@gmane.org; Wed, 25 Mar 2009 22:42:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755609AbZCYVkt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Mar 2009 17:40:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754907AbZCYVkt
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Mar 2009 17:40:49 -0400
Received: from mx.getmail.no ([84.208.15.66]:42191 "EHLO
	get-mta-out02.get.basefarm.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754858AbZCYVks (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 25 Mar 2009 17:40:48 -0400
Content-disposition: inline
Received: from mx.getmail.no ([10.5.16.4]) by get-mta-out02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KH300M8C07XLI00@get-mta-out02.get.basefarm.net> for
 git@vger.kernel.org; Wed, 25 Mar 2009 22:40:45 +0100 (MET)
Received: from alpha.localnet ([84.215.102.95])
 by get-mta-in01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KH300BN107WPK00@get-mta-in01.get.basefarm.net> for
 git@vger.kernel.org; Wed, 25 Mar 2009 22:40:45 +0100 (MET)
X-PMX-Version: 5.5.3.366731, Antispam-Engine: 2.7.0.366912,
 Antispam-Data: 2009.3.25.212528
User-Agent: KMail/1.11.1 (Linux/2.6.28-ARCH; KDE/4.2.1; x86_64; ; )
In-reply-to: <200903252236.03010.johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114676>

These tests are based on - and analogous to - the existing tests for
"core.sharedRepository" and "git init --shared"

Signed-off-by: Johan Herland <johan@herland.net>
---
 t/t0001-init.sh            |   24 +++++++-
 t/t1304-restricted-repo.sh |  132 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 153 insertions(+), 3 deletions(-)
 create mode 100755 t/t1304-restricted-repo.sh

diff --git a/t/t0001-init.sh b/t/t0001-init.sh
index 5ac0a27..639a88d 100755
--- a/t/t0001-init.sh
+++ b/t/t0001-init.sh
@@ -167,7 +167,7 @@ test_expect_success 'init with --template (blank)' '
 	! test -f template-blank/.git/info/exclude
 '
 
-test_expect_success 'init --bare/--shared overrides system/global config' '
+test_expect_success 'init --bare/--shared/--restricted overrides system/global config' '
 	(
 		HOME="`pwd`" &&
 		export HOME &&
@@ -175,13 +175,16 @@ test_expect_success 'init --bare/--shared overrides system/global config' '
 		unset GIT_CONFIG_NOGLOBAL &&
 		git config -f "$test_config" core.bare false &&
 		git config -f "$test_config" core.sharedRepository 0640 &&
+		git config -f "$test_config" core.restrictedRepository 0027 &&
 		mkdir init-bare-shared-override &&
 		cd init-bare-shared-override &&
-		git init --bare --shared=0666
+		git init --bare --shared=0644 --restricted=0022
 	) &&
 	check_config init-bare-shared-override true unset &&
-	test x0666 = \
+	test x0644 = \
 	x`git config -f init-bare-shared-override/config core.sharedRepository`
+	test x0022 = \
+	x`git config -f init-bare-shared-override/config core.restrictedRepository`
 '
 
 test_expect_success 'init honors global core.sharedRepository' '
@@ -199,4 +202,19 @@ test_expect_success 'init honors global core.sharedRepository' '
 	x`git config -f shared-honor-global/.git/config core.sharedRepository`
 '
 
+test_expect_success 'init honors global core.restrictedRepository' '
+	(
+		HOME="`pwd`" &&
+		export HOME &&
+		test_config="$HOME"/.gitconfig &&
+		unset GIT_CONFIG_NOGLOBAL &&
+		git config -f "$test_config" core.restrictedRepository 0077 &&
+		mkdir restricted-honor-global &&
+		cd restricted-honor-global &&
+		git init
+	) &&
+	test x0077 = \
+	x`git config -f restricted-honor-global/.git/config core.restrictedRepository`
+'
+
 test_done
diff --git a/t/t1304-restricted-repo.sh b/t/t1304-restricted-repo.sh
new file mode 100755
index 0000000..012cdf1
--- /dev/null
+++ b/t/t1304-restricted-repo.sh
@@ -0,0 +1,132 @@
+#!/bin/sh
+#
+# Copied and modified from t1301-shared-repo.sh
+#
+
+test_description='Test restricted repository initialization'
+
+. ./test-lib.sh
+
+# Remove a default ACL from the test dir if possible.
+setfacl -k . 2>/dev/null
+
+# User must have r/w permissions to the repo -> failure on --restricted=0600
+test_expect_success 'restricted = 0600 (faulty permission u-rw)' '
+	mkdir sub && (
+		cd sub && git init --restricted=0600
+	)
+	ret="$?"
+	rm -rf sub
+	test $ret != "0"
+'
+
+modebits () {
+	ls -l "$1" | sed -e 's|^\(..........\).*|\1|'
+}
+
+for u in 0007 0077
+do
+	test_expect_success POSIXPERM "restricted=group does not clear bits preset by umask $u" '
+		mkdir sub && (
+			cd sub &&
+			umask $u &&
+			git init --restricted=group &&
+			test "0007" = "$(git config core.restrictedrepository)"
+		) &&
+		actual=$(ls -l sub/.git/HEAD)
+		case "$u$actual" in
+		0007-rw-rw----*)
+			: happy
+			;;
+		0077-rw-------*)
+			: happy
+			;;
+		*)
+			echo Oops, .git/HEAD is not 06x0 but $actual
+			false
+			;;
+		esac
+	'
+	rm -rf sub
+done
+
+test_expect_success 'restricted=user' '
+	mkdir sub &&
+	cd sub &&
+	git init --restricted=user &&
+	test "0077" = "$(git config core.restrictedrepository)"
+'
+
+test_expect_success POSIXPERM 'update-server-info honors core.restrictedRepository' '
+	: > a1 &&
+	git add a1 &&
+	test_tick &&
+	git commit -m a1 &&
+	umask 0277 &&
+	git update-server-info &&
+	actual="$(ls -l .git/info/refs)" &&
+	case "$actual" in
+	-r--------*)
+		: happy
+		;;
+	*)
+		echo Oops, .git/info/refs is not 0400
+		false
+		;;
+	esac
+'
+
+for u in	0000:rw-rw-rw- \
+		0002:rw-rw-r-- \
+		0007:rw-rw---- \
+		0027:rw-r----- \
+		0077:rw-------
+do
+	x=$(expr "$u" : ".*:\([rw-]*\)") &&
+	y=$(echo "$x" | sed -e "s/w/-/g") &&
+	u=$(expr "$u" : "\([0-7]*\)"); test $? -le 1 &&
+	git config core.restrictedrepository "$u" &&
+	umask 0222 &&
+	test_expect_success POSIXPERM "shared = $u ($y) ro" '
+
+		rm -f .git/info/refs &&
+		git update-server-info &&
+		actual="$(modebits .git/info/refs)" &&
+		test "x$actual" = "x-$y" || {
+			ls -lt .git/info
+			false
+		}
+	'
+
+	umask 0000 &&
+	test_expect_success POSIXPERM "shared = $u ($x) rw" '
+
+		rm -f .git/info/refs &&
+		git update-server-info &&
+		actual="$(modebits .git/info/refs)" &&
+		test "x$actual" = "x-$x" || {
+			ls -lt .git/info
+			false
+		}
+
+	'
+
+done
+
+test_expect_success POSIXPERM 'git reflog expire honors core.restrictedRepository' '
+	umask 0000
+	git config core.restrictedRepository group &&
+	git reflog expire --all &&
+	actual="$(ls -l .git/logs/refs/heads/master)" &&
+	case "$actual" in
+	-rw-rw----*)
+		: happy
+		;;
+	*)
+		echo Ooops, .git/logs/refs/heads/master is not 0660 [$actual]
+		false
+		;;
+	esac
+'
+
+test_done
-- 
1.6.2.1.473.g92672
