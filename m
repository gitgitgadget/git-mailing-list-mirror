From: Mike Gorchak <mike.gorchak.qnx@gmail.com>
Subject: [PATCH 1/1] Fix time offset calculation in case of unsigned time_t
Date: Mon, 25 Feb 2013 23:53:40 +0200
Message-ID: <CAHXAxrO3nSVmALnefXWbvjR-=dOgVHDDVhyhJCeu9fsco=vjOw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 25 22:54:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UA5zy-00033E-2A
	for gcvg-git-2@plane.gmane.org; Mon, 25 Feb 2013 22:54:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759464Ab3BYVxn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Feb 2013 16:53:43 -0500
Received: from mail-qe0-f44.google.com ([209.85.128.44]:61714 "EHLO
	mail-qe0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759405Ab3BYVxm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Feb 2013 16:53:42 -0500
Received: by mail-qe0-f44.google.com with SMTP id x7so907777qeu.17
        for <git@vger.kernel.org>; Mon, 25 Feb 2013 13:53:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:date:message-id:subject:from:to
         :content-type;
        bh=pVGNx54sMzUPNxruhmBu4Ox9W/FWvhhtnlH1TcJUJ8c=;
        b=TbvmJut9Iin+nrFAd8UqDXrWzNufQl3pBxdagvik9j7ceip5676hWwAeraa3xGhKF2
         qvd20hB9EAeEWHWpjiOFa6jrmTz6IfpazjxT7dkPmQdTWaS9uTz2vAvuZ/7rsqsjSXjW
         fHe5Oj9aMvMnMv8dISpLOAYcSBrt0kjfkKqvNSTuJvpqRIeUEZdY3DWCOGYt/exatDAJ
         PmyfEe7sCBgT4JlgM3AlH1plsfi3Sk0VFPxiRN4e6LVBcrH2gkkVp6Tj4C8gcI17wAXO
         hvPltSJi28SRTTHy9uaGJ99l1t7uNkwqG/7Txk6yQUOYK+OOjB4v+qPN1JQ39TE646Zj
         RlKQ==
X-Received: by 10.224.42.79 with SMTP id r15mr13964356qae.47.1361829221037;
 Mon, 25 Feb 2013 13:53:41 -0800 (PST)
Received: by 10.49.71.68 with HTTP; Mon, 25 Feb 2013 13:53:40 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217110>

Fix time offset calculation expression in case if time_t
is unsigned. This code works fine for signed and
unsigned time_t.

Signed-off-by: Mike Gorchak <mike.gorchak.qnx@gmail.com>
---
 date.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/date.c b/date.c
index 1ac28e5..11ee7b4 100644
--- a/date.c
+++ b/date.c
@@ -648,6 +648,7 @@ int parse_date_basic(const char *date, unsigned
long *timestamp, int *offset)
 	struct tm tm;
 	int tm_gmt;
 	unsigned long dummy_timestamp;
+	time_t temp_time;
 	int dummy_offset;

 	if (!timestamp)
@@ -694,8 +695,14 @@ int parse_date_basic(const char *date, unsigned
long *timestamp, int *offset)

 	/* mktime uses local timezone */
 	*timestamp = tm_to_time_t(&tm);
-	if (*offset == -1)
-		*offset = ((time_t)*timestamp - mktime(&tm)) / 60;
+	if (*offset == -1) {
+		temp_time = mktime(&tm);
+		if ((time_t)*timestamp > temp_time) {
+			*offset = ((time_t)*timestamp - temp_time) / 60;
+		} else {
+			*offset = -(int)((temp_time - (time_t)*timestamp) / 60);
+		}
+	}

 	if (*timestamp == -1)
 		return -1;
-- 
1.8.2-rc0
