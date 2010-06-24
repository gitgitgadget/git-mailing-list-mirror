From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 1/9] Export parse_date_basic() to convert a date string to
 timestamp
Date: Thu, 24 Jun 2010 05:51:46 -0500
Message-ID: <20100624105146.GA12376@burratino>
References: <20100624105004.GA12336@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	David Michael Barr <david.barr@cordelta.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Daniel Shahaf <daniel@shahaf.name>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 24 12:52:06 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ORk2P-00010B-Ln
	for gcvg-git-2@lo.gmane.org; Thu, 24 Jun 2010 12:52:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754752Ab0FXKv6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Jun 2010 06:51:58 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:53370 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754449Ab0FXKv5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jun 2010 06:51:57 -0400
Received: by iwn41 with SMTP id 41so730737iwn.19
        for <git@vger.kernel.org>; Thu, 24 Jun 2010 03:51:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=UYaMD2Ei0/hRicKuV/HnWyHAVdggO+J5Z6+4ZwxCa1Y=;
        b=C4Wyhe28By6Mley8aabT29/pjeayGWBg7kfG49pog8wVjCEyW3VfPbxyVKUt2GujTj
         L3QCK3kwVxuTVCZNkVYAB5fwKqXCyKo0mIjnMXTl80PWNnFQ56Pd3aed6gXSnx6Gyk7O
         /cX4U92UuJq1sLZXRwir7uir2pgauu1Wfga0g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=lc06bIlBmImG3dAJxXpJb6TQ2aL69Wzcg++agJjdv04EsVPuf4kSBu74qBiPCU+SEV
         509tYRc/REAZRb2du+fbcHoLV2Klf8sKWW+5zH2fMObErtxcxqw7FeCMEDXuSszIUrFa
         vEcjb/ZlBQKi+TEqK3JXe+ZcTbS1JAUGQUe2k=
Received: by 10.231.169.6 with SMTP id w6mr9751219iby.5.1277376717182;
        Thu, 24 Jun 2010 03:51:57 -0700 (PDT)
Received: from burratino (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id b3sm17816687ibf.13.2010.06.24.03.51.56
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 24 Jun 2010 03:51:56 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100624105004.GA12336@burratino>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149572>

approxidate() is not appropriate for reading machine-written dates
because it guesses instead of erroring out on malformed dates.
parse_date() is less convenient since it returns its output as a
string.  So export the underlying function that writes a timestamp.

While at it, change the return value to match the usual convention:
return 0 for success and -1 for failure.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 cache.h |    1 +
 date.c  |   14 ++++++--------
 2 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/cache.h b/cache.h
index ff4a7c2..4566501 100644
--- a/cache.h
+++ b/cache.h
@@ -800,6 +800,7 @@ const char *show_date_relative(unsigned long time, int tz,
 			       char *timebuf,
 			       size_t timebuf_size);
 int parse_date(const char *date, char *buf, int bufsize);
+int parse_date_basic(const char *date, unsigned long *timestamp, int *offset);
 void datestamp(char *buf, int bufsize);
 #define approxidate(s) approxidate_careful((s), NULL)
 unsigned long approxidate_careful(const char *, int *);
diff --git a/date.c b/date.c
index 68cdcaa..383706d 100644
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
