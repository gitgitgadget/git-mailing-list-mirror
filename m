From: Jeff King <peff@peff.net>
Subject: [PATCH 3/5] pretty: add pp_commit_easy function for simple callers
Date: Thu, 26 May 2011 18:27:24 -0400
Message-ID: <20110526222724.GA21775@sigill.intra.peff.net>
References: <20110526222450.GA20077@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: "Stefan-W. Hahn" <stefan.hahn@s-hahn.de>
X-From: git-owner@vger.kernel.org Fri May 27 00:27:32 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QPj1g-0007ic-1r
	for gcvg-git-2@lo.gmane.org; Fri, 27 May 2011 00:27:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758578Ab1EZW11 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 May 2011 18:27:27 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:33258
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758450Ab1EZW11 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 May 2011 18:27:27 -0400
Received: (qmail 18613 invoked by uid 107); 26 May 2011 22:27:26 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 26 May 2011 18:27:26 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 26 May 2011 18:27:24 -0400
Content-Disposition: inline
In-Reply-To: <20110526222450.GA20077@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174586>

Many callers don't actually care about the pretty print
context at all; let's just give them a simple way of
pretty-printing a commit without having to create a context
struct.

Signed-off-by: Jeff King <peff@peff.net>
---
This trades off per-call lines for some infrastructure lines. It's a
slight lose in line count now, but as more callers are added, it may be
a win. But I think even now it's overall easier to read.

 builtin/branch.c      |    4 +---
 builtin/checkout.c    |    3 +--
 builtin/log.c         |    4 +---
 builtin/shortlog.c    |    3 +--
 builtin/show-branch.c |    3 +--
 commit.h              |    2 ++
 pretty.c              |    7 +++++++
 7 files changed, 14 insertions(+), 12 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index 9e546e4..d8f1522 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -436,9 +436,7 @@ static void print_ref_item(struct ref_item *item, int maxwidth, int verbose,
 
 		commit = item->commit;
 		if (commit && !parse_commit(commit)) {
-			struct pretty_print_context ctx = {0};
-			pretty_print_commit(CMIT_FMT_ONELINE, commit,
-					    &subject, &ctx);
+			pp_commit_easy(CMIT_FMT_ONELINE, commit, &subject);
 			sub = subject.buf;
 		}
 
diff --git a/builtin/checkout.c b/builtin/checkout.c
index 757f9a0..c1759dc 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -300,9 +300,8 @@ static void show_local_changes(struct object *head, struct diff_options *opts)
 static void describe_detached_head(char *msg, struct commit *commit)
 {
 	struct strbuf sb = STRBUF_INIT;
-	struct pretty_print_context ctx = {0};
 	parse_commit(commit);
-	pretty_print_commit(CMIT_FMT_ONELINE, commit, &sb, &ctx);
+	pp_commit_easy(CMIT_FMT_ONELINE, commit, &sb);
 	fprintf(stderr, "%s %s... %s\n", msg,
 		find_unique_abbrev(commit->object.sha1, DEFAULT_ABBREV), sb.buf);
 	strbuf_release(&sb);
diff --git a/builtin/log.c b/builtin/log.c
index d8c6c28..cedfdb6 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -1439,9 +1439,7 @@ int cmd_cherry(int argc, const char **argv, const char *prefix)
 
 		if (verbose) {
 			struct strbuf buf = STRBUF_INIT;
-			struct pretty_print_context ctx = {0};
-			pretty_print_commit(CMIT_FMT_ONELINE, commit,
-					    &buf, &ctx);
+			pp_commit_easy(CMIT_FMT_ONELINE, commit, &buf);
 			printf("%c %s %s\n", sign,
 			       find_unique_abbrev(commit->object.sha1, abbrev),
 			       buf.buf);
diff --git a/builtin/shortlog.c b/builtin/shortlog.c
index 1a21e4b..90877b5 100644
--- a/builtin/shortlog.c
+++ b/builtin/shortlog.c
@@ -141,9 +141,8 @@ void shortlog_add_commit(struct shortlog *log, struct commit *commit)
 	const char *author = NULL, *buffer;
 	struct strbuf buf = STRBUF_INIT;
 	struct strbuf ufbuf = STRBUF_INIT;
-	struct pretty_print_context ctx = {0};
 
-	pretty_print_commit(CMIT_FMT_RAW, commit, &buf, &ctx);
+	pp_commit_easy(CMIT_FMT_RAW, commit, &buf);
 	buffer = buf.buf;
 	while (*buffer && *buffer != '\n') {
 		const char *eol = strchr(buffer, '\n');
diff --git a/builtin/show-branch.c b/builtin/show-branch.c
index da69581..a5fc2aa 100644
--- a/builtin/show-branch.c
+++ b/builtin/show-branch.c
@@ -293,8 +293,7 @@ static void show_one_commit(struct commit *commit, int no_name)
 	struct commit_name *name = commit->util;
 
 	if (commit->object.parsed) {
-		struct pretty_print_context ctx = {0};
-		pretty_print_commit(CMIT_FMT_ONELINE, commit, &pretty, &ctx);
+		pp_commit_easy(CMIT_FMT_ONELINE, commit, &pretty);
 		pretty_str = pretty.buf;
 	}
 	if (!prefixcmp(pretty_str, "[PATCH] "))
diff --git a/commit.h b/commit.h
index eb6c5af..3e733be 100644
--- a/commit.h
+++ b/commit.h
@@ -98,6 +98,8 @@ extern void format_commit_message(const struct commit *commit,
 extern void pretty_print_commit(enum cmit_fmt fmt, const struct commit *commit,
 				struct strbuf *sb,
 				const struct pretty_print_context *context);
+extern void pp_commit_easy(enum cmit_fmt fmt, const struct commit *commit,
+			   struct strbuf *sb);
 void pp_user_info(const char *what, enum cmit_fmt fmt, struct strbuf *sb,
 		   const char *line, enum date_mode dmode,
 		   const char *encoding);
diff --git a/pretty.c b/pretty.c
index 65d20a7..38cd398 100644
--- a/pretty.c
+++ b/pretty.c
@@ -1279,3 +1279,10 @@ void pretty_print_commit(enum cmit_fmt fmt, const struct commit *commit,
 
 	free(reencoded);
 }
+
+void pp_commit_easy(enum cmit_fmt fmt, const struct commit *commit,
+		    struct strbuf *sb)
+{
+	struct pretty_print_context pp = {0};
+	pretty_print_commit(fmt, commit, sb, &pp);
+}
-- 
1.7.4.5.26.g0c6a2
