From: Mike Gorchak <mike.gorchak.qnx@gmail.com>
Subject: [PATCH 1/1] Fix date checking in case if time was not initialized.
Date: Mon, 25 Feb 2013 10:36:29 +0200
Message-ID: <CAHXAxrOOqn6ZSVT1AFyO3a3paD1tokBtcnaX68a+ddhodOvZ6Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 25 09:37:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U9tYR-00039Y-9t
	for gcvg-git-2@plane.gmane.org; Mon, 25 Feb 2013 09:36:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757487Ab3BYIgb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Feb 2013 03:36:31 -0500
Received: from mail-qa0-f49.google.com ([209.85.216.49]:45690 "EHLO
	mail-qa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753749Ab3BYIga (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Feb 2013 03:36:30 -0500
Received: by mail-qa0-f49.google.com with SMTP id o13so1425718qaj.1
        for <git@vger.kernel.org>; Mon, 25 Feb 2013 00:36:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:date:message-id:subject:from:to
         :content-type;
        bh=8L98lniCDy/8P8CvVideJ0fLAxcGiH6Gv8lCcH3bYyg=;
        b=cRWCtepoC5FoWwDhrvFGaqHTOCk+LF9SSxBcgihwbK2TWcL9Dq7CU3jA1CmiH4Qqly
         DQuBvEr+JK9WDWhiZzg0mf+GWla/r6Ox8S7J6FFuXqtgK53iv40ww4r79ktQ4FhxvXhF
         MfO3xNGL/fEZ9rL7osLvVjMualpi2xWJup2cRKEf3MjBXd5s5cHwnwSEp3VhQ4Hip+2D
         LILHQ+g/8t8445qKUKHg0+loHPNKKliyplfkzQCLpO+QNFjxCMOhy75F+x9pA7Cqd9cb
         LXJm8J14k9DAiHVaBgfpyl7W0iHIhqp5elJSy0PRAbTK/7klZ84CEz4br43miuYHQ+CA
         25Vg==
X-Received: by 10.224.10.76 with SMTP id o12mr10153480qao.36.1361781389744;
 Mon, 25 Feb 2013 00:36:29 -0800 (PST)
Received: by 10.49.71.68 with HTTP; Mon, 25 Feb 2013 00:36:29 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217048>

Fix is_date() function failings in detection of correct date in case
if time was not properly initialized.

From: Mike Gorchak <mike.gorchak.qnx@gmail.com>
Signed-off-by: Mike Gorchak <mike.gorchak.qnx@gmail.com>
---
 date.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/date.c b/date.c
index 57331ed..ec758f4 100644
--- a/date.c
+++ b/date.c
@@ -357,6 +357,7 @@ static int is_date(int year, int month, int day,
struct tm *now_tm, time_t now,
 	if (month > 0 && month < 13 && day > 0 && day < 32) {
 		struct tm check = *tm;
 		struct tm *r = (now_tm ? &check : tm);
+		struct tm fixed_r;
 		time_t specified;

 		r->tm_mon = month - 1;
@@ -377,7 +378,16 @@ static int is_date(int year, int month, int day,
struct tm *now_tm, time_t now,
 		if (!now_tm)
 			return 1;

-		specified = tm_to_time_t(r);
+		/* Fix tm structure in case if time was not initialized */
+		fixed_r = *r;
+		if (fixed_r.tm_hour==-1)
+			fixed_r.tm_hour=0;
+		if (fixed_r.tm_min==-1)
+			fixed_r.tm_min=0;
+		if (fixed_r.tm_sec==-1)
+			fixed_r.tm_sec=0;
+
+		specified = tm_to_time_t(&fixed_r);

 		/* Be it commit time or author time, it does not make
 		 * sense to specify timestamp way into the future.  Make
-- 
1.8.2-rc0
