From: Elijah Newren <newren@gmail.com>
Subject: [PATCH 15/48] t6022: Add testcase for merging a renamed file with a simple change
Date: Wed,  8 Jun 2011 01:30:45 -0600
Message-ID: <1307518278-23814-16-git-send-email-newren@gmail.com>
References: <1307518278-23814-1-git-send-email-newren@gmail.com>
Cc: jgfouca@sandia.gov, Elijah Newren <newren@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 08 09:30:05 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QUDDI-0005pC-4i
	for gcvg-git-2@lo.gmane.org; Wed, 08 Jun 2011 09:30:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754877Ab1FHH32 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jun 2011 03:29:28 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:49887 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754782Ab1FHH3Z (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jun 2011 03:29:25 -0400
Received: by mail-pv0-f174.google.com with SMTP id 12so118724pvg.19
        for <git@vger.kernel.org>; Wed, 08 Jun 2011 00:29:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=plwJDNLzNHB3vV5FVu+pOZG+3sYA62G9SMrUK+mHQhw=;
        b=i7He2D7N81G94mjvogKpYAnxsHj7kx/Fb9W9pUD/39sEn0Cym67pN8n7ulo06WIDVI
         YNW5EU9pLUY1eyRbjoKxmxDTz0C7ApCW941g9dlWFeqSn8NDRHHJpGzt3xrg0otq2Fmc
         8bRDeBehIjql4ovmiBopHAEAxmLuRShF8KXUg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=WtGzEl9LdxeTYIQTplyZBK+IXYdGJpvazlI2hQ6/NX3DI16v2WC55QrDQEJTr7W3JE
         HWEonwOCvqoIEPV+/Z+2ENGOAkBBoacy6SOEWbImdzhjGNTRwyQ6iEDd2wcFcUEdSFs2
         CIXyf+/8fPYnfoTJamTcdwLDqg3hzEIiW8IrY=
Received: by 10.142.196.14 with SMTP id t14mr214630wff.89.1307518165114;
        Wed, 08 Jun 2011 00:29:25 -0700 (PDT)
Received: from localhost.localdomain ([216.222.84.34])
        by mx.google.com with ESMTPS id k4sm296286pbl.59.2011.06.08.00.29.23
        (version=SSLv3 cipher=OTHER);
        Wed, 08 Jun 2011 00:29:24 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.rc0.62.g2d69f
In-Reply-To: <1307518278-23814-1-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175300>

This is a testcase that was broken by b2c8c0a (merge-recursive: When we
detect we can skip an update, actually skip it 2011-02-28) and fixed by
6db4105 (Revert "Merge branch 'en/merge-recursive'" 2011-05-19).  Include
this testcase to ensure we don't regress it again.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 t/t6022-merge-rename.sh |   22 ++++++++++++++++++++++
 1 files changed, 22 insertions(+), 0 deletions(-)

diff --git a/t/t6022-merge-rename.sh b/t/t6022-merge-rename.sh
index 11c5c60..52a8f0b 100755
--- a/t/t6022-merge-rename.sh
+++ b/t/t6022-merge-rename.sh
@@ -673,4 +673,26 @@ test_expect_failure 'avoid unnecessary update, with D/F conflict' '
 	test_cmp expect actual # "df" should have stayed intact
 '
 
+test_expect_success 'setup merge of rename + small change' '
+	git reset --hard &&
+	git checkout --orphan rename-plus-small-change &&
+	git rm -rf . &&
+
+	echo ORIGINAL >file &&
+	git add file &&
+
+	test_tick &&
+	git commit -m Initial &&
+	git checkout -b rename_branch &&
+	git mv file renamed_file &&
+	git commit -m Rename &&
+	git checkout rename-plus-small-change &&
+	echo NEW-VERSION >file &&
+	git commit -a -m Reformat
+'
+
+test_expect_success 'merge rename + small change' '
+	git merge rename_branch
+'
+
 test_done
-- 
1.7.6.rc0.62.g2d69f
