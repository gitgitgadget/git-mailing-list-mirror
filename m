From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 23/31] mailinfo: move content/content_top to struct mailinfo
Date: Wed, 14 Oct 2015 13:45:49 -0700
Message-ID: <1444855557-2127-24-git-send-email-gitster@pobox.com>
References: <1444778207-859-1-git-send-email-gitster@pobox.com>
 <1444855557-2127-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 14 22:48:15 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZmSy6-0003Fh-B1
	for gcvg-git-2@plane.gmane.org; Wed, 14 Oct 2015 22:48:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932105AbbJNUsK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Oct 2015 16:48:10 -0400
Received: from mail-pa0-f52.google.com ([209.85.220.52]:34042 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932268AbbJNUq2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Oct 2015 16:46:28 -0400
Received: by payp3 with SMTP id p3so16211971pay.1
        for <git@vger.kernel.org>; Wed, 14 Oct 2015 13:46:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:subject:date:message-id:in-reply-to:references;
        bh=bmu2aE1uuLIOS5ew95oR7V0dSYWXgig6oqjYXtpTcJA=;
        b=geKeMwihCW8Cs6FGBXb4morl6HdXNpbAUbAeUQ0z0GlguXETgwwj1fetLCu7fH0ci3
         3TpQZ9SEOKU11H1PjqUOCPZ4yvZjjNgkdnunzqCioB64v/soqXlQsg2DgSA0rrHIv1Mo
         8KouLYuXFpz0W55iI0NlKf+TnN3PovrunFcdJLTy4wyez7tcYVdu9Dpz0/2OauR9qFlF
         T8woBebZvqsDTIwB7JCXIoocRpz3i8N1Vi02i517mbg0uprsX/42KnvkVg3dOxm99Bo3
         11U0gOnmY44ZyE7n7iUwRp3n6p8NS75yl8518Eve5+M8+BB/xxnxE3UVMOo2QQSge9Pd
         bqCA==
X-Received: by 10.68.173.130 with SMTP id bk2mr5729967pbc.169.1444855588029;
        Wed, 14 Oct 2015 13:46:28 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:7964:41eb:7b4:cd77])
        by smtp.gmail.com with ESMTPSA id xz5sm11294450pbb.12.2015.10.14.13.46.27
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 14 Oct 2015 13:46:27 -0700 (PDT)
X-Mailer: git-send-email 2.6.1-320-g86a1181
In-Reply-To: <1444855557-2127-1-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279616>

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/mailinfo.c | 45 ++++++++++++++++++++++++++-------------------
 1 file changed, 26 insertions(+), 19 deletions(-)

diff --git a/builtin/mailinfo.c b/builtin/mailinfo.c
index 72668c9..138ca3b 100644
--- a/builtin/mailinfo.c
+++ b/builtin/mailinfo.c
@@ -7,6 +7,8 @@
 #include "utf8.h"
 #include "strbuf.h"
 
