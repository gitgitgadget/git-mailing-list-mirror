From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH 1/2] color: make it easier for non-config to parse color
   specs
Date: Sun, 18 Jan 2009 18:10:36 +0100
Message-ID: <4973628C.8080501@lsrfire.ath.cx>
References: <20090117152108.GA24899@coredump.intra.peff.net> <20090117153229.GA27071@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Markus Heidelberg <markus.heidelberg@web.de>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Jan 18 18:12:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LObC4-0003Ze-R2
	for gcvg-git-2@gmane.org; Sun, 18 Jan 2009 18:12:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759925AbZARRKy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Jan 2009 12:10:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759705AbZARRKx
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Jan 2009 12:10:53 -0500
Received: from india601.server4you.de ([85.25.151.105]:43986 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758277AbZARRKw (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Jan 2009 12:10:52 -0500
Received: from [10.0.1.101] (p57B7E094.dip.t-dialin.net [87.183.224.148])
	by india601.server4you.de (Postfix) with ESMTPSA id 2C11D2F8046;
	Sun, 18 Jan 2009 18:10:50 +0100 (CET)
User-Agent: Thunderbird 2.0.0.19 (Windows/20081209)
In-Reply-To: <20090117153229.GA27071@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106244>

Jeff King schrieb:
> We have very featureful color-parsing routines which are
> used for color.diff.* and other options. Let's make it
> easier to use those routines from other parts of the code.
> 
> This patch adds a color_parse_mem() helper function which
> takes a length-bounded string instead of a NUL-terminated
> one. While the helper is only a few lines long, it is nice
> to abstract this out so that:
> 
>  - callers don't forget to free() the temporary buffer
> 
>  - right now, it is implemented in terms of color_parse().
>    But it would be more efficient to reverse this and
>    implement color_parse in terms of color_parse_mem.

Thusly?

diff --git a/color.c b/color.c
index fc0b72a..14eac93 100644
--- a/color.c
+++ b/color.c
@@ -41,6 +41,11 @@ static int parse_attr(const char *name, int len)
 
 void color_parse(const char *value, const char *var, char *dst)
 {
+	color_parse_mem(value, strlen(value), var, dst);
+}
+
+void color_parse_mem(const char *value, int len, const char *var, char *dst)
+{
 	const char *ptr = value;
 	int attr = -1;
 	int fg = -2;
@@ -52,18 +57,22 @@ void color_parse(const char *value, const char *var, char *dst)
 	}
 
 	/* [fg [bg]] [attr] */
-	while (*ptr) {
+	while (len > 0) {
 		const char *word = ptr;
-		int val, len = 0;
+		int val, wordlen = 0;
 
-		while (word[len] && !isspace(word[len]))
-			len++;
+		while (len > 0 && !isspace(word[wordlen])) {
+			wordlen++;
+			len--;
+		}
 
-		ptr = word + len;
-		while (*ptr && isspace(*ptr))
+		ptr = word + wordlen;
+		while (len > 0 && isspace(*ptr)) {
 			ptr++;
+			len--;
+		}
 
-		val = parse_color(word, len);
+		val = parse_color(word, wordlen);
 		if (val >= -1) {
 			if (fg == -2) {
 				fg = val;
@@ -75,7 +84,7 @@ void color_parse(const char *value, const char *var, char *dst)
 			}
 			goto bad;
 		}
-		val = parse_attr(word, len);
+		val = parse_attr(word, wordlen);
 		if (val < 0 || attr != -1)
 			goto bad;
 		attr = val;
