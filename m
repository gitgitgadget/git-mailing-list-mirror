From: Jeff King <peff@peff.net>
Subject: [PATCH 3/6] checkout-index: handle "--no-prefix" option
Date: Sun, 31 Jan 2016 06:26:16 -0500
Message-ID: <20160131112615.GC5116@sigill.intra.peff.net>
References: <20160131112215.GA4589@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 31 12:26:34 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aPq98-0004rj-3Q
	for gcvg-git-2@plane.gmane.org; Sun, 31 Jan 2016 12:26:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757318AbcAaL0T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 Jan 2016 06:26:19 -0500
Received: from cloud.peff.net ([50.56.180.127]:35052 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757306AbcAaL0S (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Jan 2016 06:26:18 -0500
Received: (qmail 7266 invoked by uid 102); 31 Jan 2016 11:26:18 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sun, 31 Jan 2016 06:26:18 -0500
Received: (qmail 15692 invoked by uid 107); 31 Jan 2016 11:26:43 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sun, 31 Jan 2016 06:26:43 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 31 Jan 2016 06:26:16 -0500
Content-Disposition: inline
In-Reply-To: <20160131112215.GA4589@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285137>

We use a custom callback to parse "--prefix", but it does
not handle the "unset" case. As a result, passing
"--no-prefix" will cause a segfault.

We can fix this by switching it to an OPT_STRING, which
makes "--no-prefix" counteract a previous "--prefix". Note
that this assigns NULL, so we bump our default-case
initialization to lower in the main function.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/checkout-index.c | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/builtin/checkout-index.c b/builtin/checkout-index.c
index 3b913d1..43bedde 100644
--- a/builtin/checkout-index.c
+++ b/builtin/checkout-index.c
@@ -142,14 +142,6 @@ static int option_parse_u(const struct option *opt,
 	return 0;
 }
 
-static int option_parse_prefix(const struct option *opt,
-			       const char *arg, int unset)
-{
-	state.base_dir = arg;
-	state.base_dir_len = strlen(arg);
-	return 0;
-}
-
 static int option_parse_stage(const struct option *opt,
 			      const char *arg, int unset)
 {
@@ -191,9 +183,8 @@ int cmd_checkout_index(int argc, const char **argv, const char *prefix)
 			N_("read list of paths from the standard input")),
 		OPT_BOOL(0, "temp", &to_tempfile,
 			N_("write the content to temporary files")),
-		OPT_CALLBACK(0, "prefix", NULL, N_("string"),
-			N_("when creating files, prepend <string>"),
-			option_parse_prefix),
+		OPT_STRING(0, "prefix", &state.base_dir, N_("string"),
+			N_("when creating files, prepend <string>")),
 		OPT_CALLBACK(0, "stage", NULL, NULL,
 			N_("copy out the files from named stage"),
 			option_parse_stage),
@@ -204,7 +195,6 @@ int cmd_checkout_index(int argc, const char **argv, const char *prefix)
 		usage_with_options(builtin_checkout_index_usage,
 				   builtin_checkout_index_options);
 	git_config(git_default_config, NULL);
-	state.base_dir = "";
 	prefix_length = prefix ? strlen(prefix) : 0;
 
 	if (read_cache() < 0) {
@@ -217,6 +207,10 @@ int cmd_checkout_index(int argc, const char **argv, const char *prefix)
 	state.quiet = quiet;
 	state.not_new = not_new;
 
+	if (!state.base_dir)
+		state.base_dir = "";
+	state.base_dir_len = strlen(state.base_dir);
+
 	if (state.base_dir_len || to_tempfile) {
 		/* when --prefix is specified we do not
 		 * want to update cache.
-- 
2.7.0.489.g6faad84
