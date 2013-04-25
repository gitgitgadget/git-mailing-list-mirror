From: =?ISO-8859-15?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH 2/3] pretty: simplify output line length calculation in pp_user_info()
Date: Thu, 25 Apr 2013 21:41:57 +0200
Message-ID: <51798705.7030108@lsrfire.ath.cx>
References: <517986A9.4060506@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Antoine Pelisse <apelisse@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: git discussion list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Apr 25 21:42:06 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UVS3S-0006hH-3C
	for gcvg-git-2@plane.gmane.org; Thu, 25 Apr 2013 21:42:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758412Ab3DYTmA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Apr 2013 15:42:00 -0400
Received: from india601.server4you.de ([85.25.151.105]:49052 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757737Ab3DYTmA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Apr 2013 15:42:00 -0400
Received: from [192.168.2.105] (p4FFDACA4.dip0.t-ipconnect.de [79.253.172.164])
	by india601.server4you.de (Postfix) with ESMTPSA id 8C8CA44B;
	Thu, 25 Apr 2013 21:41:57 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 6.2; WOW64; rv:17.0) Gecko/20130328 Thunderbird/17.0.5
In-Reply-To: <517986A9.4060506@lsrfire.ath.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222424>

Keep namelen unchanged and don't use it to hold a value that we're not
interested in anyway -- we can use maillen and the constant part
directly instead.  This simplifies the code slightly and prepares for
the next patch that makes use of the original value of namelen.

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
---
 pretty.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/pretty.c b/pretty.c
index e51c993..6861997 100644
--- a/pretty.c
+++ b/pretty.c
@@ -439,8 +439,6 @@ void pp_user_info(const struct pretty_print_context *pp,
 	strbuf_add(&mail, mailbuf, maillen);
 	strbuf_add(&name, namebuf, namelen);
 
-	namelen = name.len + mail.len + 3; /* ' ' + '<' + '>' */
-
 	if (pp->fmt == CMIT_FMT_EMAIL) {
 		strbuf_addstr(sb, "From: ");
 		if (needs_rfc2047_encoding(name.buf, name.len, RFC2047_ADDRESS)) {
@@ -457,9 +455,10 @@ void pp_user_info(const struct pretty_print_context *pp,
 			strbuf_add_wrapped_bytes(sb, name.buf, name.len,
 						 -6, 1, max_length);
 		}
-		if (namelen - name.len + last_line_length(sb) > max_length)
-			strbuf_addch(sb, '\n');
 
+		if (max_length <
+		    last_line_length(sb) + strlen(" <") + maillen + strlen(">"))
+			strbuf_addch(sb, '\n');
 		strbuf_addf(sb, " <%s>\n", mail.buf);
 	} else {
 		strbuf_addf(sb, "%s: %.*s%s <%s>\n", what,
-- 
1.8.2.1
