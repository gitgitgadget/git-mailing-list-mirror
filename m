From: Jeff King <peff@peff.net>
Subject: [PATCH 3/3] format-patch: preserve subject newlines with -k
Date: Thu, 26 May 2011 16:55:04 -0400
Message-ID: <20110526205504.GC31340@sigill.intra.peff.net>
References: <20110526203625.GA31018@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: "Stefan-W. Hahn" <stefan.hahn@s-hahn.de>
X-From: git-owner@vger.kernel.org Thu May 26 22:55:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QPhaO-0004mK-8R
	for gcvg-git-2@lo.gmane.org; Thu, 26 May 2011 22:55:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758369Ab1EZUzI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 May 2011 16:55:08 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:51501
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756699Ab1EZUzH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 May 2011 16:55:07 -0400
Received: (qmail 17239 invoked by uid 107); 26 May 2011 20:55:07 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 26 May 2011 16:55:07 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 26 May 2011 16:55:04 -0400
Content-Disposition: inline
In-Reply-To: <20110526203625.GA31018@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174565>

In older versions of git, we used rfc822 header folding to
indicate that the original subject line had multiple lines
in it.  But since a1f6baa (format-patch: wrap long header
lines, 2011-02-23), we now use header folding whenever there
is a long line.

This means that "git am" cannot trust header folding as a
sign from format-patch that newlines should be preserved.
Instead, format-patch needs to signal more explicitly that
the newlines are significant.  This patch does so by
rfc2047-encoding the newlines in the subject line. No
changes are needed on the "git am" end; it already decodes
the newlines properly.

Signed-off-by: Jeff King <peff@peff.net>
---
We have always treated multi-line subjects as second-class citizens, so
this is not a must-have patch. But I think it makes sense to do,
considering how simple it is, and the fact that it makes "format-patch
-k | am -k" always a no-op, even with multi-line subjects.

 builtin/log.c          |    3 ++-
 commit.h               |    4 +++-
 log-tree.c             |    1 +
 pretty.c               |    8 +++++---
 revision.h             |    3 ++-
 t/t4152-am-subjects.sh |    2 +-
 6 files changed, 14 insertions(+), 7 deletions(-)

diff --git a/builtin/log.c b/builtin/log.c
index d8c6c28..3fdf488 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -768,7 +768,7 @@ static void make_cover_letter(struct rev_info *rev, int use_stdout,
 	pp_user_info(NULL, CMIT_FMT_EMAIL, &sb, committer, DATE_RFC2822,
 		     encoding);
 	pp_title_line(CMIT_FMT_EMAIL, &msg, &sb, subject_start, extra_headers,
-		      encoding, need_8bit_cte);
+		      encoding, need_8bit_cte, 0);
 	pp_remainder(CMIT_FMT_EMAIL, &msg, &sb, 0);
 	printf("%s\n", sb.buf);
 
@@ -1130,6 +1130,7 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 		die ("-n and -k are mutually exclusive.");
 	if (keep_subject && subject_prefix)
 		die ("--subject-prefix and -k are mutually exclusive.");
+	rev.preserve_subject = keep_subject;
 
 	argc = setup_revisions(argc, argv, &rev, &s_r_opt);
 	if (argc > 1)
diff --git a/commit.h b/commit.h
index eb6c5af..30cb7bc 100644
--- a/commit.h
+++ b/commit.h
@@ -73,6 +73,7 @@ struct pretty_print_context
 	int abbrev;
 	const char *subject;
 	const char *after_subject;
+	int preserve_subject;
 	enum date_mode date_mode;
 	int need_8bit_cte;
 	int show_notes;
@@ -107,7 +108,8 @@ void pp_title_line(enum cmit_fmt fmt,
 		   const char *subject,
 		   const char *after_subject,
 		   const char *encoding,
-		   int need_8bit_cte);
+		   int need_8bit_cte,
+		   int preserve_lines);
 void pp_remainder(enum cmit_fmt fmt,
 		  const char **msg_p,
 		  struct strbuf *sb,
diff --git a/log-tree.c b/log-tree.c
index b46ed3b..9b9aaf2 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -504,6 +504,7 @@ void show_log(struct rev_info *opt)
 	ctx.date_mode = opt->date_mode;
 	ctx.abbrev = opt->diffopt.abbrev;
 	ctx.after_subject = extra_headers;
+	ctx.preserve_subject = opt->preserve_subject;
 	ctx.reflog_info = opt->reflog_info;
 	pretty_print_commit(opt->commit_format, commit, &msgbuf, &ctx);
 
diff --git a/pretty.c b/pretty.c
index 65d20a7..315f1d2 100644
--- a/pretty.c
+++ b/pretty.c
@@ -1121,12 +1121,13 @@ void pp_title_line(enum cmit_fmt fmt,
 		   const char *subject,
 		   const char *after_subject,
 		   const char *encoding,
-		   int need_8bit_cte)
+		   int need_8bit_cte,
+		   int preserve_lines)
 {
 	struct strbuf title;
 
 	strbuf_init(&title, 80);
-	*msg_p = format_subject(&title, *msg_p, " ");
+	*msg_p = format_subject(&title, *msg_p, preserve_lines ? "\n" : " ");
 
 	strbuf_grow(sb, title.len + 1024);
 	if (subject) {
@@ -1254,7 +1255,8 @@ void pretty_print_commit(enum cmit_fmt fmt, const struct commit *commit,
 	/* These formats treat the title line specially. */
 	if (fmt == CMIT_FMT_ONELINE || fmt == CMIT_FMT_EMAIL)
 		pp_title_line(fmt, &msg, sb, context->subject,
-			      context->after_subject, encoding, need_8bit_cte);
+			      context->after_subject, encoding, need_8bit_cte,
+			      context->preserve_subject);
 
 	beginning_of_body = sb->len;
 	if (fmt != CMIT_FMT_ONELINE)
diff --git a/revision.h b/revision.h
index 05659c6..f8ddd83 100644
--- a/revision.h
+++ b/revision.h
@@ -90,7 +90,8 @@ struct rev_info {
 			abbrev_commit:1,
 			use_terminator:1,
 			missing_newline:1,
-			date_mode_explicit:1;
+			date_mode_explicit:1,
+			preserve_subject:1;
 	unsigned int	disable_stdin:1;
 
 	enum date_mode date_mode;
diff --git a/t/t4152-am-subjects.sh b/t/t4152-am-subjects.sh
index 37e5c03..4c68245 100755
--- a/t/t4152-am-subjects.sh
+++ b/t/t4152-am-subjects.sh
@@ -70,7 +70,7 @@ test_expect_success 'multiline subject unwrapped (format-patch -k | am)' '
 	check_subject multiline-k
 '
 echo "$MULTILINE_SUBJECT" >expect
-test_expect_failure 'multiline subject preserved (format-patch -k | am -k)' '
+test_expect_success 'multiline subject preserved (format-patch -k | am -k)' '
 	check_subject multiline-k -k
 '
 
-- 
1.7.4.5.26.g0c6a2
