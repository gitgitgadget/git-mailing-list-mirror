From: Christian Hesse <mail@eworm.de>
Subject: [PATCH 1/1] skip RFC1991 tests with gnupg 2.1.x
Date: Thu, 11 Dec 2014 10:30:34 +0100
Message-ID: <1418290234-21516-1-git-send-email-mail@eworm.de>
Cc: Christian Hesse <mail@eworm.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 11 10:37:20 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xz0BT-0000Nx-F9
	for gcvg-git-2@plane.gmane.org; Thu, 11 Dec 2014 10:37:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932839AbaLKJhO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Dec 2014 04:37:14 -0500
Received: from mx.mylinuxtime.de ([148.251.109.235]:60907 "EHLO
	mx.mylinuxtime.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932272AbaLKJhL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Dec 2014 04:37:11 -0500
X-Greylist: delayed 384 seconds by postgrey-1.27 at vger.kernel.org; Thu, 11 Dec 2014 04:37:11 EST
Received: from leda.eworm.de (unknown [10.10.1.2])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx.mylinuxtime.de (Postfix) with ESMTPSA id D1A5124255;
	Thu, 11 Dec 2014 10:30:46 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.9.2 mx.mylinuxtime.de D1A5124255
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=eworm.de; s=mail;
	t=1418290246; bh=eedEWdv2hJUijUuPSCQ8OBYSnsXvHcBff3iN6UwphzQ=;
	h=From:To:Cc:Subject:Date;
	b=VpB3u1fRXceZUYdaMVlGIGLGBtz2G2MPV1JPrFZdfIEJquB4MsHh5GLRXWGwKCH1y
	 Q8dpv3ujHjWDtGCAHPsDQwEu9hjYa1q+z0C3lTpTLRU2t+GCAYKY+RzOcm+to4nFVG
	 WGe5DJoScqMlbPtkjrL0I69lrnSfFz7+cTO1oaMQ=
Received: by leda.eworm.de (Postfix, from userid 1000)
	id A372D10345B; Thu, 11 Dec 2014 10:30:41 +0100 (CET)
X-Mailer: git-send-email 2.1.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261273>

---
 t/lib-gpg.sh   |  6 ++++++
 t/t7004-tag.sh | 14 +++++++-------
 2 files changed, 13 insertions(+), 7 deletions(-)

diff --git a/t/lib-gpg.sh b/t/lib-gpg.sh
index cd2baef..05b07c6 100755
--- a/t/lib-gpg.sh
+++ b/t/lib-gpg.sh
@@ -22,6 +22,12 @@ else
 		GNUPGHOME="$(pwd)/gpghome"
 		export GNUPGHOME
 		test_set_prereq GPG
+		case "$gpg_version" in
+		'gpg (GnuPG) 2.1.'*)
+			say "Your version of gpg (2.1.x) is missing some legacy features"
+			test_set_prereq GNUPG21
+			;;
+		esac
 		;;
 	esac
 fi
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
2.1.3
