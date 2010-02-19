From: =?ISO-8859-15?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH 2/4] utf8.c: remove print_spaces()
Date: Fri, 19 Feb 2010 23:15:55 +0100
Message-ID: <4B7F0D9B.2060904@lsrfire.ath.cx>
References: <4B7F0D08.6040608@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Feb 19 23:16:03 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nib8j-0006vr-9t
	for gcvg-git-2@lo.gmane.org; Fri, 19 Feb 2010 23:16:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755528Ab0BSWP4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Feb 2010 17:15:56 -0500
Received: from india601.server4you.de ([85.25.151.105]:43434 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755052Ab0BSWP4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Feb 2010 17:15:56 -0500
Received: from [10.0.1.100] (p57B7E04C.dip.t-dialin.net [87.183.224.76])
	by india601.server4you.de (Postfix) with ESMTPSA id 10FD92F806C;
	Fri, 19 Feb 2010 23:15:55 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.0; de; rv:1.9.1.7) Gecko/20100111 Thunderbird/3.0.1
In-Reply-To: <4B7F0D08.6040608@lsrfire.ath.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140488>

The previous patch made sure that strbuf_add_wrapped_text() (and thus
strbuf_add_indented_text(), too) always get a strbuf.  Make use of
this fact by adding strbuf_addchars(), a small helper that adds a
char the specified number of times to a strbuf, and use it to replace
print_spaces().

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
---
 utf8.c |   15 ++++++---------
 1 files changed, 6 insertions(+), 9 deletions(-)

diff --git a/utf8.c b/utf8.c
index 831cad6..5146d30 100644
--- a/utf8.c
+++ b/utf8.c
@@ -288,14 +288,11 @@ static inline void strbuf_write(struct strbuf *sb, const char *buf, int len)
 		fwrite(buf, len, 1, stdout);
 }
 
-static void print_spaces(struct strbuf *buf, int count)
+static void strbuf_addchars(struct strbuf *sb, int c, size_t n)
 {
-	static const char s[] = "                    ";
-	while (count >= sizeof(s)) {
-		strbuf_write(buf, s, sizeof(s) - 1);
-		count -= sizeof(s) - 1;
-	}
-	strbuf_write(buf, s, count);
+	strbuf_grow(sb, n);
+	memset(sb->buf + sb->len, c, n);
+	strbuf_setlen(sb, sb->len + n);
 }
 
 static void strbuf_add_indented_text(struct strbuf *buf, const char *text,
@@ -307,7 +304,7 @@ static void strbuf_add_indented_text(struct strbuf *buf, const char *text,
 		const char *eol = strchrnul(text, '\n');
 		if (*eol == '\n')
 			eol++;
-		print_spaces(buf, indent);
+		strbuf_addchars(buf, ' ', indent);
 		strbuf_write(buf, text, eol - text);
 		text = eol;
 		indent = indent2;
@@ -366,7 +363,7 @@ int strbuf_add_wrapped_text(struct strbuf *buf,
 				if (space)
 					start = space;
 				else
-					print_spaces(buf, indent);
+					strbuf_addchars(buf, ' ', indent);
 				strbuf_write(buf, start, text - start);
 				if (!c)
 					return w;
-- 
1.7.0
