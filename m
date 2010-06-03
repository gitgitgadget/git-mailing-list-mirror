From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH] Refactor parse_date for approxidate functions
Date: Thu,  3 Jun 2010 22:28:55 +0200
Message-ID: <1275596935-17312-1-git-send-email-artagnon@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jun 03 22:35:18 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OKH8H-0001dh-4x
	for gcvg-git-2@lo.gmane.org; Thu, 03 Jun 2010 22:35:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755907Ab0FCUfK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Jun 2010 16:35:10 -0400
Received: from mail-ew0-f223.google.com ([209.85.219.223]:36406 "EHLO
	mail-ew0-f223.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754494Ab0FCUfI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Jun 2010 16:35:08 -0400
Received: by ewy23 with SMTP id 23so137480ewy.1
        for <git@vger.kernel.org>; Thu, 03 Jun 2010 13:35:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=HBekqnpy6pdqqScWnyNMK1AJWIx112NlnzNr0c+rzRw=;
        b=szaYXACcfP7gxOaErL5d2CKEHhvT4IN4S4rgWXidWof9pteNRPqaPxlTdElpqAdThh
         s9sS7DYQJwHQFS2ReGDPquSJcqqyIpCiLjbUS5PqWHlJgAtO9J0JrlxvzoAr1hzBd11F
         reMWi0WckyJmKs42r2k0D2GNHpbAzAqme7YPE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=AyZkkbngYXDhe8DW8bMiclhEJU2TFh4hz3vN/UZ55aSViI0ZtdsOzYOL1x+vmgOr9f
         RRneSV06YyCsoqjuImoKnECW1DPz65SeketdA6ZQa6lyd1tWehIPXcVnBJoa5yC4hq0c
         zmRqttcCpa9RkGQ6cqLO7L9KIkQKtFxUyH2Bg=
Received: by 10.213.32.195 with SMTP id e3mr4482620ebd.18.1275597299776;
        Thu, 03 Jun 2010 13:34:59 -0700 (PDT)
Received: from localhost (port865.ds1-suoe.adsl.cybercity.dk [212.242.163.112])
        by mx.google.com with ESMTPS id 15sm261604ewy.12.2010.06.03.13.34.58
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 03 Jun 2010 13:34:59 -0700 (PDT)
X-Mailer: git-send-email 1.7.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148361>

approxidate_relative and approxidate_careful both use parse_date to
dump the timestamp to a character buffer and parse it back into a long
unsigned using strtoul(). Avoid doing this by creating a new
parse_date_toffset method.

Noticed-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 date.c |   56 +++++++++++++++++++++++++++++++++++++-------------------
 1 files changed, 37 insertions(+), 19 deletions(-)

diff --git a/date.c b/date.c
index 002aa3c..21b4096 100644
--- a/date.c
+++ b/date.c
@@ -585,11 +585,17 @@ static int date_string(unsigned long date, int offset, char *buf, int len)
 
 /* Gr. strptime is crap for this; it doesn't have a way to require RFC2822
    (i.e. English) day/month names, and it doesn't work correctly with %z. */
-int parse_date(const char *date, char *result, int maxlen)
+int parse_date_toffset(const char *date, unsigned long *timestamp, int *offset)
 {
 	struct tm tm;
-	int offset, tm_gmt;
-	time_t then;
+	int tm_gmt;
+	unsigned long dummy_timestamp;
+	int dummy_offset;
+
+	if(!timestamp)
+		timestamp = &dummy_timestamp;
+	if(!offset)
+		offset = &dummy_offset;
 
 	memset(&tm, 0, sizeof(tm));
 	tm.tm_year = -1;
@@ -599,7 +605,7 @@ int parse_date(const char *date, char *result, int maxlen)
 	tm.tm_hour = -1;
 	tm.tm_min = -1;
 	tm.tm_sec = -1;
-	offset = -1;
+	*offset = -1;
 	tm_gmt = 0;
 
 	for (;;) {
@@ -611,11 +617,11 @@ int parse_date(const char *date, char *result, int maxlen)
 			break;
 
 		if (isalpha(c))
-			match = match_alpha(date, &tm, &offset);
+			match = match_alpha(date, &tm, offset);
 		else if (isdigit(c))
-			match = match_digit(date, &tm, &offset, &tm_gmt);
+			match = match_digit(date, &tm, offset, &tm_gmt);
 		else if ((c == '-' || c == '+') && isdigit(date[1]))
-			match = match_tz(date, &offset);
+			match = match_tz(date, offset);
 
 		if (!match) {
 			/* BAD CRAP */
@@ -626,16 +632,26 @@ int parse_date(const char *date, char *result, int maxlen)
 	}
 
 	/* mktime uses local timezone */
-	then = tm_to_time_t(&tm);
-	if (offset == -1)
-		offset = (then - mktime(&tm)) / 60;
+	*timestamp = tm_to_time_t(&tm);
+	if (*offset == -1)
+		*offset = (*timestamp - mktime(&tm)) / 60;
 
-	if (then == -1)
+	if (*timestamp == -1)
 		return -1;
 
 	if (!tm_gmt)
-		then -= offset * 60;
-	return date_string(then, offset, result, maxlen);
+		*timestamp -= *offset * 60;
+	return 1; /* success */
+}
+
+int parse_date(const char *date, char *result, int maxlen)
+{
+	unsigned long timestamp;
+	int offset;
+	if(parse_date_toffset(date, &timestamp, &offset) > 0)
+		return date_string(timestamp, offset, result, maxlen);
+	else
+		return -1;
 }
 
 enum date_mode parse_date_format(const char *format)
@@ -983,11 +999,12 @@ static unsigned long approxidate_str(const char *date,
 
 unsigned long approxidate_relative(const char *date, const struct timeval *tv)
 {
-	char buffer[50];
+	unsigned long timestamp;
+	int offset;
 	int errors = 0;
 
-	if (parse_date(date, buffer, sizeof(buffer)) > 0)
-		return strtoul(buffer, NULL, 0);
+	if(parse_date_toffset(date, &timestamp, &offset) > 0)
+		return timestamp;
 
 	return approxidate_str(date, tv, &errors);
 }
@@ -995,14 +1012,15 @@ unsigned long approxidate_relative(const char *date, const struct timeval *tv)
 unsigned long approxidate_careful(const char *date, int *error_ret)
 {
 	struct timeval tv;
-	char buffer[50];
+	unsigned long timestamp;
+	int offset;
 	int dummy = 0;
 	if (!error_ret)
 		error_ret = &dummy;
 
-	if (parse_date(date, buffer, sizeof(buffer)) > 0) {
+	if(parse_date_toffset(date, &timestamp, &offset) > 0) {
 		*error_ret = 0;
-		return strtoul(buffer, NULL, 0);
+		return timestamp;
 	}
 
 	gettimeofday(&tv, NULL);
-- 
1.7.1
