From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 06/13] rerere: drop want_sp parameter from is_cmarker()
Date: Tue, 30 Jun 2015 23:04:52 -0700
Message-ID: <1435730699-9124-7-git-send-email-gitster@pobox.com>
References: <1435730699-9124-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 01 08:05:34 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZAB9J-0004LR-CH
	for gcvg-git-2@plane.gmane.org; Wed, 01 Jul 2015 08:05:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750768AbbGAGF0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Jul 2015 02:05:26 -0400
Received: from mail-ig0-f177.google.com ([209.85.213.177]:36790 "EHLO
	mail-ig0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752567AbbGAGFL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Jul 2015 02:05:11 -0400
Received: by igrv9 with SMTP id v9so67146060igr.1
        for <git@vger.kernel.org>; Tue, 30 Jun 2015 23:05:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:subject:date:message-id:in-reply-to:references;
        bh=eKAiA7a4wTWKvKSDw+gT+ocPa26UfpkwKEImqDcL2ms=;
        b=qfMuDzDAB8r+68EW39QbDjIz7vZYi+/bb5tvNAY9Z08meaJfphCpExJd28Ilr8Ri5g
         dE5x+GqxzYWO90/wdauv8nVgYdm5Sg+tmVuTsx2zcl2oHXjpvQFkmW2IY+l02xImiUmv
         oqPD5/X0415sW6xTUPF0m9IXpesDVW2cgZBfT52phHXl7pRYC0XnsoQiX4c1OpbBkrwN
         t2CnmemL+jtYPHvCgRWtgOqXqTwMm8LhTM/OBpg0vof6/zMypf89hJ8unsxeYhmYyZ02
         +fc7HCX+8O4biqmCE14+z8+z4l5FbAcoTMSqrz+H5yzZJi6Af5lGGTp5GRA2s8mZvVfy
         qHwA==
X-Received: by 10.43.171.202 with SMTP id nv10mr1876100icc.30.1435730709488;
        Tue, 30 Jun 2015 23:05:09 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:502c:1da0:e16d:2d77])
        by mx.google.com with ESMTPSA id m92sm666472ioi.41.2015.06.30.23.05.08
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 30 Jun 2015 23:05:08 -0700 (PDT)
X-Mailer: git-send-email 2.5.0-rc0-209-g5e1f148
In-Reply-To: <1435730699-9124-1-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273123>

As the nature of the conflict marker line determies if there should
a SP and label after it, the caller shouldn't have to pass the
parameter redundantly.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 rerere.c | 27 ++++++++++++++++++++++-----
 1 file changed, 22 insertions(+), 5 deletions(-)

diff --git a/rerere.c b/rerere.c
index 304df02..4c45f55 100644
--- a/rerere.c
+++ b/rerere.c
@@ -148,8 +148,25 @@ static int rerere_file_getline(struct strbuf *sb, struct rerere_io *io_)
 	return strbuf_getwholeline(sb, io->input, '\n');
 }
 
-static int is_cmarker(char *buf, int marker_char, int marker_size, int want_sp)
+/*
+ * Require the exact number of conflict marker letters, no more, no
+ * less, followed by SP or any whitespace
+ * (including LF).
+ */
+static int is_cmarker(char *buf, int marker_char, int marker_size)
 {
+	int want_sp;
+
+	/*
+	 * The beginning of our version and the end of their version
+	 * always are labeled like "<<<<< ours" or ">>>>> theirs",
+	 * hence we set want_sp for them.  Note that the version from
+	 * the common ancestor in diff3-style output is not always
+	 * labelled (e.g. "||||| common" is often seen but "|||||"
+	 * alone is also valid), so we do not set want_sp.
+	 */
+	want_sp = (marker_char == '<') || (marker_char == '>');
+
 	while (marker_size--)
 		if (*buf++ != marker_char)
 			return 0;
@@ -172,19 +189,19 @@ static int handle_path(unsigned char *sha1, struct rerere_io *io, int marker_siz
 		git_SHA1_Init(&ctx);
 
 	while (!io->getline(&buf, io)) {
-		if (is_cmarker(buf.buf, '<', marker_size, 1)) {
+		if (is_cmarker(buf.buf, '<', marker_size)) {
 			if (hunk != RR_CONTEXT)
 				goto bad;
 			hunk = RR_SIDE_1;
-		} else if (is_cmarker(buf.buf, '|', marker_size, 0)) {
+		} else if (is_cmarker(buf.buf, '|', marker_size)) {
 			if (hunk != RR_SIDE_1)
 				goto bad;
 			hunk = RR_ORIGINAL;
-		} else if (is_cmarker(buf.buf, '=', marker_size, 0)) {
+		} else if (is_cmarker(buf.buf, '=', marker_size)) {
 			if (hunk != RR_SIDE_1 && hunk != RR_ORIGINAL)
 				goto bad;
 			hunk = RR_SIDE_2;
-		} else if (is_cmarker(buf.buf, '>', marker_size, 1)) {
+		} else if (is_cmarker(buf.buf, '>', marker_size)) {
 			if (hunk != RR_SIDE_2)
 				goto bad;
 			if (strbuf_cmp(&one, &two) > 0)
-- 
2.5.0-rc0-209-g5e1f148
