From: =?ISO-8859-15?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH 4/4] utf8.c: speculatively assume utf-8 in strbuf_add_wrapped_text()
Date: Fri, 19 Feb 2010 23:20:44 +0100
Message-ID: <4B7F0EBC.4060209@lsrfire.ath.cx>
References: <4B7F0D08.6040608@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Feb 19 23:20:50 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NibDO-0002AP-BA
	for gcvg-git-2@lo.gmane.org; Fri, 19 Feb 2010 23:20:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755892Ab0BSWUq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Feb 2010 17:20:46 -0500
Received: from india601.server4you.de ([85.25.151.105]:33441 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755849Ab0BSWUp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Feb 2010 17:20:45 -0500
Received: from [10.0.1.100] (p57B7E04C.dip.t-dialin.net [87.183.224.76])
	by india601.server4you.de (Postfix) with ESMTPSA id 0A5542F806C;
	Fri, 19 Feb 2010 23:20:43 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.0; de; rv:1.9.1.7) Gecko/20100111 Thunderbird/3.0.1
In-Reply-To: <4B7F0D08.6040608@lsrfire.ath.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140490>

is_utf8() works by calling utf8_width() for each character at the
supplied location.  In strbuf_add_wrapped_text(), we do that anyway
while wrapping the lines.  So instead of checking the encoding
beforehand, optimistically assume that it's utf-8 and wrap along
until an invalid character is hit, and when that happens start over.

This pays off if the text consists only of valid utf-8 characters.
The following command was run against the Linux kernel repo with
git 1.7.0:

	$ time git log --format='%b' v2.6.32 >/dev/null

	real	0m2.679s
	user	0m2.580s
	sys	0m0.100s

	$ time git log --format='%w(60,4,8)%b' >/dev/null

	real	0m4.342s
	user	0m4.230s
	sys	0m0.110s

And with this patch series:

	$ time git log --format='%w(60,4,8)%b' >/dev/null

	real	0m3.741s
	user	0m3.630s
	sys	0m0.110s

So the cost of wrapping is reduced to 70% in this case.

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
---
Missing: numbers for a non-utf-8 repo.

 utf8.c |   23 +++++++++++++++++------
 1 files changed, 17 insertions(+), 6 deletions(-)

diff --git a/utf8.c b/utf8.c
index 87437b0..84cfc72 100644
--- a/utf8.c
+++ b/utf8.c
@@ -324,16 +324,21 @@ static size_t display_mode_esc_sequence_len(const char *s)
  * consumed (and no extra indent is necessary for the first line).
  */
 int strbuf_add_wrapped_text(struct strbuf *buf,
-		const char *text, int indent, int indent2, int width)
+		const char *text, int indent1, int indent2, int width)
 {
-	int w = indent, assume_utf8 = is_utf8(text);
-	const char *bol = text, *space = NULL;
+	int indent, w, assume_utf8 = 1;
+	const char *bol, *space, *start = text;
+	size_t orig_len = buf->len;
 
 	if (width <= 0) {
-		strbuf_add_indented_text(buf, text, indent, indent2);
+		strbuf_add_indented_text(buf, text, indent1, indent2);
 		return 1;
 	}
 
+retry:
+	bol = text;
+	w = indent = indent1;
+	space = NULL;
 	if (indent < 0) {
 		w = -indent;
 		space = text;
@@ -385,9 +390,15 @@ new_line:
 			}
 			continue;
 		}
-		if (assume_utf8)
+		if (assume_utf8) {
 			w += utf8_width(&text, NULL);
-		else {
+			if (!text) {
+				assume_utf8 = 0;
+				text = start;
+				strbuf_setlen(buf, orig_len);
+				goto retry;
+			}
+		} else {
 			w++;
 			text++;
 		}
-- 
1.7.0
