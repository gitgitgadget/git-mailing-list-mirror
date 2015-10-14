From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 10/31] mailinfo: move keep_subject & keep_non_patch_bracket to struct mailinfo
Date: Wed, 14 Oct 2015 13:45:36 -0700
Message-ID: <1444855557-2127-11-git-send-email-gitster@pobox.com>
References: <1444778207-859-1-git-send-email-gitster@pobox.com>
 <1444855557-2127-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 14 22:47:21 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZmSxE-0002Kx-J8
	for gcvg-git-2@plane.gmane.org; Wed, 14 Oct 2015 22:47:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932893AbbJNUqe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Oct 2015 16:46:34 -0400
Received: from mail-pa0-f53.google.com ([209.85.220.53]:35308 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932382AbbJNUqM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Oct 2015 16:46:12 -0400
Received: by padcn9 with SMTP id cn9so32992839pad.2
        for <git@vger.kernel.org>; Wed, 14 Oct 2015 13:46:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:subject:date:message-id:in-reply-to:references;
        bh=RPEX0NbJMrh7A0X+tIMMlQV9vV3fqGKIJQzsFDbtGmQ=;
        b=td1hlJyew7+095eXMKNBOfcapv1QtlAuAjBZqysRRanAAhB51xQc+E87qbHeOzOv9v
         e2ND/YPQF9SAkFmrigyn++BrtU1DNcK+UzE5DvdU8u2fG/CEm4e71QsqJgLFI07BrH2k
         zLjosJC58ClsWMeTXpSqTDe+SVimcU6WmEQE+X8JijZKKKc7Z/tGR7uCq0tdlGA/prmf
         BN5WEh3sr4BZMJ51PFTIShBA+9KbnXmQ/5i8XI87BmRgpyt+oWeiDGqrXoO9fhfUczgP
         5wfUDitscqFy5w5xtWUMnOME4uctVPe04Q29l9FP3MZnXHIs6c/q2bMey+erfhWU40lk
         mtoQ==
X-Received: by 10.68.111.3 with SMTP id ie3mr5701539pbb.63.1444855571881;
        Wed, 14 Oct 2015 13:46:11 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:7964:41eb:7b4:cd77])
        by smtp.gmail.com with ESMTPSA id bh4sm11266443pbb.62.2015.10.14.13.46.11
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 14 Oct 2015 13:46:11 -0700 (PDT)
X-Mailer: git-send-email 2.6.1-320-g86a1181
In-Reply-To: <1444855557-2127-1-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279604>

These two are the only easy ones that do not require passing the
structure around to deep corners of the callchain.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/mailinfo.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/builtin/mailinfo.c b/builtin/mailinfo.c
index 9e41a10..855d813 100644
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
@@ -1044,9 +1044,9 @@ int cmd_mailinfo(int argc, const char **argv, const char *prefix)
 
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
