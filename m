From: =?UTF-8?B?TWljaGHFgg==?= Kiedrowicz <michal.kiedrowicz@gmail.com>
Subject: [PATCH] tests: make test-apply-criss-cross-rename more robust
Date: Sat, 18 Apr 2009 23:03:57 +0200
Message-ID: <20090418230357.47b7c6c2@gmail.com>
References: <1239478260-7420-1-git-send-email-michal.kiedrowicz@gmail.com>
	<7v4owsfktw.fsf@gitster.siamese.dyndns.org>
	<20090413230351.7cbb01f5@gmail.com>
	<7v1vrwdyxx.fsf@gitster.siamese.dyndns.org>
	<20090417192324.3a888abf@gmail.com>
	<7vskk6y2tl.fsf@gitster.siamese.dyndns.org>
	<20090418225847.54862bdf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 18 23:06:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LvHjM-0008E2-PI
	for gcvg-git-2@gmane.org; Sat, 18 Apr 2009 23:05:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754709AbZDRVEI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Apr 2009 17:04:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754034AbZDRVEF
	(ORCPT <rfc822;git-outgoing>); Sat, 18 Apr 2009 17:04:05 -0400
Received: from mail-fx0-f158.google.com ([209.85.220.158]:59652 "EHLO
	mail-fx0-f158.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752562AbZDRVEE (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Apr 2009 17:04:04 -0400
Received: by fxm2 with SMTP id 2so1374538fxm.37
        for <git@vger.kernel.org>; Sat, 18 Apr 2009 14:04:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:in-reply-to:references:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=pgYyYQ57BCE4O/1Kspo89yxYDF/ClEiYsY+mNaWZkdA=;
        b=purD+VqH1QI9bceXt4pmWe4CI5fz7O1DAVxGB6GSNCgTG3RD3mzRdZBnmu/HnfAmFR
         Q7ynS/85ZiQAZjkJbvHq1Fcu8ZJ5WDJ8tAPbZvZqyyRYpyBExrG2Mxck5s9i+V9R5X88
         LFRrH8PXXWvASGuB8t4zk4U94D26sQYs+8BaE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer
         :mime-version:content-type:content-transfer-encoding;
        b=n0p11mIaiKLlmymDILqllSG8XVqw5ATO+jJN7qv2Xzeo0QR3N8bBxcBHcbW42YVqR0
         /pudReV3TH4biCOYeyLn6PIr90wpwXVtYXz1PIwVwxUj/3RlxrZpMeV+wG/pBaoiMqof
         0Vdjzy+/NAwRX/Zhqz+BIu9LEeDv/d5JImfdE=
Received: by 10.204.124.7 with SMTP id s7mr3710249bkr.189.1240088640768;
        Sat, 18 Apr 2009 14:04:00 -0700 (PDT)
Received: from localhost (77-253-158-167.adsl.inetia.pl [77.253.158.167])
        by mx.google.com with ESMTPS id z10sm6605990fka.38.2009.04.18.14.04.00
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 18 Apr 2009 14:04:00 -0700 (PDT)
In-Reply-To: <20090418225847.54862bdf@gmail.com>
X-Mailer: Claws Mail 3.7.0 (GTK+ 2.14.7; x86_64-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116868>

I realized that this test does check if git-apply succeeds, but doesn't
tell if it applies patches correctly. So I added test_cmp to check it.

I also added a test which checks swapping three files.
---
 t/t4130-apply-criss-cross-rename.sh |   34 +++++++++++++++++++++++++++++++---
 1 files changed, 31 insertions(+), 3 deletions(-)

diff --git a/t/t4130-apply-criss-cross-rename.sh b/t/t4130-apply-criss-cross-rename.sh
index 8623dbe..7cfa2d6 100755
--- a/t/t4130-apply-criss-cross-rename.sh
+++ b/t/t4130-apply-criss-cross-rename.sh
@@ -15,14 +15,17 @@ create_file() {
 test_expect_success 'setup' '
 	create_file file1 "File1 contents" &&
 	create_file file2 "File2 contents" &&
-	git add file1 file2 &&
+	create_file file3 "File3 contents" &&
+	git add file1 file2 file3 &&
 	git commit -m 1
 '
 
 test_expect_success 'criss-cross rename' '
 	mv file1 tmp &&
 	mv file2 file1 &&
-	mv tmp file2
+	mv tmp file2 &&
+	cp file1 file1-swapped &&
+	cp file2 file2-swapped
 '
 
 test_expect_success 'diff -M -B' '
@@ -32,7 +35,32 @@ test_expect_success 'diff -M -B' '
 '
 
 test_expect_success 'apply' '
-	git apply diff
+	git apply diff &&
+	test_cmp file1 file1-swapped &&
+	test_cmp file2 file2-swapped
+'
+
+test_expect_success 'criss-cross rename' '
+	git reset --hard &&
+	mv file1 tmp &&
+	mv file2 file1 &&
+	mv file3 file2
+	mv tmp file3 &&
+	cp file1 file1-swapped &&
+	cp file2 file2-swapped &&
+	cp file3 file3-swapped
+'
+
+test_expect_success 'diff -M -B' '
+	git diff -M -B > diff &&
+	git reset --hard
+'
+
+test_expect_success 'apply' '
+	git apply diff &&
+	test_cmp file1 file1-swapped &&
+	test_cmp file2 file2-swapped &&
+	test_cmp file3 file3-swapped
 '
 
 test_done
-- 
1.6.0.6
