From: Haitao Li <lihaitao@gmail.com>
Subject: [PATCH] date.c: Parse timezone with colon as separator
Date: Tue,  6 Sep 2011 22:56:36 +0800
Message-ID: <1315320996-1997-1-git-send-email-lihaitao@gmail.com>
Cc: Haitao Li <lihaitao@gmail.com>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Tue Sep 06 17:00:04 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R0x86-0007wH-KH
	for gcvg-git-2@lo.gmane.org; Tue, 06 Sep 2011 17:00:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754198Ab1IFO76 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Sep 2011 10:59:58 -0400
Received: from mail-pz0-f42.google.com ([209.85.210.42]:64313 "EHLO
	mail-pz0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754280Ab1IFO74 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Sep 2011 10:59:56 -0400
Received: by pzk37 with SMTP id 37so10395582pzk.1
        for <git@vger.kernel.org>; Tue, 06 Sep 2011 07:59:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=B9QhAi5E4vuRA/1zoNyO11ucfmJCv+IcCVkr0grLbhc=;
        b=Lk6PoM1RCleAlIRlssi4u22vQ8BtGLuzhmdw4UMfWAnEHgvXsCwIR91tDYONAJtx1l
         aIA/haxapJX+dHMfXJIK04t52wbtT5PzgH4d5aqvkn247p2C/GTp/62XK5iJ3zJo5FbA
         grbJfOAi/SpjvjoT/BjntQ75Wbv/F+S5WMY7g=
Received: by 10.68.6.36 with SMTP id x4mr9881593pbx.219.1315321196406;
        Tue, 06 Sep 2011 07:59:56 -0700 (PDT)
Received: from localhost.localdomain ([114.62.57.190])
        by mx.google.com with ESMTPS id jl4sm736481pbc.10.2011.09.06.07.59.46
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 06 Sep 2011 07:59:51 -0700 (PDT)
X-Mailer: git-send-email 1.7.5.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180805>

Timezone designators including additional separator (`:`) are ignored.
Actually zone designators in below formats are all valid according to
ISO8601:2004, section 4.3.2:
    [+-]hh, [+-]hhmm, [+-]hh:mm

Steps to reproduce the issue this patch fixes:
    $ mkdir /tmp/test
    $ cd /tmp/test
    $ git init
    $ echo 'timezone' > file.txt
    $ git add .
    $ git update-index
    $ git write-tree
    3e168d57e1c32a4598af134430384f0587581503

    # Commit the tree returned above. Give a date with colon separated
    # timezone
    $ echo "Test commit" | \
      TZ=UTC GIT_AUTHOR_DATE='2011-09-03T12:34:56+08:00' \
      git commit-tree 3e168d57e1c32a4598af134430384f0587581503 | \
      xargs git show  | grep Date
    Date:   Sat Sep 3 12:34:56 2011 +0000

while the expected result is:
    Date:   Sat Sep 3 12:34:56 2011 +0800
                                      ^---

This patch teaches git recognizing zone designators with hours and
minutes separated by colon, or minutes are empty.

Signed-off-by: Haitao Li <lihaitao@gmail.com>
---
 date.c |   14 ++++++++++----
 1 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/date.c b/date.c
index 896fbb4..8a94944 100644
--- a/date.c
+++ b/date.c
@@ -556,15 +556,21 @@ static int match_tz(const char *date, int *offp)
 	int min, hour;
 	int n = end - date - 1;
 
-	min = offset % 100;
-	hour = offset / 100;
+	if (n == 2 && *end == ':') {
+		hour = offset;
+		offset = strtoul(date+4, &end, 10);
+		min = offset % 100;
+	} else {
+		hour = offset / 100;
+		min = offset % 100;
+	}
 
 	/*
-	 * Don't accept any random crap.. At least 3 digits, and
+	 * Don't accept any random crap.. At least 2 digits, and
 	 * a valid minute. We might want to check that the minutes
 	 * are divisible by 30 or something too.
 	 */
-	if (min < 60 && n > 2) {
+	if (min < 60 && n > 1) {
 		offset = hour*60+min;
 		if (*date == '-')
 			offset = -offset;
-- 
1.7.5.4
