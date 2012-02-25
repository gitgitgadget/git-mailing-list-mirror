From: =?ISO-8859-15?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH 2/3] parse-options: allow positivation of options starting,
 with no-
Date: Sat, 25 Feb 2012 20:14:54 +0100
Message-ID: <4F49332E.7070003@lsrfire.ath.cx>
References: <4F49317A.3080809@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Bert Wesarg <bert.wesarg@googlemail.com>,
	Geoffrey Irving <irving@naml.us>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Pierre Habouzit <madcoder@debian.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 25 20:15:13 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S1N5L-0000fG-T7
	for gcvg-git-2@plane.gmane.org; Sat, 25 Feb 2012 20:15:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757061Ab2BYTPE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 Feb 2012 14:15:04 -0500
Received: from india601.server4you.de ([85.25.151.105]:38108 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756808Ab2BYTPD (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Feb 2012 14:15:03 -0500
X-Greylist: delayed 431 seconds by postgrey-1.27 at vger.kernel.org; Sat, 25 Feb 2012 14:15:03 EST
Received: from [192.168.2.105] (p4FFD9274.dip.t-dialin.net [79.253.146.116])
	by india601.server4you.de (Postfix) with ESMTPSA id 5084C2F81C7;
	Sat, 25 Feb 2012 20:15:01 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:10.0.2) Gecko/20120216 Thunderbird/10.0.2
In-Reply-To: <4F49317A.3080809@lsrfire.ath.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191542>

Long options can be negated by adding no- right after the leading
two dashes. This is useful e.g. to override options set by aliases.

For options that are defined to start with no- already, this looks
a bit funny. Allow such options to also be negated by removing the
prefix.

The following thirteen options are affected:

	apply          --no-add
	bisect--helper --no-checkout
	checkout-index --no-create
	clone          --no-checkout --no-hardlinks
	commit         --no-verify   --no-post-rewrite
	format-patch   --no-binary
	hash-object    --no-filters
	read-tree      --no-sparse-checkout
	revert         --no-commit
	show-branch    --no-name
	update-ref     --no-deref

The following five are NOT affected because they are defined with
PARSE_OPT_NONEG or the non-negated version is defined as well:

	branch       --no-merged
	format-patch --no-stat             --no-numbered
	update-index --no-assume-unchanged --no-skip-worktree

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
---
 Documentation/technical/api-parse-options.txt |    3 ++-
 parse-options.c                               |   27 ++++++++++++++++---------
 t/t0040-parse-options.sh                      |    2 +-
 3 files changed, 20 insertions(+), 12 deletions(-)

diff --git a/Documentation/technical/api-parse-options.txt b/Documentation/technical/api-parse-options.txt
index 4b92514..2527b7e 100644
--- a/Documentation/technical/api-parse-options.txt
+++ b/Documentation/technical/api-parse-options.txt
@@ -39,7 +39,8 @@ The parse-options API allows:
 * Short options may be bundled, e.g. `-a -b` can be specified as `-ab`.
 
 * Boolean long options can be 'negated' (or 'unset') by prepending
-  `no-`, e.g. `\--no-abbrev` instead of `\--abbrev`.
+  `no-`, e.g. `\--no-abbrev` instead of `\--abbrev`. Conversely,
+  options that begin with `no-` can be 'negated' by removing it.
 
 * Options and non-option arguments can clearly be separated using the `\--`
   option, e.g. `-a -b \--option \-- \--this-is-a-file` indicates that
diff --git a/parse-options.c b/parse-options.c
index f0098eb..8906841 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -193,13 +193,14 @@ static int parse_long_opt(struct parse_opt_ctx_t *p, const char *arg,
 		arg_end = arg + strlen(arg);
 
 	for (; options->type != OPTION_END; options++) {
-		const char *rest;
-		int flags = 0;
+		const char *rest, *long_name = options->long_name;
+		int flags = 0, opt_flags = 0;
 
-		if (!options->long_name)
+		if (!long_name)
 			continue;
 
-		rest = skip_prefix(arg, options->long_name);
+again:
+		rest = skip_prefix(arg, long_name);
 		if (options->type == OPTION_ARGUMENT) {
 			if (!rest)
 				continue;
@@ -212,7 +213,7 @@ static int parse_long_opt(struct parse_opt_ctx_t *p, const char *arg,
 		}
 		if (!rest) {
 			/* abbreviated? */
-			if (!strncmp(options->long_name, arg, arg_end - arg)) {
+			if (!strncmp(long_name, arg, arg_end - arg)) {
 is_abbreviated:
 				if (abbrev_option) {
 					/*
@@ -227,7 +228,7 @@ is_abbreviated:
 				if (!(flags & OPT_UNSET) && *arg_end)
 					p->opt = arg_end + 1;
 				abbrev_option = options;
-				abbrev_flags = flags;
+				abbrev_flags = flags ^ opt_flags;
 				continue;
 			}
 			/* negation allowed? */
@@ -239,12 +240,18 @@ is_abbreviated:
 				goto is_abbreviated;
 			}
 			/* negated? */
-			if (strncmp(arg, "no-", 3))
+			if (prefixcmp(arg, "no-")) {
+				if (!prefixcmp(long_name, "no-")) {
+					long_name += 3;
+					opt_flags |= OPT_UNSET;
+					goto again;
+				}
 				continue;
+			}
 			flags |= OPT_UNSET;
-			rest = skip_prefix(arg + 3, options->long_name);
+			rest = skip_prefix(arg + 3, long_name);
 			/* abbreviated and negated? */
-			if (!rest && !prefixcmp(options->long_name, arg + 3))
+			if (!rest && !prefixcmp(long_name, arg + 3))
 				goto is_abbreviated;
 			if (!rest)
 				continue;
@@ -254,7 +261,7 @@ is_abbreviated:
 				continue;
 			p->opt = rest + 1;
 		}
-		return get_value(p, options, flags);
+		return get_value(p, options, flags ^ opt_flags);
 	}
 
 	if (ambiguous_option)
diff --git a/t/t0040-parse-options.sh b/t/t0040-parse-options.sh
index 79aefe2..aa57299 100755
--- a/t/t0040-parse-options.sh
+++ b/t/t0040-parse-options.sh
@@ -107,7 +107,7 @@ test_expect_success 'OPT_BOOL() negation #2' 'check boolean: 0 -D --no-no-doubt'
 test_expect_success 'OPT_BOOL() no negation #1' 'check_unknown --fear'
 test_expect_success 'OPT_BOOL() no negation #2' 'check_unknown --no-no-fear'
 
-test_expect_failure 'OPT_BOOL() positivation' 'check boolean: 0 -D --doubt'
+test_expect_success 'OPT_BOOL() positivation' 'check boolean: 0 -D --doubt'
 
 cat > expect << EOF
 boolean: 2
-- 
1.7.9.2
