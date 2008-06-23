From: Pierre Habouzit <madcoder@debian.org>
Subject: [PATCH] parse-opt: Export a non NORETURN usage dumper.
Date: Mon, 23 Jun 2008 23:11:19 +0200
Message-ID: <1214255482-2086-2-git-send-email-madcoder@debian.org>
References: <20080623210935.GC13395@artemis.madism.org>
 <1214255482-2086-1-git-send-email-madcoder@debian.org>
Cc: peff@peff.net, Johannes.Schindelin@gmx.de, gitster@pobox.com,
	Pierre Habouzit <madcoder@debian.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 23 23:12:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KAtKx-00069F-Bf
	for gcvg-git-2@gmane.org; Mon, 23 Jun 2008 23:12:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756017AbYFWVL2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Jun 2008 17:11:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755756AbYFWVL2
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Jun 2008 17:11:28 -0400
Received: from pan.madism.org ([88.191.52.104]:51109 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754434AbYFWVL0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jun 2008 17:11:26 -0400
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (verified OK))
	by hermes.madism.org (Postfix) with ESMTPS id E28FE37F40;
	Mon, 23 Jun 2008 23:11:24 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id CF05999B65; Mon, 23 Jun 2008 23:11:22 +0200 (CEST)
X-Mailer: git-send-email 1.5.6.117.g5fe2
In-Reply-To: <1214255482-2086-1-git-send-email-madcoder@debian.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85926>

Signed-off-by: Pierre Habouzit <madcoder@debian.org>
---
 parse-options.c |   24 +++++++++++++++++-------
 parse-options.h |    9 +++++++++
 2 files changed, 26 insertions(+), 7 deletions(-)

diff --git a/parse-options.c b/parse-options.c
index 774e647..4e9e675 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -257,8 +257,8 @@ int parse_options_end(struct parse_opt_ctx_t *ctx)
 	return ctx->cpidx + ctx->argc;
 }
 
-static NORETURN void usage_with_options_internal(const char * const *,
-                                                 const struct option *, int);
+static int usage_with_options_internal(const char * const *,
+                                       const struct option *, int, int);
 
 int parse_options(int argc, const char **argv, const struct option *options,
                   const char * const usagestr[], int flags)
@@ -302,7 +302,7 @@ int parse_options(int argc, const char **argv, const struct option *options,
 		}
 
 		if (!strcmp(arg + 2, "help-all"))
-			usage_with_options_internal(usagestr, options, 1);
+			usage_with_options_internal(usagestr, options, 1, 1);
 		if (!strcmp(arg + 2, "help"))
 			usage_with_options(usagestr, options);
 		if (parse_long_opt(&ctx, arg + 2, options))
@@ -315,8 +315,8 @@ int parse_options(int argc, const char **argv, const struct option *options,
 #define USAGE_OPTS_WIDTH 24
 #define USAGE_GAP         2
 
-void usage_with_options_internal(const char * const *usagestr,
-                                 const struct option *opts, int full)
+int usage_with_options_internal(const char * const *usagestr,
+                                const struct option *opts, int full, int do_exit)
 {
 	fprintf(stderr, "usage: %s\n", *usagestr++);
 	while (*usagestr && **usagestr)
@@ -401,15 +401,25 @@ void usage_with_options_internal(const char * const *usagestr,
 	}
 	fputc('\n', stderr);
 
-	exit(129);
+	if (do_exit)
+		exit(129);
+	return PARSE_OPT_HELP;
 }
 
 void usage_with_options(const char * const *usagestr,
                         const struct option *opts)
 {
-	usage_with_options_internal(usagestr, opts, 0);
+	usage_with_options_internal(usagestr, opts, 0, 1);
+	exit(129); /* make gcc happy */
+}
+
+int parse_options_usage(const char * const *usagestr,
+                        const struct option *opts)
+{
+	return usage_with_options_internal(usagestr, opts, 0, 0);
 }
 
+
 /*----- some often used options -----*/
 #include "cache.h"
 
diff --git a/parse-options.h b/parse-options.h
index db6c986..424ea46 100644
--- a/parse-options.h
+++ b/parse-options.h
@@ -113,6 +113,12 @@ extern NORETURN void usage_with_options(const char * const *usagestr,
 
 /*----- incremantal advanced APIs -----*/
 
+enum {
+	PARSE_OPT_HELP = -1,
+	PARSE_OPT_DONE,
+	PARSE_OPT_UNKNOWN,
+};
+
 struct parse_opt_ctx_t {
 	const char **argv;
 	const char **out;
@@ -121,6 +127,9 @@ struct parse_opt_ctx_t {
 	int flags;
 };
 
+extern int parse_options_usage(const char * const *usagestr,
+                               const struct option *opts);
+
 extern void parse_options_start(struct parse_opt_ctx_t *ctx,
                                 int argc, const char **argv, int flags);
 
-- 
1.5.6.117.g5fe2
