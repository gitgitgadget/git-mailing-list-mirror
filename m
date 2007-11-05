Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=0.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RP_MATCHES_RCVD shortcircuit=no
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: (qmail 22603 invoked by uid 111); 5 Nov 2007 12:03:44 -0000
Received: from vger.kernel.org (HELO vger.kernel.org) (209.132.176.167)
    by peff.net (qpsmtpd/0.32) with ESMTP; Mon, 05 Nov 2007 07:03:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754703AbXKEMDc (ORCPT <rfc822;peff@peff.net>);
	Mon, 5 Nov 2007 07:03:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754565AbXKEMDc
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Nov 2007 07:03:32 -0500
Received: from pan.madism.org ([88.191.52.104]:52838 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754458AbXKEMD1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Nov 2007 07:03:27 -0500
Received: from madism.org (unknown [81.57.219.236])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id 9B8B42888B;
	Mon,  5 Nov 2007 13:03:25 +0100 (CET)
Received: by madism.org (Postfix, from userid 1000)
	id 7404186BB; Mon,  5 Nov 2007 13:03:24 +0100 (CET)
From:	Pierre Habouzit <madcoder@debian.org>
To:	gitster@pobox.com
Cc:	git@vger.kernel.org, Pierre Habouzit <madcoder@debian.org>
Subject: [PATCH 3/4] Add OPTION_BASEOFFSET/OPTION_SUBARRAY.
Date:	Mon,  5 Nov 2007 13:03:23 +0100
Message-Id: <1194264204-3475-4-git-send-email-madcoder@debian.org>
X-Mailer: git-send-email 1.5.3.5.1531.g59008
In-Reply-To: <1194264204-3475-3-git-send-email-madcoder@debian.org>
References: <1194264204-3475-1-git-send-email-madcoder@debian.org>
 <1194264204-3475-2-git-send-email-madcoder@debian.org>
 <1194264204-3475-3-git-send-email-madcoder@debian.org>
To:	Junio C Hamano <gitster@pobox.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List:	git@vger.kernel.org

Currently make the implementation die() if SUBARRAYs are encountered.
Refactor the rest of the code to be ready for recursion.

Signed-off-by: Pierre Habouzit <madcoder@debian.org>
---
 parse-options.c |  114 ++++++++++++++++++++++++++++++++++++++-----------------
 parse-options.h |    6 +++
 2 files changed, 85 insertions(+), 35 deletions(-)

diff --git a/parse-options.c b/parse-options.c
index d2e32c1..5cea511 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -8,6 +8,9 @@ struct optparse_t {
 	const char **argv;
 	int argc;
 	const char *opt;
+
+	const struct option *abbrev_option, *conflict_option;
+	int abbrev_flags, conflict_flags;
 };
 
 static inline const char *get_arg(struct optparse_t *p)
@@ -104,23 +107,35 @@ static int get_value(struct optparse_t *p,
 	}
 }
 
