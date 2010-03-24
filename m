From: Stephen Boyd <bebarino@gmail.com>
Subject: [PATCH 3/7] t6200: test fmt-merge-msg more
Date: Wed, 24 Mar 2010 00:16:00 -0700
Message-ID: <1269414964-9518-4-git-send-email-bebarino@gmail.com>
References: <1269414964-9518-1-git-send-email-bebarino@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 24 08:17:10 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NuKpw-0006wZ-Ah
	for gcvg-git-2@lo.gmane.org; Wed, 24 Mar 2010 08:17:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754904Ab0CXHQ2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Mar 2010 03:16:28 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:35068 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754861Ab0CXHQP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Mar 2010 03:16:15 -0400
Received: by gyg8 with SMTP id 8so3581887gyg.19
        for <git@vger.kernel.org>; Wed, 24 Mar 2010 00:16:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=it+p8d5vK7PAbjbGgNz45K4pWrlqsXosBGIGjiQKw4o=;
        b=R+KdPB0Bi4PvHQAnlckS1XNHFVtJ3HVWAfzmXW5hn1cBMmKqEA4c7q6wsu8v0Znvtf
         Bp+o49wdkTzk7V5UvVMKKuRL67zLG4ksX/puavCI+feFdxCGO3Uzv68jETsdFHMAekvO
         89bzQ1wC94hme7nBuY81+DJr3nbqn6Yfs+vOQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=JmsSPq+u19Zm7GeyRGG9jZD6vQDkoFwtYK4PAD+l5clCKcTSBzJqi66VAanX5Uvd1z
         /DvR/k/VNYjm2YCuOUokhFlKoFd7JA46tUEj6P54E3ppS54vvUCSvqZR28c2Oee3Y96z
         Wl0RpHXgONXq+gxTbICgzH0dHwvCi8J0oMZsw=
Received: by 10.90.38.27 with SMTP id l27mr1691617agl.6.1269414975070;
        Wed, 24 Mar 2010 00:16:15 -0700 (PDT)
Received: from localhost (user-0c9haca.cable.mindspring.com [24.152.169.138])
        by mx.google.com with ESMTPS id 23sm6842259iwn.2.2010.03.24.00.16.14
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 24 Mar 2010 00:16:14 -0700 (PDT)
X-Mailer: git-send-email 1.7.0.3.254.g4503b
In-Reply-To: <1269414964-9518-1-git-send-email-bebarino@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143071>

Add some more tests so we don't break behavior upon modernizing
fmt-merge-msg.

Signed-off-by: Stephen Boyd <bebarino@gmail.com>
---
 t/t6200-fmt-merge-msg.sh |  115 ++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 115 insertions(+), 0 deletions(-)

diff --git a/t/t6200-fmt-merge-msg.sh b/t/t6200-fmt-merge-msg.sh
index b24c5bf..42f8ece 100755
--- a/t/t6200-fmt-merge-msg.sh
+++ b/t/t6200-fmt-merge-msg.sh
@@ -62,6 +62,14 @@ test_expect_success setup '
 	test_tick &&
 	git commit -a -m "Right #5" &&
 
+	git checkout -b long &&
+	i=0 &&
+	while test $i -lt 30
+	do
+		test_commit $i one &&
+		i=$(($i+1))
+	done &&
+
 	git show-branch
 '
 
@@ -253,4 +261,111 @@ test_expect_success 'merge-msg with nothing to merge' '
 	test_cmp /dev/null actual
 '
 
+cat >expected <<\EOF
+Merge tag 'tag-r3'
+
+* tag 'tag-r3':
+  Right #3
+  Common #2
+  Common #1
+EOF
+
+test_expect_success 'merge-msg tag' '
+
+	git config --unset-all merge.log
+	git config --unset-all merge.summary
+	git config merge.summary yes &&
+
+	git checkout master &&
+	test_tick &&
+	git fetch . tag tag-r3 &&
+
+	git fmt-merge-msg <.git/FETCH_HEAD >actual &&
+	test_cmp expected actual
+'
+
+cat >expected <<\EOF
+Merge tags 'tag-r3' and 'tag-l5'
+
+* tag 'tag-r3':
+  Right #3
+  Common #2
+  Common #1
+
+* tag 'tag-l5':
+  Left #5
+  Left #4
+  Left #3
+  Common #2
+  Common #1
+EOF
+
+test_expect_success 'merge-msg two tags' '
+
+	git config --unset-all merge.log
+	git config --unset-all merge.summary
+	git config merge.summary yes &&
+
+	git checkout master &&
+	test_tick &&
+	git fetch . tag tag-r3 tag tag-l5 &&
+
+	git fmt-merge-msg <.git/FETCH_HEAD >actual &&
+	test_cmp expected actual
+'
+
+cat >expected <<\EOF
+Merge branch 'left', tag 'tag-r3'
+
+* tag 'tag-r3':
+  Right #3
+  Common #2
+  Common #1
+
+* left:
+  Left #5
+  Left #4
+  Left #3
+  Common #2
+  Common #1
+EOF
+
+test_expect_success 'merge-msg tag and branch' '
+
+	git config --unset-all merge.log
+	git config --unset-all merge.summary
+	git config merge.summary yes &&
+
+	git checkout master &&
+	test_tick &&
+	git fetch . tag tag-r3 left &&
+
+	git fmt-merge-msg <.git/FETCH_HEAD >actual &&
+	test_cmp expected actual
+'
+
+cat >expected <<\EOF
+Merge branch 'long'
+
+* long: (35 commits)
+EOF
+
+test_expect_success 'merge-msg lots of commits' '
+
+	git checkout master &&
+	test_tick &&
+	git fetch . long &&
+
+	i=29 &&
+	while test $i -gt 9
+	do
+		echo "  $i" &&
+		i=$(($i-1))
+	done >>expected &&
+	echo "  ..." >>expected
+
+	git fmt-merge-msg <.git/FETCH_HEAD >actual &&
+	test_cmp expected actual
+'
+
 test_done
-- 
1.7.0.3.254.g4503b
