From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 12/34] mailinfo: move keep_subject & keep_non_patch_bracket to struct mailinfo
Date: Mon, 19 Oct 2015 00:28:29 -0700
Message-ID: <1445239731-10677-13-git-send-email-gitster@pobox.com>
References: <1444855557-2127-1-git-send-email-gitster@pobox.com>
 <1445239731-10677-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 19 09:29:15 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zo4sc-0002Yy-8Y
	for gcvg-git-2@plane.gmane.org; Mon, 19 Oct 2015 09:29:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752842AbbJSH3K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Oct 2015 03:29:10 -0400
Received: from mail-pa0-f49.google.com ([209.85.220.49]:33915 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752306AbbJSH3I (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Oct 2015 03:29:08 -0400
Received: by padhk11 with SMTP id hk11so21770195pad.1
        for <git@vger.kernel.org>; Mon, 19 Oct 2015 00:29:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:subject:date:message-id:in-reply-to:references;
        bh=tfgY3HwhF+zG9pelk+i4xU72DQfQujmWY6fqoNMYLXw=;
        b=wTNtq6ZRp54EDrtB6g+CqfmOfJ/o4OFMAPb1p4ot3pZvVvF/69atyFR+eYGmJxDAki
         WVsl8ziN4LFcsdHZaeIOlcqpklJe8QjIkxTCV1GD66Wwo46ShcQDWPOh3Y9zlsMUAcP4
         5tgTbhoqtP47SVNJ46dvV5LyTsLOZISVQK5NysCL6CwYIWcvyM6Ai5g3JNhr1Os4IlvY
         RvcKmlC5uOhHJkmkoRtjPAi8akvLBfqKGQPyzS6udvDXIe/s/fKj30Os903TAdw/7Wyw
         eR9UVtGVJN1zAFqG2Ds6JEX4Ak7ZeB2ddI7ckc0WJ/54hZkeCX+yA5LWGqaam+MVEBe6
         prPA==
X-Received: by 10.69.8.129 with SMTP id dk1mr4245162pbd.72.1445239748203;
        Mon, 19 Oct 2015 00:29:08 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:f5db:ee54:4f5:9373])
        by smtp.gmail.com with ESMTPSA id im9sm34497303pbc.1.2015.10.19.00.29.07
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 19 Oct 2015 00:29:07 -0700 (PDT)
X-Mailer: git-send-email 2.6.2-388-g10c4a0e
In-Reply-To: <1445239731-10677-1-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279837>

These two are the only easy ones that do not require passing the
structure around to deep corners of the callchain.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/mailinfo.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/builtin/mailinfo.c b/builtin/mailinfo.c
index e3c0c31..08c67f5 100644
--- a/builtin/mailinfo.c
+++ b/builtin/mailinfo.c
@@ -9,13 +9,13 @@
 
 static FILE *cmitmsg, *patchfile, *fin, *fout;
 
-static int keep_subject;
-static int keep_non_patch_brackets_in_subject;
 static const char *metainfo_charset;
 
 struct mailinfo {
 	struct strbuf name;
 	struct strbuf email;
+	int keep_subject;
+	int keep_non_patch_brackets_in_subject;
 };
 static char *message_id;
 
@@ -224,7 +224,7 @@ static int is_multipart_boundary(const struct strbuf *line)
 		!memcmp(line->buf, (*content_top)->buf, (*content_top)->len));
 }
 
-static void cleanup_subject(struct strbuf *subject)
+static void cleanup_subject(struct mailinfo *mi, struct strbuf *subject)
 {
 	size_t at = 0;
 
@@ -252,7 +252,7 @@ static void cleanup_subject(struct strbuf *subject)
 			if (!pos)
 				break;
 			remove = pos - subject->buf + at + 1;
-			if (!keep_non_patch_brackets_in_subject ||
+			if (!mi->keep_non_patch_brackets_in_subject ||
 			    (7 <= remove &&
 			     memmem(subject->buf + at, remove, "PATCH", 5)))
 				strbuf_remove(subject, at, remove);
@@ -947,8 +947,8 @@ static void handle_info(struct mailinfo *mi)
 			continue;
 
 		if (!strcmp(header[i], "Subject")) {
-			if (!keep_subject) {
-				cleanup_subject(hdr);
+			if (!mi->keep_subject) {
+				cleanup_subject(mi, hdr);
 				cleanup_space(hdr);
 			}
 			output_header_lines(fout, "Subject", hdr);
@@ -1051,9 +1051,9 @@ int cmd_mailinfo(int argc, const char **argv, const char *prefix)
 
 	while (1 < argc && argv[1][0] == '-') {
 		if (!strcmp(argv[1], "-k"))
-			keep_subject = 1;
+			mi.keep_subject = 1;
 		else if (!strcmp(argv[1], "-b"))
-			keep_non_patch_brackets_in_subject = 1;
+			mi.keep_non_patch_brackets_in_subject = 1;
 		else if (!strcmp(argv[1], "-m") || !strcmp(argv[1], "--message-id"))
 			add_message_id = 1;
 		else if (!strcmp(argv[1], "-u"))
-- 
2.6.2-383-g144b2e6
