From: Jeff King <peff@peff.net>
Subject: [PATCH 2/3] logmsg_reencode: never return NULL
Date: Sat, 26 Jan 2013 04:44:06 -0500
Message-ID: <20130126094406.GB6999@sigill.intra.peff.net>
References: <20130126094026.GA9646@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jonathon Mah <jmah@me.com>, Jonathan Nieder <jrnieder@gmail.com>,
	Duy Nguyen <pclouds@gmail.com>,
	Stefan =?utf-8?B?TsOkd2U=?= <stefan.naewe@atlas-elektronik.com>,
	Armin <netzverweigerer@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jan 26 10:44:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tz2JM-00040p-IL
	for gcvg-git-2@plane.gmane.org; Sat, 26 Jan 2013 10:44:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752933Ab3AZJoL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Jan 2013 04:44:11 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:51378 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752512Ab3AZJoJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Jan 2013 04:44:09 -0500
Received: (qmail 21165 invoked by uid 107); 26 Jan 2013 09:45:30 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 26 Jan 2013 04:45:30 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 26 Jan 2013 04:44:06 -0500
Content-Disposition: inline
In-Reply-To: <20130126094026.GA9646@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214617>

The logmsg_reencode function will return the reencoded
commit buffer, or NULL if reencoding failed or no reencoding
was necessary. Since every caller then ends up checking for NULL
and just using the commit's original buffer, anyway, we can
be a bit more helpful and just return that buffer when we
would have returned NULL.

Since the resulting string may or may not need to be freed,
we introduce a logmsg_free, which checks whether the buffer
came from the commit object or not (callers either
implemented the same check already, or kept two separate
pointers, one to mark the buffer to be used, and one for the
to-be-freed string).

Pushing this logic into logmsg_* simplifies the callers, and
will let future patches lazily load the commit buffer in a
single place.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/blame.c  |  9 ++++-----
 builtin/commit.c | 14 ++------------
 commit.h         |  1 +
 pretty.c         | 38 ++++++++++++++++++++++----------------
 4 files changed, 29 insertions(+), 33 deletions(-)

