From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v4 08/21] checkout-index: there are only two possible
 line terminations
Date: Fri, 15 Jan 2016 15:20:54 -0500
Message-ID: <20160115202053.GA27640@sigill.intra.peff.net>
References: <1452740590-16827-1-git-send-email-gitster@pobox.com>
 <1452815916-6447-1-git-send-email-gitster@pobox.com>
 <1452815916-6447-9-git-send-email-gitster@pobox.com>
 <20160115200856.GC11301@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 15 21:21:03 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aKArl-0000UX-EQ
	for gcvg-git-2@plane.gmane.org; Fri, 15 Jan 2016 21:21:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751564AbcAOUU5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Jan 2016 15:20:57 -0500
Received: from cloud.peff.net ([50.56.180.127]:54624 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750801AbcAOUU4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jan 2016 15:20:56 -0500
Received: (qmail 10306 invoked by uid 102); 15 Jan 2016 20:20:56 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 15 Jan 2016 15:20:56 -0500
Received: (qmail 23428 invoked by uid 107); 15 Jan 2016 20:21:15 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 15 Jan 2016 15:21:15 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 15 Jan 2016 15:20:54 -0500
Content-Disposition: inline
In-Reply-To: <20160115200856.GC11301@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284208>

On Fri, Jan 15, 2016 at 03:08:56PM -0500, Jeff King wrote:

> Is it worth doing this on top?
> 
> -- >8 --
> Subject: [PATCH] checkout-index: simplify "-z" option parsing
> 
> Now that we act as a simple bool, there's no need to use a
> custom callback.

Of course this is a backward step if we wanted to add negation. But I
suspect if we did so it would not be as "--no-nul-termination" (which
involves inventing "--nul-termination" in the first place), but rather
as a separate option. Anyway, since AFAIK nobody has plans to add one,
the code has been like this for years, we don't significantly impede
anyone from doing it later, I'm inclined to err on the side of
simplifying.

If we do, there are two similar candidates:

-- >8 --
Subject: [PATCH] apply, ls-files: simplify "-z" parsing

As a short option, we cannot handle negation. Thus a
callback handling "unset" is overkill, and we can just use
OPT_SET_INT instead to handle setting the option.

Signed-off-by: Jeff King <peff@peff.net>
---
These could also become OPT_BOOL, but then we have to translate that to
'\n' / NUL later in the code.

I was also curious what "--no-foo" does (if a long option _is_ defined)
with OPT_SET_INT. It resets the value to 0, which would be wrong in this
case. I guess that makes a slight trap for anybody adding
"--nul-termination" later (if they do not think about 
"--no-nul-termination", they may not realize it does not work). I'm not
all that moved by that line of reasoning personally, though.

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
2.7.0.244.g0701a9d
