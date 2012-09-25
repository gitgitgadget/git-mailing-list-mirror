From: Jeff King <peff@peff.net>
Subject: [PATCH 1/3] pretty: make some commit-parsing helpers more public
Date: Mon, 24 Sep 2012 20:24:17 -0400
Message-ID: <20120925002417.GA19605@sigill.intra.peff.net>
References: <20120925002325.GA19560@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 25 02:24:34 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TGIwz-0007wi-7p
	for gcvg-git-2@plane.gmane.org; Tue, 25 Sep 2012 02:24:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751546Ab2IYAYY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Sep 2012 20:24:24 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:57442 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751465Ab2IYAYX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Sep 2012 20:24:23 -0400
Received: (qmail 7384 invoked by uid 107); 25 Sep 2012 00:24:50 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 24 Sep 2012 20:24:50 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 24 Sep 2012 20:24:17 -0400
Content-Disposition: inline
In-Reply-To: <20120925002325.GA19560@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206336>

This is a quick hack to make these functions available for
the lua code. It would be way cleaner to move all of the
incremental parsing bits to format-commit.[ch] and clean up
the names (e.g., "struct chunk" is not nearly descriptive
enough for a global).

Signed-off-by: Jeff King <peff@peff.net>
---
 commit.h | 36 ++++++++++++++++++++++++++++++++++++
 pretty.c | 38 ++------------------------------------
 2 files changed, 38 insertions(+), 36 deletions(-)

diff --git a/commit.h b/commit.h
index 9f21313..71cd4af 100644
--- a/commit.h
+++ b/commit.h
@@ -126,6 +126,42 @@ void pp_remainder(const struct pretty_print_context *pp,
 		  struct strbuf *sb,
 		  int indent);
 
+struct chunk {
+	size_t off;
+	size_t len;
+};
+
+struct format_commit_context {
+	const struct commit *commit;
+	const struct pretty_print_context *pretty_ctx;
+	unsigned commit_header_parsed:1;
+	unsigned commit_message_parsed:1;
+	unsigned commit_signature_parsed:1;
+	struct {
+		char *gpg_output;
+		char good_bad;
+		char *signer;
+	} signature;
+	char *message;
+	size_t width, indent1, indent2;
+
+	/* These offsets are relative to the start of the commit message. */
+	struct chunk author;
+	struct chunk committer;
+	struct chunk encoding;
+	size_t message_off;
+	size_t subject_off;
+	size_t body_off;
+
+	/* The following ones are relative to the result struct strbuf. */
+	struct chunk abbrev_commit_hash;
+	struct chunk abbrev_tree_hash;
+	struct chunk abbrev_parent_hashes;
+	size_t wrap_start;
+};
+
+void parse_commit_header(struct format_commit_context *);
+void parse_commit_message(struct format_commit_context *);
 
 /** Removes the first commit from a list sorted by date, and adds all
  * of its parents.
diff --git a/pretty.c b/pretty.c
index 8b1ea9f..0d4eb3d 100644
--- a/pretty.c
+++ b/pretty.c
@@ -612,40 +612,6 @@ skip:
 	return 0; /* unknown placeholder */
 }
 
-struct chunk {
-	size_t off;
-	size_t len;
-};
-
-struct format_commit_context {
-	const struct commit *commit;
-	const struct pretty_print_context *pretty_ctx;
-	unsigned commit_header_parsed:1;
-	unsigned commit_message_parsed:1;
-	unsigned commit_signature_parsed:1;
-	struct {
-		char *gpg_output;
-		char good_bad;
-		char *signer;
-	} signature;
-	char *message;
-	size_t width, indent1, indent2;
-
-	/* These offsets are relative to the start of the commit message. */
-	struct chunk author;
-	struct chunk committer;
-	struct chunk encoding;
-	size_t message_off;
-	size_t subject_off;
-	size_t body_off;
-
-	/* The following ones are relative to the result struct strbuf. */
-	struct chunk abbrev_commit_hash;
-	struct chunk abbrev_tree_hash;
-	struct chunk abbrev_parent_hashes;
-	size_t wrap_start;
-};
-
 static int add_again(struct strbuf *sb, struct chunk *chunk)
 {
 	if (chunk->len) {
@@ -663,7 +629,7 @@ static int add_again(struct strbuf *sb, struct chunk *chunk)
 	return 0;
 }
 
-static void parse_commit_header(struct format_commit_context *context)
+void parse_commit_header(struct format_commit_context *context)
 {
 	const char *msg = context->message;
 	int i;
@@ -749,7 +715,7 @@ const char *format_subject(struct strbuf *sb, const char *msg,
 	return msg;
 }
 
-static void parse_commit_message(struct format_commit_context *c)
+void parse_commit_message(struct format_commit_context *c)
 {
 	const char *msg = c->message + c->message_off;
 	const char *start = c->message;
-- 
1.7.12.1.10.g6537447
