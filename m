From: Jeff King <peff@peff.net>
Subject: [PATCH 5/5] format-patch: preserve subject newlines with -k
Date: Thu, 26 May 2011 18:28:17 -0400
Message-ID: <20110526222817.GC21775@sigill.intra.peff.net>
References: <20110526222450.GA20077@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: "Stefan-W. Hahn" <stefan.hahn@s-hahn.de>
X-From: git-owner@vger.kernel.org Fri May 27 00:28:25 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QPj2X-0008Ch-3E
	for gcvg-git-2@lo.gmane.org; Fri, 27 May 2011 00:28:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758598Ab1EZW2U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 May 2011 18:28:20 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:46267
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758450Ab1EZW2U (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 May 2011 18:28:20 -0400
Received: (qmail 18677 invoked by uid 107); 26 May 2011 22:28:20 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 26 May 2011 18:28:20 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 26 May 2011 18:28:17 -0400
Content-Disposition: inline
In-Reply-To: <20110526222450.GA20077@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174588>

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
 builtin/log.c          |    1 +
 commit.h               |    1 +
 log-tree.c             |    1 +
 pretty.c               |    3 ++-
 revision.h             |    3 ++-
 t/t4152-am-subjects.sh |    2 +-
 6 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/builtin/log.c b/builtin/log.c
index 8d842cb..0e46e5a 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -1131,6 +1131,7 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 		die ("-n and -k are mutually exclusive.");
 	if (keep_subject && subject_prefix)
 		die ("--subject-prefix and -k are mutually exclusive.");
+	rev.preserve_subject = keep_subject;
 
 	argc = setup_revisions(argc, argv, &rev, &s_r_opt);
 	if (argc > 1)
diff --git a/commit.h b/commit.h
index 2935740..e985dcc 100644
--- a/commit.h
+++ b/commit.h
@@ -74,6 +74,7 @@ struct pretty_print_context
 	int abbrev;
 	const char *subject;
 	const char *after_subject;
+	int preserve_subject;
 	enum date_mode date_mode;
 	int need_8bit_cte;
 	int show_notes;
diff --git a/log-tree.c b/log-tree.c
index 0d8cc7a..0c41789 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -504,6 +504,7 @@ void show_log(struct rev_info *opt)
 	ctx.date_mode = opt->date_mode;
 	ctx.abbrev = opt->diffopt.abbrev;
 	ctx.after_subject = extra_headers;
+	ctx.preserve_subject = opt->preserve_subject;
 	ctx.reflog_info = opt->reflog_info;
 	ctx.fmt = opt->commit_format;
 	pretty_print_commit(&ctx, commit, &msgbuf);
diff --git a/pretty.c b/pretty.c
index f920205..905a082 100644
--- a/pretty.c
+++ b/pretty.c
@@ -1122,7 +1122,8 @@ void pp_title_line(const struct pretty_print_context *pp,
 	struct strbuf title;
 
 	strbuf_init(&title, 80);
-	*msg_p = format_subject(&title, *msg_p, " ");
+	*msg_p = format_subject(&title, *msg_p,
+				pp->preserve_subject ? "\n" : " ");
 
 	strbuf_grow(sb, title.len + 1024);
 	if (pp->subject) {
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
