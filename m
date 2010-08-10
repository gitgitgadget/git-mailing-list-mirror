From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH] git-notes: Run partial expensive test everywhere
Date: Tue, 10 Aug 2010 19:56:04 +0000
Message-ID: <1281470164-27008-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 10 21:56:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oiuvo-0001F1-Ew
	for gcvg-git-2@lo.gmane.org; Tue, 10 Aug 2010 21:56:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756037Ab0HJT4L convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 10 Aug 2010 15:56:11 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:46838 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755116Ab0HJT4K (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Aug 2010 15:56:10 -0400
Received: by wwj40 with SMTP id 40so13314230wwj.1
        for <git@vger.kernel.org>; Tue, 10 Aug 2010 12:56:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        bh=MpACDHf7UO3TuyiZA806PBgncV6s+RVw0tzt4J9l+gw=;
        b=WMHYUPydY9rF1tJJm07bc2Q5qWe8PafBHVwKs/ifjBg3ZyvxHo0vw2tmaDbawnMpgi
         udJ1EC9h0r2q85Szy/yJAsit75Es7S6cdiX1HXLAOrPe3+8p37Fhcz9Z1IVzdtu/eNYJ
         Y7SRbRnvtqOaSCXRM9AXohGIcpJBdDTzonyo4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=OlbGtkmWVi6RibEo9GUbUWRBPiQalJL9hUhxVq8hed/J73Q+GNT3jSVt8M70N2pau7
         ko+YB1TUGsN3NhMAWsxgXRpFMNp8mIZDRDubBJ4Ox/GKzdH40cyTsy8lLTSQeT3WvI+C
         aV3uSqxa0BKMek/BkHyLVkRz3jxh2CLEjcCE8=
Received: by 10.227.138.7 with SMTP id y7mr15199494wbt.133.1281470169149;
        Tue, 10 Aug 2010 12:56:09 -0700 (PDT)
Received: from v.nix.is (v.nix.is [109.74.193.250])
        by mx.google.com with ESMTPS id i25sm5808180wbi.16.2010.08.10.12.56.08
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 10 Aug 2010 12:56:08 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.1.295.gd03d
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153151>

The git-notes expensive timing test is only expensive because it
either did 1k iterations or nothing. Change it to do 10 by default,
with an option to run the expensive version with the old
GIT_NOTES_TIMING_TESTS=3DZomgYesPlease variable.

Since nobody was ostensibly running this test under TAP the code had
bitrotted so that it emitted invalid TAP. This change fixes that.

The old version would also mysteriously fail on systems without
/usr/bin/time, there's now a check for that using the test
prerequisite facility.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 t/t3302-notes-index-expensive.sh |   39 ++++++++++++++++++++++++++----=
-------
 1 files changed, 27 insertions(+), 12 deletions(-)

diff --git a/t/t3302-notes-index-expensive.sh b/t/t3302-notes-index-exp=
ensive.sh
index 361a10a..3b8313c 100755
--- a/t/t3302-notes-index-expensive.sh
+++ b/t/t3302-notes-index-expensive.sh
@@ -7,11 +7,16 @@ test_description=3D'Test commit notes index (expensiv=
e!)'
=20
 . ./test-lib.sh
=20
-test -z "$GIT_NOTES_TIMING_TESTS" && {
-	skip_all=3D"Skipping timing tests"
-	test_done
-	exit
-}
+test_set_prereq NOT_EXPENSIVE
+test -n "$GIT_NOTES_TIMING_TESTS" && test_set_prereq EXPENSIVE
+
+if test -x /usr/bin/time
+then
+	# Hack around multiple test prerequisites not supporting AND-ing
+	# of terms
+	test_set_prereq USR_BIN_TIME+NOT_EXPENSIVE
+	test_have_prereq EXPENSIVE && test_set_prereq USR_BIN_TIME+EXPENSIVE
+fi
=20
 create_repo () {
 	number_of_commits=3D$1
@@ -102,17 +107,27 @@ time_notes () {
 	done
 }
=20
-for count in 10 100 1000 10000; do
+do_tests () {
+	pr=3D$1
+	count=3D$2
+
+	test_expect_success $pr 'setup / mkdir' '
+		mkdir $count &&
+		cd $count
+	'
=20
-	mkdir $count
-	(cd $count;
+	test_expect_success $pr "setup $count" "create_repo $count"
=20
-	test_expect_success "setup $count" "create_repo $count"
+	test_expect_success $pr 'notes work' "test_notes $count"
=20
-	test_expect_success 'notes work' "test_notes $count"
+	test_expect_success USR_BIN_TIME+$pr 'notes timing with /usr/bin/time=
' "time_notes 100"
+
+	test_expect_success $pr 'teardown / cd ..' 'cd ..'
+}
=20
-	test_expect_success 'notes timing' "time_notes 100"
-	)
+do_tests NOT_EXPENSIVE 10
+for count in 100 1000 10000; do
+	do_tests EXPENSIVE $count
 done
=20
 test_done
--=20
1.7.2.1.295.gd03d
