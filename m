From: Will Palmer <wmpalmer@gmail.com>
Subject: [PATCH/RFC 7/9] add long form %(color:...) for %C(...)
Date: Tue, 29 Mar 2011 00:17:29 +0100
Message-ID: <1301354251-23380-8-git-send-email-wmpalmer@gmail.com>
References: <1301354251-23380-1-git-send-email-wmpalmer@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Will Palmer <wmpalmer@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 29 01:18:13 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q4LhM-0000rH-NA
	for gcvg-git-2@lo.gmane.org; Tue, 29 Mar 2011 01:18:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755553Ab1C1XSJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Mar 2011 19:18:09 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:35885 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755539Ab1C1XSE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Mar 2011 19:18:04 -0400
Received: by mail-ww0-f44.google.com with SMTP id 36so4410093wwa.1
        for <git@vger.kernel.org>; Mon, 28 Mar 2011 16:18:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=Rqmg24dAQ9LrhvTvDh/80kWO5r7fYJGmA+ymNyjWKJw=;
        b=uU+xCpIV8wTSrRvz//792+Cy1SzRPZqWeYmDE41vuxLqzXIov/+0lg4Dzls2i8vg+e
         faii49ukW6RVC8oMk/FV26MfGziH1pfN/njgx10tkqs/bVHWJxgEsWTSDoqOmQPeuVk4
         XivPy89w+dkDR1PGhaH5PIzxj620DS81NyRNk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=bb7PF66mF/pxlo5OdqU9JaFmJdVzM2gIz5KBZkXiGa8kbh8OZkcB5vd4eSHYylyq61
         FNFa39oJmIpn8kTVpnqCjQsOfQbwa1eJXo9pGY0X9pb6ceQJL0hJ0ZMFFB2TL/omiuBT
         wBfjE8ED208kkFDwmF7sgiEtyBl9WNlxYmTbE=
Received: by 10.216.221.16 with SMTP id q16mr4223109wep.71.1301354283378;
        Mon, 28 Mar 2011 16:18:03 -0700 (PDT)
Received: from localhost.localdomain (5acc3aad.bb.sky.com [90.204.58.173])
        by mx.google.com with ESMTPS id b54sm1678272wer.45.2011.03.28.16.18.01
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 28 Mar 2011 16:18:02 -0700 (PDT)
X-Mailer: git-send-email 1.7.4.2
In-Reply-To: <1301354251-23380-1-git-send-email-wmpalmer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170201>

this adds %(color:...) as an alternative to %C(...) in the "git log"
family of commands. We now have a "long form" for all of the existing
complex placeholders.

Signed-off-by: Will Palmer <wmpalmer@gmail.com>
---
 Documentation/pretty-formats.txt |    1 +
 pretty.c                         |   22 ++++++++++++++++++++++
 test-pretty.c                    |    1 +
 3 files changed, 24 insertions(+), 0 deletions(-)

diff --git a/Documentation/pretty-formats.txt b/Documentation/pretty-formats.txt
index c9f3fb6..d987102 100644
--- a/Documentation/pretty-formats.txt
+++ b/Documentation/pretty-formats.txt
@@ -138,6 +138,7 @@ The placeholders are:
 - '%Cblue': switch color to blue
 - '%Creset': reset color
 - '%C(...)': color specification, as described in color.branch.* config option
+- '%(color:...)': alternative form of %C(...)
 - '%m': left, right or boundary mark
 - '%n': newline
 - '%%': a raw '%'
diff --git a/pretty.c b/pretty.c
index 8301008..616b857 100644
--- a/pretty.c
+++ b/pretty.c
@@ -126,9 +126,31 @@ static struct format_part *parse_extended(const char *unparsed)
 {
 	struct format_part *part = format_part_alloc();
 	const char *c = unparsed + 2; /* "%(..." + strlen("%(") */
+	const char *e;
 
 	c += strspn(c, WHITESPACE);
 
+	if (!prefixcmp(c, "color")) {
+		part->type = FORMAT_PART_LITERAL;
+		c += 5 + strspn(c + 5, WHITESPACE);
+		if (*c == ')') {
+			part->literal = xstrdup(GIT_COLOR_RESET);
+			part->literal_len = strlen(part->literal);
+			goto success;
+		}
+		if (*c != ':')
+			goto fail;
+		c++;
+		e = strchr(c, ')');
+		part->literal = xcalloc(1, COLOR_MAXLEN);
+		if (!e || !color_parse_len(c, e - c,
+					   part->literal))
+			goto fail;
+		part->literal_len = strlen(part->literal);
+		c = e;
+		goto success;
+	}
+
 	if (!prefixcmp(c, "wrap")) {
 		part->type = FORMAT_PART_WRAP;
 		c += 4;
diff --git a/test-pretty.c b/test-pretty.c
index 64a8218..eb88e3a 100644
--- a/test-pretty.c
+++ b/test-pretty.c
@@ -18,6 +18,7 @@ static const char *all = "a"
 "%Cred%Cgreen%Cblue%Creset%C(reset)"
 "%m%w()%w(1)%w(1,2)%w(1,2,3)"
 "%(wrap)%(wrap:1)%(wrap:1,2)%(wrap:1,2,3)"
+"%(color)%(color:red)%(color:red bold)%(color:red green bold)"
 "%x0a%n%%%@";
 
 static struct strbuf *parts_debug(struct format_parts *parts,
-- 
1.7.4.2
