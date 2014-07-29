From: Jeff King <peff@peff.net>
Subject: [PATCH v2 3/6] pretty: make empty userformats truly empty
Date: Tue, 29 Jul 2014 13:56:48 -0400
Message-ID: <20140729175648.GC31181@peff.net>
References: <20140729175300.GA21536@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 29 19:56:57 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XCBdw-0001AQ-S3
	for gcvg-git-2@plane.gmane.org; Tue, 29 Jul 2014 19:56:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751817AbaG2R4x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Jul 2014 13:56:53 -0400
Received: from cloud.peff.net ([50.56.180.127]:42612 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751311AbaG2R4w (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jul 2014 13:56:52 -0400
Received: (qmail 2475 invoked by uid 102); 29 Jul 2014 17:56:52 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 29 Jul 2014 12:56:52 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 29 Jul 2014 13:56:48 -0400
Content-Disposition: inline
In-Reply-To: <20140729175300.GA21536@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254454>

If the user provides an empty format with "--format=", we
end up putting in extra whitespace that the user cannot
prevent. This comes from two places:

  1. If the format is missing a terminating newline, we add
     one automatically. This makes sense for --format=%h, but
     not for a truly empty format.

  2. We add an extra newline between the pretty-printed
     format and a diff or diffstat. If the format is empty,
     there's no point in doing so if there's nothing to
     separate.

With this patch, one can get a diff with no other cruft out
of "diff-tree --format= $commit".

Signed-off-by: Jeff King <peff@peff.net>
---
I assume nobody really cared about including that extra whitespace with
a blank format (I have come across this literally dozens of times in the
past few years, and everytime wanted the behavior that this patch gives,
not the other). But if somebody is depending on it, our alternate route
would be to introduce a new CMIT_FMT_NONE. I started on that, but it
really does end up hitting all of the same weird special-cases that that
CMIT_FMT_USERFORMAT does. If we can do it this way, I think the code is
a lot cleaner.

 combine-diff.c | 3 ++-
 commit.h       | 1 +
 log-tree.c     | 5 +++--
 pretty.c       | 5 +++++
 4 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/combine-diff.c b/combine-diff.c
index f9975d2..1a1e659 100644
--- a/combine-diff.c
+++ b/combine-diff.c
@@ -1397,7 +1397,8 @@ void diff_tree_combined(const unsigned char *sha1,
 		show_log(rev);
 
 		if (rev->verbose_header && opt->output_format &&
-		    opt->output_format != DIFF_FORMAT_NO_OUTPUT)
+		    opt->output_format != DIFF_FORMAT_NO_OUTPUT &&
+		    !commit_format_is_empty(rev->commit_format))
 			printf("%s%c", diff_line_prefix(opt),
 			       opt->line_termination);
 	}
diff --git a/commit.h b/commit.h
index a8cbf52..aa8c3ca 100644
--- a/commit.h
+++ b/commit.h
@@ -159,6 +159,7 @@ extern void get_commit_format(const char *arg, struct rev_info *);
 extern const char *format_subject(struct strbuf *sb, const char *msg,
 				  const char *line_separator);
 extern void userformat_find_requirements(const char *fmt, struct userformat_want *w);
+extern int commit_format_is_empty(enum cmit_fmt);
 extern void format_commit_message(const struct commit *commit,
 				  const char *format, struct strbuf *sb,
 				  const struct pretty_print_context *context);
diff --git a/log-tree.c b/log-tree.c
index 0c53dc1..95e9b1d 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -649,7 +649,7 @@ void show_log(struct rev_info *opt)
 		graph_show_commit_msg(opt->graph, &msgbuf);
 	else
 		fwrite(msgbuf.buf, sizeof(char), msgbuf.len, stdout);
-	if (opt->use_terminator) {
+	if (opt->use_terminator && !commit_format_is_empty(opt->commit_format)) {
 		if (!opt->missing_newline)
 			graph_show_padding(opt->graph);
 		putchar(opt->diffopt.line_termination);
@@ -676,7 +676,8 @@ int log_tree_diff_flush(struct rev_info *opt)
 		show_log(opt);
 		if ((opt->diffopt.output_format & ~DIFF_FORMAT_NO_OUTPUT) &&
 		    opt->verbose_header &&
-		    opt->commit_format != CMIT_FMT_ONELINE) {
+		    opt->commit_format != CMIT_FMT_ONELINE &&
+		    !commit_format_is_empty(opt->commit_format)) {
 			/*
 			 * When showing a verbose header (i.e. log message),
 			 * and not in --pretty=oneline format, we would want
diff --git a/pretty.c b/pretty.c
index f97a762..31fc76b 100644
--- a/pretty.c
+++ b/pretty.c
@@ -24,6 +24,11 @@ static size_t commit_formats_len;
 static size_t commit_formats_alloc;
 static struct cmt_fmt_map *find_commit_format(const char *sought);
 
+int commit_format_is_empty(enum cmit_fmt fmt)
+{
+	return fmt == CMIT_FMT_USERFORMAT && !*user_format;
+}
+
 static void save_user_format(struct rev_info *rev, const char *cp, int is_tformat)
 {
 	free(user_format);
-- 
2.1.0.rc0.286.g5c67d74
