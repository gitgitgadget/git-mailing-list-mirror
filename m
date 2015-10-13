From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 22/26] mailinfo: move content/content_top to struct mailinfo
Date: Tue, 13 Oct 2015 16:16:43 -0700
Message-ID: <1444778207-859-23-git-send-email-gitster@pobox.com>
References: <1444778207-859-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 14 01:18:15 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zm8pi-00079E-4S
	for gcvg-git-2@plane.gmane.org; Wed, 14 Oct 2015 01:18:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753416AbbJMXSL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Oct 2015 19:18:11 -0400
Received: from mail-pa0-f46.google.com ([209.85.220.46]:36200 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752092AbbJMXRQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Oct 2015 19:17:16 -0400
Received: by pacex6 with SMTP id ex6so34354184pac.3
        for <git@vger.kernel.org>; Tue, 13 Oct 2015 16:17:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:subject:date:message-id:in-reply-to:references;
        bh=CKxPO+0nLrzPNkFqAK7bYQTujCZKAr9qvU2UlgTlR6Y=;
        b=jO4b7z9M5ihCLpCt8L2EMtX8P2x0k4NMzg6rbjXyXyw6Dd2rcwip3DFNUOGdqFGmKg
         jh2ZEU1g7jVAuhBJMrsJkWrqvHF2PFktxQSDkUmD3Tuv2haYlO3xyIstJBFLZE2drkOB
         JmnkKFbwrQhQOUBUvNOT6FkY5+F1PSDW+gIOBUPRqaJ+OUD7mgjxs9ligUcPXoAaqG64
         2v++boDheFAQMtV4QjKnH2vg8r02XcDd6t6tby6fjY4dLSRC+DBS4UZN8r56RcP7iPdt
         Jc6EOWXUO6nwmBEw19wRRmUsp1g1LQ8+zKCtgWdBXVr3iQJf7rWWIj6F8ku2/j5O22HR
         Nxyw==
X-Received: by 10.68.184.162 with SMTP id ev2mr43323193pbc.109.1444778235426;
        Tue, 13 Oct 2015 16:17:15 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:45f3:915b:d2ba:37bc])
        by smtp.gmail.com with ESMTPSA id aw5sm5848212pbc.13.2015.10.13.16.17.14
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 13 Oct 2015 16:17:14 -0700 (PDT)
X-Mailer: git-send-email 2.6.1-320-g86a1181
In-Reply-To: <1444778207-859-1-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279551>

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/mailinfo.c | 45 ++++++++++++++++++++++++++-------------------
 1 file changed, 26 insertions(+), 19 deletions(-)

diff --git a/builtin/mailinfo.c b/builtin/mailinfo.c
index d38d716..4b9b1cc 100644
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
@@ -825,7 +826,7 @@ static void handle_filter(struct mailinfo *mi, struct strbuf *line)
 static int find_boundary(struct mailinfo *mi, struct strbuf *line)
 {
 	while (!strbuf_getline(line, mi->input, '\n')) {
-		if (*content_top && is_multipart_boundary(line))
+		if (*(mi->content_top) && is_multipart_boundary(mi, line))
 			return 1;
 	}
 	return 0;
@@ -837,18 +838,18 @@ static int handle_boundary(struct mailinfo *mi, struct strbuf *line)
 
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
@@ -883,14 +884,14 @@ static void handle_body(struct mailinfo *mi, struct strbuf *line)
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
@@ -1057,6 +1058,7 @@ static void setup_mailinfo(struct mailinfo *mi)
 	strbuf_init(&mi->log_message, 0);
 	mi->header_stage = 1;
 	mi->use_inbody_headers = 1;
+	mi->content_top = mi->content;
 	git_config(git_mailinfo_config, &mi);
 }
 
@@ -1066,6 +1068,11 @@ static void clear_mailinfo(struct mailinfo *mi)
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
