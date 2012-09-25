From: Jeff King <peff@peff.net>
Subject: [PATCH 3/3] add a "lua" pretty format
Date: Mon, 24 Sep 2012 20:25:39 -0400
Message-ID: <20120925002539.GC19605@sigill.intra.peff.net>
References: <20120925002325.GA19560@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 25 02:25:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TGIyI-00006z-Q5
	for gcvg-git-2@plane.gmane.org; Tue, 25 Sep 2012 02:25:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751780Ab2IYAZq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Sep 2012 20:25:46 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:57448 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751521Ab2IYAZp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Sep 2012 20:25:45 -0400
Received: (qmail 7450 invoked by uid 107); 25 Sep 2012 00:26:12 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 24 Sep 2012 20:26:12 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 24 Sep 2012 20:25:39 -0400
Content-Disposition: inline
In-Reply-To: <20120925002325.GA19560@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206338>

With this patch, you can do:

  git log --pretty=lua:'
    return abbrev(hash()) .. " (" .. author().email .. ") " .. subject()
  '

Signed-off-by: Jeff King <peff@peff.net>
---
 commit.h   |  1 +
 log-tree.c |  3 ++-
 pretty.c   | 21 +++++++++++++++++++--
 3 files changed, 22 insertions(+), 3 deletions(-)

diff --git a/commit.h b/commit.h
index 71cd4af..8865a36 100644
--- a/commit.h
+++ b/commit.h
@@ -73,6 +73,7 @@ enum cmit_fmt {
 	CMIT_FMT_ONELINE,
 	CMIT_FMT_EMAIL,
 	CMIT_FMT_USERFORMAT,
+	CMIT_FMT_LUA,
 
 	CMIT_FMT_UNSPECIFIED
 };
diff --git a/log-tree.c b/log-tree.c
index c894930..c8274d1 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -599,7 +599,8 @@ void show_log(struct rev_info *opt)
 	if (opt->commit_format == CMIT_FMT_EMAIL) {
 		log_write_email_headers(opt, commit, &ctx.subject, &extra_headers,
 					&ctx.need_8bit_cte);
-	} else if (opt->commit_format != CMIT_FMT_USERFORMAT) {
+	} else if (opt->commit_format != CMIT_FMT_USERFORMAT &&
+		   opt->commit_format != CMIT_FMT_LUA) {
 		fputs(diff_get_color_opt(&opt->diffopt, DIFF_COMMIT), stdout);
 		if (opt->commit_format != CMIT_FMT_ONELINE)
 			fputs("commit ", stdout);
diff --git a/pretty.c b/pretty.c
index 0d4eb3d..fdd4258 100644
--- a/pretty.c
+++ b/pretty.c
@@ -10,6 +10,7 @@
 #include "color.h"
 #include "reflog-walk.h"
 #include "gpg-interface.h"
+#include "lua-commit.h"
 
 static char *user_format;
 static struct cmt_fmt_map {
@@ -33,6 +34,13 @@ static void save_user_format(struct rev_info *rev, const char *cp, int is_tforma
 	rev->commit_format = CMIT_FMT_USERFORMAT;
 }
 
+static void save_lua_format(struct rev_info *rev, const char *cp, int is_tformat)
+{
+	lua_commit_init(cp);
+	save_user_format(rev, cp, is_tformat);
+	rev->commit_format = CMIT_FMT_LUA;
+}
+
 static int git_pretty_formats_config(const char *var, const char *value, void *cb)
 {
 	struct cmt_fmt_map *commit_format = NULL;
@@ -155,6 +163,10 @@ void get_commit_format(const char *arg, struct rev_info *rev)
 		save_user_format(rev, strchr(arg, ':') + 1, arg[0] == 't');
 		return;
 	}
+	if (!prefixcmp(arg, "lua:")) {
+		save_lua_format(rev, arg + 4, 1);
+		return;
+	}
 
 	if (strchr(arg, '%')) {
 		save_user_format(rev, arg, 1);
@@ -1168,7 +1180,11 @@ void format_commit_message(const struct commit *commit,
 		free(enc);
 	}
 
-	strbuf_expand(sb, format, format_commit_item, &context);
+	if (pretty_ctx->fmt == CMIT_FMT_USERFORMAT)
+		strbuf_expand(sb, format, format_commit_item, &context);
+	else if (pretty_ctx->fmt == CMIT_FMT_LUA)
+		lua_commit_format(sb, &context);
+
 	rewrap_message_tail(sb, &context, 0, 0, 0);
 
 	if (context.message != commit->buffer)
@@ -1328,7 +1344,8 @@ void pretty_print_commit(const struct pretty_print_context *pp,
 	const char *encoding;
 	int need_8bit_cte = pp->need_8bit_cte;
 
-	if (pp->fmt == CMIT_FMT_USERFORMAT) {
+	if (pp->fmt == CMIT_FMT_USERFORMAT ||
+	    pp->fmt == CMIT_FMT_LUA) {
 		format_commit_message(commit, user_format, sb, pp);
 		return;
 	}
-- 
1.7.12.1.10.g6537447
