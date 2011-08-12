From: Elijah Newren <newren@gmail.com>
Subject: [PATCHv2 03/56] t6042: Add a pair of cases where undetected renames cause issues
Date: Thu, 11 Aug 2011 23:19:36 -0600
Message-ID: <1313126429-17368-4-git-send-email-newren@gmail.com>
References: <1313126429-17368-1-git-send-email-newren@gmail.com>
Cc: git@vger.kernel.org, Jim Foucar <jgfouca@sandia.gov>,
	Elijah Newren <newren@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Aug 12 07:21:00 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QrkB2-0004ab-0E
	for gcvg-git-2@lo.gmane.org; Fri, 12 Aug 2011 07:21:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752003Ab1HLFUo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Aug 2011 01:20:44 -0400
Received: from mail-iy0-f170.google.com ([209.85.210.170]:62901 "EHLO
	mail-iy0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751929Ab1HLFUj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Aug 2011 01:20:39 -0400
Received: by mail-iy0-f170.google.com with SMTP id 16so834922iye.1
        for <git@vger.kernel.org>; Thu, 11 Aug 2011 22:20:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=y0vRpdnI78LFMnXyjr5CxSeIRsfjH2G8Ez8QEkVJdUM=;
        b=KKmn1TBguoBjPdKUD9QbCWT0MH5bHJbaZYlpTeHBAZWBf83PHz+LgewngG3r2KOK2z
         8NyyCRmegmwdwhLVMHsAYol/Gwa17HE5CAFCATY+ajIaF1RZPrHqnlQIrVaDt5CZZoNU
         TIEwno+H+2S1nfoUYF4dbCfr1nzA34MeByuXU=
Received: by 10.231.6.40 with SMTP id 40mr1046308ibx.80.1313126438743;
        Thu, 11 Aug 2011 22:20:38 -0700 (PDT)
Received: from Miney.hsd1.nm.comcast.net. (c-107-4-21-12.hsd1.nm.comcast.net [107.4.21.12])
        by mx.google.com with ESMTPS id n18sm2032317ibg.52.2011.08.11.22.20.37
        (version=SSLv3 cipher=OTHER);
        Thu, 11 Aug 2011 22:20:38 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.99.ga8ca0
In-Reply-To: <1313126429-17368-1-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179165>

An undetected rename can cause a silent success where a conflict should
have been detected, or can cause an erroneous conflict state where the
merge should have been resolvable.  Add testcases for both.

Signed-off-by: Elijah Newren <newren@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
No changes since v1.

 t/t6042-merge-rename-corner-cases.sh |   61 ++++++++++++++++++++++++++++++++++
 1 files changed, 61 insertions(+), 0 deletions(-)

diff --git a/t/t6042-merge-rename-corner-cases.sh b/t/t6042-merge-rename-corner-cases.sh
index 276d7dd..f338fb4 100755
--- a/t/t6042-merge-rename-corner-cases.sh
+++ b/t/t6042-merge-rename-corner-cases.sh
@@ -72,4 +72,65 @@ test_expect_failure 'rename/modify/add-source conflict resolvable' '
 	test $(git rev-parse C:a) = $(git rev-parse a)
 '
 
+test_expect_success 'setup resolvable conflict missed if rename missed' '
+	git rm -rf . &&
+	git clean -fdqx &&
+	rm -rf .git &&
+	git init &&
+
+	printf "1\n2\n3\n4\n5\n" >a &&
+	echo foo >b &&
+	git add a b &&
+	git commit -m A &&
+	git tag A &&
+
+	git checkout -b B A &&
+	git mv a c &&
+	echo "Completely different content" >a &&
+	git add a &&
+	git commit -m B &&
+
+	git checkout -b C A &&
+	echo 6 >>a &&
+	git add a &&
+	git commit -m C
+'
+
+test_expect_failure 'conflict caused if rename not detected' '
+	git checkout -q C^0 &&
+	git merge -s recursive B^0 &&
+
+	test 3 -eq $(git ls-files -s | wc -l) &&
+	test 0 -eq $(git ls-files -u | wc -l) &&
+	test 0 -eq $(git ls-files -o | wc -l) &&
+
+	test 6 -eq $(wc -l < c) &&
+	test $(git rev-parse HEAD:a) = $(git rev-parse B:a) &&
+	test $(git rev-parse HEAD:b) = $(git rev-parse A:b)
+'
+
+test_expect_success 'setup conflict resolved wrong if rename missed' '
+	git reset --hard &&
+	git clean -f &&
+
+	git checkout -b D A &&
+	echo 7 >>a &&
+	git add a &&
+	git mv a c &&
+	echo "Completely different content" >a &&
+	git add a &&
+	git commit -m D &&
+
+	git checkout -b E A &&
+	git rm a &&
+	echo "Completely different content" >>a &&
+	git add a &&
+	git commit -m E
+'
+
+test_expect_failure 'missed conflict if rename not detected' '
+	git checkout -q E^0 &&
+	test_must_fail git merge -s recursive D^0
+'
+
 test_done
-- 
1.7.6.100.gac5c1
