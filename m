From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 24/34] mailinfo: move content/content_top to struct mailinfo
Date: Mon, 19 Oct 2015 00:28:41 -0700
Message-ID: <1445239731-10677-25-git-send-email-gitster@pobox.com>
References: <1444855557-2127-1-git-send-email-gitster@pobox.com>
 <1445239731-10677-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 19 09:30:14 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zo4tZ-0003DY-8J
	for gcvg-git-2@plane.gmane.org; Mon, 19 Oct 2015 09:30:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753234AbbJSHaG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Oct 2015 03:30:06 -0400
Received: from mail-pa0-f53.google.com ([209.85.220.53]:34956 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752892AbbJSH3X (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Oct 2015 03:29:23 -0400
Received: by pasz6 with SMTP id z6so22266196pas.2
        for <git@vger.kernel.org>; Mon, 19 Oct 2015 00:29:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:subject:date:message-id:in-reply-to:references;
        bh=w2ky6p9dTlEPgLrE6B6jXrWsT5Y+k2wrQpcPUog2/xo=;
        b=i7HA/jl0O8EB3yfvrplIafPQRazBSGPubgbOBkWytB7zBXyvky9H+/mnMa4Nh2NCKV
         cPPB0E8ez3S78FcJ9a4/hCgxr3n2BFi4bgqqoR3H0iZKPzKbeUjj0cG18PNiF6HzRBOz
         t7bQNZoIxk4Hiz8LO0/DINRC4JQ/8QDxvsFa6vjPbTU0gp5swIcDyTvnYe5v/9frdL1Z
         aaAoHsvmoZ6FsRf52jXw6wlwJ+R2kBBwKU98v533mDACnBll6M0gXIA2LMt3lcXPiRi9
         rWVsOG8+XjAL8Zwp/lAn5w4lWl6DXKu5h6dvOfE8VU+2GjeTC+KhfU7CKM8WmxNtSzd/
         osFw==
X-Received: by 10.69.26.101 with SMTP id ix5mr33014199pbd.144.1445239762598;
        Mon, 19 Oct 2015 00:29:22 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:f5db:ee54:4f5:9373])
        by smtp.gmail.com with ESMTPSA id kw10sm34498997pbc.25.2015.10.19.00.29.22
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 19 Oct 2015 00:29:22 -0700 (PDT)
X-Mailer: git-send-email 2.6.2-388-g10c4a0e
In-Reply-To: <1445239731-10677-1-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279855>

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/mailinfo.c | 45 ++++++++++++++++++++++++++-------------------
 1 file changed, 26 insertions(+), 19 deletions(-)

diff --git a/builtin/mailinfo.c b/builtin/mailinfo.c
index 2c194da..ec65805 100644
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
@@ -22,6 +24,8 @@ struct mailinfo {
 	int use_inbody_headers; /* defaults to 1 */
 	const char *metainfo_charset;
 
+	struct strbuf *content[MAX_BOUNDARIES];
+	struct strbuf **content_top;
 	struct strbuf charset;
 	char *message_id;
 	enum  {
@@ -35,7 +39,6 @@ struct mailinfo {
 };
 
 #define MAX_HDR_PARSED 10
-#define MAX_BOUNDARIES 5
 
 static void cleanup_space(struct strbuf *sb);
 
@@ -180,10 +183,6 @@ static int slurp_attr(const char *line, const char *name, struct strbuf *attr)
 	return 1;
 }
 
-static struct strbuf *content[MAX_BOUNDARIES];
-
-static struct strbuf **content_top = content;
-
 static void handle_content_type(struct mailinfo *mi, struct strbuf *line)
 {
 	struct strbuf *boundary = xmalloc(sizeof(struct strbuf));
@@ -191,11 +190,11 @@ static void handle_content_type(struct mailinfo *mi, struct strbuf *line)
 
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
@@ -223,10 +222,12 @@ static void handle_content_transfer_encoding(struct mailinfo *mi,
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
@@ -799,7 +800,7 @@ static void handle_filter(struct mailinfo *mi, struct strbuf *line)
 static int find_boundary(struct mailinfo *mi, struct strbuf *line)
 {
 	while (!strbuf_getline(line, mi->input, '\n')) {
-		if (*content_top && is_multipart_boundary(line))
+		if (*(mi->content_top) && is_multipart_boundary(mi, line))
 			return 1;
 	}
 	return 0;
@@ -811,18 +812,18 @@ static int handle_boundary(struct mailinfo *mi, struct strbuf *line)
 
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
@@ -857,14 +858,14 @@ static void handle_body(struct mailinfo *mi, struct strbuf *line)
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
@@ -1028,6 +1029,7 @@ static void setup_mailinfo(struct mailinfo *mi)
 	strbuf_init(&mi->charset, 0);
 	mi->header_stage = 1;
 	mi->use_inbody_headers = 1;
+	mi->content_top = mi->content;
 	git_config(git_mailinfo_config, &mi);
 }
 
@@ -1046,6 +1048,11 @@ static void clear_mailinfo(struct mailinfo *mi)
 	for (i = 0; mi->s_hdr_data[i]; i++)
 		strbuf_release(mi->s_hdr_data[i]);
 	free(mi->s_hdr_data);
+
+	while (mi->content < mi->content_top) {
+		free(*(mi->content_top));
+		mi->content_top--;
+	}
 }
 
 static const char mailinfo_usage[] =
-- 
2.6.2-383-g144b2e6
