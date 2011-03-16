From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 1/2] mktag: avoid %td in format string
Date: Wed, 16 Mar 2011 00:14:22 -0500
Message-ID: <20110316051422.GB1932@elie>
References: <27484.1172021696@lotus.CS.Berkeley.EDU>
 <20110316051232.GA1932@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jason Riedy <jason@acm.org>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 16 06:14:37 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pzj45-0004rs-1O
	for gcvg-git-2@lo.gmane.org; Wed, 16 Mar 2011 06:14:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751288Ab1CPFO2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Mar 2011 01:14:28 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:63820 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750939Ab1CPFO1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Mar 2011 01:14:27 -0400
Received: by gyf1 with SMTP id 1so513227gyf.19
        for <git@vger.kernel.org>; Tue, 15 Mar 2011 22:14:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=2sT766WfCRXCDP+dYxuTNXBAcDg+6PBlwlxxS3lqQ+c=;
        b=vqYc/0icEYMuHYsqBevok65XPlnHVbuY4Lr9HPQPzUCjm8m17jGpJchH40rV7zXRf9
         9QdO2q8MfL6w5OjNr8mIvvlrYbwVRa1M9+CuqlFeTVgFknQRuWS4KBx+UiZTyawj2EMf
         1k/XfchUfF70ADsknQV6vRnZKJuo5pKcjX76U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=HEJLRNL5i3WSwKrmtuuB9KOY1XkQ2+2lNsiVNmy/u+nKMTqD+SZz6TjW64Fu+z50n1
         Cn7m0UV2RJ9nFw8ceOgTen0gKqCZvlpEQ02rh8lAvZrLzZnaE9uyVwrM5Vi+h82am5l+
         MyRDEU0Yi8YM07CypzUSe+tgYFWgPEsTPfIho=
Received: by 10.100.235.2 with SMTP id i2mr212440anh.164.1300252466587;
        Tue, 15 Mar 2011 22:14:26 -0700 (PDT)
Received: from elie (adsl-69-209-56-53.dsl.chcgil.sbcglobal.net [69.209.56.53])
        by mx.google.com with ESMTPS id x37sm708052ana.28.2011.03.15.22.14.25
        (version=SSLv3 cipher=OTHER);
        Tue, 15 Mar 2011 22:14:25 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20110316051232.GA1932@elie>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169102>

Since v1.7.0-rc0~34 (make "mktag" a built-in, 2010-01-22), git mktag
uses the C99-style %td format to print ptrdiff_t values.  It falls
back to %d when NO_C99_FORMAT is set, on the assumption that pre-C99
systems probably are using 32-bit pointers.

But many modern systems are 64-bit and

 * sometimes one wants to test the NO_C99_FORMAT fallbacks using a
   modern development platform;
 * some platforms (I'm looking at you, msvc) have not gotten with the
   program and are still C89-only.

These ptrdiff_t values are offsets from the beginning of a buffer, so
a size_t or uintmax_t would work about as well.  Use the latter so we
can take advantage of the PRIuMAX fallback in git-compat-util.h, even
on C99-challenged systems with 64-bit pointers.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
These two patches apply to maint.

 builtin/mktag.c |   48 ++++++++++++++++++++++--------------------------
 1 files changed, 22 insertions(+), 26 deletions(-)

diff --git a/builtin/mktag.c b/builtin/mktag.c
index 1cb0f3f..bc05227 100644
--- a/builtin/mktag.c
+++ b/builtin/mktag.c
@@ -35,12 +35,6 @@ static int verify_object(const unsigned char *sha1, const char *expected_type)
 	return ret;
 }
 
