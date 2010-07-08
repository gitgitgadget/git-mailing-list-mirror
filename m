From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH] test-lib: Don't write test-results when HARNESS_ACTIVE
Date: Thu,  8 Jul 2010 23:34:40 +0000
Message-ID: <1278632080-31949-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 09 01:34:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OX0cJ-0005uF-Lz
	for gcvg-git-2@lo.gmane.org; Fri, 09 Jul 2010 01:34:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755043Ab0GHXev convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 8 Jul 2010 19:34:51 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:64442 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753383Ab0GHXeu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Jul 2010 19:34:50 -0400
Received: by eya25 with SMTP id 25so196866eya.19
        for <git@vger.kernel.org>; Thu, 08 Jul 2010 16:34:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        bh=Uinl0oTREtMZRXM4MbqQ8hOnM+/DDD58MluSHjBANmo=;
        b=jqqJ6tjEQqupFotVrbA7sxr1Yspmahn+eRAitoJnE7mpjEYjrmRMn4xpiDsdwMnqRD
         jXjs1+Yk4XIYr3RjeR0Uqv9ozEBPJUSdN2vnoBcap8Wo3ZFy3uJBcu4TwKX09X1nv+7H
         d1nzs0uK9W6GM9Mr7JQXhByuz9J0CvWRqjtpc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=lPiY4yRQZrQsbuXkQK9DsKTOSzqVQaXizOp5tObJcdvWohbi0F9cGKMhyoMM05sQm1
         4iz7iEJpVl83NkW2uW5d6s8a2l6z4wuNsK6KDoXCG78t7IlFwIik16b1XOHkV/exxE0n
         VtwzZ7s0rb3z3fWYvpPK1Kj0E1PV5FEIL7rBE=
Received: by 10.213.13.71 with SMTP id b7mr7534586eba.3.1278632088200;
        Thu, 08 Jul 2010 16:34:48 -0700 (PDT)
Received: from localhost.localdomain ([188.105.94.3])
        by mx.google.com with ESMTPS id v59sm1887304eeh.10.2010.07.08.16.34.46
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 08 Jul 2010 16:34:46 -0700 (PDT)
X-Mailer: git-send-email 1.7.0.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150620>

TAP harnesses don't need to read test-results/*, since they keep track
of the number of passing/failing tests internally. Skip the generation
of these files when HARNESS_ACTIVE is set.

It's now possible to run the Git test suite without writing anything
to the t/ directory at all if you use a TAP harness and the --root
switch:

    cd t
    sudo mount -t tmpfs none /tmp/memory -o size=3D300m
    prove -j9 ./t[0-9]*.sh :: --root=3D/tmp/memory

The I/O that the ~500 test-results/* files contributed was very
minimal, but I thought this was worth mentioning.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 t/test-lib.sh |   23 +++++++++++++----------
 1 files changed, 13 insertions(+), 10 deletions(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index ac496aa..5f2959f 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -633,16 +633,19 @@ test_create_repo () {
=20
 test_done () {
 	GIT_EXIT_OK=3Dt
-	test_results_dir=3D"$TEST_DIRECTORY/test-results"
-	mkdir -p "$test_results_dir"
-	test_results_path=3D"$test_results_dir/${0%.sh}-$$"
-
-	echo "total $test_count" >> $test_results_path
-	echo "success $test_success" >> $test_results_path
-	echo "fixed $test_fixed" >> $test_results_path
-	echo "broken $test_broken" >> $test_results_path
-	echo "failed $test_failure" >> $test_results_path
-	echo "" >> $test_results_path
+
+	if test -z "$HARNESS_ACTIVE"; then
+		test_results_dir=3D"$TEST_DIRECTORY/test-results"
+		mkdir -p "$test_results_dir"
+		test_results_path=3D"$test_results_dir/${0%.sh}-$$"
+
+		echo "total $test_count" >> $test_results_path
+		echo "success $test_success" >> $test_results_path
+		echo "fixed $test_fixed" >> $test_results_path
+		echo "broken $test_broken" >> $test_results_path
+		echo "failed $test_failure" >> $test_results_path
+		echo "" >> $test_results_path
+	fi
=20
 	if test "$test_fixed" !=3D 0
 	then
--=20
1.7.0.4