-static int parse_short_opt(struct optparse_t *p, const struct option *options)
+static int parse_short_opt(struct optparse_t *p, const struct option *options,
+                           int level)
 {
-	for (; options->type != OPTION_END; options++) {
-		if (options->short_name == *p->opt) {
+	for (;; options++) {
+		switch (options->type) {
+		case OPTION_END:
+			return level > 0 ? -1 : error("unknown switch `%c'", *p->opt);
+		case OPTION_GROUP:
+		case OPTION_BASEOFFSET:
+			continue;
+		case OPTION_SUBARRAY:
+			die("unsupported yet");
+			break;
+		default:
+			if (options->short_name != *p->opt)
+				continue;
 			p->opt = p->opt[1] ? p->opt + 1 : NULL;
 			return get_value(p, options, OPT_SHORT);
 		}
 	}
-	return error("unknown switch `%c'", *p->opt);
 }
 
 static int parse_long_opt(struct optparse_t *p, const char *arg,
-                          const struct option *options)
+                          const struct option *options, int level)
 {
 	const char *arg_end = strchr(arg, '=');
-	const struct option *abbrev_option = NULL, *conflict_option = NULL;
-	int abbrev_flags = 0, conflict_flags = 0;
+
+	if (level == 0)
+		p->conflict_option = p->abbrev_option = NULL;
 
 	if (!arg_end)
 		arg_end = arg + strlen(arg);
@@ -129,6 +144,17 @@ static int parse_long_opt(struct optparse_t *p, const char *arg,
 		const char *rest;
 		int flags = 0;
 
+		switch (options->type) {
+		case OPTION_GROUP:
+		case OPTION_BASEOFFSET:
+			continue;
+		case OPTION_SUBARRAY:
+			die("unsupported yet");
+			break;
+		default:
+			break;
+		}
+
 		if (!options->long_name)
 			continue;
 
@@ -138,13 +164,16 @@ static int parse_long_opt(struct optparse_t *p, const char *arg,
 
 		rest = skip_prefix(arg, options->long_name);
 		if (!rest) {
+			/* negated and abbreviated very much? */
+			if (!prefixcmp("no-", arg))
+				die("--n,--no,--no- are never proper abbreviated options");
 			/* abbreviated? */
 			if (!strncmp(options->long_name, arg, arg_end - arg)) {
 is_abbreviated:
-				conflict_option = abbrev_option;
-				conflict_flags = abbrev_flags;
-				abbrev_option = options;
-				abbrev_flags = flags;
+				p->conflict_option = p->abbrev_option;
+				p->conflict_flags = p->abbrev_flags;
+				p->abbrev_option = options;
+				p->abbrev_flags = flags;
 				continue;
 			}
 			/* negated? */
@@ -167,16 +196,18 @@ is_abbreviated:
 		}
 		return get_value(p, options, flags);
 	}
-	if (conflict_option)
+	if (level > 0)
+		return -1;
+	if (p->conflict_option)
 		return error("Ambiguous option: %s (could be --%s%s or --%s%s)",
-			arg, (conflict_flags & OPT_UNSET) ?  "no-" : "",
-			conflict_option->long_name,
-			(abbrev_flags & OPT_UNSET) ?  "no-" : "",
-			abbrev_option->long_name);
-	if (abbrev_option) {
-		if (!(abbrev_flags & OPT_UNSET) && *arg_end)
+			arg, (p->conflict_flags & OPT_UNSET) ?  "no-" : "",
+			p->conflict_option->long_name,
+			(p->abbrev_flags & OPT_UNSET) ?  "no-" : "",
+			p->abbrev_option->long_name);
+	if (p->abbrev_option) {
+		if (!(p->abbrev_flags & OPT_UNSET) && *arg_end)
 			p->opt = arg_end + 1;
-		return get_value(p, abbrev_option, abbrev_flags);
+		return get_value(p, p->abbrev_option, p->abbrev_flags);
 	}
 	return error("unknown option `%s'", arg);
 }
@@ -200,7 +231,7 @@ int parse_options(int argc, const char **argv, const struct option *options,
 			do {
 				if (*args.opt == 'h')
 					usage_with_options(usagestr, options);
-				if (parse_short_opt(&args, options) < 0)
+				if (parse_short_opt(&args, options, 0) < 0)
 					usage_with_options(usagestr, options);
 			} while (args.opt);
 			continue;
@@ -216,7 +247,7 @@ int parse_options(int argc, const char **argv, const struct option *options,
 
 		if (!strcmp(arg + 2, "help"))
 			usage_with_options(usagestr, options);
-		if (parse_long_opt(&args, arg + 2, options))
+		if (parse_long_opt(&args, arg + 2, options, 0))
 			usage_with_options(usagestr, options);
 	}
 
@@ -228,27 +259,27 @@ int parse_options(int argc, const char **argv, const struct option *options,
 #define USAGE_OPTS_WIDTH 24
 #define USAGE_GAP         2
 
-void usage_with_options(const char * const *usagestr,
-                        const struct option *opts)
+static void dump_options(const struct option *opts)
 {
-	fprintf(stderr, "usage: %s\n", *usagestr++);
-	while (*usagestr && **usagestr)
-		fprintf(stderr, "   or: %s\n", *usagestr++);
-	while (*usagestr)
-		fprintf(stderr, "    %s\n", *usagestr++);
-
-	if (opts->type != OPTION_GROUP)
-		fputc('\n', stderr);
-
-	for (; opts->type != OPTION_END; opts++) {
+	for (;; opts++) {
 		size_t pos;
 		int pad;
 
-		if (opts->type == OPTION_GROUP) {
+		switch (opts->type) {
+		case OPTION_END:
+			return;
+		case OPTION_GROUP:
 			fputc('\n', stderr);
 			if (*opts->help)
 				fprintf(stderr, "%s\n", opts->help);
 			continue;
+		case OPTION_BASEOFFSET:
+			continue;
+		case OPTION_SUBARRAY:
+			dump_options((struct option *)opts->defval);
+			continue;
+		default:
+			break;
 		}
 
 		pos = fprintf(stderr, "    ");
@@ -295,8 +326,21 @@ void usage_with_options(const char * const *usagestr,
 		}
 		fprintf(stderr, "%*s%s\n", pad + USAGE_GAP, "", opts->help);
 	}
-	fputc('\n', stderr);
+}
 
+void usage_with_options(const char * const *usagestr,
+                        const struct option *opts)
+{
+	fprintf(stderr, "usage: %s\n", *usagestr++);
+	while (*usagestr && **usagestr)
+		fprintf(stderr, "   or: %s\n", *usagestr++);
+	while (*usagestr)
+		fprintf(stderr, "    %s\n", *usagestr++);
+
+	if (opts->type != OPTION_GROUP)
+		fputc('\n', stderr);
+	dump_options(opts);
+	fputc('\n', stderr);
 	exit(129);
 }
 
diff --git a/parse-options.h b/parse-options.h
index 65bce6e..6668924 100644
--- a/parse-options.h
+++ b/parse-options.h
@@ -4,6 +4,8 @@
 enum parse_opt_type {
 	OPTION_END,
 	OPTION_GROUP,
+	OPTION_BASEOFFSET,
+	OPTION_SUBARRAY,
 	OPTION_BOOLEAN,
 	OPTION_STRING,
 	OPTION_INTEGER,
@@ -35,6 +37,7 @@ typedef int parse_opt_cb(const struct option *, const char *arg, int unset);
  *
  * `value`::
  *   stores pointers to the values to be filled.
+ *   BASEOFFSET use it to store the offset wrt which the struct was filled.
  *
  * `argh`::
  *   token to explain the kind of argument this option wants. Keep it
@@ -56,6 +59,9 @@ typedef int parse_opt_cb(const struct option *, const char *arg, int unset);
  * `defval`::
  *   default value to fill (*->value) with for PARSE_OPT_OPTARG.
  *   CALLBACKS can use it like they want.
+ *   SUBARRAYs use it to store the subarray address.
+ *   BASEOFFSET use it to store the sizeof the struct used to fill the array.
+ *              Any `value` that does not points into it is not relocated.
  */
 struct option {
 	enum parse_opt_type type;
-- 
1.5.3.5.1531.g59008

