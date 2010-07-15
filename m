From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 1/8] Export parse_date_basic() to convert a date string to timestamp
Date: Thu, 15 Jul 2010 18:22:57 +0200
Message-ID: <1279210984-31604-2-git-send-email-artagnon@gmail.com>
References: <1279210984-31604-1-git-send-email-artagnon@gmail.com>
Cc: David Michael Barr <david.barr@cordelta.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jul 15 18:22:08 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OZRCK-0006nr-7l
	for gcvg-git-2@lo.gmane.org; Thu, 15 Jul 2010 18:22:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933676Ab0GOQVY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Jul 2010 12:21:24 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:61019 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933663Ab0GOQVW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Jul 2010 12:21:22 -0400
Received: by ewy23 with SMTP id 23so286658ewy.19
        for <git@vger.kernel.org>; Thu, 15 Jul 2010 09:21:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=UtZCvsgWvJVFn6oZwS6IUv11TmH133593W4ny65NXMs=;
        b=lVNsuUuJWb9+xiFQBE6xaiSGA1aV0fXuRMuNldFIWBRp7LHCJnYXY7wDN4mUsavLUa
         T/D8vd/YBEVolgqGs0TyKQSwzTmpdN+PPRow6V4ICzs/ZWDyJ8kpGe3PqJCBSfB891ZB
         ar2BmZx/clqmKE6wRk2DSWlZnHwuxOtrCVbOg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=qDXeOmNTClv5dYRh7PqpW3b8Ffjr4DqLyGUiuiZ/2s63CWO0QPcjC8C7RVB0vdoOFF
         H5HjyuZnTn4SwcldPGu59kisfX0gkJzR5Ug2oP6ITDX5G8V+WTUn88I2t/eCOxjFEQnQ
         Q0D6X7cYG/+LIGNjiQIW8rbR4qs5V6Fbn6iVE=
Received: by 10.213.14.208 with SMTP id h16mr2966119eba.7.1279210881075;
        Thu, 15 Jul 2010 09:21:21 -0700 (PDT)
Received: from localhost (nat-wireless.itu.dk [130.226.142.243])
        by mx.google.com with ESMTPS id a48sm9365793eei.19.2010.07.15.09.21.19
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 15 Jul 2010 09:21:20 -0700 (PDT)
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1279210984-31604-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151087>

From: Jonathan Nieder <jrnieder@gmail.com>

approxidate() is not appropriate for reading machine-written dates
because it guesses instead of erroring out on malformed dates.
parse_date() is less convenient since it returns its output as a
string.  So export the underlying function that writes a timestamp.

While at it, change the return value to match the usual convention:
return 0 for success and -1 for failure.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
Acked-by: Ramkumar Ramachandra <artagnon@gmail.com>
Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 cache.h |    1 +
 date.c  |   14 ++++++--------
 2 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/cache.h b/cache.h
index c9fa3df..68258be 100644
--- a/cache.h
+++ b/cache.h
@@ -811,6 +811,7 @@ const char *show_date_relative(unsigned long time, int tz,
 			       char *timebuf,
 			       size_t timebuf_size);
 int parse_date(const char *date, char *buf, int bufsize);
+int parse_date_basic(const char *date, unsigned long *timestamp, int *offset);
 void datestamp(char *buf, int bufsize);
 #define approxidate(s) approxidate_careful((s), NULL)
 unsigned long approxidate_careful(const char *, int *);
diff --git a/date.c b/date.c
index 3c981f7..00f9eb5 100644
--- a/date.c
+++ b/date.c
@@ -586,7 +586,7 @@ static int date_string(unsigned long date, int offset, char *buf, int len)
 
 /* Gr. strptime is crap for this; it doesn't have a way to require RFC2822
    (i.e. English) day/month names, and it doesn't work correctly with %z. */
-int parse_date_toffset(const char *date, unsigned long *timestamp, int *offset)
+int parse_date_basic(const char *date, unsigned long *timestamp, int *offset)
 {
 	struct tm tm;
 	int tm_gmt;
@@ -642,17 +642,16 @@ int parse_date_toffset(const char *date, unsigned long *timestamp, int *offset)
 
 	if (!tm_gmt)
 		*timestamp -= *offset * 60;
-	return 1; /* success */
+	return 0; /* success */
 }
 
 int parse_date(const char *date, char *result, int maxlen)
 {
 	unsigned long timestamp;
 	int offset;
-	if (parse_date_toffset(date, &timestamp, &offset) > 0)
-		return date_string(timestamp, offset, result, maxlen);
-	else
+	if (parse_date_basic(date, &timestamp, &offset))
 		return -1;
+	return date_string(timestamp, offset, result, maxlen);
 }
 
 enum date_mode parse_date_format(const char *format)
@@ -1004,9 +1003,8 @@ unsigned long approxidate_relative(const char *date, const struct timeval *tv)
 	int offset;
 	int errors = 0;
 
-	if (parse_date_toffset(date, &timestamp, &offset) > 0)
+	if (!parse_date_basic(date, &timestamp, &offset))
 		return timestamp;
-
 	return approxidate_str(date, tv, &errors);
 }
 
@@ -1019,7 +1017,7 @@ unsigned long approxidate_careful(const char *date, int *error_ret)
 	if (!error_ret)
 		error_ret = &dummy;
 
-	if (parse_date_toffset(date, &timestamp, &offset) > 0) {
+	if (!parse_date_basic(date, &timestamp, &offset)) {
 		*error_ret = 0;
 		return timestamp;
 	}
-- 
1.7.1
