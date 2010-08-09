From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 01/10] Export parse_date_basic() to convert a date string
 to timestamp
Date: Mon, 9 Aug 2010 17:01:27 -0500
Message-ID: <20100809220127.GB4203@burratino>
References: <1279210984-31604-1-git-send-email-artagnon@gmail.com>
 <20100716101352.GA14374@burratino>
 <20100809215719.GA4203@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	David Michael Barr <david.barr@cordelta.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 10 00:03:12 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OiaR1-0000D2-Qz
	for gcvg-git-2@lo.gmane.org; Tue, 10 Aug 2010 00:03:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756213Ab0HIWDB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Aug 2010 18:03:01 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:51801 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751815Ab0HIWDA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Aug 2010 18:03:00 -0400
Received: by qwh6 with SMTP id 6so7658046qwh.19
        for <git@vger.kernel.org>; Mon, 09 Aug 2010 15:02:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=s29Wj3h5M9YmPm7o46M2ZcL/Fk1QAq1NrbhVbvNk3aA=;
        b=MZ0Ksb3LGAUwiiEndNPLps7oofC/45obRInbFuwf1aFA6yj1cXKpmUFnoM1qmKrZQn
         mxPXjyXqBAm1p1OVcr0LBZP+fqCm8MLYCQoWsgE3RRcVLQ2LqYLpxpuvoEEW0PjAo5rE
         WrSYhbGWnijt1ZXItiDOqUGhOfLjRKBL+x1kA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=Ux7gG8omW2JW3UYYX0Dqspbh0hHUdhNQ+RvMA8Sqa9u3h6kUwags4cZSgFgcyZdpjO
         ry5yRBpLLAslxVVzACOXZhHKpmm6M9epNomNYPM4BjPkw2Ak3dzgfgxOk6rS4pT6bzAN
         tEBX4p8ulpn41OH9iJTgSmSVGU6XyvaLsEseU=
Received: by 10.220.100.67 with SMTP id x3mr9952738vcn.122.1281391379638;
        Mon, 09 Aug 2010 15:02:59 -0700 (PDT)
Received: from burratino (ip-64-32-208-34.chi.megapath.net [64.32.208.34])
        by mx.google.com with ESMTPS id s41sm1137448vcz.39.2010.08.09.15.02.56
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 09 Aug 2010 15:02:58 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100809215719.GA4203@burratino>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153033>

approxidate() is not appropriate for reading machine-written dates
because it guesses instead of erroring out on malformed dates.
parse_date() is less convenient since it returns its output as a
string.  So export the underlying function that writes a timestamp.

While at it, change the return value to match the usual convention:
return 0 for success and -1 for failure.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
Acked-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
As before, I think this improves code clarity, independently of
its use for svn-fe.  So I would not be unhappy if it is applied
as a separate topic.

No change from last round.

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
1.7.2.1.544.ga752d.dirty
