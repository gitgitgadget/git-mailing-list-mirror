From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH v2] test-lib: Don't write test-results when HARNESS_ACTIVE
Date: Wed, 11 Aug 2010 19:37:31 +0000
Message-ID: <1281555451-6847-1-git-send-email-avarab@gmail.com>
References: <1278632080-31949-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 11 21:38:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OjH83-0007Yu-II
	for gcvg-git-2@lo.gmane.org; Wed, 11 Aug 2010 21:38:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756337Ab0HKTiT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 11 Aug 2010 15:38:19 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:57465 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755845Ab0HKTiS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Aug 2010 15:38:18 -0400
Received: by wyb32 with SMTP id 32so496100wyb.19
        for <git@vger.kernel.org>; Wed, 11 Aug 2010 12:38:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=00ioCkES8bwl85eCBSs4AslRk3XIAUvBu3WgOfywoXQ=;
        b=eJn5XyOLYu163s0lvNxed1nveeOAC0IixQfTwNHcHFxPS7pYJkCLX/Rg8xTih8wtV4
         WjMzlyxdHEyigSLC5umt58jxmjS5BFbFbrauIRWrZoqe8qUBrx5INdjaXURuWCUQAFQz
         ESKEK6aD7q/XgjEtgDKgtcxDH6FyMs9ESEbaE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=hE76nyRG3bD3FKBhtUroWkOZubWFMt+KaBTcn6FKKL3vVyxD8foyj6aekmQN5iZk+v
         wqGlmF2FeRqBC31++NFuhCGVi18XnLWbcvjdX1WbTWRsd6lBubpAKTOyQSpW417lZTZX
         jBcLqnz5n5rtkSOJvBz+BRYLCilTflcpzYm1w=
Received: by 10.216.53.74 with SMTP id f52mr16967201wec.112.1281555457061;
        Wed, 11 Aug 2010 12:37:37 -0700 (PDT)
Received: from v.nix.is (v.nix.is [109.74.193.250])
        by mx.google.com with ESMTPS id u32sm341626weq.11.2010.08.11.12.37.36
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 11 Aug 2010 12:37:36 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.1.295.gdf931
In-Reply-To: <1278632080-31949-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153293>

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

This one fell through the cracks, and conflicted with Thomas's later
"Only run aggregate-results over actual counts" patch.

Please apply it, it keeps conflicting with local changes I have to the
test-lib.sh

 t/test-lib.sh |   23 +++++++++++++----------
 1 files changed, 13 insertions(+), 10 deletions(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index 4e73fff..956f1a5 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -646,16 +646,19 @@ test_create_repo () {
=20
 test_done () {
 	GIT_EXIT_OK=3Dt
-	test_results_dir=3D"$TEST_DIRECTORY/test-results"
-	mkdir -p "$test_results_dir"
-	test_results_path=3D"$test_results_dir/${0%.sh}-$$.counts"
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
+		test_results_path=3D"$test_results_dir/${0%.sh}-$$.counts"
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
1.7.2.1.295.gdf931
