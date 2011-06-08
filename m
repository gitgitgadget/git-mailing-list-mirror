From: Elijah Newren <newren@gmail.com>
Subject: [PATCH 03/48] t6039: Add a pair of cases where undetected renames cause issues
Date: Wed,  8 Jun 2011 01:30:33 -0600
Message-ID: <1307518278-23814-4-git-send-email-newren@gmail.com>
References: <1307518278-23814-1-git-send-email-newren@gmail.com>
Cc: jgfouca@sandia.gov, Elijah Newren <newren@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 08 09:29:14 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QUDCP-0005Ph-FJ
	for gcvg-git-2@lo.gmane.org; Wed, 08 Jun 2011 09:29:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754532Ab1FHH26 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jun 2011 03:28:58 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:43667 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754471Ab1FHH24 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jun 2011 03:28:56 -0400
Received: by pzk9 with SMTP id 9so118978pzk.19
        for <git@vger.kernel.org>; Wed, 08 Jun 2011 00:28:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=CYXkDs2GmKlKSUFNKXSYiJqTPu7XGkOD3lHpDnpt9ro=;
        b=X8or+TH4BrgrfgfUGwEOqBQrsi/a8fbEogFmUSvwt1X14i2qiV9FUa6Y+bCQP+pgM+
         dJfH6Rld1FvwwZuKtRhzfiHRQXZWMd88V1YbFWxTjU5zcrWLHSFZeJn0Z1LFl6tdgR4K
         Vt8e96Wn9karp/4QwySBAYaVPRbPdC/T536W4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=krCnPm+ntSOru3l95/86WH4oPazdVGCom0wurS5VEtyTuYk9ghiIVsbZ67iwEqNy10
         PWCl6yOY43nJpHUTx0CPM0p95ALvEdQSRgNQft8xeAv73Pr9Iz0pCEEY8/yZ0fztX5je
         lxQz9SV83j5u2mVB2nrV8A/xUSeeI5lCnS8hE=
Received: by 10.68.37.65 with SMTP id w1mr564575pbj.341.1307518135875;
        Wed, 08 Jun 2011 00:28:55 -0700 (PDT)
Received: from localhost.localdomain ([216.222.84.34])
        by mx.google.com with ESMTPS id k4sm296286pbl.59.2011.06.08.00.28.53
        (version=SSLv3 cipher=OTHER);
        Wed, 08 Jun 2011 00:28:55 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.rc0.62.g2d69f
In-Reply-To: <1307518278-23814-1-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175299>

An undetected rename can cause a silent success where a conflict should
have been detected, or can cause an erroneous conflict state where the
merge should have been resolvable.  Add testcases for both.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 t/t6039-merge-rename-corner-cases.sh |   61 ++++++++++++++++++++++++++++++++++
 1 files changed, 61 insertions(+), 0 deletions(-)

diff --git a/t/t6039-merge-rename-corner-cases.sh b/t/t6039-merge-rename-corner-cases.sh
index 276d7dd..f338fb4 100755
--- a/t/t6039-merge-rename-corner-cases.sh
+++ b/t/t6039-merge-rename-corner-cases.sh
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
1.7.6.rc0.62.g2d69f