+#define MAX_BOUNDARIES 5
+
 struct mailinfo {
 	FILE *input;
 	FILE *output;
@@ -21,6 +23,8 @@ struct mailinfo {
 	int use_inbody_headers; /* defaults to 1 */
 	const char *metainfo_charset;
 
+	struct strbuf *content[MAX_BOUNDARIES];
+	struct strbuf **content_top;
 	struct strbuf charset;
 	char *message_id;
 	enum  {
@@ -36,7 +40,6 @@ struct mailinfo {
 };
 
 #define MAX_HDR_PARSED 10
-#define MAX_BOUNDARIES 5
 
 static void cleanup_space(struct strbuf *sb);
 
@@ -181,10 +184,6 @@ static int slurp_attr(const char *line, const char *name, struct strbuf *attr)
 	return 1;
 }
 
-static struct strbuf *content[MAX_BOUNDARIES];
-
-static struct strbuf **content_top = content;
-
 static void handle_content_type(struct mailinfo *mi, struct strbuf *line)
 {
 	struct strbuf *boundary = xmalloc(sizeof(struct strbuf));
@@ -192,11 +191,11 @@ static void handle_content_type(struct mailinfo *mi, struct strbuf *line)
 
 	if (slurp_attr(line->buf, "boundary=", boundary)) {
 		strbuf_insert(boundary, 0, "--", 2);
-		if (++content_top >= &content[MAX_BOUNDARIES]) {
+		if (++mi->content_top >= &mi->content[MAX_BOUNDARIES]) {
 			fprintf(stderr, "Too many boundaries to handle\n");
 			exit(1);
 		}
-		*content_top = boundary;
+		*(mi->content_top) = boundary;
 		boundary = NULL;
 	}
 	slurp_attr(line->buf, "charset=", &mi->charset);
@@ -224,10 +223,12 @@ static void handle_content_transfer_encoding(struct mailinfo *mi,
 		mi->transfer_encoding = TE_DONTCARE;
 }
 
-static int is_multipart_boundary(const struct strbuf *line)
+static int is_multipart_boundary(struct mailinfo *mi, const struct strbuf *line)
 {
-	return (((*content_top)->len <= line->len) &&
-		!memcmp(line->buf, (*content_top)->buf, (*content_top)->len));
+	struct strbuf *content_top = *(mi->content_top);
+
+	return ((content_top->len <= line->len) &&
+		!memcmp(line->buf, content_top->buf, content_top->len));
 }
 
 static void cleanup_subject(struct mailinfo *mi, struct strbuf *subject)
@@ -796,7 +797,7 @@ static void handle_filter(struct mailinfo *mi, struct strbuf *line)
 static int find_boundary(struct mailinfo *mi, struct strbuf *line)
 {
 	while (!strbuf_getline(line, mi->input, '\n')) {
-		if (*content_top && is_multipart_boundary(line))
+		if (*(mi->content_top) && is_multipart_boundary(mi, line))
 			return 1;
 	}
 	return 0;
@@ -808,18 +809,18 @@ static int handle_boundary(struct mailinfo *mi, struct strbuf *line)
 
 	strbuf_addch(&newline, '\n');
 again:
-	if (line->len >= (*content_top)->len + 2 &&
-	    !memcmp(line->buf + (*content_top)->len, "--", 2)) {
+	if (line->len >= (*(mi->content_top))->len + 2 &&
+	    !memcmp(line->buf + (*(mi->content_top))->len, "--", 2)) {
 		/* we hit an end boundary */
 		/* pop the current boundary off the stack */
-		strbuf_release(*content_top);
-		free(*content_top);
-		*content_top = NULL;
+		strbuf_release(*(mi->content_top));
+		free(*(mi->content_top));
+		*(mi->content_top) = NULL;
 
 		/* technically won't happen as is_multipart_boundary()
 		   will fail first.  But just in case..
 		 */
-		if (--content_top < content) {
+		if (--mi->content_top < mi->content) {
 			fprintf(stderr, "Detected mismatched boundaries, "
 					"can't recover\n");
 			exit(1);
@@ -854,14 +855,14 @@ static void handle_body(struct mailinfo *mi, struct strbuf *line)
 	struct strbuf prev = STRBUF_INIT;
 
 	/* Skip up to the first boundary */
-	if (*content_top) {
+	if (*(mi->content_top)) {
 		if (!find_boundary(mi, line))
 			goto handle_body_out;
 	}
 
 	do {
 		/* process any boundary lines */
-		if (*content_top && is_multipart_boundary(line)) {
+		if (*(mi->content_top) && is_multipart_boundary(mi, line)) {
 			/* flush any leftover */
 			if (prev.len) {
 				handle_filter(mi, &prev);
@@ -1029,6 +1030,7 @@ static void setup_mailinfo(struct mailinfo *mi)
 	strbuf_init(&mi->log_message, 0);
 	mi->header_stage = 1;
 	mi->use_inbody_headers = 1;
+	mi->content_top = mi->content;
 	git_config(git_mailinfo_config, &mi);
 }
 
@@ -1038,6 +1040,11 @@ static void clear_mailinfo(struct mailinfo *mi)
 	strbuf_release(&mi->email);
 	strbuf_release(&mi->charset);
 	strbuf_release(&mi->log_message);
+
+	while (mi->content < mi->content_top) {
+		free(*(mi->content_top));
+		mi->content_top--;
+	}
 }
 
 static const char mailinfo_usage[] =
-- 
2.6.1-320-g86a1181
