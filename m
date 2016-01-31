From: Jeff King <peff@peff.net>
Subject: [PATCH 6/6] apply, ls-files: simplify "-z" parsing
Date: Sun, 31 Jan 2016 06:35:46 -0500
Message-ID: <20160131113546.GF5116@sigill.intra.peff.net>
References: <20160131112215.GA4589@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 31 12:36:25 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aPqId-0000v9-8s
	for gcvg-git-2@plane.gmane.org; Sun, 31 Jan 2016 12:36:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757310AbcAaLfv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 Jan 2016 06:35:51 -0500
Received: from cloud.peff.net ([50.56.180.127]:35065 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757298AbcAaLfv (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Jan 2016 06:35:51 -0500
Received: (qmail 7702 invoked by uid 102); 31 Jan 2016 11:35:51 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sun, 31 Jan 2016 06:35:51 -0500
Received: (qmail 15890 invoked by uid 107); 31 Jan 2016 11:36:16 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sun, 31 Jan 2016 06:36:16 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 31 Jan 2016 06:35:47 -0500
Content-Disposition: inline
In-Reply-To: <20160131112215.GA4589@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285140>

As a short option, we cannot handle negation. Thus a
callback handling "unset" is overkill, and we can just use
OPT_SET_INT instead to handle setting the option.

Signed-off-by: Jeff King <peff@peff.net>
---
I left this one for last, because it's the most questionable. Unlike the
previous "-z" case, we're setting the actual character, so the logic is
inverted: turning on the option sets it to 0, and turning it off restore
'\n'.

This means OPT_SET_INT would do the wrong thing for the "unset" case, as
it would put a "0" into the option. You can't trigger that now, but if
somebody were to add a long option (e.g., "--nul"), then "--no-nul"
would do the wrong thing.

I'm on the fence on whether the simplification is worth it, or if we
should leave the callbacks as future-proofing.

 builtin/apply.c    | 15 ++-------------
 builtin/ls-files.c | 13 ++-----------
 2 files changed, 4 insertions(+), 24 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index deb1364..565f3fd 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -4464,16 +4464,6 @@ static int option_parse_p(const struct option *opt,
 	return 0;
 }
 
-static int option_parse_z(const struct option *opt,
-			  const char *arg, int unset)
-{
-	if (unset)
-		line_termination = '\n';
-	else
-		line_termination = 0;
-	return 0;
-}
-
 static int option_parse_space_change(const struct option *opt,
 			  const char *arg, int unset)
 {
@@ -4546,9 +4536,8 @@ int cmd_apply(int argc, const char **argv, const char *prefix_)
 			 N_( "attempt three-way merge if a patch does not apply")),
 		OPT_FILENAME(0, "build-fake-ancestor", &fake_ancestor,
 			N_("build a temporary index based on embedded index information")),
-		{ OPTION_CALLBACK, 'z', NULL, NULL, NULL,
-			N_("paths are separated with NUL character"),
-			PARSE_OPT_NOARG, option_parse_z },
+		OPT_SET_INT('z', NULL, &line_termination,
+			N_("paths are separated with NUL character"), '\0'),
 		OPT_INTEGER('C', NULL, &p_context,
 				N_("ensure at least <n> lines of context match")),
 		{ OPTION_CALLBACK, 0, "whitespace", &whitespace_option, N_("action"),
diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index b6a7cb0..59bad9b 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -359,14 +359,6 @@ static const char * const ls_files_usage[] = {
 	NULL
 };
 
-static int option_parse_z(const struct option *opt,
-			  const char *arg, int unset)
-{
-	line_terminator = unset ? '\n' : '\0';
-
-	return 0;
-}
-
 static int option_parse_exclude(const struct option *opt,
 				const char *arg, int unset)
 {
@@ -408,9 +400,8 @@ int cmd_ls_files(int argc, const char **argv, const char *cmd_prefix)
 	struct exclude_list *el;
 	struct string_list exclude_list = STRING_LIST_INIT_NODUP;
 	struct option builtin_ls_files_options[] = {
-		{ OPTION_CALLBACK, 'z', NULL, NULL, NULL,
-			N_("paths are separated with NUL character"),
-			PARSE_OPT_NOARG, option_parse_z },
+		OPT_SET_INT('z', NULL, &line_terminator,
+			N_("paths are separated with NUL character"), '\0'),
 		OPT_BOOL('t', NULL, &show_tag,
 			N_("identify the file status with tags")),
 		OPT_BOOL('v', NULL, &show_valid_bit,
-- 
2.7.0.489.g6faad84