-#ifdef NO_C99_FORMAT
-#define PD_FMT "%d"
-#else
-#define PD_FMT "%td"
-#endif
-
 static int verify_tag(char *buffer, unsigned long size)
 {
 	int typelen;
@@ -70,15 +64,18 @@ static int verify_tag(char *buffer, unsigned long size)
 	/* Verify tag-line */
 	tag_line = strchr(type_line, '\n');
 	if (!tag_line)
-		return error("char" PD_FMT ": could not find next \"\\n\"", type_line - buffer);
+		return error("char%"PRIuMAX": could not find next \"\\n\"",
+				(uintmax_t) (type_line - buffer));
 	tag_line++;
 	if (memcmp(tag_line, "tag ", 4) || tag_line[4] == '\n')
-		return error("char" PD_FMT ": no \"tag \" found", tag_line - buffer);
+		return error("char%"PRIuMAX": no \"tag \" found",
+				(uintmax_t) (tag_line - buffer));
 
 	/* Get the actual type */
 	typelen = tag_line - type_line - strlen("type \n");
 	if (typelen >= sizeof(type))
-		return error("char" PD_FMT ": type too long", type_line+5 - buffer);
+		return error("char%"PRIuMAX": type too long",
+				(uintmax_t) (type_line+5 - buffer));
 
 	memcpy(type, type_line+5, typelen);
 	type[typelen] = 0;
@@ -95,15 +92,16 @@ static int verify_tag(char *buffer, unsigned long size)
 			break;
 		if (c > ' ')
 			continue;
-		return error("char" PD_FMT ": could not verify tag name", tag_line - buffer);
+		return error("char%"PRIuMAX": could not verify tag name",
+				(uintmax_t) (tag_line - buffer));
 	}
 
 	/* Verify the tagger line */
 	tagger_line = tag_line;
 
 	if (memcmp(tagger_line, "tagger ", 7))
-		return error("char" PD_FMT ": could not find \"tagger \"",
-			tagger_line - buffer);
+		return error("char%"PRIuMAX": could not find \"tagger \"",
+			(uintmax_t) (tagger_line - buffer));
 
 	/*
 	 * Check for correct form for name and email
@@ -115,44 +113,42 @@ static int verify_tag(char *buffer, unsigned long size)
 	if (!(lb = strstr(tagger_line, " <")) || !(rb = strstr(lb+2, "> ")) ||
 		strpbrk(tagger_line, "<>\n") != lb+1 ||
 		strpbrk(lb+2, "><\n ") != rb)
-		return error("char" PD_FMT ": malformed tagger field",
-			tagger_line - buffer);
+		return error("char%"PRIuMAX": malformed tagger field",
+			(uintmax_t) (tagger_line - buffer));
 
 	/* Check for author name, at least one character, space is acceptable */
 	if (lb == tagger_line)
-		return error("char" PD_FMT ": missing tagger name",
-			tagger_line - buffer);
+		return error("char%"PRIuMAX": missing tagger name",
+			(uintmax_t) (tagger_line - buffer));
 
 	/* timestamp, 1 or more digits followed by space */
 	tagger_line = rb + 2;
 	if (!(len = strspn(tagger_line, "0123456789")))
-		return error("char" PD_FMT ": missing tag timestamp",
-			tagger_line - buffer);
+		return error("char%"PRIuMAX": missing tag timestamp",
+			(uintmax_t) (tagger_line - buffer));
 	tagger_line += len;
 	if (*tagger_line != ' ')
-		return error("char" PD_FMT ": malformed tag timestamp",
-			tagger_line - buffer);
+		return error("char%"PRIuMAX": malformed tag timestamp",
+			(uintmax_t) (tagger_line - buffer));
 	tagger_line++;
 
 	/* timezone, 5 digits [+-]hhmm, max. 1400 */
 	if (!((tagger_line[0] == '+' || tagger_line[0] == '-') &&
 	      strspn(tagger_line+1, "0123456789") == 4 &&
 	      tagger_line[5] == '\n' && atoi(tagger_line+1) <= 1400))
-		return error("char" PD_FMT ": malformed tag timezone",
-			tagger_line - buffer);
+		return error("char%"PRIuMAX": malformed tag timezone",
+			(uintmax_t) (tagger_line - buffer));
 	tagger_line += 6;
 
 	/* Verify the blank line separating the header from the body */
 	if (*tagger_line != '\n')
-		return error("char" PD_FMT ": trailing garbage in tag header",
-			tagger_line - buffer);
+		return error("char%"PRIuMAX": trailing garbage in tag header",
+			(uintmax_t) (tagger_line - buffer));
 
 	/* The actual stuff afterwards we don't care about.. */
 	return 0;
 }
 
-#undef PD_FMT
-
 int cmd_mktag(int argc, const char **argv, const char *prefix)
 {
 	struct strbuf buf = STRBUF_INIT;
-- 
1.7.4.1
