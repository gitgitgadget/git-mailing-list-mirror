From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v4 04/21] mktree: there are only two possible line terminations
Date: Thu, 14 Jan 2016 15:58:19 -0800
Message-ID: <1452815916-6447-5-git-send-email-gitster@pobox.com>
References: <1452740590-16827-1-git-send-email-gitster@pobox.com>
 <1452815916-6447-1-git-send-email-gitster@pobox.com>
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 15 00:58:56 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aJrn4-0003Dl-My
	for gcvg-git-2@plane.gmane.org; Fri, 15 Jan 2016 00:58:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755648AbcANX6s (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Jan 2016 18:58:48 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:50413 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755579AbcANX6p (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jan 2016 18:58:45 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 96E533CD63;
	Thu, 14 Jan 2016 18:58:44 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=qiBj
	ZO0yj2FOVDTW8JvKQGCbfA8=; b=hLs4NbKz9fQWF+S63xARjf9rNDhSxeHwmYD1
	5H9QGZmYdSpHmlT+75jjMGeYJt9T+/GPZFyd9Z/FuXk1PxZiXlcX2d3WU5oxs6aP
	/xAOYRHXyr8aUDuxtRUW3SKX89ZZImmy+zje/gYz0qFXgXyfgmKmGAm1kfxmgInQ
	FiBt1bs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
	RbUvewaRQtv00x1pBXxdSk1oumszRvDKBK+ZdkC6XlDmJjMb8GWKHqdFJ9tdt2wg
	pl5kM5hvAjR8Y3IUkSYhvHuZ0N9M3bOiOrn7oqKSmKbzwPyo7BGDUm8XN5k7iArG
	qkvmsyNyj3zk2O26VSGGVarrX4AVQM1/RVLrUi0Q61Y=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 8EE423CD62;
	Thu, 14 Jan 2016 18:58:44 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 108A53CD61;
	Thu, 14 Jan 2016 18:58:43 -0500 (EST)
X-Mailer: git-send-email 2.7.0-250-ge1b5ba3
In-Reply-To: <1452815916-6447-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: BE4B2ABE-BB1A-11E5-978B-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284109>

The program by default reads LF terminated lines, with an option to
use NUL terminated records.  Instead of pretending that there can be
other useful values for line_termination, use a boolean variable,
nul_term_line, to tell if NUL terminated records are used, and
switch between strbuf_getline_{lf,nul} based on it.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/mktree.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/builtin/mktree.c b/builtin/mktree.c
index a964d6b..a237caa 100644
--- a/builtin/mktree.c
+++ b/builtin/mktree.c
@@ -65,7 +65,7 @@ static const char *mktree_usage[] = {
 	NULL
 };
 
-static void mktree_line(char *buf, size_t len, int line_termination, int allow_missing)
+static void mktree_line(char *buf, size_t len, int nul_term_line, int allow_missing)
 {
 	char *ptr, *ntr;
 	unsigned mode;
@@ -97,7 +97,7 @@ static void mktree_line(char *buf, size_t len, int line_termination, int allow_m
 	*ntr++ = 0; /* now at the beginning of SHA1 */
 
 	path = ntr + 41;  /* at the beginning of name */
-	if (line_termination && path[0] == '"') {
+	if (!nul_term_line && path[0] == '"') {
 		struct strbuf p_uq = STRBUF_INIT;
 		if (unquote_c_style(&p_uq, path, NULL))
 			die("invalid quoting");
@@ -141,23 +141,25 @@ int cmd_mktree(int ac, const char **av, const char *prefix)
 {
 	struct strbuf sb = STRBUF_INIT;
 	unsigned char sha1[20];
-	int line_termination = '\n';
+	int nul_term_line = 0;
 	int allow_missing = 0;
 	int is_batch_mode = 0;
 	int got_eof = 0;
+	strbuf_getline_fn getline_fn;
 
 	const struct option option[] = {
-		OPT_SET_INT('z', NULL, &line_termination, N_("input is NUL terminated"), '\0'),
+		OPT_BOOL('z', NULL, &nul_term_line, N_("input is NUL terminated")),
 		OPT_SET_INT( 0 , "missing", &allow_missing, N_("allow missing objects"), 1),
 		OPT_SET_INT( 0 , "batch", &is_batch_mode, N_("allow creation of more than one tree"), 1),
 		OPT_END()
 	};
 
 	ac = parse_options(ac, av, prefix, option, mktree_usage, 0);
+	getline_fn = nul_term_line ? strbuf_getline_nul : strbuf_getline_lf;
 
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
+			mktree_line(sb.buf, sb.len, nul_term_line, allow_missing);
 		}
 		if (is_batch_mode && got_eof && used < 1) {
 			/*
-- 
2.7.0-250-ge1b5ba3
