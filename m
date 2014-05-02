From: Jeff King <peff@peff.net>
Subject: [PATCH 1/4] commit: use split_ident_line to compare author/committer
Date: Thu, 1 May 2014 21:06:57 -0400
Message-ID: <20140502010656.GA25413@sigill.intra.peff.net>
References: <20140502010328.GA30556@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 02 03:07:05 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wg1wO-0006jk-Py
	for gcvg-git-2@plane.gmane.org; Fri, 02 May 2014 03:07:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751364AbaEBBG7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 May 2014 21:06:59 -0400
Received: from cloud.peff.net ([50.56.180.127]:43258 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751321AbaEBBG7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 May 2014 21:06:59 -0400
Received: (qmail 27909 invoked by uid 102); 2 May 2014 01:06:59 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 01 May 2014 20:06:59 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 01 May 2014 21:06:57 -0400
Content-Disposition: inline
In-Reply-To: <20140502010328.GA30556@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247914>

Instead of string-wise comparing the author/committer lines
with their timestamps truncated, we can use split_ident_line
and ident_cmp. These functions are more robust than our
ad-hoc parsing, though in practice it should not matter, as
we just generated these ident lines ourselves.

However, this will also allow us easy access to the
timestamp and tz fields in future patches.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/commit.c | 33 ++++++++++++++++-----------------
 1 file changed, 16 insertions(+), 17 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index 9cfef6c..728cc9b 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -585,13 +585,11 @@ static void determine_author_info(struct strbuf *author_ident)
 	}
 }
 
-static char *cut_ident_timestamp_part(char *string)
+static void split_ident_or_die(struct ident_split *id, const struct strbuf *buf)
 {
-	char *ket = strrchr(string, '>');
-	if (!ket || ket[1] != ' ')
-		die(_("Malformed ident string: '%s'"), string);
-	*++ket = '\0';
-	return ket;
+	if (split_ident_line(id, buf->buf, buf->len) ||
+	    !sane_ident_split(id))
+		die(_("Malformed ident string: '%s'"), buf->buf);
 }
 
 static int prepare_to_commit(const char *index_file, const char *prefix,
@@ -755,7 +753,8 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 	if (use_editor && include_status) {
 		int ident_shown = 0;
 		int saved_color_setting;
-		char *ai_tmp, *ci_tmp;
+		struct ident_split ci, ai;
+
 		if (whence != FROM_COMMIT) {
 			if (cleanup_mode == CLEANUP_SCISSORS)
 				wt_status_add_cut_line(s->fp);
@@ -795,21 +794,24 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 			status_printf_ln(s, GIT_COLOR_NORMAL,
 					"%s", only_include_assumed);
 
-		ai_tmp = cut_ident_timestamp_part(author_ident->buf);
-		ci_tmp = cut_ident_timestamp_part(committer_ident.buf);
-		if (strcmp(author_ident->buf, committer_ident.buf))
+		split_ident_or_die(&ai, author_ident);
+		split_ident_or_die(&ci, &committer_ident);
+
+		if (ident_cmp(&ai, &ci))
 			status_printf_ln(s, GIT_COLOR_NORMAL,
 				_("%s"
-				"Author:    %s"),
+				"Author:    %.*s <%.*s>"),
 				ident_shown++ ? "" : "\n",
-				author_ident->buf);
+				(int)(ai.name_end - ai.name_begin), ai.name_begin,
+				(int)(ai.mail_end - ai.mail_begin), ai.mail_begin);
 
 		if (!committer_ident_sufficiently_given())
 			status_printf_ln(s, GIT_COLOR_NORMAL,
 				_("%s"
-				"Committer: %s"),
+				"Committer: %.*s <%.*s>"),
 				ident_shown++ ? "" : "\n",
-				committer_ident.buf);
+				(int)(ci.name_end - ci.name_begin), ci.name_begin,
+				(int)(ci.mail_end - ci.mail_begin), ci.mail_begin);
 
 		if (ident_shown)
 			status_printf_ln(s, GIT_COLOR_NORMAL, "");
@@ -818,9 +820,6 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 		s->use_color = 0;
 		commitable = run_status(s->fp, index_file, prefix, 1, s);
 		s->use_color = saved_color_setting;
-
-		*ai_tmp = ' ';
-		*ci_tmp = ' ';
 	} else {
 		unsigned char sha1[20];
 		const char *parent = "HEAD";
-- 
1.9.1.656.ge8a0637
