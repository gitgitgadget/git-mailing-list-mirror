Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: *
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=1.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RP_MATCHES_RCVD shortcircuit=no
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: (qmail 22590 invoked by uid 111); 5 Nov 2007 12:03:40 -0000
Received: from vger.kernel.org (HELO vger.kernel.org) (209.132.176.167)
    by peff.net (qpsmtpd/0.32) with ESMTP; Mon, 05 Nov 2007 07:03:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754689AbXKEMDa (ORCPT <rfc822;peff@peff.net>);
	Mon, 5 Nov 2007 07:03:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754565AbXKEMDa
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Nov 2007 07:03:30 -0500
Received: from pan.madism.org ([88.191.52.104]:52837 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753912AbXKEMD0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Nov 2007 07:03:26 -0500
Received: from madism.org (unknown [81.57.219.236])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id 8EA0628889;
	Mon,  5 Nov 2007 13:03:25 +0100 (CET)
Received: by madism.org (Postfix, from userid 1000)
	id 6950D8418; Mon,  5 Nov 2007 13:03:24 +0100 (CET)
From:	Pierre Habouzit <madcoder@debian.org>
To:	gitster@pobox.com
Cc:	git@vger.kernel.org, Pierre Habouzit <madcoder@debian.org>
Subject: [PATCH 1/4] parse-options: abbreviation engine fix.
Date:	Mon,  5 Nov 2007 13:03:21 +0100
Message-Id: <1194264204-3475-2-git-send-email-madcoder@debian.org>
X-Mailer: git-send-email 1.5.3.5.1531.g59008
In-Reply-To: <1194264204-3475-1-git-send-email-madcoder@debian.org>
References: <1194264204-3475-1-git-send-email-madcoder@debian.org>
To:	Junio C Hamano <gitster@pobox.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List:	git@vger.kernel.org

When we had at least two long option then followed by another one that was a
prefix of both of them, then the abbreviation detector failed.

Fix the issue, add a test.

Signed-off-by: Pierre Habouzit <madcoder@debian.org>
---
 parse-options.c          |   48 +++++++++++++++++++++++-----------------------
 t/t0040-parse-options.sh |   13 ++++++++++++
 test-parse-options.c     |    1 +
 3 files changed, 38 insertions(+), 24 deletions(-)

diff --git a/parse-options.c b/parse-options.c
index cc09c98..d2e32c1 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -119,8 +119,8 @@ static int parse_long_opt(struct optparse_t *p, const char *arg,
                           const struct option *options)
 {
 	const char *arg_end = strchr(arg, '=');
-	const struct option *abbrev_option = NULL;
-	int abbrev_flags = 0;
+	const struct option *abbrev_option = NULL, *conflict_option = NULL;
+	int abbrev_flags = 0, conflict_flags = 0;
 
 	if (!arg_end)
 		arg_end = arg + strlen(arg);
@@ -132,42 +132,33 @@ static int parse_long_opt(struct optparse_t *p, const char *arg,
 		if (!options->long_name)
 			continue;
 
+		/* special case {n,no,no-} that always conflict */
+		if (!prefixcmp("no-", arg))
+			die("`--{n,no,no-}' cannot be abbreviated forms of options");
+
 		rest = skip_prefix(arg, options->long_name);
 		if (!rest) {
 			/* abbreviated? */
 			if (!strncmp(options->long_name, arg, arg_end - arg)) {
 is_abbreviated:
-				if (abbrev_option)
-					return error("Ambiguous option: %s "
-						"(could be --%s%s or --%s%s)",
-						arg,
-						(flags & OPT_UNSET) ?
-							"no-" : "",
-						options->long_name,
-						(abbrev_flags & OPT_UNSET) ?
-							"no-" : "",
-						abbrev_option->long_name);
-				if (!(flags & OPT_UNSET) && *arg_end)
-					p->opt = arg_end + 1;
+				conflict_option = abbrev_option;
+				conflict_flags = abbrev_flags;
 				abbrev_option = options;
 				abbrev_flags = flags;
 				continue;
 			}
-			/* negated and abbreviated very much? */
-			if (!prefixcmp("no-", arg)) {
-				flags |= OPT_UNSET;
-				goto is_abbreviated;
-			}
 			/* negated? */
 			if (strncmp(arg, "no-", 3))
 				continue;
 			flags |= OPT_UNSET;
-			rest = skip_prefix(arg + 3, options->long_name);
+			arg += 3;
+			rest = skip_prefix(arg, options->long_name);
 			/* abbreviated and negated? */
-			if (!rest && !prefixcmp(options->long_name, arg + 3))
-				goto is_abbreviated;
-			if (!rest)
+			if (!rest) {
+				if (!strncmp(options->long_name, arg, arg_end - arg))
+					goto is_abbreviated;
 				continue;
+			}
 		}
 		if (*rest) {
 			if (*rest != '=')
@@ -176,8 +167,17 @@ is_abbreviated:
 		}
 		return get_value(p, options, flags);
 	}
-	if (abbrev_option)
+	if (conflict_option)
+		return error("Ambiguous option: %s (could be --%s%s or --%s%s)",
+			arg, (conflict_flags & OPT_UNSET) ?  "no-" : "",
+			conflict_option->long_name,
+			(abbrev_flags & OPT_UNSET) ?  "no-" : "",
+			abbrev_option->long_name);
+	if (abbrev_option) {
+		if (!(abbrev_flags & OPT_UNSET) && *arg_end)
+			p->opt = arg_end + 1;
 		return get_value(p, abbrev_option, abbrev_flags);
+	}
 	return error("unknown option `%s'", arg);
 }
 
diff --git a/t/t0040-parse-options.sh b/t/t0040-parse-options.sh
index ae49424..ee758e5 100755
--- a/t/t0040-parse-options.sh
+++ b/t/t0040-parse-options.sh
@@ -18,6 +18,7 @@ string options
     -s, --string <string>
                           get a string
     --string2 <str>       get another string
+    --st <st>             get another string (pervert ordering)
 
 EOF
 
@@ -90,4 +91,16 @@ test_expect_failure 'ambiguously abbreviated option' '
         test $? != 129
 '
 
+cat > expect << EOF
+boolean: 0
+integer: 2
+string: 123
+EOF
+
+test_expect_failure 'non ambiguous option (after two options it abbreviates)' '
+	test-parse-options --st 123 &&
+	test ! -s output.err &&
+	git diff expect output
+'
+
 test_done
diff --git a/test-parse-options.c b/test-parse-options.c
index 277cfe4..4d3e2ec 100644
--- a/test-parse-options.c
+++ b/test-parse-options.c
@@ -18,6 +18,7 @@ int main(int argc, const char **argv)
 		OPT_GROUP("string options"),
 		OPT_STRING('s', "string", &string, "string", "get a string"),
 		OPT_STRING(0, "string2", &string, "str", "get another string"),
+		OPT_STRING(0, "st", &string, "st", "get another string (pervert ordering)"),
 		OPT_END(),
 	};
 	int i;
-- 
1.5.3.5.1531.g59008

