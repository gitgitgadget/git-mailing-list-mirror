From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 7/5] pretty: %G[?GS] placeholders
Date: Fri, 21 Oct 2011 22:01:56 -0700
Message-ID: <7v7h3x7h6j.fsf_-_@alter.siamese.dyndns.org>
References: <1318983645-18897-1-git-send-email-gitster@pobox.com>
 <1319071023-31919-1-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 22 07:07:56 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RHToI-0005se-GF
	for gcvg-git-2@lo.gmane.org; Sat, 22 Oct 2011 07:07:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752111Ab1JVFCB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Oct 2011 01:02:01 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55310 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751951Ab1JVFCA (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Oct 2011 01:02:00 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5F2B72879;
	Sat, 22 Oct 2011 01:01:59 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=+sbP8cN+YzBLjhoEX1jevF/XT+E=; b=lwcGsN
	LwJpf2yuebM2tH6xhuSKPFyk9c0WdriWZDiHraZKo/0Gmsp7+Amlps5Z4AjbWF89
	SkiDYmu28VcXZYUg5oF926qJmxfH2mhjx+om8cbtjZ8d7zQ3B8gi8TbiFLwOVRH/
	JKgFlW6CZXrV9bdgtyRlHAmL0545wSBVaeoD4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=jv8GpYuAU9xlUxUmxkRu//1WUqhIqqw7
	YZmw0MAVg1SPNqKblPhptmGJwLVRU2s9oD+S3ElJN+OPjqmXjjbPp57TRtwZCoow
	PPvMbYoLgLUmP66TZaPvzw9F/jV5xBDUO/cMqcTu11el1MCCUikhsSiQbNrSfSbW
	QRCNe9pFLLQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 556992878;
	Sat, 22 Oct 2011 01:01:59 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DD10F2877; Sat, 22 Oct 2011
 01:01:57 -0400 (EDT)
In-Reply-To: <1319071023-31919-1-git-send-email-gitster@pobox.com> (Junio C.
 Hamano's message of "Wed, 19 Oct 2011 17:36:58 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F808885A-FC6A-11E0-BBBD-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184096>

Add new placeholders related to the GPG signature on signed commits.

 - %GG to show the raw verification message from GPG;
 - %G? to show either "G" for Good, "B" for Bad;
 - %GS to show the name of the signer.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 * The 6th is the one that works with a bogus commit with NUL in it I sent
   out previously.

   This concludes the series; I'll leave the design and implementation of
   other useful placeholders to the list for now.

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
1.7.7.555.g02edb3
