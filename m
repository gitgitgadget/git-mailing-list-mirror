From: Lukas Fleischer <git@cryptocrack.de>
Subject: [PATCH 2/2] bundle: Fix exclusion of annotated tags
Date: Mon,  4 Aug 2014 22:57:03 +0200
Message-ID: <1407185823-9950-2-git-send-email-git@cryptocrack.de>
References: <1406968747-16100-1-git-send-email-git@cryptocrack.de>
 <1407185823-9950-1-git-send-email-git@cryptocrack.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 04 22:57:13 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XEPJg-0007zu-Pg
	for gcvg-git-2@plane.gmane.org; Mon, 04 Aug 2014 22:57:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752557AbaHDU5I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Aug 2014 16:57:08 -0400
Received: from mout.gmx.net ([212.227.15.18]:63944 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751742AbaHDU5H (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Aug 2014 16:57:07 -0400
Received: from localhost ([87.180.47.94]) by mail.gmx.com (mrgmx002) with
 ESMTPSA (Nemesis) id 0Mgt3g-1WsK5x1aaG-00M505 for <git@vger.kernel.org>; Mon,
 04 Aug 2014 22:57:05 +0200
X-Mailer: git-send-email 2.0.4
In-Reply-To: <1407185823-9950-1-git-send-email-git@cryptocrack.de>
X-Provags-ID: V03:K0:NG0ZKz4/XnHmUatdH1/ybZUBUs9wMs5rA80vVF9WqIv0U7ZIQgw
 zW+ut1rmkWpx3Wm/tF7ePLvNJqJ1efEmpf8L3+GhRKjOBNuASEeaptwgNfwLISuswSncy7l
 Lp9RgPf3onEaIufa/fQCWCNhSFFC7qLxNPl5lpAFfHDxOmFRZbycEDPWMaHqYCcXzvpSBcK
 LDQ1ZvDLBkEH8Ar2QcGSQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254782>

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
index 2d53388..a828c71 100755
--- a/t/t5704-bundle.sh
+++ b/t/t5704-bundle.sh
@@ -14,7 +14,7 @@ test_expect_success 'setup' '
 	git tag -d third
 '
 
-test_expect_failure 'tags can be excluded by rev-list options' '
+test_expect_success 'tags can be excluded by rev-list options' '
 	git bundle create bundle --all --since=7.Apr.2005.15:14:00.-0700 &&
 	git ls-remote bundle > output &&
 	grep tag output &&
-- 
2.0.4
