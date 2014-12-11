From: Christian Hesse <mail@eworm.de>
Subject: [PATCH v2 1/1] create gpg homedir on the fly and skip RFC1991 tests for gnupg 2.1
Date: Thu, 11 Dec 2014 14:16:12 +0100
Message-ID: <1418303772-7909-1-git-send-email-mail@eworm.de>
Cc: Christian Hesse <mail@eworm.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 11 14:16:29 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xz3bY-00011G-Sx
	for gcvg-git-2@plane.gmane.org; Thu, 11 Dec 2014 14:16:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757838AbaLKNQZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Dec 2014 08:16:25 -0500
Received: from mx.mylinuxtime.de ([148.251.109.235]:57874 "EHLO
	mx.mylinuxtime.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750702AbaLKNQX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Dec 2014 08:16:23 -0500
Received: from leda.eworm.de (unknown [10.10.1.2])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx.mylinuxtime.de (Postfix) with ESMTPSA id 3703E24312;
	Thu, 11 Dec 2014 14:16:22 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.9.2 mx.mylinuxtime.de 3703E24312
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=eworm.de; s=mail;
	t=1418303782; bh=IZXZi4Eu1gvNOhFvF1dmygbN/CM6z5Rez/SoFMUo2mI=;
	h=From:To:Cc:Subject:Date;
	b=UYNkdE8JwnCkn5yVvch9601Xe0EHswqK7HZPaZkuN9mtEUoKcaUPdibfgtyWmWUCF
	 Le0Ez1/xrbWq6w0pALo4MB4IoNNEM5zgy9sG03LXs/e3Hk1zbxgZXXYutztdH3rpw0
	 FJlYaw2iSMNf3/G99cZeu++1KJBDA+Z3GHjBpQQ0=
Received: by leda.eworm.de (Postfix, from userid 1000)
	id 0E83F10344D; Thu, 11 Dec 2014 14:16:17 +0100 (CET)
X-Mailer: git-send-email 2.2.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261276>

GnuPG 2.1 homedir looks different, so just creat it on the fly by
importing needed private and public keys and ownertrust.
This solves an issue with gnupg 2.1 running interactive pinentry when
old secret key is present.

Additionally GnuPG 2.1 does not longer support RFC1991, so skip these
tests.
---
 t/lib-gpg.sh          |  13 ++++++++++---
 t/lib-gpg/ownertrust  |   4 ++++
 t/lib-gpg/random_seed | Bin 600 -> 0 bytes
 t/lib-gpg/trustdb.gpg | Bin 1360 -> 0 bytes
 t/t7004-tag.sh        |  14 +++++++-------
 5 files changed, 21 insertions(+), 10 deletions(-)
 create mode 100644 t/lib-gpg/ownertrust
 delete mode 100644 t/lib-gpg/random_seed
 delete mode 100644 t/lib-gpg/trustdb.gpg

diff --git a/t/lib-gpg.sh b/t/lib-gpg.sh
index cd2baef..17c45ad 100755
--- a/t/lib-gpg.sh
+++ b/t/lib-gpg.sh
@@ -16,12 +16,19 @@ else
 		# Type DSA and Elgamal, size 2048 bits, no expiration date.
 		# Name and email: C O Mitter <committer@example.com>
 		# No password given, to enable non-interactive operation.
-		cp -R "$TEST_DIRECTORY"/lib-gpg ./gpghome
-		chmod 0700 gpghome
-		chmod 0600 gpghome/*
+		mkdir ./gpghome
+		chmod 0700 ./gpghome
 		GNUPGHOME="$(pwd)/gpghome"
 		export GNUPGHOME
+		gpg --homedir "${GNUPGHOME}" --import \
+			"$TEST_DIRECTORY"/lib-gpg/pubring.gpg \
+			"$TEST_DIRECTORY"/lib-gpg/secring.gpg
+		gpg --homedir "${GNUPGHOME}" --import-ownertrust \
+			"$TEST_DIRECTORY"/lib-gpg/ownertrust
 		test_set_prereq GPG
+		if [ -e "${GNUPGHOME}"/pubring.kbx ]; then
+			test_set_prereq GNUPG21
+		fi
 		;;
 	esac
 fi
diff --git a/t/lib-gpg/ownertrust b/t/lib-gpg/ownertrust
new file mode 100644
index 0000000..b3e3c4f
--- /dev/null
+++ b/t/lib-gpg/ownertrust
@@ -0,0 +1,4 @@
+# List of assigned trustvalues, created Thu 11 Dec 2014 01:26:28 PM CET
+# (Use "gpg --import-ownertrust" to restore them)
+73D758744BE721698EC54E8713B6F51ECDDE430D:6:
+D4BE22311AD3131E5EDA29A461092E85B7227189:3:
diff --git a/t/lib-gpg/random_seed b/t/lib-gpg/random_seed
deleted file mode 100644
index 95d249f15fce980f0e8c1a8a18b085b3885708aa..0000000000000000000000000000000000000000
GIT binary patch
literal 0
HcmV?d00001

literal 600
zcmV-e0;m1ccZd+x>>TST*Lrq1x^ggx^+ymwieO!6X=U~ZH@{avIgxdn#ai{)Ou@Qw
za}Z!boffEq^fn)n?c=IEnDpt59Lnc)aR*;8Z;k>gh_NW;ka;7Mt@v#sG(!Y9SSXWv
zQxd3WlyBr#4ltW6uKOoa6(r3df1VX$cG4`Om6hD-ckaX+Hb_yI?{f`hJQY&k!1cM-
zoGeY~(Z7aYn$W06djh?W|CMs>W=k@jgf=P2D1UA1T%vz0oE|<O<lIacG0xioPtS&U
zNd#}P%YpJr-H65~J^RdqA!YV9BEvh7Gw^CdXg+Hp?kj=KGW|+|&g$4?`trWWGuy$9
zv-|;8Y4(NRHWPyJ{epd{4%FHQKk5j}?0FFDAJ;0kIItZ4y<JS?DIG4~0!#x~;X`!P
zO%+va?@`?yQnhjrP@&#yjY$YO_0yk|1ddhc8V&ru7d%ytet)mF<ZIUbPB3bvhHQ41
zNmnYeFxUMu=m$K5&s=5_F&JSR#oU3Y#X{(q7HTp-VYJ)%JjihbZ@R#GeqmU{>0C4Q
zc}hUG+ighB{7XSaNw_h;=YtqacQ<B(Cg$e)^NTDD-oMD+T`O#-^|-ib>j!<pxHg+(
zlC$%zE836|E*F*((=>O{Nn@K$taZO}!>$t>GMgsw?!=n_#(%X9Ha|$b=H@VstWYe;
zPUQ<L$$#9HTcOLoyEd6*A4TOEe3}c}GiW*^P1Lt{nHYUEAB`Qx7*wizaEyM$?AjVN
mb-6m)4=6PVqdR>h+D!{<c#q1!T9b(}OW7hrrT@nJcBO(OGA4ll

diff --git a/t/lib-gpg/trustdb.gpg b/t/lib-gpg/trustdb.gpg
deleted file mode 100644
index 4879ae9a84650a93a4d15bd6560c5d1b89eb4c2f..0000000000000000000000000000000000000000
GIT binary patch
literal 0
HcmV?d00001

literal 1360
zcmZQfFGy!*W@Ke#VqggLnYN69fq@Z-(E%eDx(E*bs5<NcGvvcX4&tvN?+<A7410el
zpr*s&;$I$y;_DG5-p>^?`;Pjx3vc@>clMq$FB`<O@(4fkGH5;5W#Id_>(K1CUIi|N
zsvi2g;@3gdA(S!jFkIQEWGHo6ST63C=8{BCz1HnYg`Lb06^aOjybMdTjEeXLLrOJU
RgG}yTes6vJW7bzp^8ko~DZ2mw

diff --git a/t/t7004-tag.sh b/t/t7004-tag.sh
index 796e9f7..1c40967 100755
--- a/t/t7004-tag.sh
+++ b/t/t7004-tag.sh
@@ -1081,7 +1081,7 @@ test_expect_success GPG \
 get_tag_header rfc1991-signed-tag $commit commit $time >expect
 echo "RFC1991 signed tag" >>expect
 echo '-----BEGIN PGP MESSAGE-----' >>expect
-test_expect_success GPG \
+test_expect_success GPG,!GNUPG21 \
 	'creating a signed tag with rfc1991' '
 	echo "rfc1991" >gpghome/gpg.conf &&
 	git tag -s -m "RFC1991 signed tag" rfc1991-signed-tag $commit &&
@@ -1095,7 +1095,7 @@ cp "$1" actual
 EOF
 chmod +x fakeeditor
 
-test_expect_success GPG \
+test_expect_success GPG,!GNUPG21 \
 	'reediting a signed tag body omits signature' '
 	echo "rfc1991" >gpghome/gpg.conf &&
 	echo "RFC1991 signed tag" >expect &&
@@ -1103,13 +1103,13 @@ test_expect_success GPG \
 	test_cmp expect actual
 '
 
-test_expect_success GPG \
+test_expect_success GPG,!GNUPG21 \
 	'verifying rfc1991 signature' '
 	echo "rfc1991" >gpghome/gpg.conf &&
 	git tag -v rfc1991-signed-tag
 '
 
-test_expect_success GPG \
+test_expect_success GPG,!GNUPG21 \
 	'list tag with rfc1991 signature' '
 	echo "rfc1991" >gpghome/gpg.conf &&
 	echo "rfc1991-signed-tag RFC1991 signed tag" >expect &&
@@ -1123,12 +1123,12 @@ test_expect_success GPG \
 
 rm -f gpghome/gpg.conf
 
-test_expect_success GPG \
+test_expect_success GPG,!GNUPG21 \
 	'verifying rfc1991 signature without --rfc1991' '
 	git tag -v rfc1991-signed-tag
 '
 
-test_expect_success GPG \
+test_expect_success GPG,!GNUPG21 \
 	'list tag with rfc1991 signature without --rfc1991' '
 	echo "rfc1991-signed-tag RFC1991 signed tag" >expect &&
 	git tag -l -n1 rfc1991-signed-tag >actual &&
@@ -1139,7 +1139,7 @@ test_expect_success GPG \
 	test_cmp expect actual
 '
 
-test_expect_success GPG \
+test_expect_success GPG,!GNUPG21 \
 	'reediting a signed tag body omits signature' '
 	echo "RFC1991 signed tag" >expect &&
 	GIT_EDITOR=./fakeeditor git tag -f -s rfc1991-signed-tag $commit &&
-- 
2.2.0