diff --git a/builtin/blame.c b/builtin/blame.c
index b431ba3..962e4e3 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -1420,7 +1420,7 @@ static void get_commit_info(struct commit *commit,
 {
 	int len;
 	const char *subject, *encoding;
-	char *reencoded, *message;
+	char *message;
 
 	commit_info_init(ret);
 
@@ -1438,14 +1438,13 @@ static void get_commit_info(struct commit *commit,
 			    sha1_to_hex(commit->object.sha1));
 	}
 	encoding = get_log_output_encoding();
-	reencoded = logmsg_reencode(commit, encoding);
-	message   = reencoded ? reencoded : commit->buffer;
+	message = logmsg_reencode(commit, encoding);
 	get_ac_line(message, "\nauthor ",
 		    &ret->author, &ret->author_mail,
 		    &ret->author_time, &ret->author_tz);
 
 	if (!detailed) {
-		free(reencoded);
+		logmsg_free(message, commit);
 		return;
 	}
 
@@ -1459,7 +1458,7 @@ static void get_commit_info(struct commit *commit,
 	else
 		strbuf_addf(&ret->summary, "(%s)", sha1_to_hex(commit->object.sha1));
 
-	free(reencoded);
+	logmsg_free(message, commit);
 }
 
 /*
diff --git a/builtin/commit.c b/builtin/commit.c
index fbbb40f..6169f1e 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -946,24 +946,14 @@ static const char *read_commit_message(const char *name)
 
 static const char *read_commit_message(const char *name)
 {
-	const char *out_enc, *out;
+	const char *out_enc;
 	struct commit *commit;
 
 	commit = lookup_commit_reference_by_name(name);
 	if (!commit)
 		die(_("could not lookup commit %s"), name);
 	out_enc = get_commit_output_encoding();
-	out = logmsg_reencode(commit, out_enc);
-
-	/*
-	 * If we failed to reencode the buffer, just copy it
-	 * byte for byte so the user can try to fix it up.
-	 * This also handles the case where input and output
-	 * encodings are identical.
-	 */
-	if (out == NULL)
-		out = commit->buffer;
-	return out;
+	return logmsg_reencode(commit, out_enc);
 }
 
 static int parse_and_validate_options(int argc, const char *argv[],
diff --git a/commit.h b/commit.h
index c16c8a7..e770649 100644
--- a/commit.h
+++ b/commit.h
@@ -101,6 +101,7 @@ extern char *logmsg_reencode(const struct commit *commit,
 struct rev_info; /* in revision.h, it circularly uses enum cmit_fmt */
 extern char *logmsg_reencode(const struct commit *commit,
 			     const char *output_encoding);
+extern void logmsg_free(char *msg, const struct commit *commit);
 extern void get_commit_format(const char *arg, struct rev_info *);
 extern const char *format_subject(struct strbuf *sb, const char *msg,
 				  const char *line_separator);
diff --git a/pretty.c b/pretty.c
index 07fc062..c675349 100644
--- a/pretty.c
+++ b/pretty.c
@@ -524,10 +524,11 @@ static char *get_header(const struct commit *commit, const char *key)
 	strbuf_addch(sb, '\n');
 }
 
-static char *get_header(const struct commit *commit, const char *key)
+static char *get_header(const struct commit *commit, const char *msg,
+			const char *key)
 {
 	int key_len = strlen(key);
-	const char *line = commit->buffer;
+	const char *line = msg;
 
 	while (line) {
 		const char *eol = strchr(line, '\n'), *next;
@@ -588,17 +589,18 @@ char *logmsg_reencode(const struct commit *commit,
 	static const char *utf8 = "UTF-8";
 	const char *use_encoding;
 	char *encoding;
+	char *msg = commit->buffer;
 	char *out;
 
 	if (!output_encoding || !*output_encoding)
-		return NULL;
-	encoding = get_header(commit, "encoding");
+		return msg;
+	encoding = get_header(commit, msg, "encoding");
 	use_encoding = encoding ? encoding : utf8;
 	if (same_encoding(use_encoding, output_encoding))
 		if (encoding) /* we'll strip encoding header later */
 			out = xstrdup(commit->buffer);
 		else
-			return NULL; /* nothing to do */
+			return msg; /* nothing to do */
 	else
 		out = reencode_string(commit->buffer,
 				      output_encoding, use_encoding);
@@ -606,7 +608,17 @@ char *logmsg_reencode(const struct commit *commit,
 		out = replace_encoding_header(out, output_encoding);
 
 	free(encoding);
-	return out;
+	/*
+	 * If the re-encoding failed, out might be NULL here; in that
+	 * case we just return the commit message verbatim.
+	 */
+	return out ? out : msg;
+}
+
+void logmsg_free(char *msg, const struct commit *commit)
+{
+	if (msg != commit->buffer)
+		free(msg);
 }
 
 static int mailmap_name(const char **email, size_t *email_len,
@@ -1278,14 +1290,11 @@ void format_commit_message(const struct commit *commit,
 	context.pretty_ctx = pretty_ctx;
 	context.wrap_start = sb->len;
 	context.message = logmsg_reencode(commit, output_enc);
-	if (!context.message)
-		context.message = commit->buffer;
 
 	strbuf_expand(sb, format, format_commit_item, &context);
 	rewrap_message_tail(sb, &context, 0, 0, 0);
 
-	if (context.message != commit->buffer)
-		free(context.message);
+	logmsg_free(context.message, commit);
 	free(context.signature.gpg_output);
 	free(context.signature.signer);
 }
@@ -1432,7 +1441,7 @@ void pretty_print_commit(const struct pretty_print_context *pp,
 {
 	unsigned long beginning_of_body;
 	int indent = 4;
-	const char *msg = commit->buffer;
+	const char *msg;
 	char *reencoded;
 	const char *encoding;
 	int need_8bit_cte = pp->need_8bit_cte;
@@ -1443,10 +1452,7 @@ void pretty_print_commit(const struct pretty_print_context *pp,
 	}
 
 	encoding = get_log_output_encoding();
-	reencoded = logmsg_reencode(commit, encoding);
-	if (reencoded) {
-		msg = reencoded;
-	}
+	msg = reencoded = logmsg_reencode(commit, encoding);
 
 	if (pp->fmt == CMIT_FMT_ONELINE || pp->fmt == CMIT_FMT_EMAIL)
 		indent = 0;
@@ -1503,7 +1509,7 @@ void pretty_print_commit(const struct pretty_print_context *pp,
 	if (pp->fmt == CMIT_FMT_EMAIL && sb->len <= beginning_of_body)
 		strbuf_addch(sb, '\n');
 
-	free(reencoded);
+	logmsg_free(reencoded, commit);
 }
 
 void pp_commit_easy(enum cmit_fmt fmt, const struct commit *commit,
-- 
1.8.0.2.16.g72e2fc9
