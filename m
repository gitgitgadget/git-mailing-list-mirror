From: Jeff King <peff@peff.net>
Subject: [PATCH 1/2] pretty.c: drop const-ness from pretty_print_context
Date: Wed, 3 Jul 2013 03:07:48 -0400
Message-ID: <20130703070747.GA17730@sigill.intra.peff.net>
References: <20130703070719.GA17638@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 03 09:07:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UuHAR-0006ps-DP
	for gcvg-git-2@plane.gmane.org; Wed, 03 Jul 2013 09:07:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754381Ab3GCHHv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Jul 2013 03:07:51 -0400
Received: from cloud.peff.net ([50.56.180.127]:36052 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754270Ab3GCHHv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Jul 2013 03:07:51 -0400
Received: (qmail 28717 invoked by uid 102); 3 Jul 2013 07:09:01 -0000
Received: from c-98-244-76-202.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (98.244.76.202)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 03 Jul 2013 02:09:01 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 03 Jul 2013 03:07:48 -0400
Content-Disposition: inline
In-Reply-To: <20130703070719.GA17638@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229457>

In the current code, callers are expected to fill in the
pretty_print_context, and then the pretty.c functions simply
read from it. This leaves no room for the pretty.c functions
to communicate with each other by manipulating the context
(e.g., data seen while printing the header may impact how we
print the body).

Rather than introduce a new struct to hold modifiable data,
let's just drop the const-ness of the existing context
struct.

Signed-off-by: Jeff King <peff@peff.net>
---
 commit.h | 16 ++++++++++++----
 pretty.c | 10 +++++-----
 2 files changed, 17 insertions(+), 9 deletions(-)

diff --git a/commit.h b/commit.h
index 6e9c7cd..2057201 100644
--- a/commit.h
+++ b/commit.h
@@ -79,6 +79,9 @@ struct pretty_print_context {
 };
 
 struct pretty_print_context {
+	/*
+	 * Callers should tweak these to change the behavior of pp_* functions.
+	 */
 	enum cmit_fmt fmt;
 	int abbrev;
 	const char *subject;
@@ -92,6 +95,11 @@ struct pretty_print_context {
 	const char *output_encoding;
 	struct string_list *mailmap;
 	int color;
+
+	/*
+	 * Fields below here are manipulated internally by pp_* functions and
+	 * should not be counted on by callers.
+	 */
 };
 
 struct userformat_want {
@@ -111,20 +119,20 @@ void pp_title_line(const struct pretty_print_context *pp,
 extern void format_commit_message(const struct commit *commit,
 				  const char *format, struct strbuf *sb,
 				  const struct pretty_print_context *context);
-extern void pretty_print_commit(const struct pretty_print_context *pp,
+extern void pretty_print_commit(struct pretty_print_context *pp,
 				const struct commit *commit,
 				struct strbuf *sb);
 extern void pp_commit_easy(enum cmit_fmt fmt, const struct commit *commit,
 			   struct strbuf *sb);
-void pp_user_info(const struct pretty_print_context *pp,
+void pp_user_info(struct pretty_print_context *pp,
 		  const char *what, struct strbuf *sb,
 		  const char *line, const char *encoding);
-void pp_title_line(const struct pretty_print_context *pp,
+void pp_title_line(struct pretty_print_context *pp,
 		   const char **msg_p,
 		   struct strbuf *sb,
 		   const char *encoding,
 		   int need_8bit_cte);
-void pp_remainder(const struct pretty_print_context *pp,
+void pp_remainder(struct pretty_print_context *pp,
 		  const char **msg_p,
 		  struct strbuf *sb,
 		  int indent);
diff --git a/pretty.c b/pretty.c
index 9e43154..68cd7a0 100644
--- a/pretty.c
+++ b/pretty.c
@@ -406,7 +406,7 @@ static const char *show_ident_date(const struct ident_split *ident,
 	return show_date(date, tz, mode);
 }
 
-void pp_user_info(const struct pretty_print_context *pp,
+void pp_user_info(struct pretty_print_context *pp,
 		  const char *what, struct strbuf *sb,
 		  const char *line, const char *encoding)
 {
@@ -1514,7 +1514,7 @@ void format_commit_message(const struct commit *commit,
 	free(context.signature_check.signer);
 }
 
-static void pp_header(const struct pretty_print_context *pp,
+static void pp_header(struct pretty_print_context *pp,
 		      const char *encoding,
 		      const struct commit *commit,
 		      const char **msg_p,
@@ -1575,7 +1575,7 @@ static void pp_header(const struct pretty_print_context *pp,
 	}
 }
 
-void pp_title_line(const struct pretty_print_context *pp,
+void pp_title_line(struct pretty_print_context *pp,
 		   const char **msg_p,
 		   struct strbuf *sb,
 		   const char *encoding,
@@ -1618,7 +1618,7 @@ void pp_title_line(const struct pretty_print_context *pp,
 	strbuf_release(&title);
 }
 
-void pp_remainder(const struct pretty_print_context *pp,
+void pp_remainder(struct pretty_print_context *pp,
 		  const char **msg_p,
 		  struct strbuf *sb,
 		  int indent)
@@ -1650,7 +1650,7 @@ void pp_remainder(const struct pretty_print_context *pp,
 	}
 }
 
-void pretty_print_commit(const struct pretty_print_context *pp,
+void pretty_print_commit(struct pretty_print_context *pp,
 			 const struct commit *commit,
 			 struct strbuf *sb)
 {
-- 
1.8.3.26.g3f85fc7
