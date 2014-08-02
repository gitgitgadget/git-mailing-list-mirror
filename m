From: Lukas Fleischer <git@cryptocrack.de>
Subject: [PATCH 2/2] bundle: Fix exclusion of annotated tags
Date: Sat,  2 Aug 2014 10:39:07 +0200
Message-ID: <1406968747-16100-2-git-send-email-git@cryptocrack.de>
References: <1406968747-16100-1-git-send-email-git@cryptocrack.de>
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 02 10:39:34 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XDUqi-0002ks-6I
	for gcvg-git-2@plane.gmane.org; Sat, 02 Aug 2014 10:39:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751844AbaHBIjT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 Aug 2014 04:39:19 -0400
Received: from mout.gmx.net ([212.227.15.15]:55251 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751099AbaHBIjM (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Aug 2014 04:39:12 -0400
Received: from localhost ([87.180.61.8]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0Mdr7l-1WoZTE1RSn-00PZqq; Sat, 02 Aug 2014 10:39:09
 +0200
X-Mailer: git-send-email 2.0.3
In-Reply-To: <1406968747-16100-1-git-send-email-git@cryptocrack.de>
X-Provags-ID: V03:K0:sCUFW/GpHebnvLVh+IQ4jx+UuDfsjaIL1KN9Wv5B+MgECv5eTVY
 nSUTh4Ft2myknvacHVc+ZoGKQY+cjy+7lTO390To5/E2p0xiBl765EAdnb4+h+Uuh3nf9sx
 7wZz8KLmQFpZkVeCNmRSKkAWuisq3Bdooi2YYwDu7eMSDVQ2Jv0vndOERKJN123YDrG6k2v
 sc3GNlLfj2o7y8SUZIDVQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254690>

In commit c9a42c4 (bundle: allow rev-list options to exclude annotated
tags, 2009-01-02), support for excluding annotated tags outside the
specified date range was added. However, the wrong order of parameters
was chosen when calling memchr(). Fix this by swapping the character to
search for with the maximum length parameter.

Signed-off-by: Lukas Fleischer <git@cryptocrack.de>
---
 bundle.c          | 4 ++--
 t/t5704-bundle.sh | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/bundle.c b/bundle.c
index 71a21a6..b708906 100644
--- a/bundle.c
+++ b/bundle.c
@@ -221,8 +221,8 @@ static int is_tag_in_date_range(struct object *tag, struct rev_info *revs)
 	line = memmem(buf, size, "\ntagger ", 8);
 	if (!line++)
 		return 1;
-	lineend = memchr(line, buf + size - line, '\n');
-	line = memchr(line, lineend ? lineend - line : buf + size - line, '>');
+	lineend = memchr(line, '\n', buf + size - line);
+	line = memchr(line, '>', lineend ? lineend - line : buf + size - line);
 	if (!line++)
 		return 1;
 	date = strtoul(line, NULL, 10);
diff --git a/t/t5704-bundle.sh b/t/t5704-bundle.sh
index 2f063ea..8a4d299 100755
--- a/t/t5704-bundle.sh
+++ b/t/t5704-bundle.sh
@@ -14,7 +14,7 @@ test_expect_success 'setup' '
 	git tag -d third
 '
 
-test_expect_failure 'annotated tags can be excluded by rev-list options' '
+test_expect_success 'annotated tags can be excluded by rev-list options' '
 	git bundle create bundle --all --since=7.Apr.2005.15:14:00.-0700 &&
 	git ls-remote bundle > output &&
 	grep tag output &&
-- 
2.0.3
