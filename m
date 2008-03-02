From: Pierre Habouzit <madcoder@debian.org>
Subject: [PATCH 3/3] parse-options: new option type to treat an option-like parameter as an argument.
Date: Sun, 02 Mar 2008 11:35:56 +0100
Message-ID: <20080302103556.GB21078@artemis.madism.org>
References: <20080302082138.GB5407@artemis.madism.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: Git ML <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Mar 02 11:36:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JVlYd-0003kS-48
	for gcvg-git-2@gmane.org; Sun, 02 Mar 2008 11:36:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752563AbYCBKf6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Mar 2008 05:35:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752348AbYCBKf6
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Mar 2008 05:35:58 -0500
Received: from pan.madism.org ([88.191.52.104]:40753 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752184AbYCBKf5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Mar 2008 05:35:57 -0500
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id B40E63108A;
	Sun,  2 Mar 2008 11:35:56 +0100 (CET)
Received: by madism.org (Postfix, from userid 1000)
	id 602333D63F3; Sun,  2 Mar 2008 11:35:56 +0100 (CET)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	Git ML <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Content-Disposition: inline
In-Reply-To: <20080302082138.GB5407@artemis.madism.org>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75772>

This is meant to be used to keep --not and --all during revision parsing.

Signed-off-by: Pierre Habouzit <madcoder@debian.org>
---
 parse-options.c          |   26 +++++++++++++++++++-------
 parse-options.h          |    2 ++
 t/t0040-parse-options.sh |   16 ++++++++++++++++
 test-parse-options.c     |    2 ++
 4 files changed, 39 insertions(+), 7 deletions(-)

diff --git a/parse-options.c b/parse-options.c
index be35785..8e64316 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -6,7 +6,8 @@
 
 struct optparse_t {
 	const char **argv;
-	int argc;
+	const char **out;
+	int argc, cpidx;
 	const char *opt;
 };
 
@@ -159,6 +160,16 @@ static int parse_long_opt(struct optparse_t *p, const char *arg,
 			continue;
 
 		rest = skip_prefix(arg, options->long_name);
+		if (options->type == OPTION_ARGUMENT) {
+			if (!rest)
+				continue;
+			if (*rest == '=')
+				return opterror(options, "takes no value", flags);
+			if (*rest)
+				continue;
+			p->out[p->cpidx++] = arg - 2;
+			return 0;
+		}
 		if (!rest) {
 			/* abbreviated? */
 			if (!strncmp(options->long_name, arg, arg_end - arg)) {
@@ -242,8 +253,7 @@ static NORETURN void usage_with_options_internal(const char * const *,
 int parse_options(int argc, const char **argv, const struct option *options,
                   const char * const usagestr[], int flags)
 {
-	struct optparse_t args = { argv + 1, argc - 1, NULL };
-	int j = 0;
+	struct optparse_t args = { argv + 1, argv, argc - 1, 0, NULL };
 
 	for (; args.argc; args.argc--, args.argv++) {
 		const char *arg = args.argv[0];
@@ -251,7 +261,7 @@ int parse_options(int argc, const char **argv, const struct option *options,
 		if (*arg != '-' || !arg[1]) {
 			if (flags & PARSE_OPT_STOP_AT_NON_OPTION)
 				break;
-			argv[j++] = args.argv[0];
+			args.out[args.cpidx++] = args.argv[0];
 			continue;
 		}
 
@@ -288,9 +298,9 @@ int parse_options(int argc, const char **argv, const struct option *options,
 			usage_with_options(usagestr, options);
 	}
 
-	memmove(argv + j, args.argv, args.argc * sizeof(*argv));
-	argv[j + args.argc] = NULL;
-	return j + args.argc;
+	memmove(args.out + args.cpidx, args.argv, args.argc * sizeof(*args.out));
+	args.out[args.cpidx + args.argc] = NULL;
+	return args.cpidx + args.argc;
 }
 
 #define USAGE_OPTS_WIDTH 24
@@ -330,6 +340,8 @@ void usage_with_options_internal(const char * const *usagestr,
 			pos += fprintf(stderr, "--%s", opts->long_name);
 
 		switch (opts->type) {
+		case OPTION_ARGUMENT:
+			break;
 		case OPTION_INTEGER:
 			if (opts->flags & PARSE_OPT_OPTARG)
 				pos += fprintf(stderr, " [<n>]");
diff --git a/parse-options.h b/parse-options.h
index 0d40cd2..1af62b0 100644
--- a/parse-options.h
+++ b/parse-options.h
@@ -4,6 +4,7 @@
 enum parse_opt_type {
 	/* special types */
 	OPTION_END,
+	OPTION_ARGUMENT,
 	OPTION_GROUP,
 	/* options with no arguments */
 	OPTION_BIT,
@@ -85,6 +86,7 @@ struct option {
 };
 
 #define OPT_END()                   { OPTION_END }
+#define OPT_ARGUMENT(l, h)          { OPTION_ARGUMENT, 0, (l), NULL, NULL, (h) }
 #define OPT_GROUP(h)                { OPTION_GROUP, 0, NULL, NULL, NULL, (h) }
 #define OPT_BIT(s, l, v, h, b)      { OPTION_BIT, (s), (l), (v), NULL, (h), 0, NULL, (b) }
 #define OPT_BOOLEAN(s, l, v, h)     { OPTION_BOOLEAN, (s), (l), (v), NULL, (h) }
diff --git a/t/t0040-parse-options.sh b/t/t0040-parse-options.sh
index 0e2933a..c23f0ac 100755
--- a/t/t0040-parse-options.sh
+++ b/t/t0040-parse-options.sh
@@ -21,6 +21,9 @@ string options
     --st <st>             get another string (pervert ordering)
     -o <str>              get another string
 
+magic arguments
+    --quux                means --quux
+
 EOF
 
 test_expect_success 'test help' '
@@ -114,4 +117,17 @@ test_expect_success 'detect possible typos' '
 	git diff expect.err output.err
 '
 
+cat > expect <<EOF
+boolean: 0
+integer: 0
+string: (not set)
+arg 00: --quux
+EOF
+
+test_expect_success 'keep some options as arguments' '
+	test-parse-options --quux > output 2> output.err &&
+        test ! -s output.err &&
+        git diff expect output
+'
+
 test_done
diff --git a/test-parse-options.c b/test-parse-options.c
index eed8a02..73360d7 100644
--- a/test-parse-options.c
+++ b/test-parse-options.c
@@ -20,6 +20,8 @@ int main(int argc, const char **argv)
 		OPT_STRING(0, "string2", &string, "str", "get another string"),
 		OPT_STRING(0, "st", &string, "st", "get another string (pervert ordering)"),
 		OPT_STRING('o', NULL, &string, "str", "get another string"),
+		OPT_GROUP("magic arguments"),
+		OPT_ARGUMENT("quux", "means --quux"),
 		OPT_END(),
 	};
 	int i;
-- 
1.5.4.3.471.ga96e8.dirty
