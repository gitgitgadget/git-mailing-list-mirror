From: =?ISO-8859-15?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH] pretty: use prefixcmp instead of memcmp on NUL-terminated
 strings
Date: Mon, 14 Jan 2013 17:34:56 +0100
Message-ID: <50F433B0.3010501@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>
To: git discussion list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jan 14 17:35:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tun0Z-0005hF-AB
	for gcvg-git-2@plane.gmane.org; Mon, 14 Jan 2013 17:35:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756824Ab3ANQfJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jan 2013 11:35:09 -0500
Received: from india601.server4you.de ([85.25.151.105]:37555 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755871Ab3ANQfG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jan 2013 11:35:06 -0500
Received: from [192.168.2.105] (p4FFD927D.dip.t-dialin.net [79.253.146.125])
	by india601.server4you.de (Postfix) with ESMTPSA id 0B5AB130;
	Mon, 14 Jan 2013 17:35:05 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows NT 6.2; WOW64; rv:17.0) Gecko/20130107 Thunderbird/17.0.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213498>

This conversion avoids the need for magic string length numbers in the
code.  And unlike memcmp(), prefixcmp() is careful to not run over the
end of a string.

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
---
 pretty.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/pretty.c b/pretty.c
index 92c839f..01795de 100644
--- a/pretty.c
+++ b/pretty.c
@@ -966,7 +966,7 @@ static size_t format_commit_one(struct strbuf *sb, const char *placeholder,
 
 			if (!end)
 				return 0;
-			if (!memcmp(begin, "auto,", 5)) {
+			if (!prefixcmp(begin, "auto,")) {
 				if (!want_color(c->pretty_ctx->color))
 					return end - placeholder + 1;
 				begin += 5;
@@ -1301,7 +1301,7 @@ static void pp_header(const struct pretty_print_context *pp,
 			continue;
 		}
 
-		if (!memcmp(line, "parent ", 7)) {
+		if (!prefixcmp(line, "parent ")) {
 			if (linelen != 48)
 				die("bad parent line in commit");
 			continue;
@@ -1325,11 +1325,11 @@ static void pp_header(const struct pretty_print_context *pp,
 		 * FULL shows both authors but not dates.
 		 * FULLER shows both authors and dates.
 		 */
-		if (!memcmp(line, "author ", 7)) {
+		if (!prefixcmp(line, "author ")) {
 			strbuf_grow(sb, linelen + 80);
 			pp_user_info(pp, "Author", sb, line + 7, encoding);
 		}
-		if (!memcmp(line, "committer ", 10) &&
+		if (!prefixcmp(line, "committer ") &&
 		    (pp->fmt == CMIT_FMT_FULL || pp->fmt == CMIT_FMT_FULLER)) {
 			strbuf_grow(sb, linelen + 80);
 			pp_user_info(pp, "Commit", sb, line + 10, encoding);
-- 
1.8.0
