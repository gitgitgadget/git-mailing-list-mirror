From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] format_commit_message(): simplify calls to logmsg_reencode()
Date: Mon, 10 Dec 2012 12:57:16 -0800
Message-ID: <7vboe1aamr.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 10 21:57:43 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TiAPy-0001Na-4n
	for gcvg-git-2@plane.gmane.org; Mon, 10 Dec 2012 21:57:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751564Ab2LJU5U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Dec 2012 15:57:20 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43024 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751068Ab2LJU5U (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Dec 2012 15:57:20 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3330BA7EE;
	Mon, 10 Dec 2012 15:57:19 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=q
	H8iUOzwNyANBXkpD8sQoHLe9k0=; b=LF3GInBxcX1q9RdRIuQbBP6YtWlArKeT1
	svL/a3JGS3YXhe1LP5EjEBEgfj7hQ1eqgnk6/9DxVldroKAt1mVOdAAOUTDH+NiX
	wmJ+kMrQDk2LiEVkPxElGyfTN3+sBLCa61Kn2v88pWEamG3b+QQj3av4cqB+XHB7
	z9ljj7OXWs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=eMY
	Z9/uwmKxe0N96qTBS9xs5Ch+5uEHC3EqXat6U4H1YAEPZJBu1wXIlF0fLae+Nxfd
	gtB9Wiex5MS+JXtvYCxu6AOgAafFlY5+/iyEUbcW9O2m8hRlTWbJ50311qbYAqxR
	bo81ysr25J7NgUD4nOSnaJsJGlWqqSdsG+vJH5U4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 21F7DA7ED;
	Mon, 10 Dec 2012 15:57:19 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 72615A7EB; Mon, 10 Dec 2012
 15:57:18 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 2F2E1622-430C-11E2-B3C9-995F2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211274>

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
1.8.1.rc1.123.gf61cb86
