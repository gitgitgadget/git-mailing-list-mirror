From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 1/2] parse-options: introduce OPT_SUBCOMMAND
Date: Thu,  8 Dec 2011 17:37:07 +0530
Message-ID: <1323346028-9201-2-git-send-email-artagnon@gmail.com>
References: <1323346028-9201-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Dec 08 13:08:23 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RYclz-0006aY-3q
	for gcvg-git-2@lo.gmane.org; Thu, 08 Dec 2011 13:08:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751021Ab1LHMIO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Dec 2011 07:08:14 -0500
Received: from mail-qy0-f174.google.com ([209.85.216.174]:37635 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750825Ab1LHMIN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Dec 2011 07:08:13 -0500
Received: by qcqz2 with SMTP id z2so1198316qcq.19
        for <git@vger.kernel.org>; Thu, 08 Dec 2011 04:08:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=IcDFSjvTvoxNAvJxGPhhjb5cctz0rkgj5VGO+mU/0KY=;
        b=j1zGG+eUN6eE/DhGbOAitw4vqtqEP5tX+YapYn2BPzmgCXdp9PrhXMBIxckVzF/nrF
         I4iWRR0JyKs0YF/a8SHI4awut/K/Y0Jb5B5tdOTh5Ykl7WmTxjC2wgvd3SZzhoMXeihh
         7GdzuakRLdaONJdk/U38tmpJWZg8CXnVF78pA=
Received: by 10.50.158.227 with SMTP id wx3mr3292682igb.52.1323346092305;
        Thu, 08 Dec 2011 04:08:12 -0800 (PST)
Received: from localhost.localdomain ([203.110.240.205])
        by mx.google.com with ESMTPS id el2sm18965489ibb.10.2011.12.08.04.08.09
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 08 Dec 2011 04:08:11 -0800 (PST)
X-Mailer: git-send-email 1.7.7.3
In-Reply-To: <1323346028-9201-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186549>

Several git programs take long dash-less options on the command-line
to indicate different modes of operation like:

  git stash show
  git bundle verify test.bundle
  git bisect start

Currently, the parse-options framework forbids the use of
opts->long_name and OPT_PARSE_NODASH, and the parsing has to be done
by hand as a result.  Lift this restriction, and create a new
OPT_SUBCOMMAND; this is built on top of OPTION_BIT to allow for the
detection of more than one subcommand.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 parse-options.c          |    5 +++--
 parse-options.h          |    3 +++
 t/t0040-parse-options.sh |   31 +++++++++++++++++++++++++++++++
 test-parse-options.c     |    4 ++++
 4 files changed, 41 insertions(+), 2 deletions(-)

diff --git a/parse-options.c b/parse-options.c
index f0098eb..079616a 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -278,6 +278,8 @@ static int parse_nodash_opt(struct parse_opt_ctx_t *p, const char *arg,
 			continue;
 		if (options->short_name == arg[0] && arg[1] == '\0')
 			return get_value(p, options, OPT_SHORT);
+		if (options->long_name && !strcmp(options->long_name, arg))
+			return get_value(p, options, OPT_SHORT);
 	}
 	return -2;
 }
@@ -314,8 +316,7 @@ static void parse_options_check(const struct option *opts)
 		if (opts->flags & PARSE_OPT_NODASH &&
 		    ((opts->flags & PARSE_OPT_OPTARG) ||
 		     !(opts->flags & PARSE_OPT_NOARG) ||
-		     !(opts->flags & PARSE_OPT_NONEG) ||
-		     opts->long_name))
+		     !(opts->flags & PARSE_OPT_NONEG)))
 			err |= optbug(opts, "uses feature "
 					"not supported for dashless options");
 		switch (opts->type) {
diff --git a/parse-options.h b/parse-options.h
index 2e811dc..9267d46 100644
--- a/parse-options.h
+++ b/parse-options.h
@@ -123,6 +123,9 @@ struct option {
 #define OPT_GROUP(h)                { OPTION_GROUP, 0, NULL, NULL, NULL, (h) }
 #define OPT_BIT(s, l, v, h, b)      { OPTION_BIT, (s), (l), (v), NULL, (h), \
 				      PARSE_OPT_NOARG, NULL, (b) }
+#define OPT_SUBCOMMAND(l, v, h, i)  { OPTION_BIT, 0, (l), (v), NULL, (h), \
+				      PARSE_OPT_NONEG | PARSE_OPT_NOARG | \
+				      PARSE_OPT_NODASH | PARSE_OPT_HIDDEN, NULL, (i) }
 #define OPT_NEGBIT(s, l, v, h, b)   { OPTION_NEGBIT, (s), (l), (v), NULL, \
 				      (h), PARSE_OPT_NOARG, NULL, (b) }
 #define OPT_COUNTUP(s, l, v, h)     { OPTION_COUNTUP, (s), (l), (v), NULL, \
