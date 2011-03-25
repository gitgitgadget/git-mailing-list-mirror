From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 3/4] vcs-svn: avoid unnecessary copying of log message and
 author
Date: Thu, 24 Mar 2011 23:10:00 -0500
Message-ID: <20110325041000.GD3007@elie>
References: <7vsjuegzj8.fsf@alter.siamese.dyndns.org>
 <1300970636-31743-1-git-send-email-david.barr@cordelta.com>
 <20110325033431.GA3007@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: David Barr <david.barr@cordelta.com>
X-From: git-owner@vger.kernel.org Fri Mar 25 05:10:12 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q2yLi-0005Jc-PV
	for gcvg-git-2@lo.gmane.org; Fri, 25 Mar 2011 05:10:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751361Ab1CYEKG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Mar 2011 00:10:06 -0400
Received: from mail-yi0-f46.google.com ([209.85.218.46]:49269 "EHLO
	mail-yi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751028Ab1CYEKE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Mar 2011 00:10:04 -0400
Received: by yia27 with SMTP id 27so309399yia.19
        for <git@vger.kernel.org>; Thu, 24 Mar 2011 21:10:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=WoaJzfmvNV/wwvzaGpqsKVjerZUB73YPiXNqNLryQ2w=;
        b=BTcCMwsqjUsDtoeL9AbQq/nUKdZUItXLbkyBrc+beI9O87hpv2QjXK5No19eXWKmqz
         UELxde6vQji2gd8Dc5TUopJe2XZv4YwGyTO9i5X3Was1WLdIRxBeXOmIqDYGDE0J4b/c
         rfjXbKPgE6EUlDauM6DvZQ0r0atkOD5dnuuYY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=RgN/vaezaBi7ko+r9LG7+PWEn21b/XBXDA/oGW8V22W4I3DjYtXDOe+kHLdYxfSoVu
         jmEYkbO7hxJ9sNu2o2RpEH7oVzIz/+7K0z/0FURLgmz+pjAG99gkNaRiaYxn1/UOiPNA
         /pZZg7nr+Ty5Fdf95Sfsex1nsUjxRl6D6eaCU=
Received: by 10.236.122.66 with SMTP id s42mr420108yhh.173.1301026204508;
        Thu, 24 Mar 2011 21:10:04 -0700 (PDT)
Received: from elie (adsl-68-255-102-141.dsl.chcgil.sbcglobal.net [68.255.102.141])
        by mx.google.com with ESMTPS id u65sm339411yhn.92.2011.03.24.21.10.02
        (version=SSLv3 cipher=OTHER);
        Thu, 24 Mar 2011 21:10:03 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20110325033431.GA3007@elie>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169962>

Use strbuf_swap when storing the svn:log and svn:author properties, so
pointers to rather than the contents of buffers get copied.  The main
effect should be to make the code a little easier to read.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 vcs-svn/svndump.c |   20 ++++++++++----------
 1 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/vcs-svn/svndump.c b/vcs-svn/svndump.c
index c00f031..88ecef1 100644
--- a/vcs-svn/svndump.c
+++ b/vcs-svn/svndump.c
@@ -83,7 +83,7 @@ static void reset_dump_ctx(const char *url)
 }
 
 static void handle_property(const struct strbuf *key_buf,
-				const char *val, uint32_t len,
+				struct strbuf *val,
 				uint32_t *type_set)
 {
 	const char *key = key_buf->buf;
@@ -95,23 +95,23 @@ static void handle_property(const struct strbuf *key_buf,
 			break;
 		if (!val)
 			die("invalid dump: unsets svn:log");
-		strbuf_reset(&rev_ctx.log);
-		strbuf_add(&rev_ctx.log, val, len);
+		strbuf_swap(&rev_ctx.log, val);
 		break;
 	case sizeof("svn:author"):
 		if (constcmp(key, "svn:author"))
 			break;
-		strbuf_reset(&rev_ctx.author);
-		if (val)
-			strbuf_add(&rev_ctx.author, val, len);
+		if (!val)
+			strbuf_reset(&rev_ctx.author);
+		else
+			strbuf_swap(&rev_ctx.author, val);
 		break;
 	case sizeof("svn:date"):
 		if (constcmp(key, "svn:date"))
 			break;
 		if (!val)
 			die("invalid dump: unsets svn:date");
-		if (parse_date_basic(val, &rev_ctx.timestamp, NULL))
-			warning("invalid timestamp: %s", val);
+		if (parse_date_basic(val->buf, &rev_ctx.timestamp, NULL))
+			warning("invalid timestamp: %s", val->buf);
 		break;
 	case sizeof("svn:executable"):
 	case sizeof("svn:special"):
@@ -187,10 +187,10 @@ static void read_props(void)
 			strbuf_swap(&key, &val);
 			continue;
 		case 'D':
-			handle_property(&val, NULL, 0, &type_set);
+			handle_property(&val, NULL, &type_set);
 			continue;
 		case 'V':
-			handle_property(&key, val.buf, len, &type_set);
+			handle_property(&key, &val, &type_set);
 			strbuf_reset(&key);
 			continue;
 		default:
-- 
1.7.4.1
