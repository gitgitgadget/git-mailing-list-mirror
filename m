From: Jeff King <peff@peff.net>
Subject: [RFH] convert shortlog to use parse_options
Date: Thu, 13 Dec 2007 00:52:26 -0500
Message-ID: <20071213055226.GA3636@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Thu Dec 13 06:52:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J2h0A-0001G6-Bn
	for gcvg-git-2@gmane.org; Thu, 13 Dec 2007 06:52:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751209AbXLMFwa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Dec 2007 00:52:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751002AbXLMFwa
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Dec 2007 00:52:30 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:1235 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750770AbXLMFw3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Dec 2007 00:52:29 -0500
Received: (qmail 7392 invoked by uid 111); 13 Dec 2007 05:52:27 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Thu, 13 Dec 2007 00:52:27 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 13 Dec 2007 00:52:26 -0500
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68121>

Pierre,

I am converting shortlog to use parse_options, but I have hit a behavior
I can't seem to represent.

The "-w" option has an optional argument, and we used to accept only
"-w" or "-wX,Y,Z". However, parse_options allows "-w X,Y,Z".

This means that "-w HEAD" used to mean "turn on wrapping
with default parameters, look at HEAD" and now translates to
"-w with parameter HEAD".

Is there a way to do this currently, or can we add an option flag?

---
 builtin-shortlog.c |  111 +++++++++++++++++++++++++++++-----------------------
 1 files changed, 62 insertions(+), 49 deletions(-)

diff --git a/builtin-shortlog.c b/builtin-shortlog.c
index 3d8d709..37fdb45 100644
--- a/builtin-shortlog.c
+++ b/builtin-shortlog.c
@@ -6,9 +6,12 @@
 #include "revision.h"
 #include "utf8.h"
 #include "mailmap.h"
+#include "parse-options.h"
 
-static const char shortlog_usage[] =
-"git-shortlog [-n] [-s] [<commit-id>... ]";
+static const char * const shortlog_usage[] = {
+	"git-shortlog [-n] [-s] [-e] [<commit-id>... ]",
+	NULL
+};
 
 static char *common_repo_prefix;
 static int email;
@@ -181,34 +184,45 @@ static int parse_uint(char const **arg, int comma)
 }
 
 static const char wrap_arg_usage[] = "-w[<width>[,<indent1>[,<indent2>]]]";
+struct wrap_arg {
+	int enabled;
+	int len;
+	int in1;
+	int in2;
+};
 #define DEFAULT_WRAPLEN 76
 #define DEFAULT_INDENT1 6
 #define DEFAULT_INDENT2 9
 
-static void parse_wrap_args(const char *arg, int *in1, int *in2, int *wrap)
+static int parse_wrap(const struct option *opt, const char *arg, int unset)
 {
-	arg += 2; /* skip -w */
+	struct wrap_arg *wrap = opt->value;
 
-	*wrap = parse_uint(&arg, ',');
-	if (*wrap < 0)
+	wrap->enabled = 1;
+
+	if (!arg)
+		return 0;
+	wrap->len = parse_uint(&arg, ',');
+	if (wrap->len < 0)
 		die(wrap_arg_usage);
-	*in1 = parse_uint(&arg, ',');
-	if (*in1 < 0)
+	wrap->in1 = parse_uint(&arg, ',');
+	if (wrap->in1 < 0)
 		die(wrap_arg_usage);
-	*in2 = parse_uint(&arg, '\0');
-	if (*in2 < 0)
+	wrap->in2 = parse_uint(&arg, '\0');
+	if (wrap->in2 < 0)
 		die(wrap_arg_usage);
 
-	if (!*wrap)
-		*wrap = DEFAULT_WRAPLEN;
-	if (!*in1)
-		*in1 = DEFAULT_INDENT1;
-	if (!*in2)
-		*in2 = DEFAULT_INDENT2;
-	if (*wrap &&
-	    ((*in1 && *wrap <= *in1) ||
-	     (*in2 && *wrap <= *in2)))
+	if (!wrap->len)
+		wrap->len = DEFAULT_WRAPLEN;
+	if (!wrap->in1)
+		wrap->in1 = DEFAULT_INDENT1;
+	if (!wrap->in2)
+		wrap->in2 = DEFAULT_INDENT2;
+	if (wrap->len &&
+	    ((wrap->in1 && wrap->len <= wrap->in1) ||
+	     (wrap->in2 && wrap->len <= wrap->in2)))
 		die(wrap_arg_usage);
+	return 0;
 }
 
 int cmd_shortlog(int argc, const char **argv, const char *prefix)
@@ -216,34 +230,31 @@ int cmd_shortlog(int argc, const char **argv, const char *prefix)
 	struct rev_info rev;
 	struct path_list list = { NULL, 0, 0, 1 };
 	int i, j, sort_by_number = 0, summary = 0;
-	int wrap_lines = 0;
-	int wrap = DEFAULT_WRAPLEN;
-	int in1 = DEFAULT_INDENT1;
-	int in2 = DEFAULT_INDENT2;
-
-	/* since -n is a shadowed rev argument, parse our args first */
-	while (argc > 1) {
-		if (!strcmp(argv[1], "-n") || !strcmp(argv[1], "--numbered"))
-			sort_by_number = 1;
-		else if (!strcmp(argv[1], "-s") ||
-				!strcmp(argv[1], "--summary"))
-			summary = 1;
-		else if (!strcmp(argv[1], "-e") ||
-			 !strcmp(argv[1], "--email"))
-			email = 1;
-		else if (!prefixcmp(argv[1], "-w")) {
-			wrap_lines = 1;
-			parse_wrap_args(argv[1], &in1, &in2, &wrap);
-		}
-		else if (!strcmp(argv[1], "-h") || !strcmp(argv[1], "--help"))
-			usage(shortlog_usage);
-		else
-			break;
-		argv++;
-		argc--;
-	}
+	struct wrap_arg wrap = {
+		0,
+		DEFAULT_WRAPLEN,
+		DEFAULT_INDENT1,
+		DEFAULT_INDENT2
+	};
+	struct option options[] = {
+		OPT_BOOLEAN('n', "numbered", &sort_by_number, "sort by number"),
+		OPT_BOOLEAN('s', "summary", &summary,
+				"show commit count summary"),
+		OPT_BOOLEAN('e', "email", &email, "show email addresses"),
+		{
+			OPTION_CALLBACK, 'w', NULL, &wrap, "wrap",
+			"line-wrap commit message", PARSE_OPT_OPTARG,
+			parse_wrap
+		},
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
 	if (argc > 1)
 		die ("unrecognized argument: %s", argv[1]);
 
@@ -272,9 +283,11 @@ int cmd_shortlog(int argc, const char **argv, const char *prefix)
 			for (j = onelines->nr - 1; j >= 0; j--) {
 				const char *msg = onelines->items[j].path;
 
-				if (wrap_lines) {
-					int col = print_wrapped_text(msg, in1, in2, wrap);
-					if (col != wrap)
+				if (wrap.enabled) {
+					int col = print_wrapped_text(msg,
+							wrap.in1, wrap.in2,
+							wrap.len);
+					if (col != wrap.len)
 						putchar('\n');
 				}
 				else
-- 
1.5.4.rc0.1088.gfa79c-dirty
