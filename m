From: Jeff King <peff@peff.net>
Subject: [PATCH] convert shortlog to use parse_options
Date: Sat, 1 Mar 2008 04:02:32 -0500
Message-ID: <20080301090231.GA16937@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Mar 01 10:03:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JVNcz-0006Fk-Ua
	for gcvg-git-2@gmane.org; Sat, 01 Mar 2008 10:03:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761759AbYCAJCo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Mar 2008 04:02:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759867AbYCAJCn
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Mar 2008 04:02:43 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:4209 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755866AbYCAJCj (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Mar 2008 04:02:39 -0500
Received: (qmail 15434 invoked by uid 111); 1 Mar 2008 09:02:35 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Sat, 01 Mar 2008 04:02:35 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sat, 01 Mar 2008 04:02:32 -0500
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75644>

The behavior should be identical, except that we now support
option bundling (e.g., "git shortlog -nse").

Signed-off-by: Jeff King <peff@peff.net>
---
Another of my pre-1.5.4 cleanups (I think we may enter 1.5.5 freeze
before I get through my backlog!). This was originally rejected because
it changed the semantics of "-w" to allow "-w X,Y,Z". However, Pierre's
c43a24834 forces short options to stick.

This is also, of course, respun on top of Daniel's shortlog changes.

 builtin-shortlog.c |   62 ++++++++++++++++++++++++++++++---------------------
 1 files changed, 36 insertions(+), 26 deletions(-)

diff --git a/builtin-shortlog.c b/builtin-shortlog.c
index af31aba..bf6802e 100644
--- a/builtin-shortlog.c
+++ b/builtin-shortlog.c
@@ -7,9 +7,12 @@
 #include "utf8.h"
 #include "mailmap.h"
 #include "shortlog.h"
+#include "parse-options.h"
 
-static const char shortlog_usage[] =
-"git-shortlog [-n] [-s] [-e] [<commit-id>... ]";
+static const char * const shortlog_usage[] = {
+	"git-shortlog [-n] [-s] [-e] [<commit-id>... ]",
+	NULL
+};
 
 static int compare_by_number(const void *a1, const void *a2)
 {
@@ -188,8 +191,6 @@ static const char wrap_arg_usage[] = "-w[<width>[,<indent1>[,<indent2>]]]";
 
 static void parse_wrap_args(const char *arg, int *in1, int *in2, int *wrap)
 {
-	arg += 2; /* skip -w */
-
 	*wrap = parse_uint(&arg, ',');
 	if (*wrap < 0)
 		die(wrap_arg_usage);
@@ -212,6 +213,16 @@ static void parse_wrap_args(const char *arg, int *in1, int *in2, int *wrap)
 		die(wrap_arg_usage);
 }
 
+static int parse_wrap_callback(const struct option *opt, const char *arg,
+		int unset)
+{
+	struct shortlog *log = opt->value;
+	log->wrap_lines = 1;
+	if (arg)
+		parse_wrap_args(arg, &log->wrap, &log->in1, &log->in2);
+	return 0;
+}
+
 void shortlog_init(struct shortlog *log)
 {
 	memset(log, 0, sizeof(*log));
@@ -231,29 +242,28 @@ int cmd_shortlog(int argc, const char **argv, const char *prefix)
 
 	shortlog_init(&log);
 
-	/* since -n is a shadowed rev argument, parse our args first */
-	while (argc > 1) {
-		if (!strcmp(argv[1], "-n") || !strcmp(argv[1], "--numbered"))
-			log.sort_by_number = 1;
-		else if (!strcmp(argv[1], "-s") ||
-				!strcmp(argv[1], "--summary"))
-			log.summary = 1;
-		else if (!strcmp(argv[1], "-e") ||
-			 !strcmp(argv[1], "--email"))
-			log.email = 1;
-		else if (!prefixcmp(argv[1], "-w")) {
-			log.wrap_lines = 1;
-			parse_wrap_args(argv[1], &log.in1, &log.in2, &log.wrap);
-		}
-		else if (!strcmp(argv[1], "-h") || !strcmp(argv[1], "--help"))
-			usage(shortlog_usage);
-		else
-			break;
-		argv++;
-		argc--;
-	}
+	struct option options[] = {
+		OPT_BOOLEAN('n', "numbered", &log.sort_by_number,
+				"sort by number"),
+		OPT_BOOLEAN('s', "summary", &log.summary,
+				"show commit count summary"),
+		OPT_BOOLEAN('e', "email", &log.email, "show email addresses"),
+		{
+			OPTION_CALLBACK, 'w', NULL, &log, "wrap",
+			"line-wrap commit message", PARSE_OPT_OPTARG,
+			parse_wrap_callback
+		},
+		OPT_END()
+	};
+
+	argc = parse_options(argc, argv, options, shortlog_usage, 0);
+
 	init_revisions(&rev, prefix);
-	argc = setup_revisions(argc, argv, &rev, NULL);
+	/* setup_revisions expects to have the program name in argv[0],
+	 * but parse_options has removed it. We have to do parse_options
+	 * before setup_revisions, though, to claim "-n". */
+	argc = setup_revisions(argc+1, argv-1, &rev, NULL);
+
 	if (argc > 1)
 		die ("unrecognized argument: %s", argv[1]);
 
-- 
1.5.4.3.341.g4e44
