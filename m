From: Jeff King <peff@peff.net>
Subject: [PATCH 11/15] convert logmsg_reencode to get_commit_buffer
Date: Mon, 9 Jun 2014 14:13:13 -0400
Message-ID: <20140609181312.GK20315@sigill.intra.peff.net>
References: <20140609180236.GA24644@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Jakub Narebski <jnareb@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 09 20:13:19 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wu44M-0000Er-L4
	for gcvg-git-2@plane.gmane.org; Mon, 09 Jun 2014 20:13:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753939AbaFISNP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Jun 2014 14:13:15 -0400
Received: from cloud.peff.net ([50.56.180.127]:40392 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753820AbaFISNO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Jun 2014 14:13:14 -0400
Received: (qmail 15969 invoked by uid 102); 9 Jun 2014 18:13:14 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 09 Jun 2014 13:13:14 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 09 Jun 2014 14:13:13 -0400
Content-Disposition: inline
In-Reply-To: <20140609180236.GA24644@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251097>

Like the callsites in the previous commit, logmsg_reencode
already falls back to read_sha1_file when necessary.
However, I split its conversion out into its own commit
because it's a bit more complex.

We return either:

  1. The original commit->buffer

  2. A newly allocated buffer from read_sha1_file

  3. A reencoded buffer (based on either 1 or 2 above).

while trying to do as few extra reads/allocations as
possible. Callers currently free the result with
logmsg_free, but we can simplify this by pointing them
straight to unuse_commit_buffer. This is a slight layering
violation, in that we may be passing a buffer from (3).
However, since the end result is to free() anything except
(1), a behavior which is unlikely to change, and because
this makes the interface much simpler, it's a reasonable
bending of the rules.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/blame.c |  4 ++--
 builtin/reset.c |  2 +-
 commit.h        |  1 -
 pretty.c        | 40 +++++++++++-----------------------------
 revision.c      |  2 +-
 sequencer.c     |  2 +-
 6 files changed, 16 insertions(+), 35 deletions(-)

diff --git a/builtin/blame.c b/builtin/blame.c
index 0af3a18..cde19eb 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -1666,7 +1666,7 @@ static void get_commit_info(struct commit *commit,
 		    &ret->author_time, &ret->author_tz);
 
 	if (!detailed) {
-		logmsg_free(message, commit);
+		unuse_commit_buffer(commit, message);
 		return;
 	}
 
@@ -1680,7 +1680,7 @@ static void get_commit_info(struct commit *commit,
 	else
 		strbuf_addf(&ret->summary, "(%s)", sha1_to_hex(commit->object.sha1));
 
-	logmsg_free(message, commit);
+	unuse_commit_buffer(commit, message);
 }
 
 /*
diff --git a/builtin/reset.c b/builtin/reset.c
index 7ebee07..850d532 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -109,7 +109,7 @@ static void print_new_head_line(struct commit *commit)
 	}
 	else
 		printf("\n");
-	logmsg_free(msg, commit);
+	unuse_commit_buffer(commit, msg);
 }
 
 static void update_index_from_diff(struct diff_queue_struct *q,
diff --git a/commit.h b/commit.h
index 67caf92..27e4fd7 100644
--- a/commit.h
+++ b/commit.h
@@ -156,7 +156,6 @@ struct rev_info; /* in revision.h, it circularly uses enum cmit_fmt */
 extern const char *logmsg_reencode(const struct commit *commit,
 				   char **commit_encoding,
 				   const char *output_encoding);
-extern void logmsg_free(const char *msg, const struct commit *commit);
 extern void get_commit_format(const char *arg, struct rev_info *);
 extern const char *format_subject(struct strbuf *sb, const char *msg,
 				  const char *line_separator);
diff --git a/pretty.c b/pretty.c
index d152de2..8fd60cd 100644
--- a/pretty.c
+++ b/pretty.c
@@ -613,22 +613,9 @@ const char *logmsg_reencode(const struct commit *commit,
 	static const char *utf8 = "UTF-8";
 	const char *use_encoding;
 	char *encoding;
-	char *msg = commit->buffer;
+	const char *msg = get_commit_buffer(commit);
 	char *out;
 
-	if (!msg) {
-		enum object_type type;
-		unsigned long size;
-
-		msg = read_sha1_file(commit->object.sha1, &type, &size);
-		if (!msg)
-			die("Cannot read commit object %s",
-			    sha1_to_hex(commit->object.sha1));
-		if (type != OBJ_COMMIT)
-			die("Expected commit for '%s', got %s",
-			    sha1_to_hex(commit->object.sha1), typename(type));
-	}
-
 	if (!output_encoding || !*output_encoding) {
 		if (commit_encoding)
 			*commit_encoding =
@@ -652,12 +639,13 @@ const char *logmsg_reencode(const struct commit *commit,
 		 * Otherwise, we still want to munge the encoding header in the
 		 * result, which will be done by modifying the buffer. If we
 		 * are using a fresh copy, we can reuse it. But if we are using
-		 * the cached copy from commit->buffer, we need to duplicate it
-		 * to avoid munging commit->buffer.
+		 * the cached copy from get_commit_buffer, we need to duplicate it
+		 * to avoid munging the cached copy.
 		 */
-		out = msg;
-		if (out == commit->buffer)
-			out = xstrdup(out);
+		if (msg == get_cached_commit_buffer(commit))
+			out = xstrdup(msg);
+		else
+			out = (char *)msg;
 	}
 	else {
 		/*
@@ -667,8 +655,8 @@ const char *logmsg_reencode(const struct commit *commit,
 		 * copy, we can free it.
 		 */
 		out = reencode_string(msg, output_encoding, use_encoding);
-		if (out && msg != commit->buffer)
-			free(msg);
+		if (out)
+			unuse_commit_buffer(commit, msg);
 	}
 
 	/*
@@ -687,12 +675,6 @@ const char *logmsg_reencode(const struct commit *commit,
 	return out ? out : msg;
 }
 
-void logmsg_free(const char *msg, const struct commit *commit)
-{
-	if (msg != commit->buffer)
-		free((void *)msg);
-}
-
 static int mailmap_name(const char **email, size_t *email_len,
 			const char **name, size_t *name_len)
 {
@@ -1531,7 +1513,7 @@ void format_commit_message(const struct commit *commit,
 	}
 
 	free(context.commit_encoding);
-	logmsg_free(context.message, commit);
+	unuse_commit_buffer(commit, context.message);
 	free(context.signature_check.gpg_output);
 	free(context.signature_check.signer);
 }
@@ -1767,7 +1749,7 @@ void pretty_print_commit(struct pretty_print_context *pp,
 	if (pp->fmt == CMIT_FMT_EMAIL && sb->len <= beginning_of_body)
 		strbuf_addch(sb, '\n');
 
-	logmsg_free(reencoded, commit);
+	unuse_commit_buffer(commit, reencoded);
 }
 
 void pp_commit_easy(enum cmit_fmt fmt, const struct commit *commit,
diff --git a/revision.c b/revision.c
index 47e5b7a..ad5fdf4 100644
--- a/revision.c
+++ b/revision.c
@@ -2843,7 +2843,7 @@ static int commit_match(struct commit *commit, struct rev_info *opt)
 		retval = grep_buffer(&opt->grep_filter,
 				     (char *)message, strlen(message));
 	strbuf_release(&buf);
-	logmsg_free(message, commit);
+	unuse_commit_buffer(commit, message);
 	return retval;
 }
 
diff --git a/sequencer.c b/sequencer.c
index 3fcab4d..4632f7d 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -154,7 +154,7 @@ static int get_message(struct commit *commit, struct commit_message *out)
 static void free_message(struct commit *commit, struct commit_message *msg)
 {
 	free(msg->parent_label);
-	logmsg_free(msg->message, commit);
+	unuse_commit_buffer(commit, msg->message);
 }
 
 static void write_cherry_pick_head(struct commit *commit, const char *pseudoref)
-- 
2.0.0.729.g520999f
