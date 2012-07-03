From: katsu <gkatsu.ne@gmail.com>
Subject: [PATCH] Fix Q-encoded multi-octet-char split in email.
Date: Tue,  3 Jul 2012 10:41:37 +0900
Message-ID: <1341279697-4596-1-git-send-email-gkatsu.ne@gmail.com>
Cc: katsu <gkatsu.ne@gmail.com>,
	Takeharu Katsuyama <tkatsu.ne@gmail.com>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Tue Jul 03 03:50:29 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SlsFz-0002Rp-Qw
	for gcvg-git-2@plane.gmane.org; Tue, 03 Jul 2012 03:50:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933317Ab2GCBuP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Jul 2012 21:50:15 -0400
Received: from mx2.avis.ne.jp ([202.247.192.54]:44738 "EHLO mx2.avis.ne.jp"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932139Ab2GCBuM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Jul 2012 21:50:12 -0400
X-Greylist: delayed 506 seconds by postgrey-1.27 at vger.kernel.org; Mon, 02 Jul 2012 21:50:12 EDT
Received: from negw.ne.njrc.co.jp (f219-42.ip.avis.ne.jp [202.247.219.42])
	by mx2.avis.ne.jp (Postfix) with ESMTP id 0D1B97814A;
	Tue,  3 Jul 2012 10:41:44 +0900 (JST)
Received: from alpha.ne.njrc.co.jp
       (alpha.ne.njrc.co.jp [172.19.33.7])
       by negw.ne.njrc.co.jp (unknown) with ESMTP id q631fhKT003843;
       Tue, 3 Jul 2012 10:41:43 +0900
Received: from localhost (pce-224.ne.njrc.co.jp [172.19.33.224])
	by alpha.ne.njrc.co.jp (Postfix) with ESMTP id 2532760B62;
	Tue,  3 Jul 2012 10:41:43 +0900 (JST)
X-Mailer: git-send-email 1.7.9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200891>

Issue: Email subject written in multi-octet language like japanese cannot
be displayed in correct at destinations's email client, because the
Q-encoded subject which is longer than 78 octets is split by a octet not by
a character at line breaks.
e.g.)
   "=?utf-8?q? [PATCH] ... =E8=83=86=E8=81=A9?="
                    |
                    V
   "=?utf-8?q? [PATCH] ... =E8=83=86=E8?="
   "=?utf-8?q?=81=A9=?"

Changes: Add a judge if a character is an part of utf-8 muti-octet, and
split the characters by a character not by a octet at line breaks in
function add_rfc2407() in pretty.c. Like following.

   "=?utf-8?q? [PATCH] ... =E8=83=86?="
   "=?utf-8?q?=E8=81=A9=?"

Signed-off-by: Takeharu Katsuyama <tkatsu.ne@gmail.com>
---
 pretty.c |   29 ++++++++++++++++++++++++++++-
 1 files changed, 28 insertions(+), 1 deletions(-)
 mode change 100644 => 100755 pretty.c

diff --git a/pretty.c b/pretty.c
old mode 100644
new mode 100755
index 8b1ea9f..266a8fe
--- a/pretty.c
+++ b/pretty.c
@@ -272,6 +272,12 @@ static void add_rfc2047(struct strbuf *sb, const char *line, int len,
 	static const int max_length = 78; /* per rfc2822 */
 	int i;
 	int line_len;
+	int utf_ctr, use_utf;
+
+	if (!strcmp(encoding, "UTF-8") || !strcmp(encoding, "utf-8"))
+		use_utf = 1;
+	else
+		use_utf = 0;
 
 	/* How many bytes are already used on the current line? */
 	for (i = sb->len - 1; i >= 0; i--)
@@ -293,10 +299,31 @@ needquote:
 	strbuf_grow(sb, len * 3 + strlen(encoding) + 100);
 	strbuf_addf(sb, "=?%s?q?", encoding);
 	line_len += strlen(encoding) + 5; /* 5 for =??q? */
+	utf_ctr = 0;
 	for (i = 0; i < len; i++) {
 		unsigned ch = line[i] & 0xFF;
 
-		if (line_len >= max_length - 2) {
+		/*
+		 * Judge if it is an utf-8 char, to avoid inserting newline
+		 * in the middle of utf-8 char code.
+		 */
+		if (use_utf) {
+			if (ch >= 0xC2 && ch <= 0xDF)	/* 1'st byte of 2-bytes utf-8 */
+				utf_ctr = 1;
+			else if (ch >= 0xE0 && ch <= 0xEF)	/*  3-bytes utf-8 */
+				utf_ctr = 2;
+			else if (ch >= 0xF0 && ch <= 0xF7)	/*  4-bytes utf-8 */
+				utf_ctr = 3;
+			else if (ch >= 0xF8 && ch <= 0xFB)	/*  5-bytes utf-8 */
+				utf_ctr = 4;
+			else if (ch >= 0xFC && ch <= 0xFD)	/*  6-bytes utf-8 */
+				utf_ctr = 5;
+			else if (ch >= 0x80 && ch <= 0xBF)  /* 2'nd to 6'th byte of utf-8 */
+				utf_ctr--;
+			else
+				utf_ctr = 0;
+		}
+		if (line_len >= (max_length - 2 - utf_ctr *3)) {
 			strbuf_addf(sb, "?=\n =?%s?q?", encoding);
 			line_len = strlen(encoding) + 5 + 1; /* =??q? plus SP */
 		}
-- 
1.7.9
