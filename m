From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v4 07/21] update-index: there are only two possible line terminations
Date: Thu, 14 Jan 2016 15:58:22 -0800
Message-ID: <1452815916-6447-8-git-send-email-gitster@pobox.com>
References: <1452740590-16827-1-git-send-email-gitster@pobox.com>
 <1452815916-6447-1-git-send-email-gitster@pobox.com>
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 15 00:59:05 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aJrnE-0003Jp-De
	for gcvg-git-2@plane.gmane.org; Fri, 15 Jan 2016 00:59:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932123AbcANX7A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Jan 2016 18:59:00 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:62839 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755681AbcANX6u (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jan 2016 18:58:50 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id DE6FF3CD73;
	Thu, 14 Jan 2016 18:58:49 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=/Jof
	pMURNGbfGgNfa74Y7ryR1TM=; b=NII05d7KR2QKQzNia8WCGsx2a7HD2amswGCp
	Og9PNMqwCQpTdPHiqmlfTR/qU3jXFxav7wkl3qMSZ3ZxBt7A6H0o4RZsmuNWVhn4
	yv9JOnVLRlA1tSx1MLd6njBZt8Pii3cgYlZEy1QYDkLb061dZFjSC8jNXBjMbmE7
	C+5shZ0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
	ap9W1NnG6/3GoOqXK9OuYDqksFRDNKY+YEKVDVwPWu6LqRqFApS1vti/cU30tA8d
	eaYtO2F0DFr/HEBhgpBBH2aYAYeCuouG+wTodmTQEcqwcXNQNfOuxqvWy5CyUvBK
	FQuxEBvIA7IKDq8H6nyfoOXCmjr42bB9UGAuQCjeAvA=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id D37CE3CD71;
	Thu, 14 Jan 2016 18:58:49 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 472CD3CD6E;
	Thu, 14 Jan 2016 18:58:49 -0500 (EST)
X-Mailer: git-send-email 2.7.0-250-ge1b5ba3
In-Reply-To: <1452815916-6447-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: C1685D66-BB1A-11E5-AC64-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284108>

The program by default reads LF terminated lines, with an option to
use NUL terminated records.  Instead of pretending that there can be
other useful values for line_termination, use a boolean variable,
nul_term_line, to tell if NUL terminated records are used, and
switch between strbuf_getline_{lf,nul} based on it.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/update-index.c | 27 ++++++++++++++++-----------
 1 file changed, 16 insertions(+), 11 deletions(-)

diff --git a/builtin/update-index.c b/builtin/update-index.c
index 7431938..7c5c143 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -468,12 +468,14 @@ static void update_one(const char *path)
 	report("add '%s'", path);
 }
 
-static void read_index_info(int line_termination)
+static void read_index_info(int nul_term_line)
 {
 	struct strbuf buf = STRBUF_INIT;
 	struct strbuf uq = STRBUF_INIT;
+	strbuf_getline_fn getline_fn;
 
-	while (strbuf_getline(&buf, stdin, line_termination) != EOF) {
+	getline_fn = nul_term_line ? strbuf_getline_nul : strbuf_getline_lf;
+	while (getline_fn(&buf, stdin) != EOF) {
 		char *ptr, *tab;
 		char *path_name;
 		unsigned char sha1[20];
@@ -522,7 +524,7 @@ static void read_index_info(int line_termination)
 			goto bad_line;
 
 		path_name = ptr;
-		if (line_termination && path_name[0] == '"') {
+		if (!nul_term_line && path_name[0] == '"') {
 			strbuf_reset(&uq);
 			if (unquote_c_style(&uq, path_name, NULL)) {
 				die("git update-index: bad quoting of path name");
@@ -844,12 +846,12 @@ static int cacheinfo_callback(struct parse_opt_ctx_t *ctx,
 static int stdin_cacheinfo_callback(struct parse_opt_ctx_t *ctx,
 			      const struct option *opt, int unset)
 {
-	int *line_termination = opt->value;
+	int *nul_term_line = opt->value;
 
 	if (ctx->argc != 1)
 		return error("option '%s' must be the last argument", opt->long_name);
 	allow_add = allow_replace = allow_remove = 1;
-	read_index_info(*line_termination);
+	read_index_info(*nul_term_line);
 	return 0;
 }
 
@@ -901,7 +903,7 @@ static int reupdate_callback(struct parse_opt_ctx_t *ctx,
 
 int cmd_update_index(int argc, const char **argv, const char *prefix)
 {
-	int newfd, entries, has_errors = 0, line_termination = '\n';
+	int newfd, entries, has_errors = 0, nul_term_line = 0;
 	int untracked_cache = -1;
 	int read_from_stdin = 0;
 	int prefix_length = prefix ? strlen(prefix) : 0;
@@ -912,6 +914,7 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
 	int split_index = -1;
 	struct lock_file *lock_file;
 	struct parse_opt_ctx_t ctx;
+	strbuf_getline_fn getline_fn;
 	int parseopt_state = PARSE_OPT_UNKNOWN;
 	struct option options[] = {
 		OPT_BIT('q', NULL, &refresh_args.flags,
@@ -963,13 +966,13 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
 			N_("add to index only; do not add content to object database"), 1),
 		OPT_SET_INT(0, "force-remove", &force_remove,
 			N_("remove named paths even if present in worktree"), 1),
-		OPT_SET_INT('z', NULL, &line_termination,
-			N_("with --stdin: input lines are terminated by null bytes"), '\0'),
+		OPT_BOOL('z', NULL, &nul_term_line,
+			 N_("with --stdin: input lines are terminated by null bytes")),
 		{OPTION_LOWLEVEL_CALLBACK, 0, "stdin", &read_from_stdin, NULL,
 			N_("read list of paths to be updated from standard input"),
 			PARSE_OPT_NONEG | PARSE_OPT_NOARG,
 			(parse_opt_cb *) stdin_callback},
-		{OPTION_LOWLEVEL_CALLBACK, 0, "index-info", &line_termination, NULL,
+		{OPTION_LOWLEVEL_CALLBACK, 0, "index-info", &nul_term_line, NULL,
 			N_("add entries from standard input to the index"),
 			PARSE_OPT_NONEG | PARSE_OPT_NOARG,
 			(parse_opt_cb *) stdin_cacheinfo_callback},
@@ -1057,6 +1060,8 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
 		}
 	}
 	argc = parse_options_end(&ctx);
+
+	getline_fn = nul_term_line ? strbuf_getline_nul : strbuf_getline_lf;
 	if (preferred_index_format) {
 		if (preferred_index_format < INDEX_FORMAT_LB ||
 		    INDEX_FORMAT_UB < preferred_index_format)
@@ -1073,9 +1078,9 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
 		struct strbuf buf = STRBUF_INIT, nbuf = STRBUF_INIT;
 
 		setup_work_tree();
-		while (strbuf_getline(&buf, stdin, line_termination) != EOF) {
+		while (getline_fn(&buf, stdin) != EOF) {
 			char *p;
-			if (line_termination && buf.buf[0] == '"') {
+			if (!nul_term_line && buf.buf[0] == '"') {
 				strbuf_reset(&nbuf);
 				if (unquote_c_style(&nbuf, buf.buf, NULL))
 					die("line is badly quoted");
-- 
2.7.0-250-ge1b5ba3