diff --git a/t/t0040-parse-options.sh b/t/t0040-parse-options.sh
index a1e4616..47a402e 100755
--- a/t/t0040-parse-options.sh
+++ b/t/t0040-parse-options.sh
@@ -55,6 +55,7 @@ mv expect expect.err
 
 cat > expect << EOF
 boolean: 2
+subcommand: 0
 integer: 1729
 timestamp: 0
 string: 123
@@ -74,6 +75,7 @@ test_expect_success 'short options' '
 
 cat > expect << EOF
 boolean: 2
+subcommand: 0
 integer: 1729
 timestamp: 0
 string: 321
@@ -103,6 +105,7 @@ test_expect_success 'missing required value' '
 
 cat > expect << EOF
 boolean: 1
+subcommand: 0
 integer: 13
 timestamp: 0
 string: 123
@@ -125,6 +128,7 @@ test_expect_success 'intermingled arguments' '
 
 cat > expect << EOF
 boolean: 0
+subcommand: 0
 integer: 2
 timestamp: 0
 string: (not set)
@@ -154,6 +158,7 @@ test_expect_success 'ambiguously abbreviated option' '
 
 cat > expect << EOF
 boolean: 0
+subcommand: 0
 integer: 0
 timestamp: 0
 string: 123
@@ -182,6 +187,7 @@ test_expect_success 'detect possible typos' '
 
 cat > expect <<EOF
 boolean: 0
+subcommand: 0
 integer: 0
 timestamp: 0
 string: (not set)
@@ -201,6 +207,7 @@ test_expect_success 'keep some options as arguments' '
 
 cat > expect <<EOF
 boolean: 0
+subcommand: 0
 integer: 0
 timestamp: 1
 string: default
@@ -222,6 +229,7 @@ test_expect_success 'OPT_DATE() and OPT_SET_PTR() work' '
 cat > expect <<EOF
 Callback: "four", 0
 boolean: 5
+subcommand: 0
 integer: 4
 timestamp: 0
 string: (not set)
@@ -250,6 +258,7 @@ test_expect_success 'OPT_CALLBACK() and callback errors work' '
 
 cat > expect <<EOF
 boolean: 1
+subcommand: 0
 integer: 23
 timestamp: 0
 string: (not set)
@@ -274,6 +283,7 @@ test_expect_success 'OPT_NEGBIT() and OPT_SET_INT() work' '
 
 cat > expect <<EOF
 boolean: 6
+subcommand: 0
 integer: 0
 timestamp: 0
 string: (not set)
@@ -304,6 +314,26 @@ test_expect_success 'OPT_BOOLEAN() with PARSE_OPT_NODASH works' '
 
 cat > expect <<EOF
 boolean: 0
+subcommand: 4
+integer: 0
+timestamp: 0
+string: (not set)
+abbrev: 7
+verbose: 0
+quiet: no
+dry run: no
+file: (not set)
+EOF
+
+test_expect_success 'OPT_SUBCOMMAND() works' '
+	test-parse-options sub4 > output 2> output.err &&
+	test ! -s output.err &&
+	test_cmp expect output
+'
+
+cat > expect <<EOF
+boolean: 0
+subcommand: 0
 integer: 12345
 timestamp: 0
 string: (not set)
@@ -322,6 +352,7 @@ test_expect_success 'OPT_NUMBER_CALLBACK() works' '
 
 cat >expect <<EOF
 boolean: 0
+subcommand: 0
 integer: 0
 timestamp: 0
 string: (not set)
diff --git a/test-parse-options.c b/test-parse-options.c
index 36487c4..8d5fcd4 100644
--- a/test-parse-options.c
+++ b/test-parse-options.c
@@ -3,6 +3,7 @@
 #include "string-list.h"
 
 static int boolean = 0;
+static int subcommand = 0;
 static int integer = 0;
 static unsigned long timestamp;
 static int abbrev = 7;
@@ -40,6 +41,8 @@ int main(int argc, const char **argv)
 		OPT_BOOLEAN('b', "boolean", &boolean, "get a boolean"),
 		OPT_BIT('4', "or4", &boolean,
 			"bitwise-or boolean with ...0100", 4),
+		OPT_SUBCOMMAND("sub4", &subcommand,
+			"bitwise-or subcommand with ...0100", 4),
 		OPT_NEGBIT(0, "neg-or4", &boolean, "same as --no-or4", 4),
 		OPT_GROUP(""),
 		OPT_INTEGER('i', "integer", &integer, "get a integer"),
@@ -80,6 +83,7 @@ int main(int argc, const char **argv)
 	argc = parse_options(argc, argv, prefix, options, usage, 0);
 
 	printf("boolean: %d\n", boolean);
+	printf("subcommand: %d\n", subcommand);
 	printf("integer: %u\n", integer);
 	printf("timestamp: %lu\n", timestamp);
 	printf("string: %s\n", string ? string : "(not set)");
-- 
1.7.7.3
