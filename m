From: Jeff King <peff@peff.net>
Subject: [PATCH 4/6] checkout-index: handle "--no-index" option
Date: Sun, 31 Jan 2016 06:29:36 -0500
Message-ID: <20160131112936.GD5116@sigill.intra.peff.net>
References: <20160131112215.GA4589@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 31 12:30:18 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aPqCQ-0000Yu-P6
	for gcvg-git-2@plane.gmane.org; Sun, 31 Jan 2016 12:29:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757371AbcAaL3m (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 Jan 2016 06:29:42 -0500
Received: from cloud.peff.net ([50.56.180.127]:35056 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757369AbcAaL3l (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Jan 2016 06:29:41 -0500
Received: (qmail 7437 invoked by uid 102); 31 Jan 2016 11:29:42 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sun, 31 Jan 2016 06:29:42 -0500
Received: (qmail 15717 invoked by uid 107); 31 Jan 2016 11:30:06 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sun, 31 Jan 2016 06:30:06 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 31 Jan 2016 06:29:36 -0500
Content-Disposition: inline
In-Reply-To: <20160131112215.GA4589@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285138>

The parsing of "--index" is done in a callback, but it does
not handle an "unset" option. We don't necessarily expect
anyone to use this, but the current behavior is to treat it
exactly like "--index", which would probably be surprising.

Instead, let's just turn it into an OPT_BOOL, and handle it
after we're done parsing. This makes "--no-index" just work
(it cancels a previous "--index").

As a bonus, this makes the logic easier to follow. The old
code opened the index during the option parsing, leaving the
reader to wonder if there was some timing issue (there
isn't; none of the other options care that we've opened it).
And then if we found that "--prefix" had been given, we had
to rollback the index. Now we can simply avoid opening it in
the first place.

Note that it might make more sense for checkout-index to
complain when "--index --prefix=foo" is given (rather than
silently ignoring "--index"), but since it has been that way
since 415e96c ([PATCH] Implement git-checkout-cache -u to
update stat information in the cache., 2005-05-15), it's
safer to leave it as-is.

Signed-off-by: Jeff King <peff@peff.net>
---
I also reformatted the comment that violated our style
guidelines, but I am not sure if it is all that helpful. It
seems we also cancel "--index" with "--temp" or
"--stage=all", but I do not know why. I left the content
as-is, but if somebody knows enough to elaborate, it might
be worth doing.

 builtin/checkout-index.c | 34 ++++++++++------------------------
 1 file changed, 10 insertions(+), 24 deletions(-)

diff --git a/builtin/checkout-index.c b/builtin/checkout-index.c
index 43bedde..f8179a7 100644
--- a/builtin/checkout-index.c
+++ b/builtin/checkout-index.c
@@ -130,18 +130,6 @@ static const char * const builtin_checkout_index_usage[] = {
 
 static struct lock_file lock_file;
 
-static int option_parse_u(const struct option *opt,
-			      const char *arg, int unset)
-{
-	int *newfd = opt->value;
-
-	state.refresh_cache = 1;
-	state.istate = &the_index;
-	if (*newfd < 0)
-		*newfd = hold_locked_index(&lock_file, 1);
-	return 0;
-}
-
 static int option_parse_stage(const struct option *opt,
 			      const char *arg, int unset)
 {
@@ -166,6 +154,7 @@ int cmd_checkout_index(int argc, const char **argv, const char *prefix)
 	int read_from_stdin = 0;
 	int prefix_length;
 	int force = 0, quiet = 0, not_new = 0;
+	int index_opt = 0;
 	struct option builtin_checkout_index_options[] = {
 		OPT_BOOL('a', "all", &all,
 			N_("check out all files in the index")),
@@ -174,9 +163,8 @@ int cmd_checkout_index(int argc, const char **argv, const char *prefix)
 			N_("no warning for existing files and files not in index")),
 		OPT_BOOL('n', "no-create", &not_new,
 			N_("don't checkout new files")),
-		{ OPTION_CALLBACK, 'u', "index", &newfd, NULL,
-			N_("update stat information in the index file"),
-			PARSE_OPT_NOARG, option_parse_u },
+		OPT_BOOL('u', "index", &index_opt,
+			 N_("update stat information in the index file")),
 		OPT_BOOL('z', NULL, &nul_term_line,
 			N_("paths are separated with NUL character")),
 		OPT_BOOL(0, "stdin", &read_from_stdin,
@@ -211,15 +199,13 @@ int cmd_checkout_index(int argc, const char **argv, const char *prefix)
 		state.base_dir = "";
 	state.base_dir_len = strlen(state.base_dir);
 
-	if (state.base_dir_len || to_tempfile) {
-		/* when --prefix is specified we do not
-		 * want to update cache.
-		 */
-		if (state.refresh_cache) {
-			rollback_lock_file(&lock_file);
-			newfd = -1;
-		}
-		state.refresh_cache = 0;
+	/*
+	 * when --prefix is specified we do not want to update cache.
+	 */
+	if (index_opt && !state.base_dir_len && !to_tempfile) {
+		state.refresh_cache = 1;
+		state.istate = &the_index;
+		newfd = hold_locked_index(&lock_file, 1);
 	}
 
 	/* Check out named files first */
-- 
2.7.0.489.g6faad84
