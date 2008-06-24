From: Pierre Habouzit <madcoder@debian.org>
Subject: [PATCH 2/7] parse-opt: Export a non NORETURN usage dumper.
Date: Tue, 24 Jun 2008 11:12:07 +0200
Message-ID: <1214298732-6247-3-git-send-email-madcoder@debian.org>
References: <alpine.LFD.1.10.0806222207220.2926@woody.linux-foundation.org>
 <1214298732-6247-1-git-send-email-madcoder@debian.org>
 <1214298732-6247-2-git-send-email-madcoder@debian.org>
Cc: torvalds@linux-foundation.org, gitster@pobox.com, peff@peff.net,
	Johannes.Schindelin@gmx.de, Pierre Habouzit <madcoder@debian.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 24 11:13:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KB4aQ-0007aq-7d
	for gcvg-git-2@gmane.org; Tue, 24 Jun 2008 11:13:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752795AbYFXJMS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jun 2008 05:12:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753017AbYFXJMS
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Jun 2008 05:12:18 -0400
Received: from pan.madism.org ([88.191.52.104]:48570 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752217AbYFXJMP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jun 2008 05:12:15 -0400
Received: from madism.org (APuteaux-103-1-3-109.w217-128.abo.wanadoo.fr [217.128.49.109])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (verified OK))
	by hermes.madism.org (Postfix) with ESMTPS id 8E1C2380E5;
	Tue, 24 Jun 2008 11:12:14 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id 1CD043D691E; Tue, 24 Jun 2008 11:12:12 +0200 (CEST)
X-Mailer: git-send-email 1.5.6.110.g736c7.dirty
In-Reply-To: <1214298732-6247-2-git-send-email-madcoder@debian.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86020>

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
1.5.6.110.g736c7.dirty
