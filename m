From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 17/17] pretty: %G[?GS] placeholders
Date: Tue,  8 Nov 2011 17:02:03 -0800
Message-ID: <1320800523-5407-18-git-send-email-gitster@pobox.com>
References: <1320800523-5407-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 09 02:02:57 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RNwZ5-0003z8-Cn
	for gcvg-git-2@lo.gmane.org; Wed, 09 Nov 2011 02:02:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755552Ab1KIBCu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Nov 2011 20:02:50 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36725 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754814Ab1KIBCn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Nov 2011 20:02:43 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 232955BB0
	for <git@vger.kernel.org>; Tue,  8 Nov 2011 20:02:43 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=0/xC
	foK4jAF+oFRCRqDYpaKpeN4=; b=Tw6iwtx8Z1O8r4VgElzd5o4+8iRmzZqno8/f
	guf6HYcTuzjdlU8T+8cklp4bfIiFJxJhb8He5zptv7O2yicYcOY1Wd8janC0duVK
	EFaYCUBOSTJBTE6WbZRxuZFeqR4m8aiPct7k124wdDpzyg3DwxbIt22Mh9jjb/t0
	WGqe6qo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=QsEgZs
	mnunqV96mmQ1jD79r8i5n5GFBBkvgy49NF8JKQVlS9XdmfUOnXZvNUr3VO/JTYDG
	+521ZOsTnZ3hP4PYLKiu94BPJMREHtzc0ABaOVYAdlqayMM0+b4G5HqVZ+OREQ1t
	kUc9w0vt6PJtTSSGeHyQH/0gTzKtu5nkHG3lc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1B69F5BAF
	for <git@vger.kernel.org>; Tue,  8 Nov 2011 20:02:43 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5F8B65BAE for
 <git@vger.kernel.org>; Tue,  8 Nov 2011 20:02:42 -0500 (EST)
X-Mailer: git-send-email 1.7.8.rc1.82.gde0f9
In-Reply-To: <1320800523-5407-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 86EA5A1A-0A6E-11E1-9134-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185137>

Add new placeholders related to the GPG signature on signed commits.

 - %GG to show the raw verification message from GPG;
 - %G? to show either "G" for Good, "B" for Bad;
 - %GS to show the name of the signer.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 pretty.c |   86 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 86 insertions(+), 0 deletions(-)

diff --git a/pretty.c b/pretty.c
index f45eb54..392d656 100644
--- a/pretty.c
+++ b/pretty.c
@@ -9,6 +9,7 @@
 #include "notes.h"
 #include "color.h"
 #include "reflog-walk.h"
+#include "gpg-interface.h"
 
 static char *user_format;
 static struct cmt_fmt_map {
@@ -640,6 +641,12 @@ struct format_commit_context {
 	const struct pretty_print_context *pretty_ctx;
 	unsigned commit_header_parsed:1;
 	unsigned commit_message_parsed:1;
+	unsigned commit_signature_parsed:1;
+	struct {
+		char *gpg_output;
+		char good_bad;
+		char *signer;
+	} signature;
 	char *message;
 	size_t width, indent1, indent2;
 
@@ -822,6 +829,59 @@ static void rewrap_message_tail(struct strbuf *sb,
 	c->indent2 = new_indent2;
 }
 
+static struct {
+	char result;
+	const char *check;
+} signature_check[] = {
+	{ 'G', ": Good signature from " },
+	{ 'B', ": BAD signature from " },
+};
+
+static void parse_signature_lines(struct format_commit_context *ctx)
+{
+	const char *buf = ctx->signature.gpg_output;
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(signature_check); i++) {
+		const char *found = strstr(buf, signature_check[i].check);
+		const char *next;
+		if (!found)
+			continue;
+		ctx->signature.good_bad = signature_check[i].result;
+		found += strlen(signature_check[i].check);
+		next = strchrnul(found, '\n');
+		ctx->signature.signer = xmemdupz(found, next - found);
+		break;
+	}
+}
+
+static void parse_commit_signature(struct format_commit_context *ctx)
+{
+	struct strbuf payload = STRBUF_INIT;
+	struct strbuf signature = STRBUF_INIT;
+	struct strbuf gpg_output = STRBUF_INIT;
+	int status;
+
+	ctx->commit_signature_parsed = 1;
+
+	if (parse_signed_commit(ctx->commit->object.sha1,
+				&payload, &signature) <= 0)
+		goto out;
+	status = verify_signed_buffer(payload.buf, payload.len,
+				      signature.buf, signature.len,
+				      &gpg_output);
+	if (status && !gpg_output.len)
+		goto out;
+	ctx->signature.gpg_output = strbuf_detach(&gpg_output, NULL);
+	parse_signature_lines(ctx);
+
+ out:
+	strbuf_release(&gpg_output);
+	strbuf_release(&payload);
+	strbuf_release(&signature);
+}
+
+
 static size_t format_commit_one(struct strbuf *sb, const char *placeholder,
 				void *context)
 {
@@ -974,6 +1034,30 @@ static size_t format_commit_one(struct strbuf *sb, const char *placeholder,
 		return 0;
 	}
 
+	if (placeholder[0] == 'G') {
+		if (!c->commit_signature_parsed)
+			parse_commit_signature(c);
+		switch (placeholder[1]) {
+		case 'G':
+			if (c->signature.gpg_output)
+				strbuf_addstr(sb, c->signature.gpg_output);
+			break;
+		case '?':
+			switch (c->signature.good_bad) {
+			case 'G':
+			case 'B':
+				strbuf_addch(sb, c->signature.good_bad);
+			}
+			break;
+		case 'S':
+			if (c->signature.signer)
+				strbuf_addstr(sb, c->signature.signer);
+			break;
+		}
+		return 2;
+	}
+
+
 	/* For the rest we have to parse the commit header. */
 	if (!c->commit_header_parsed)
 		parse_commit_header(c);
@@ -1114,6 +1198,8 @@ void format_commit_message(const struct commit *commit,
 
 	if (context.message != commit->buffer)
 		free(context.message);
+	free(context.signature.gpg_output);
+	free(context.signature.signer);
 }
 
 static void pp_header(const struct pretty_print_context *pp,
-- 
1.7.8.rc1.82.g90e080
