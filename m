From: =?ISO-8859-15?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH 1/3] pretty: simplify input line length calculation in pp_user_info()
Date: Thu, 25 Apr 2013 21:40:25 +0200
Message-ID: <517986A9.4060506@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Antoine Pelisse <apelisse@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: git discussion list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Apr 25 21:40:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UVS20-0004sm-Fw
	for gcvg-git-2@plane.gmane.org; Thu, 25 Apr 2013 21:40:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756986Ab3DYTkc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Apr 2013 15:40:32 -0400
Received: from india601.server4you.de ([85.25.151.105]:49047 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756630Ab3DYTkb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Apr 2013 15:40:31 -0400
Received: from [192.168.2.105] (p4FFDACA4.dip0.t-ipconnect.de [79.253.172.164])
	by india601.server4you.de (Postfix) with ESMTPSA id 2B68CDC;
	Thu, 25 Apr 2013 21:40:30 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 6.2; WOW64; rv:17.0) Gecko/20130328 Thunderbird/17.0.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222423>

Instead of searching for LF and NUL with two strchr() calls use a single
strchrnul() call.  We don't need to check if the returned pointer is NULL
because either we'll find the NUL at the end of line, or the caller
forgot to NUL-terminate the string and we'll overrun the buffer in any
case.  Also we don't need to pass LF or NUL to split_ident_line() as it
ignores it anyway.

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
---
 pretty.c | 13 ++-----------
 1 file changed, 2 insertions(+), 11 deletions(-)

diff --git a/pretty.c b/pretty.c
index ba31481..e51c993 100644
--- a/pretty.c
+++ b/pretty.c
@@ -413,7 +413,6 @@ void pp_user_info(const struct pretty_print_context *pp,
 	struct strbuf name;
 	struct strbuf mail;
 	struct ident_split ident;
-	int linelen;
 	char *line_end;
 	const char *mailbuf, *namebuf;
 	size_t namelen, maillen;
@@ -422,18 +421,10 @@ void pp_user_info(const struct pretty_print_context *pp,
 	if (pp->fmt == CMIT_FMT_ONELINE)
 		return;
 
-	line_end = strchr(line, '\n');
-	if (!line_end) {
-		line_end = strchr(line, '\0');
-		if (!line_end)
-			return;
-	}
-
-	linelen = ++line_end - line;
-	if (split_ident_line(&ident, line, linelen))
+	line_end = strchrnul(line, '\n');
+	if (split_ident_line(&ident, line, line_end - line))
 		return;
 
-
 	mailbuf = ident.mail_begin;
 	maillen = ident.mail_end - ident.mail_begin;
 	namebuf = ident.name_begin;
-- 
1.8.2.1
