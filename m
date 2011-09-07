From: Haitao Li <lihaitao@gmail.com>
Subject: [PATCH v2] date.c: Support iso8601 timezone formats
Date: Wed,  7 Sep 2011 13:46:47 +0800
Message-ID: <1315374407-30828-1-git-send-email-lihaitao@gmail.com>
References: <1315320996-1997-1-git-send-email-lihaitao@gmail.com>
Cc: Haitao Li <lihaitao@gmail.com>
To: git@vger.kernel.org, Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Sep 07 08:10:52 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R1BLX-0002Z1-TQ
	for gcvg-git-2@lo.gmane.org; Wed, 07 Sep 2011 08:10:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755516Ab1IGGKr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Sep 2011 02:10:47 -0400
Received: from mail-pz0-f42.google.com ([209.85.210.42]:39600 "EHLO
	mail-pz0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755507Ab1IGGKp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Sep 2011 02:10:45 -0400
Received: by pzk37 with SMTP id 37so11378090pzk.1
        for <git@vger.kernel.org>; Tue, 06 Sep 2011 23:10:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=kWBDg7DkbZSSe7h56D7fDx4b5A+pToCYudYYWLmaXg4=;
        b=XYaMGZVzOI0rYjoANlDpDYtuAQ3X0OS1kq4s/IT6zdFvQCJZAr5Vg2tZIR1ptDedTV
         Zb1fg7fnmdNIoFQC3T5sOf6ycII+NwNHZMp3fLPOIdVFsaUXjF5T1GJxVDtJ8/YrRtOd
         8fdaKPJoG6vuM/AoVHSD9wgNuv/1RuoGzuVQ4=
Received: by 10.68.46.98 with SMTP id u2mr381262pbm.31.1315374419508;
        Tue, 06 Sep 2011 22:46:59 -0700 (PDT)
Received: from localhost.localdomain (cursa.dreamhost.com. [173.236.210.234])
        by mx.google.com with ESMTPS id u2sm2709523pbq.9.2011.09.06.22.46.57
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 06 Sep 2011 22:46:58 -0700 (PDT)
X-Mailer: git-send-email 1.7.5.4
In-Reply-To: <1315320996-1997-1-git-send-email-lihaitao@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180853>

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
 date.c          |   32 ++++++++++++++++++++++++++------
 t/t0006-date.sh |    5 +++++
 2 files changed, 31 insertions(+), 6 deletions(-)

diff --git a/date.c b/date.c
index 896fbb4..f970ea8 100644
--- a/date.c
+++ b/date.c
@@ -556,15 +556,35 @@ static int match_tz(const char *date, int *offp)
 	int min, hour;
 	int n = end - date - 1;
 
-	min = offset % 100;
-	hour = offset / 100;
+	/*
+	 * ISO8601:2004(E) allows time zone designator been separated
+	 * by a clone in the extended format
+	 */
+	if (*end == ':') {
+		if (isdigit(end[1])) {
+			hour = offset;
+			min = strtoul(end+1, &end, 10);
+		} else {
+			/* Mark as invalid */
+			n = -1;
+		}
+	} else {
+		/* Only hours specified */
+		if (n == 1 || n == 2) {
+			hour = offset;
+			min = 0;
+		} else {
+			hour = offset / 100;
+			min = offset % 100;
+		}
+	}
 
 	/*
-	 * Don't accept any random crap.. At least 3 digits, and
-	 * a valid minute. We might want to check that the minutes
-	 * are divisible by 30 or something too.
+	 * Don't accept any random crap.. We might want to check that
+	 * the minutes are divisible by 15 or something too. (Offset of
+	 * Kathmandu, Nepal is UTC+5:45)
 	 */
-	if (min < 60 && n > 2) {
+	if (n > 0 && min < 60 && hour < 25) {
 		offset = hour*60+min;
 		if (*date == '-')
 			offset = -offset;
diff --git a/t/t0006-date.sh b/t/t0006-date.sh
index f87abb5..5235b7a 100755
--- a/t/t0006-date.sh
+++ b/t/t0006-date.sh
@@ -40,6 +40,11 @@ check_parse 2008-02 bad
 check_parse 2008-02-14 bad
 check_parse '2008-02-14 20:30:45' '2008-02-14 20:30:45 +0000'
 check_parse '2008-02-14 20:30:45 -0500' '2008-02-14 20:30:45 -0500'
+check_parse '2008-02-14 20:30:45 -0015' '2008-02-14 20:30:45 -0015'
+check_parse '2008-02-14 20:30:45 -5' '2008-02-14 20:30:45 -0500'
+check_parse '2008-02-14 20:30:45 -05' '2008-02-14 20:30:45 -0500'
+check_parse '2008-02-14 20:30:45 -:30' '2008-02-14 20:30:45 +0000'
+check_parse '2008-02-14 20:30:45 -05:00' '2008-02-14 20:30:45 -0500'
 check_parse '2008-02-14 20:30:45' '2008-02-14 20:30:45 -0500' EST5
 
 check_approxidate() {
-- 
1.7.5.4
