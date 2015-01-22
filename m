From: Alexander Kuleshov <kuleshovmail@gmail.com>
Subject: [PATCH] parse-opts: add OPT_SUBCMD()
Date: Thu, 22 Jan 2015 17:48:58 +0600
Message-ID: <1421927338-32276-1-git-send-email-kuleshovmail@gmail.com>
Cc: git@vger.kernel.org, Alexander Kuleshov <kuleshovmail@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 22 12:49:21 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YEGGG-0001ZR-Cr
	for gcvg-git-2@plane.gmane.org; Thu, 22 Jan 2015 12:49:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751236AbbAVLtQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Jan 2015 06:49:16 -0500
Received: from mail-la0-f54.google.com ([209.85.215.54]:56699 "EHLO
	mail-la0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750875AbbAVLtP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Jan 2015 06:49:15 -0500
Received: by mail-la0-f54.google.com with SMTP id hv19so1074379lab.13
        for <git@vger.kernel.org>; Thu, 22 Jan 2015 03:49:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=BHTJCTcl+BEuhLX0ftyY6qn1PNzIkRhiAPo3VO68H4Y=;
        b=FQX76kwtomHgTZeTfUT7BLYG8m0iQGVAYJZPOR3ZM7MGEAj0AF8GIx0t/X7wQ990Xs
         nkGGi4xYDRUwUG2zbJEsd+PM0zjxz+jq0FYWo/Ql5Qg8Bw7N6j2oMDGole90kLf2rw1O
         0+tTLcTBrSFVuqSuESwk2GthoQTajMNp7fVOfgqr+IZg0kvRQZ0stsYw3UVD4wtpKWFU
         TcIMRDpBsa4T0ZtYnZpTPBWUpvKuKH3/54M14Donke7uzHF+DvLP1VCudrg54A+p7zok
         ugp1pKrdyG1x14bvZsuqgXf+/APiFwGKxMg6NfMe1R+SFXSfX0tqesjpeJVL26Bp79V8
         DjWw==
X-Received: by 10.112.217.68 with SMTP id ow4mr957509lbc.97.1421927353383;
        Thu, 22 Jan 2015 03:49:13 -0800 (PST)
Received: from localhost.localdomain ([5.251.234.181])
        by mx.google.com with ESMTPSA id wu12sm2776610lac.5.2015.01.22.03.49.11
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 22 Jan 2015 03:49:12 -0800 (PST)
X-Mailer: git-send-email 2.3.0.rc1.275.g028c360.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262819>

OPT_SUBCMD can be used for parsing git commands which has not only
short/long options, but subcomands. For example: git bundle (create,
verify and etc...) or git remote (add, rename and etc...)

Signed-off-by: Alexander Kuleshov <kuleshovmail@gmail.com>
---
 parse-options.c          | 25 +++++++++++++++++++++++++
 parse-options.h          |  8 ++++++++
 t/t0040-parse-options.sh | 13 +++++++++++++
 test-parse-options.c     |  3 +++
 4 files changed, 49 insertions(+)

diff --git a/parse-options.c b/parse-options.c
index 80106c0..79f971e 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -121,6 +121,10 @@ static int get_value(struct parse_opt_ctx_t *p,
 		*(int *)opt->value = unset ? 0 : opt->defval;
 		return 0;
 
+	case OPTION_SUBCMD:
+		*(int *)opt->value = 1;
+		return 0;
+
 	case OPTION_CMDMODE:
 		/*
 		 * Giving the same mode option twice, although is unnecessary,
@@ -314,6 +318,17 @@ is_abbreviated:
 	return -2;
 }
 
+static int parse_subcmd_opt(struct parse_opt_ctx_t *p, const char *arg,
+			 const struct option *options) {
+	const struct option *all_opts = options;
+	for (; options->type != OPTION_END; options++) {
+		if (options->long_name && !strcmp(options->long_name, arg))
+			return get_value(p, options, all_opts, 0);
+	}
+
+	return -2;
+}
+
 static int parse_nodash_opt(struct parse_opt_ctx_t *p, const char *arg,
 			    const struct option *options)
 {
@@ -417,6 +432,7 @@ int parse_options_step(struct parse_opt_ctx_t *ctx,
 		       const struct option *options,
 		       const char * const usagestr[])
 {
+	int argc = ctx->argc;
 	int internal_help = !(ctx->flags & PARSE_OPT_NO_INTERNAL_HELP);
 
 	/* we must reset ->opt, unknown short option leave it dangling */
@@ -426,6 +442,11 @@ int parse_options_step(struct parse_opt_ctx_t *ctx,
 		const char *arg = ctx->argv[0];
 
 		if (*arg != '-' || !arg[1]) {
+			if (ctx->argc == argc &&
+			    options->type == OPTION_SUBCMD &&
+			    parse_subcmd_opt(ctx, arg, options) == 0){
+				continue;
+			}
 			if (parse_nodash_opt(ctx, arg, options) == 0)
 				continue;
 			if (ctx->flags & PARSE_OPT_STOP_AT_NON_OPTION)
@@ -581,6 +602,10 @@ static int usage_with_options_internal(struct parse_opt_ctx_t *ctx,
 		size_t pos;
 		int pad;
 
+		if (opts->type == OPTION_SUBCMD) {
+			continue;
+		}
+
 		if (opts->type == OPTION_GROUP) {
 			fputc('\n', outfile);
 			if (*opts->help)
diff --git a/parse-options.h b/parse-options.h
index 7940bc7..0e75a85 100644
--- a/parse-options.h
+++ b/parse-options.h
@@ -13,6 +13,8 @@ enum parse_opt_type {
 	OPTION_COUNTUP,
 	OPTION_SET_INT,
 	OPTION_CMDMODE,
+	OPTION_SUBCMD,
+
 	/* options with arguments (usually) */
 	OPTION_STRING,
 	OPTION_INTEGER,
@@ -115,6 +117,10 @@ struct option {
 #define OPT_END()                   { OPTION_END }
 #define OPT_ARGUMENT(l, h)          { OPTION_ARGUMENT, 0, (l), NULL, NULL, \
 				      (h), PARSE_OPT_NOARG}
+
+#define OPT_SUBCMD(l, v, h)         { OPTION_SUBCMD, 0, (l), (v), NULL, \
+				      (h), PARSE_OPT_NOARG}
+
 #define OPT_GROUP(h)                { OPTION_GROUP, 0, NULL, NULL, NULL, (h) }
 #define OPT_BIT(s, l, v, h, b)      { OPTION_BIT, (s), (l), (v), NULL, (h), \
 				      PARSE_OPT_NOARG, NULL, (b) }
@@ -125,8 +131,10 @@ struct option {
 #define OPT_SET_INT(s, l, v, h, i)  { OPTION_SET_INT, (s), (l), (v), NULL, \
 				      (h), PARSE_OPT_NOARG, NULL, (i) }
 #define OPT_BOOL(s, l, v, h)        OPT_SET_INT(s, l, v, h, 1)
+
 #define OPT_HIDDEN_BOOL(s, l, v, h) { OPTION_SET_INT, (s), (l), (v), NULL, \
 				      (h), PARSE_OPT_NOARG | PARSE_OPT_HIDDEN, NULL, 1}
+
 #define OPT_CMDMODE(s, l, v, h, i) { OPTION_CMDMODE, (s), (l), (v), NULL, \
 				      (h), PARSE_OPT_NOARG|PARSE_OPT_NONEG, NULL, (i) }
 #define OPT_INTEGER(s, l, v, h)     { OPTION_INTEGER, (s), (l), (v), N_("n"), (h) }
diff --git a/t/t0040-parse-options.sh b/t/t0040-parse-options.sh
index a90c86b..7898a5a 100755
--- a/t/t0040-parse-options.sh
+++ b/t/t0040-parse-options.sh
@@ -65,6 +65,7 @@ verbose: 0
 quiet: no
 dry run: no
 file: (not set)
+subcommand: 1
 EOF
 
 check() {
@@ -142,6 +143,7 @@ verbose: 2
 quiet: no
 dry run: yes
 file: prefix/my.file
+subcommand: 1
 EOF
 
 test_expect_success 'short options' '
@@ -161,6 +163,7 @@ verbose: 2
 quiet: no
 dry run: no
 file: prefix/fi.le
+subcommand: 1
 EOF
 
 test_expect_success 'long options' '
@@ -190,6 +193,7 @@ verbose: 0
 quiet: no
 dry run: no
 file: (not set)
+subcommand: 1
 arg 00: a1
 arg 01: b1
 arg 02: --boolean
@@ -212,6 +216,7 @@ verbose: 0
 quiet: no
 dry run: no
 file: (not set)
+subcommand: 1
 EOF
 
 test_expect_success 'unambiguously abbreviated option' '
@@ -241,6 +246,7 @@ verbose: 0
 quiet: no
 dry run: no
 file: (not set)
+subcommand: 1
 EOF
 
 test_expect_success 'non ambiguous option (after two options it abbreviates)' '
@@ -279,6 +285,7 @@ verbose: 0
 quiet: no
 dry run: no
 file: (not set)
+subcommand: 1
 arg 00: --quux
 EOF
 
@@ -298,6 +305,7 @@ verbose: 0
 quiet: yes
 dry run: no
 file: (not set)
+subcommand: 1
 arg 00: foo
 EOF
 
@@ -319,6 +327,7 @@ verbose: 0
 quiet: no
 dry run: no
 file: (not set)
+subcommand: 1
 EOF
 
 test_expect_success 'OPT_CALLBACK() and OPT_BIT() work' '
@@ -347,6 +356,7 @@ verbose: 0
 quiet: no
 dry run: no
 file: (not set)
+subcommand: 1
 EOF
 
 test_expect_success 'OPT_BIT() and OPT_SET_INT() work' '
@@ -371,6 +381,7 @@ verbose: 0
 quiet: no
 dry run: no
 file: (not set)
+subcommand: 1
 EOF
 
 test_expect_success 'OPT_BIT() works' '
@@ -401,6 +412,7 @@ verbose: 0
 quiet: no
 dry run: no
 file: (not set)
+subcommand: 1
 EOF
 
 test_expect_success 'OPT_NUMBER_CALLBACK() works' '
@@ -419,6 +431,7 @@ verbose: 0
 quiet: no
 dry run: no
 file: (not set)
+subcommand: 1
 EOF
 
 test_expect_success 'negation of OPT_NONEG flags is not ambiguous' '
diff --git a/test-parse-options.c b/test-parse-options.c
index 5dabce6..96e2a21 100644
--- a/test-parse-options.c
+++ b/test-parse-options.c
@@ -11,6 +11,7 @@ static char *string = NULL;
 static char *file = NULL;
 static int ambiguous;
 static struct string_list list;
+static int subcommand = 0;
 
 static int length_callback(const struct option *opt, const char *arg, int unset)
 {
@@ -52,6 +53,7 @@ int main(int argc, char **argv)
 		OPT_DATE('t', NULL, &timestamp, "get timestamp of <time>"),
 		OPT_CALLBACK('L', "length", &integer, "str",
 			"get length of <str>", length_callback),
+		OPT_SUBCMD("subcommand", &subcommand, "get a subcommand"),
 		OPT_FILENAME('F', "file", &file, "set file to <file>"),
 		OPT_GROUP("String options"),
 		OPT_STRING('s', "string", &string, "string", "get a string"),
@@ -90,6 +92,7 @@ int main(int argc, char **argv)
 	printf("quiet: %s\n", quiet ? "yes" : "no");
 	printf("dry run: %s\n", dry_run ? "yes" : "no");
 	printf("file: %s\n", file ? file : "(not set)");
+	printf("subcommand: %d\n", 1);
 
 	for (i = 0; i < list.nr; i++)
 		printf("list: %s\n", list.items[i].string);
-- 
2.3.0.rc1.275.g028c360.dirty
