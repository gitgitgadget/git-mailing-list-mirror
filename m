From: Junio C Hamano <gitster@pobox.com>
Subject: [PREVIEW v3 4/9] mktree: there are only two line terminators
Date: Wed, 13 Jan 2016 19:03:04 -0800
Message-ID: <1452740590-16827-5-git-send-email-gitster@pobox.com>
References: <1450303398-25900-1-git-send-email-gitster@pobox.com>
 <1452740590-16827-1-git-send-email-gitster@pobox.com>
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 14 04:03:33 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aJYCC-0007Yv-Mk
	for gcvg-git-2@plane.gmane.org; Thu, 14 Jan 2016 04:03:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752882AbcANDDZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jan 2016 22:03:25 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:62046 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751182AbcANDDT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jan 2016 22:03:19 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id D845A3C42F;
	Wed, 13 Jan 2016 22:03:18 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=xXwf
	5gjBVG+aZPbCpgRUniyMSOU=; b=T//YZLff6ZdMDEt/2/ntC6hOSyuoOOvazZos
	DbgvbKRFVnBUZoHKIYeD8XyOn9ZcjkM86eJnsYo9V6IdQ62G7OEXJYPWBF4nt2br
	+mML09EyTsBPsIkPLfP49kMj2GjYS6b+6TwDm/cid69OvOQUbFxCmgu+gyqRgx4M
	lPzO+7g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
	iFOO5pe6XX31j5h+WtS7iz8dAFhV6cCydTj4HhaBcFMjh6TNz5lvN/lYl8byGgcP
	/JshYu0LyRAr4u4fWFZlqOiF13kPZUks2sWzavghZ2swpdY6UxKosoDfG76gkfsH
	1+78FC0kH0WCtHLsgTfP9rrhBcQSLjZQiLwO7Qoc9kg=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id BD27F3C42E;
	Wed, 13 Jan 2016 22:03:18 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 3A1703C42D;
	Wed, 13 Jan 2016 22:03:18 -0500 (EST)
X-Mailer: git-send-email 2.7.0-242-gdd583c7
In-Reply-To: <1452740590-16827-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 5C998D6A-BA6B-11E5-9DB7-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284005>

The program by default works on LF terminated lines, with an option
to use NUL terminated records.  Instead of pretending that there can
be other useful values that can be stuffed into line_termination,
make it a boolean "lf_lines", and switch between strbuf_getline_{lf,nul}
based on it.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/mktree.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/builtin/mktree.c b/builtin/mktree.c
index a964d6b..00e9b7e 100644
--- a/builtin/mktree.c
+++ b/builtin/mktree.c
@@ -65,7 +65,7 @@ static const char *mktree_usage[] = {
 	NULL
 };
 
-static void mktree_line(char *buf, size_t len, int line_termination, int allow_missing)
+static void mktree_line(char *buf, size_t len, int lf_lines, int allow_missing)
 {
 	char *ptr, *ntr;
 	unsigned mode;
@@ -97,7 +97,7 @@ static void mktree_line(char *buf, size_t len, int line_termination, int allow_m
 	*ntr++ = 0; /* now at the beginning of SHA1 */
 
 	path = ntr + 41;  /* at the beginning of name */
-	if (line_termination && path[0] == '"') {
+	if (lf_lines && path[0] == '"') {
 		struct strbuf p_uq = STRBUF_INIT;
 		if (unquote_c_style(&p_uq, path, NULL))
 			die("invalid quoting");
@@ -141,23 +141,25 @@ int cmd_mktree(int ac, const char **av, const char *prefix)
 {
 	struct strbuf sb = STRBUF_INIT;
 	unsigned char sha1[20];
-	int line_termination = '\n';
+	int lf_lines = 1;
 	int allow_missing = 0;
 	int is_batch_mode = 0;
 	int got_eof = 0;
+	strbuf_getline_fn getline_fn;
 
 	const struct option option[] = {
-		OPT_SET_INT('z', NULL, &line_termination, N_("input is NUL terminated"), '\0'),
+		OPT_SET_INT('z', NULL, &lf_lines, N_("input is NUL terminated"), '\0'),
 		OPT_SET_INT( 0 , "missing", &allow_missing, N_("allow missing objects"), 1),
 		OPT_SET_INT( 0 , "batch", &is_batch_mode, N_("allow creation of more than one tree"), 1),
 		OPT_END()
 	};
 
 	ac = parse_options(ac, av, prefix, option, mktree_usage, 0);
+	getline_fn = lf_lines ? strbuf_getline_lf : strbuf_getline_nul;
 
 	while (!got_eof) {
 		while (1) {
-			if (strbuf_getline(&sb, stdin, line_termination) == EOF) {
+			if (getline_fn(&sb, stdin) == EOF) {
 				got_eof = 1;
 				break;
 			}
@@ -167,7 +169,7 @@ int cmd_mktree(int ac, const char **av, const char *prefix)
 					break;
 				die("input format error: (blank line only valid in batch mode)");
 			}
-			mktree_line(sb.buf, sb.len, line_termination, allow_missing);
+			mktree_line(sb.buf, sb.len, lf_lines, allow_missing);
 		}
 		if (is_batch_mode && got_eof && used < 1) {
 			/*
-- 
2.7.0-242-gdd583c7
