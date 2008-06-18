From: Shawn Bohrer <shawn.bohrer@gmail.com>
Subject: [PATCH 2/2] git shortlog: Modify to use parse_options
Date: Tue, 17 Jun 2008 22:03:56 -0500
Message-ID: <1213758236-979-3-git-send-email-shawn.bohrer@gmail.com>
References: <>
 <1213758236-979-1-git-send-email-shawn.bohrer@gmail.com>
 <1213758236-979-2-git-send-email-shawn.bohrer@gmail.com>
Cc: peff@peff.net, gitster@pobox.com, madcoder@debian.org,
	Shawn Bohrer <shawn.bohrer@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 18 05:06:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K8nze-0007JY-RX
	for gcvg-git-2@gmane.org; Wed, 18 Jun 2008 05:05:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755830AbYFRDEY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Jun 2008 23:04:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755882AbYFRDEY
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Jun 2008 23:04:24 -0400
Received: from yw-out-2324.google.com ([74.125.46.31]:40312 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755780AbYFRDEX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Jun 2008 23:04:23 -0400
Received: by yw-out-2324.google.com with SMTP id 9so37846ywe.1
        for <git@vger.kernel.org>; Tue, 17 Jun 2008 20:04:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references;
        bh=RXqEhsmz6mO2/x0KBK/PH2tc6vg6iWE+E+4RyvJNzfY=;
        b=RqzAu26dtth152+7iysbo/+NktZ4fcx5vxXhBSBIMEPtTR2eqNoRDMk648Du1RblaX
         DirRztg3kG6uuuhTww2cXj6smqtdj+9hSOQ7s3yNqAvSFo5efExo9mzO9z3YIBhPW/ih
         F6ogoV220s7BHjlXhDphHF3ty2hRVkK2NR47w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=J0qSYLzwvRtHFXikIq0pH8al1ThmFBeMPiNsoTw1iG62iAM1sVtJqfF4dvQVyx45VQ
         xbOSXcm9Wtal9Vkk2tC9EHYBHpU4ihEtX0X2EL5SKS8iDBsSJVtiHhR4U0eh8PmCxqLk
         KzF94YE3H8NuS9kO1sZay965hBMAg6qsb0ujQ=
Received: by 10.150.11.6 with SMTP id 6mr198393ybk.9.1213758262839;
        Tue, 17 Jun 2008 20:04:22 -0700 (PDT)
Received: from lintop ( [70.114.134.204])
        by mx.google.com with ESMTPS id v26sm3615935ele.1.2008.06.17.20.04.20
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 17 Jun 2008 20:04:22 -0700 (PDT)
Received: by lintop (sSMTP sendmail emulation); Tue, 17 Jun 2008 22:04:12 -0500
X-Mailer: git-send-email 1.5.4.3
In-Reply-To: <1213758236-979-2-git-send-email-shawn.bohrer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85356>

Signed-off-by: Shawn Bohrer <shawn.bohrer@gmail.com>
---
 builtin-shortlog.c |   54 +++++++++++++++++++++++++++------------------------
 1 files changed, 29 insertions(+), 25 deletions(-)

diff --git a/builtin-shortlog.c b/builtin-shortlog.c
index e6a2865..b1087b5 100644
--- a/builtin-shortlog.c
+++ b/builtin-shortlog.c
@@ -7,9 +7,12 @@
 #include "utf8.h"
 #include "mailmap.h"
 #include "shortlog.h"
+#include "parse-options.h"
 
-static const char shortlog_usage[] =
-"git-shortlog [-n] [-s] [-e] [-w] [<commit-id>... ]";
+static const char *const shortlog_usage[] = {
+	"git-shortlog [-n] [-s] [-e] [-w] [<commit-id>... ]",
+	NULL
+};
 
 static int compare_by_number(const void *a1, const void *a2)
 {
@@ -189,8 +192,6 @@ static const char wrap_arg_usage[] = "-w[<width>[,<indent1>[,<indent2>]]]";
 
 static void parse_wrap_args(const char *arg, int *in1, int *in2, int *wrap)
 {
-	arg += 2; /* skip -w */
-
 	*wrap = parse_uint(&arg, ',');
 	if (*wrap < 0)
 		die(wrap_arg_usage);
@@ -230,35 +231,38 @@ int cmd_shortlog(int argc, const char **argv, const char *prefix)
 	struct shortlog log;
 	struct rev_info rev;
 	int nongit;
+	const char * wrap_options = NULL;
+	struct option options[] = {
+		OPT_BOOLEAN('n', "numbered", &log.sort_by_number,
+			    "sort by number"),
+		OPT_BOOLEAN('s', "summary", &log.summary,
+			    "only provide commit count summary"),
+		OPT_BOOLEAN('e', "email", &log.email,
+			    "show email address of author"),
+		{ OPTION_STRING, 'w', NULL, &wrap_options,
+		  "[<width>[,<indent1>[,<indent2>]]]", "linewrap the output",
+		  PARSE_OPT_OPTARG, NULL, (intptr_t)"-w" },
+		OPT_END()
+	};
 
 	prefix = setup_git_directory_gently(&nongit);
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
+	argc = parse_options(argc, argv, options, shortlog_usage,
+			     PARSE_OPT_NO_ERROR_ON_UNKNOWN);
+
+	if (wrap_options)
+	{
+		if (!prefixcmp(wrap_options, "-w"))
+			wrap_options += 2; /* skip -w */
+		log.wrap_lines = 1;
+		parse_wrap_args(wrap_options, &log.in1, &log.in2, &log.wrap);
 	}
+
 	init_revisions(&rev, prefix);
 	argc = setup_revisions(argc, argv, &rev, NULL);
 	if (argc > 1)
-		die ("unrecognized argument: %s", argv[1]);
+		usage_with_options(shortlog_usage, options);
 
 	/* assume HEAD if from a tty */
 	if (!nongit && !rev.pending.nr && isatty(0))
-- 
1.5.4.3
