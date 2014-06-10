From: Jeff King <peff@peff.net>
Subject: [PATCH 06/17] logmsg_reencode: return const buffer
Date: Tue, 10 Jun 2014 17:39:30 -0400
Message-ID: <20140610213930.GF19147@sigill.intra.peff.net>
References: <20140610213509.GA26979@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Jakub Narebski <jnareb@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 10 23:39:36 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WuTlX-0004GR-Jj
	for gcvg-git-2@plane.gmane.org; Tue, 10 Jun 2014 23:39:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753953AbaFJVjc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Jun 2014 17:39:32 -0400
Received: from cloud.peff.net ([50.56.180.127]:41378 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753168AbaFJVjb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jun 2014 17:39:31 -0400
Received: (qmail 19491 invoked by uid 102); 10 Jun 2014 21:39:31 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 10 Jun 2014 16:39:31 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 10 Jun 2014 17:39:30 -0400
Content-Disposition: inline
In-Reply-To: <20140610213509.GA26979@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251249>

The return value from logmsg_reencode may be either a newly
allocated buffer or a pointer to the existing commit->buffer.
We would not want the caller to accidentally free() or
modify the latter, so let's mark it as const.  We can cast
away the constness in logmsg_free, but only once we have
determined that it is a free-able buffer.

Signed-off-by: Jeff King <peff@peff.net>
---
Fixed comment style issue from v1.

 builtin/blame.c |  2 +-
 builtin/reset.c |  2 +-
 commit.h        |  8 ++++----
 pretty.c        | 14 +++++++-------
 revision.c      | 13 ++++++++++---
 5 files changed, 23 insertions(+), 16 deletions(-)

diff --git a/builtin/blame.c b/builtin/blame.c
index d6056a5..6ce3c6d 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -1655,7 +1655,7 @@ static void get_commit_info(struct commit *commit,
 {
 	int len;
 	const char *subject, *encoding;
-	char *message;
+	const char *message;
 
 	commit_info_init(ret);
 
diff --git a/builtin/reset.c b/builtin/reset.c
index f368266..7ebee07 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -93,7 +93,7 @@ static int reset_index(const unsigned char *sha1, int reset_type, int quiet)
 static void print_new_head_line(struct commit *commit)
 {
 	const char *hex, *body;
-	char *msg;
+	const char *msg;
 
 	hex = find_unique_abbrev(commit->object.sha1, DEFAULT_ABBREV);
 	printf(_("HEAD is now at %s"), hex);
diff --git a/commit.h b/commit.h
index 1cb55ae..4df48cb 100644
--- a/commit.h
+++ b/commit.h
@@ -115,10 +115,10 @@ struct userformat_want {
 
 extern int has_non_ascii(const char *text);
 struct rev_info; /* in revision.h, it circularly uses enum cmit_fmt */
-extern char *logmsg_reencode(const struct commit *commit,
-			     char **commit_encoding,
-			     const char *output_encoding);
-extern void logmsg_free(char *msg, const struct commit *commit);
+extern const char *logmsg_reencode(const struct commit *commit,
+				   char **commit_encoding,
+				   const char *output_encoding);
+extern void logmsg_free(const char *msg, const struct commit *commit);
 extern void get_commit_format(const char *arg, struct rev_info *);
 extern const char *format_subject(struct strbuf *sb, const char *msg,
 				  const char *line_separator);
diff --git a/pretty.c b/pretty.c
index e1e2cad..d152de2 100644
--- a/pretty.c
+++ b/pretty.c
@@ -606,9 +606,9 @@ static char *replace_encoding_header(char *buf, const char *encoding)
 	return strbuf_detach(&tmp, NULL);
 }
 
-char *logmsg_reencode(const struct commit *commit,
-		      char **commit_encoding,
-		      const char *output_encoding)
+const char *logmsg_reencode(const struct commit *commit,
+			    char **commit_encoding,
+			    const char *output_encoding)
 {
 	static const char *utf8 = "UTF-8";
 	const char *use_encoding;
@@ -687,10 +687,10 @@ char *logmsg_reencode(const struct commit *commit,
 	return out ? out : msg;
 }
 
-void logmsg_free(char *msg, const struct commit *commit)
+void logmsg_free(const char *msg, const struct commit *commit)
 {
 	if (msg != commit->buffer)
-		free(msg);
+		free((void *)msg);
 }
 
 static int mailmap_name(const char **email, size_t *email_len,
@@ -796,7 +796,7 @@ struct format_commit_context {
 	struct signature_check signature_check;
 	enum flush_type flush_type;
 	enum trunc_type truncate;
-	char *message;
+	const char *message;
 	char *commit_encoding;
 	size_t width, indent1, indent2;
 	int auto_color;
@@ -1700,7 +1700,7 @@ void pretty_print_commit(struct pretty_print_context *pp,
 	unsigned long beginning_of_body;
 	int indent = 4;
 	const char *msg;
-	char *reencoded;
+	const char *reencoded;
 	const char *encoding;
 	int need_8bit_cte = pp->need_8bit_cte;
 
diff --git a/revision.c b/revision.c
index 71e2337..be151ef 100644
--- a/revision.c
+++ b/revision.c
@@ -2788,7 +2788,7 @@ static int commit_match(struct commit *commit, struct rev_info *opt)
 {
 	int retval;
 	const char *encoding;
-	char *message;
+	const char *message;
 	struct strbuf buf = STRBUF_INIT;
 
 	if (!opt->grep_filter.pattern_list && !opt->grep_filter.header_list)
@@ -2830,12 +2830,19 @@ static int commit_match(struct commit *commit, struct rev_info *opt)
 		format_display_notes(commit->object.sha1, &buf, encoding, 1);
 	}
 
-	/* Find either in the original commit message, or in the temporary */
+	/*
+	 * Find either in the original commit message, or in the temporary.
+	 * Note that we cast away the constness of "message" here. It is
+	 * const because it may come from the cached commit buffer. That's OK,
+	 * because we know that it is modifiable heap memory, and that while
+	 * grep_buffer may modify it for speed, it will restore any
+	 * changes before returning.
+	 */
 	if (buf.len)
 		retval = grep_buffer(&opt->grep_filter, buf.buf, buf.len);
 	else
 		retval = grep_buffer(&opt->grep_filter,
-				     message, strlen(message));
+				     (char *)message, strlen(message));
 	strbuf_release(&buf);
 	logmsg_free(message, commit);
 	return retval;
-- 
2.0.0.729.g520999f
