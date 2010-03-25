From: Chris Packham <judge.packham@gmail.com>
Subject: [PATCHv2 2/2] tests for git alternate command
Date: Wed, 24 Mar 2010 23:07:31 -0700
Message-ID: <1269497251-13103-3-git-send-email-judge.packham@gmail.com>
References: <a038bef51003241335l1623ade4i4a9b7269546739d4@mail.gmail.com>
Cc: jrnieder@gmail.com, gitster@pobox.com, bebarino@gmail.com,
	Chris Packham <judge.packham@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 25 07:10:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NugGu-0005DH-L8
	for gcvg-git-2@lo.gmane.org; Thu, 25 Mar 2010 07:10:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752570Ab0CYGKI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Mar 2010 02:10:08 -0400
Received: from mail-pz0-f194.google.com ([209.85.222.194]:58135 "EHLO
	mail-pz0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752107Ab0CYGKB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Mar 2010 02:10:01 -0400
Received: by mail-pz0-f194.google.com with SMTP id 32so1476442pzk.4
        for <git@vger.kernel.org>; Wed, 24 Mar 2010 23:10:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=N9BBzsmp+c+0yRdZtRhzh3OK3SdNxEuDIRq2+FXkfvU=;
        b=V/4nvL1E0wwonyukAVTpt+mKLGQzdE2IHGoo8QaZF1arFkudWR0po5d++HVjI8kHii
         JGzcYk4hCJT1WA22l1sKenWxDsDxpO2CNqOgWpcpuy20nHrywBafEwcaRgB3hnRkD3vl
         zd7L25QouSgH3to446YJJB+5EKm6EAfQH1Lc8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=NizTNJPMDtaAzNIfbQ6WVjDn1hWzcRWNCAPCcLFKWrTARooceu/TbLZi0Ljqr2wene
         66LROo8LPZM8DKy9NF477G5b+WVz1/NBvQrWnjJ1FbbC5LIVS1X6+8u1KII517R0psIw
         +xKcOVsQ5tJtF251w6O/xWkFYyfrsfi3kiA3o=
Received: by 10.142.1.19 with SMTP id 19mr4130286wfa.111.1269497401035;
        Wed, 24 Mar 2010 23:10:01 -0700 (PDT)
Received: from localhost.localdomain (adsl-71-131-190-40.dsl.sntc01.pacbell.net [71.131.190.40])
        by mx.google.com with ESMTPS id 20sm650523pzk.7.2010.03.24.23.09.59
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 24 Mar 2010 23:10:00 -0700 (PDT)
X-Mailer: git-send-email 1.7.0.3
In-Reply-To: <a038bef51003241335l1623ade4i4a9b7269546739d4@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143165>

Signed-off-by: Chris Packham <judge.packham@gmail.com>
---
I wasn't sure about the test numbering so I just grabbed the highest one. Still
need to add tests for the deletion use case.

 t/t9800-git-alternate.sh |   95 ++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 95 insertions(+), 0 deletions(-)
 create mode 100644 t/t9800-git-alternate.sh

diff --git a/t/t9800-git-alternate.sh b/t/t9800-git-alternate.sh
new file mode 100644
index 0000000..e95f5bd
--- /dev/null
+++ b/t/t9800-git-alternate.sh
@@ -0,0 +1,95 @@
+#!/bin/sh
+
+test_description='Test of git alternate command'
+
+. ./test-lib.sh
+
+test_expect_success \
+	'Setup for rest of the test' '
+	mkdir -p base &&
+	cd base &&
+	git init &&
+	echo test > a.txt &&
+	echo test > b.txt &&
+	echo test > c.txt &&
+	git add *.txt &&
+	git commit -a -m "Initial Commit" &&
+	cd .. &&
+	git clone base A &&
+	git clone A B &&
+	git clone A C &&
+	git clone A D
+'
+
+test_expect_success \
+	'Add alternate after clone' '
+	(cd B &&
+	git alternate -a ../base/.git/objects
+	)
+'
+
+test_expect_success \
+	'add same alternate fails adding existing abs path' '
+	(cd B &&
+	test_must_fail git alternate -a $PWD/base/.git/objects
+	)
+'
+
+test_expect_success \
+ 	'add same alternate fails adding existing relative path' '
+ 	(cd B &&
+ 	test_must_fail git alternate -a ../base/.git/objects
+ 	)
+'
+
+test_expect_success \
+	'Add multiple alternates' '
+	(cd C &&
+	git alternate -a ../base/.git/objects &&
+	git alternate -a ../B/.git/objects
+	)
+'
+
+test_expect_success \
+	'Add recursive alternate' '
+	(cd D &&
+	git alternate -a ../C/.git/objects
+	)
+'
+
+test_expect_success \
+	'test git alternate display' '
+	testbase=$PWD
+	(cd B &&
+	git alternate >actual &&
+	{
+		echo "Object store $testbase/base/.git/objects"
+		echo "    referenced via $testbase/B/.git"
+	} >expect &&
+	test_cmp expect actual
+	)
+'
+
+test_expect_success \
+	'test git alternate recursive display' '
+	testbase=$PWD
+	(cd D &&
+
+	git alternate -r >actual &&
+
+	{
+		echo "Object store $testbase/C/.git/objects"
+		echo "    referenced via $testbase/D/.git"
+		echo "Object store $testbase/base/.git/objects"
+		echo "    referenced via $testbase/C/.git"
+		echo "Object store $testbase/B/.git/objects"
+		echo "    referenced via $testbase/C/.git"
+		echo "Object store $testbase/base/.git/objects"
+		echo "    referenced via $testbase/B/.git"
+	} >expect &&
+
+	test_cmp expect actual
+	)
+'
+
+#rm -rf A B C D base
\ No newline at end of file
-- 
1.7.0.3
