From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] format_commit_message(): simplify calls to logmsg_reencode()
Date: Fri, 11 Jan 2013 14:15:09 -0800
Message-ID: <1357942509-21431-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 11 23:15:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ttmsw-0007Yu-Fl
	for gcvg-git-2@plane.gmane.org; Fri, 11 Jan 2013 23:15:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755763Ab3AKWPM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jan 2013 17:15:12 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43948 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754443Ab3AKWPL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jan 2013 17:15:11 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 17A7EB227
	for <git@vger.kernel.org>; Fri, 11 Jan 2013 17:15:11 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id; s=sasl; bh=IWAw+Mpa79vYP9MeoUzfwJANajU
	=; b=suoFJvkpK65MBzw52PdGWPQOTrzHgkWxw7t96IVV99RDb7Pf9qeEHUsLbgE
	YPgS+9+GvOoqapnGJRT7MjGerDBoXKIvkhh2J7xta3P1apJA+DIuugM8eQOhYqIg
	cQLKe8y76C+APyT7AxA82U4/wptiMA+AVyQSbbpmzJ3vsX/s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id; q=dns; s=sasl; b=HlutZFSo1DidsF+E0sTQ8r6lD2vgf
	VU5070YJ7LRq2bn6NFKR26YnmOiHJzk99PeuBm7BA4+VZxtc2A3C/nXKVy13Wewe
	HyEEYAy4hhcbfbDkSsIDDeywPQQjH25DMmR1oaWT9EgRCO/fxfHA+PWBH5Sco+Ee
	9KDdr7Pk98JMTE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0A17CB226
	for <git@vger.kernel.org>; Fri, 11 Jan 2013 17:15:11 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 873F4B224 for
 <git@vger.kernel.org>; Fri, 11 Jan 2013 17:15:10 -0500 (EST)
X-Mailer: git-send-email 1.8.1.407.g91cb4ac
X-Pobox-Relay-ID: 5D2DA30A-5C3C-11E2-B4F3-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213248>

All the other callers of logmsg_reencode() pass return value of
get_commit_output_encoding() or get_log_output_encoding().  Teach
the function to optionally take NULL as a synonym to "" aka "no
conversion requested" so that we can simplify the only remaining
calling site.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 pretty.c | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/pretty.c b/pretty.c
index e87fe9f..732e2a2 100644
--- a/pretty.c
+++ b/pretty.c
@@ -500,7 +500,7 @@ char *logmsg_reencode(const struct commit *commit,
 	char *encoding;
 	char *out;
 
-	if (!*output_encoding)
+	if (!output_encoding || !*output_encoding)
 		return NULL;
 	encoding = get_header(commit, "encoding");
 	use_encoding = encoding ? encoding : utf8;
@@ -1184,23 +1184,15 @@ void format_commit_message(const struct commit *commit,
 			   const struct pretty_print_context *pretty_ctx)
 {
 	struct format_commit_context context;
-	static const char utf8[] = "UTF-8";
 	const char *output_enc = pretty_ctx->output_encoding;
 
 	memset(&context, 0, sizeof(context));
 	context.commit = commit;
 	context.pretty_ctx = pretty_ctx;
 	context.wrap_start = sb->len;
-	context.message = commit->buffer;
-	if (output_enc) {
-		char *enc = get_header(commit, "encoding");
-		if (strcmp(enc ? enc : utf8, output_enc)) {
-			context.message = logmsg_reencode(commit, output_enc);
-			if (!context.message)
-				context.message = commit->buffer;
-		}
-		free(enc);
-	}
+	context.message = logmsg_reencode(commit, output_enc);
+	if (!context.message)
+		context.message = commit->buffer;
 
 	strbuf_expand(sb, format, format_commit_item, &context);
 	rewrap_message_tail(sb, &context, 0, 0, 0);
-- 
1.8.1.407.g91cb4ac
