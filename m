From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH] test-lib: Multi-prereq support only checked the last prereq
Date: Tue, 10 Aug 2010 23:21:51 +0000
Message-ID: <1281482511-2461-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 11 01:22:08 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oiy8y-0002Mu-O9
	for gcvg-git-2@lo.gmane.org; Wed, 11 Aug 2010 01:22:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757896Ab0HJXWA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 10 Aug 2010 19:22:00 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:45767 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751881Ab0HJXV6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Aug 2010 19:21:58 -0400
Received: by wwj40 with SMTP id 40so13537091wwj.1
        for <git@vger.kernel.org>; Tue, 10 Aug 2010 16:21:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        bh=Ep1KW/P4JSTK+r9a1VGox3uECIHzgdUqfUtI5B3QOww=;
        b=AjbmFuCb+gTxHZLPUnjTVsKxl0UtwRUk1kpZ6s2P5TEu0M6D8Rmt7EyjHO5RIhRNwS
         nFimjS0D+zV56938TDkc0wVLn9r1bmCVW/xHWFyTnJAq+2G4Bmkh0wSxh6k7eP/gPX4e
         /F4MiUu7hMBrI8kA+WWvdV0hkV13NEf9uppSE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=uuoDz39YPXychBHjvPej2CPSfpTeibIJBwHVWcs+W44SQMRw8eR+YC1+j2smYAVDsA
         Dw9sqxboLRsu0hN/7qyrqZBN5pkFW/XTmWd5Ck2H7aEby44kRFCV0i15m4F/sTNtXt4V
         x+r0OZ1Ouebk9LibAbBUG2CpAruy0WpaGwIFY=
Received: by 10.227.142.208 with SMTP id r16mr15755803wbu.140.1281482517421;
        Tue, 10 Aug 2010 16:21:57 -0700 (PDT)
Received: from v.nix.is (v.nix.is [109.74.193.250])
        by mx.google.com with ESMTPS id i25sm5986315wbi.16.2010.08.10.16.21.56
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 10 Aug 2010 16:21:56 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.1.295.gd03d
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153173>

The support for multiple test prerequisites added by me in "test-lib:
Add support for multiple test prerequisites" was broken.

The clever for-loop (which I blindly copied from Junio) iterated over
each prerequisite and returned true/false within a case statement.
Thus only the last prerequisite in the list of prerequisites was ever
considered, the rest were ignored.

=46ix that by changing the test_have_prereq code to something less
clever that keeps a count of the total prereqs and the ones we have
and compares the count at the end.

This comes with the added advantage that it's easy to list the missing
prerequisites in the test output.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---

I should have spotted this earlier.

 t/t0000-basic.sh |    6 +++++-
 t/test-lib.sh    |   21 ++++++++++++++++++---
 2 files changed, 23 insertions(+), 4 deletions(-)

diff --git a/t/t0000-basic.sh b/t/t0000-basic.sh
index 2887677..9602085 100755
--- a/t/t0000-basic.sh
+++ b/t/t0000-basic.sh
@@ -84,7 +84,11 @@ donthaveit=3Dyes
 test_expect_success HAVEIT,DONTHAVEIT 'unmet prerequisites causes test=
 to be skipped' '
     donthaveit=3Dno
 '
-if test $haveit$donthaveit !=3D yesyes
+donthaveiteither=3Dyes
+test_expect_success DONTHAVEIT,HAVEIT 'unmet prerequisites causes test=
 to be skipped' '
+    donthaveiteither=3Dno
+'
+if test $haveit$donthaveit$donthaveiteither !=3D yesyesyes
 then
 	say "bug in test framework: multiple prerequisite tags do not work re=
liably"
 	exit 1
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 4e73fff..8c8e129 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -337,15 +337,30 @@ test_have_prereq () {
 	IFS=3D,
 	set -- $*
 	IFS=3D$save_IFS
+
+	total_prereq=3D0
+	ok_prereq=3D0
+	missing_prereq=3D
+
 	for prerequisite
 	do
+		total_prereq=3D$(($total_prereq + 1))
 		case $satisfied in
 		*" $prerequisite "*)
-			: yes, have it ;;
+			ok_prereq=3D$(($ok_prereq + 1))
+			;;
 		*)
-			! : nope ;;
+			# Keep a list of missing prerequisites
+			if test -z "$missing_prereq"
+			then
+				missing_prereq=3D$prerequisite
+			else
+				missing_prereq=3D"$prerequisite,$missing_prereq"
+			fi
 		esac
 	done
+
+	test $total_prereq =3D $ok_prereq
 }
=20
 # You are not expected to call test_ok_ and test_failure_ directly, us=
e
@@ -408,7 +423,7 @@ test_skip () {
 	case "$to_skip" in
 	t)
 		say_color skip >&3 "skipping test: $@"
-		say_color skip "ok $test_count # skip $1 (prereqs: $prereq)"
+		say_color skip "ok $test_count # skip $1 (missing $missing_prereq of=
 $prereq)"
 		: true
 		;;
 	*)
--=20
1.7.2.1.295.gd03d
