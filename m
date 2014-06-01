From: =?ISO-8859-15?Q?Ren=E9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH] mailinfo: use strcmp() for string comparison
Date: Sun, 01 Jun 2014 11:00:40 +0200
Message-ID: <538AEBB8.9070505@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jun 01 11:10:17 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wr1mP-0000sO-1n
	for gcvg-git-2@plane.gmane.org; Sun, 01 Jun 2014 11:10:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751887AbaFAJCf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 Jun 2014 05:02:35 -0400
Received: from mout.web.de ([212.227.15.4]:56711 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751200AbaFAJCe (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Jun 2014 05:02:34 -0400
Received: from [192.168.178.27] ([79.253.133.25]) by smtp.web.de (mrweb002)
 with ESMTPSA (Nemesis) id 0LrsGE-1WgKQ636j8-013bq4; Sun, 01 Jun 2014 11:01:16
 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.5.0
X-Provags-ID: V03:K0:53zy9cNCQzDcTzI1BkQWVcgN5g4Gaay/iPSi0+crVToHVm6VhTm
 RVHhe6XHPSpBOkRKb+SQamUxo/g71U/KgJkF27MNnqxkGmEWfL7tl/GfPh60TVhMLnoUNHX
 9Zx2oqwrmnbvmP1rOgP01TFm1GkVLLi+CHyiK2yexjGtkpZ9ug92Q36bmzmzLPkXe2sD9Oi
 56ElupK2DPEPidOpBdoZQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250524>

The array header is defined as:

	static const char *header[MAX_HDR_PARSED] = {
	     "From","Subject","Date",
	};

When looking for the index of a specfic string in that array, simply
use strcmp() instead of memcmp().  This avoids running over the end of
the string (e.g. with memcmp("Subject", "From", 7)) and gets rid of
magic string length constants.

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
This is a minimal fix.  A good question, however, would be: Why do we
keep on looking up constant strings in a (short) constant string array
anyway?

 builtin/mailinfo.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/builtin/mailinfo.c b/builtin/mailinfo.c
index 2c3cd8e..cf11c8d 100644
--- a/builtin/mailinfo.c
+++ b/builtin/mailinfo.c
@@ -334,7 +334,7 @@ static int check_header(const struct strbuf *line,
 	}
 	if (starts_with(line->buf, "[PATCH]") && isspace(line->buf[7])) {
 		for (i = 0; header[i]; i++) {
-			if (!memcmp("Subject", header[i], 7)) {
+			if (!strcmp("Subject", header[i])) {
 				handle_header(&hdr_data[i], line);
 				ret = 1;
 				goto check_header_out;
@@ -929,13 +929,13 @@ static void handle_info(void)
 		else
 			continue;
 
-		if (!memcmp(header[i], "Subject", 7)) {
+		if (!strcmp(header[i], "Subject")) {
 			if (!keep_subject) {
 				cleanup_subject(hdr);
 				cleanup_space(hdr);
 			}
 			output_header_lines(fout, "Subject", hdr);
-		} else if (!memcmp(header[i], "From", 4)) {
+		} else if (!strcmp(header[i], "From")) {
 			cleanup_space(hdr);
 			handle_from(hdr);
 			fprintf(fout, "Author: %s\n", name.buf);
-- 
2.0.0
