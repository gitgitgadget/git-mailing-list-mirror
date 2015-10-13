From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 09/26] mailinfo: move keep_subject & keep_non_patch_bracket to struct mailinfo
Date: Tue, 13 Oct 2015 16:16:30 -0700
Message-ID: <1444778207-859-10-git-send-email-gitster@pobox.com>
References: <1444778207-859-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 14 01:18:05 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zm8pW-00070K-RN
	for gcvg-git-2@plane.gmane.org; Wed, 14 Oct 2015 01:18:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753366AbbJMXRW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Oct 2015 19:17:22 -0400
Received: from mail-pa0-f44.google.com ([209.85.220.44]:33250 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752218AbbJMXRB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Oct 2015 19:17:01 -0400
Received: by pabrc13 with SMTP id rc13so34526125pab.0
        for <git@vger.kernel.org>; Tue, 13 Oct 2015 16:17:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:subject:date:message-id:in-reply-to:references;
        bh=GbXQEVQwOk3QGL2WZ0jRWcBqC+e8XUgMKmhnabp82qY=;
        b=dn9T2ZlAMU/ZEVi8fVUzZueciYn6aR30Pr4yz+laUpvo9715PsCGk3x9PZ2+i8H28o
         jbIVczicwbwWYM37ApOhb+xAP+A0KDs6yx1nKTbMvWZsmzXVGQL27ZvOrJvJO4bwJzXy
         gmbpo5wZ38ggelAR5fn43QTuW9i6C8erQnfB9E9ird4l4ixJ5JR8fSVRgGfyIsrbOvKx
         AfQGnsAYeqFM4qr0pYCySwwWaEgXSNWWstzPQsHv9K7H7cCVx4VUFy7nLd/OPKHv4NB+
         mBDOQgzKNDqtbHa1i2gyvhK8pPnEZrbPgczfqGU0bmHHTwLah8+RGkpMA1vWRByXyrx7
         g/WQ==
X-Received: by 10.66.158.100 with SMTP id wt4mr15579pab.31.1444778220566;
        Tue, 13 Oct 2015 16:17:00 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:45f3:915b:d2ba:37bc])
        by smtp.gmail.com with ESMTPSA id d13sm5843989pbu.20.2015.10.13.16.16.59
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 13 Oct 2015 16:17:00 -0700 (PDT)
X-Mailer: git-send-email 2.6.1-320-g86a1181
In-Reply-To: <1444778207-859-1-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279547>

These two are the only easy ones that do not require passing the
structure around to deep corners of the callchain.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/mailinfo.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/builtin/mailinfo.c b/builtin/mailinfo.c
index 7b61187..d642b0d 100644
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
@@ -976,8 +976,8 @@ static void handle_info(struct mailinfo *mi)
 			continue;
 
 		if (!strcmp(header[i], "Subject")) {
-			if (!keep_subject) {
-				cleanup_subject(hdr);
+			if (!mi->keep_subject) {
+				cleanup_subject(mi, hdr);
 				cleanup_space(hdr);
 			}
 			output_header_lines(fout, "Subject", hdr);
@@ -1071,9 +1071,9 @@ int cmd_mailinfo(int argc, const char **argv, const char *prefix)
 
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
2.6.1-320-g86a1181
