From: Shawn Bohrer <shawn.bohrer@gmail.com>
Subject: [PATCH 1/2] parse_options: Add flag to prevent errors for further processing
Date: Tue, 17 Jun 2008 22:03:55 -0500
Message-ID: <1213758236-979-2-git-send-email-shawn.bohrer@gmail.com>
References: <>
 <1213758236-979-1-git-send-email-shawn.bohrer@gmail.com>
Cc: peff@peff.net, gitster@pobox.com, madcoder@debian.org,
	Shawn Bohrer <shawn.bohrer@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 18 05:05:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K8nze-0007JY-7r
	for gcvg-git-2@gmane.org; Wed, 18 Jun 2008 05:05:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755486AbYFRDEV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Jun 2008 23:04:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755672AbYFRDEV
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Jun 2008 23:04:21 -0400
Received: from yw-out-2324.google.com ([74.125.46.31]:40312 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754903AbYFRDEU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Jun 2008 23:04:20 -0400
Received: by yw-out-2324.google.com with SMTP id 9so37846ywe.1
        for <git@vger.kernel.org>; Tue, 17 Jun 2008 20:04:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references;
        bh=/22Hy25+QjRn6pRXKDTp1bPQyM8dP4C6F3TZWBTvfo4=;
        b=smHYL7EfHzC+133/KkH+0M08wiEI1NparmJyadmjczRKM/7jPMnEtaoE35HB2zmPz1
         hfJXoVBp86MzWDeTC3GBS/aDFHfOZN0ijHbnpdbfyBgH5oRBH6MzD197fbwLznnr4+6f
         sqNp1aWrlYgCQqnzK8NA+OTIUgETOPM3F8ZKY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=KWzCVqdHxBN5FgZcAgzjCjj+UbkDq6tTRuvv3D2yeEBienPPFeDhfvaiUKBugSvWAM
         P/ta/FT5lc8pyIEQQkP4SwlP7JaNH71Dx31LbT9W4KUzBJDLPaAXJCjjhUQpLsN0LThS
         JuceNUGYYbgfUR9OQxz8WFwrH74KS0oqyP0uw=
Received: by 10.150.92.12 with SMTP id p12mr116649ybb.238.1213758259584;
        Tue, 17 Jun 2008 20:04:19 -0700 (PDT)
Received: from lintop ( [70.114.134.204])
        by mx.google.com with ESMTPS id e27sm3670900elf.3.2008.06.17.20.04.17
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 17 Jun 2008 20:04:19 -0700 (PDT)
Received: by lintop (sSMTP sendmail emulation); Tue, 17 Jun 2008 22:04:09 -0500
X-Mailer: git-send-email 1.5.4.3
In-Reply-To: <1213758236-979-1-git-send-email-shawn.bohrer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85355>

This adds the PARSE_OPT_NO_ERROR_ON_UNKNOWN flag which prevents
parse_options() from erroring out when it finds an unknown option,
and leaves the original command and unknown options in argv.

This option is useful if the option parsing needs to be done in
multiple stages for example if the remaining options will be passed
to additional git commands.

Signed-off-by: Shawn Bohrer <shawn.bohrer@gmail.com>
---
 parse-options.c |   25 ++++++++++++++++++++-----
 parse-options.h |    5 +++--
 2 files changed, 23 insertions(+), 7 deletions(-)

diff --git a/parse-options.c b/parse-options.c
index 8071711..2635e18 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -131,7 +131,8 @@ static int get_value(struct optparse_t *p,
 	}
 }
 
-static int parse_short_opt(struct optparse_t *p, const struct option *options)
+static int parse_short_opt(struct optparse_t *p, const struct option *options,
+			   int flags)
 {
 	for (; options->type != OPTION_END; options++) {
 		if (options->short_name == *p->opt) {
@@ -139,11 +140,16 @@ static int parse_short_opt(struct optparse_t *p, const struct option *options)
 			return get_value(p, options, OPT_SHORT);
 		}
 	}
+
+	if (flags & PARSE_OPT_NO_ERROR_ON_UNKNOWN) {
+		p->out[p->cpidx++] = p->argv[0];
+		return 0;
+	}
 	return error("unknown switch `%c'", *p->opt);
 }
 
 static int parse_long_opt(struct optparse_t *p, const char *arg,
-                          const struct option *options)
+                          const struct option *options, int flags)
 {
 	const char *arg_end = strchr(arg, '=');
 	const struct option *abbrev_option = NULL, *ambiguous_option = NULL;
@@ -224,6 +230,11 @@ is_abbreviated:
 			abbrev_option->long_name);
 	if (abbrev_option)
 		return get_value(p, abbrev_option, abbrev_flags);
+
+	if (flags & PARSE_OPT_NO_ERROR_ON_UNKNOWN) {
+		p->out[p->cpidx++] = p->argv[0];
+		return 0;
+	}
 	return error("unknown option `%s'", arg);
 }
 
@@ -254,6 +265,8 @@ int parse_options(int argc, const char **argv, const struct option *options,
                   const char * const usagestr[], int flags)
 {
 	struct optparse_t args = { argv + 1, argv, argc - 1, 0, NULL };
+	if (flags & PARSE_OPT_NO_ERROR_ON_UNKNOWN)
+		args.out =  argv + 1;
 
 	for (; args.argc; args.argc--, args.argv++) {
 		const char *arg = args.argv[0];
@@ -269,14 +282,14 @@ int parse_options(int argc, const char **argv, const struct option *options,
 			args.opt = arg + 1;
 			if (*args.opt == 'h')
 				usage_with_options(usagestr, options);
-			if (parse_short_opt(&args, options) < 0)
+			if (parse_short_opt(&args, options, flags) < 0)
 				usage_with_options(usagestr, options);
 			if (args.opt)
 				check_typos(arg + 1, options);
 			while (args.opt) {
 				if (*args.opt == 'h')
 					usage_with_options(usagestr, options);
-				if (parse_short_opt(&args, options) < 0)
+				if (parse_short_opt(&args, options, flags) < 0)
 					usage_with_options(usagestr, options);
 			}
 			continue;
@@ -294,11 +307,13 @@ int parse_options(int argc, const char **argv, const struct option *options,
 			usage_with_options_internal(usagestr, options, 1);
 		if (!strcmp(arg + 2, "help"))
 			usage_with_options(usagestr, options);
-		if (parse_long_opt(&args, arg + 2, options))
+		if (parse_long_opt(&args, arg + 2, options, flags))
 			usage_with_options(usagestr, options);
 	}
 
 	memmove(args.out + args.cpidx, args.argv, args.argc * sizeof(*args.out));
+	if (flags & PARSE_OPT_NO_ERROR_ON_UNKNOWN)
+		++args.cpidx;
 	args.out[args.cpidx + args.argc] = NULL;
 	return args.cpidx + args.argc;
 }
diff --git a/parse-options.h b/parse-options.h
index 4ee443d..416ccdd 100644
--- a/parse-options.h
+++ b/parse-options.h
@@ -18,8 +18,9 @@ enum parse_opt_type {
 };
 
 enum parse_opt_flags {
-	PARSE_OPT_KEEP_DASHDASH = 1,
-	PARSE_OPT_STOP_AT_NON_OPTION = 2,
+	PARSE_OPT_KEEP_DASHDASH       = 1,
+	PARSE_OPT_STOP_AT_NON_OPTION  = 2,
+	PARSE_OPT_NO_ERROR_ON_UNKNOWN = 4
 };
 
 enum parse_opt_option_flags {
-- 
1.5.4.3
