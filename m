From: =?ISO-8859-15?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH 3/3 v2] parse-options: remove PARSE_OPT_NEGHELP
Date: Tue, 28 Feb 2012 20:06:09 +0100
Message-ID: <4F4D25A1.8050702@lsrfire.ath.cx>
References: <4F49317A.3080809@lsrfire.ath.cx> <4F49336C.3000303@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Bert Wesarg <bert.wesarg@googlemail.com>,
	Geoffrey Irving <irving@naml.us>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Pierre Habouzit <madcoder@debian.org>,
	Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 28 20:06:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S2SNT-0004se-T5
	for gcvg-git-2@plane.gmane.org; Tue, 28 Feb 2012 20:06:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030210Ab2B1TGT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Feb 2012 14:06:19 -0500
Received: from india601.server4you.de ([85.25.151.105]:38268 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965674Ab2B1TGR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Feb 2012 14:06:17 -0500
Received: from [192.168.2.105] (p4FFDAFAB.dip.t-dialin.net [79.253.175.171])
	by india601.server4you.de (Postfix) with ESMTPSA id 48E012F8039;
	Tue, 28 Feb 2012 20:06:15 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:10.0.2) Gecko/20120216 Thunderbird/10.0.2
In-Reply-To: <4F49336C.3000303@lsrfire.ath.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191763>

PARSE_OPT_NEGHELP is confusing because short options defined with that
flag do the opposite of what the helptext says. It is also not needed
anymore now that options starting with no- can be negated by removing
that prefix. Convert its only two users to OPT_NEGBIT() and OPT_BOOL()
and then remove support for PARSE_OPT_NEGHELP.

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
---
This version doesn't invert the logic in grep anymore.

 builtin/fast-export.c |    4 +---
 builtin/grep.c        |    5 ++---
 parse-options.c       |    6 ++----
 parse-options.h       |    4 ----
 4 files changed, 5 insertions(+), 14 deletions(-)

diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index 08fed98..19509ea 100644
--- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -647,9 +647,7 @@ int cmd_fast_export(int argc, const char **argv, const char *prefix)
 			     "Output full tree for each commit"),
 		OPT_BOOLEAN(0, "use-done-feature", &use_done_feature,
 			     "Use the done feature to terminate the stream"),
-		{ OPTION_NEGBIT, 0, "data", &no_data, NULL,
-			"Skip output of blob data",
-			PARSE_OPT_NOARG | PARSE_OPT_NEGHELP, NULL, 1 },
+		OPT_BOOL(0, "no-data", &no_data, "Skip output of blob data"),
 		OPT_END()
 	};
 
diff --git a/builtin/grep.c b/builtin/grep.c
index e4ea900..643938d 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -684,9 +684,8 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 	struct option options[] = {
 		OPT_BOOLEAN(0, "cached", &cached,
 			"search in index instead of in the work tree"),
-		{ OPTION_BOOLEAN, 0, "index", &use_index, NULL,
-			"finds in contents not managed by git",
-			PARSE_OPT_NOARG | PARSE_OPT_NEGHELP },
+		OPT_NEGBIT(0, "no-index", &use_index,
+			 "finds in contents not managed by git", 1),
 		OPT_BOOLEAN(0, "untracked", &untracked,
 			"search in both tracked and untracked files"),
 		OPT_SET_INT(0, "exclude-standard", &opt_exclude,
diff --git a/parse-options.c b/parse-options.c
index 8906841..1908996 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -533,7 +533,7 @@ static int usage_with_options_internal(struct parse_opt_ctx_t *ctx,
 			continue;
 
 		pos = fprintf(outfile, "    ");
-		if (opts->short_name && !(opts->flags & PARSE_OPT_NEGHELP)) {
+		if (opts->short_name) {
 			if (opts->flags & PARSE_OPT_NODASH)
 				pos += fprintf(outfile, "%c", opts->short_name);
 			else
@@ -542,9 +542,7 @@ static int usage_with_options_internal(struct parse_opt_ctx_t *ctx,
 		if (opts->long_name && opts->short_name)
 			pos += fprintf(outfile, ", ");
 		if (opts->long_name)
-			pos += fprintf(outfile, "--%s%s",
-				(opts->flags & PARSE_OPT_NEGHELP) ?  "no-" : "",
-				opts->long_name);
+			pos += fprintf(outfile, "--%s", opts->long_name);
 		if (opts->type == OPTION_NUMBER)
 			pos += fprintf(outfile, "-NUM");
 
diff --git a/parse-options.h b/parse-options.h
index 2e811dc..def9ced 100644
--- a/parse-options.h
+++ b/parse-options.h
@@ -40,7 +40,6 @@ enum parse_opt_option_flags {
 	PARSE_OPT_LASTARG_DEFAULT = 16,
 	PARSE_OPT_NODASH = 32,
 	PARSE_OPT_LITERAL_ARGHELP = 64,
-	PARSE_OPT_NEGHELP = 128,
 	PARSE_OPT_SHELL_EVAL = 256
 };
 
@@ -90,9 +89,6 @@ typedef int parse_opt_ll_cb(struct parse_opt_ctx_t *ctx,
  *   PARSE_OPT_LITERAL_ARGHELP: says that argh shouldn't be enclosed in brackets
  *				(i.e. '<argh>') in the help message.
  *				Useful for options with multiple parameters.
- *   PARSE_OPT_NEGHELP: says that the long option should always be shown with
- *				the --no prefix in the usage message. Sometimes
- *				useful for users of OPTION_NEGBIT.
  *
  * `callback`::
  *   pointer to the callback to use for OPTION_CALLBACK or
-- 
1.7.9.2
