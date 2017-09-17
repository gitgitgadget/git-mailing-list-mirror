Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 07D0920281
	for <e@80x24.org>; Sun, 17 Sep 2017 08:17:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750803AbdIQIRc (ORCPT <rfc822;e@80x24.org>);
        Sun, 17 Sep 2017 04:17:32 -0400
Received: from benson.default.arb33.uk0.bigv.io ([46.43.0.16]:33432 "EHLO
        benson.default.arb33.uk0.bigv.io" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750761AbdIQIR3 (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 17 Sep 2017 04:17:29 -0400
X-Greylist: delayed 2426 seconds by postgrey-1.27 at vger.kernel.org; Sun, 17 Sep 2017 04:17:29 EDT
Received: from cpc91198-cmbg18-2-0-cust103.5-4.cable.virginm.net ([81.98.98.104] helo=celaeno.hellion.org.uk)
        by benson.default.arb33.uk0.bigv.io with esmtpsa (TLS1.2:RSA_AES_128_CBC_SHA1:128)
        (Exim 4.80)
        (envelope-from <ijc-relay-phiayoh8@benson.default.arb33.uk0.bigv.io>)
        id 1dtU8S-0006LQ-Ue; Sun, 17 Sep 2017 08:37:01 +0100
Received: from dagon.hellion.org.uk ([192.168.1.7])
        by celaeno.hellion.org.uk with smtp (Exim 4.84_2)
        (envelope-from <ijc@hellion.org.uk>)
        id 1dtU8P-0005xG-MN; Sun, 17 Sep 2017 08:36:58 +0100
Received: by dagon.hellion.org.uk (sSMTP sendmail emulation); Sun, 17 Sep 2017 08:36:57 +0100
From:   Ian Campbell <ijc@hellion.org.uk>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, Ian Campbell <ijc@hellion.org.uk>
Subject: [PATCH v2 1/4] mktag: add option which allows the tagger field to be omitted
Date:   Sun, 17 Sep 2017 08:36:54 +0100
Message-Id: <20170917073657.31193-1-ijc@hellion.org.uk>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <1505633797.22447.4.camel@hellion.org.uk>
References: <1505633797.22447.4.camel@hellion.org.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This can be useful e.g. in `filter-branch` when rewritting tags produced by
older versions of Git, such as v2.6.12-rc2..v2.6.13-rc3 in the Linux kernel
source tree:

        $ git cat-file tag v2.6.12-rc2
        object 1da177e4c3f41524e886b7f1b8a0c1fc7321cac2
        type commit
        tag v2.6.12-rc2

        Linux v2.6.12-rc2 release
        -----BEGIN PGP SIGNATURE-----
        Version: GnuPG v1.2.4 (GNU/Linux)

        iD8DBQBCbW8ZF3YsRnbiHLsRAgFRAKCq/TkuDaEombFABkPqYgGCgWN2lQCcC0qc
        wznDbFU45A54dZC8RZ5JxyE=
        =ESRP
        -----END PGP SIGNATURE-----

        $ git cat-file tag v2.6.12-rc2 | git mktag
        error: char76: could not find "tagger "
        fatal: invalid tag signature file
        $ git cat-file tag v2.6.12-rc2 | git mktag --allow-missing-tagger
        9e734775f7c22d2f89943ad6c745571f1930105f

To that end, pass the new option to `mktag` in `filter-branch`.

Signed-off-by: Ian Campbell <ijc@hellion.org.uk>
---
 Documentation/git-mktag.txt |   9 +++-
 builtin/mktag.c             | 100 +++++++++++++++++++++++++-------------------
 git-filter-branch.sh        |   2 +-
 t/t3800-mktag.sh            |  33 ++++++++++++++-
 4 files changed, 98 insertions(+), 46 deletions(-)

diff --git a/Documentation/git-mktag.txt b/Documentation/git-mktag.txt
index fa6a75612..c720c7419 100644
--- a/Documentation/git-mktag.txt
+++ b/Documentation/git-mktag.txt
@@ -9,7 +9,7 @@ git-mktag - Creates a tag object
 SYNOPSIS
 --------
 [verse]
-'git mktag'
+'git mktag' [--allow-missing-tagger]
 
 DESCRIPTION
 -----------
@@ -34,6 +34,13 @@ exists, is separated by a blank line from the header.  The
 message part may contain a signature that Git itself doesn't
 care about, but that can be verified with gpg.
 
+OPTIONS
+-------
+--allow-missing-tagger::
+	Allow the `tagger` line in the header to be omitted. This is
+	rarely desirable but may be useful in recreating tags created
+	by older Git.
+
 GIT
 ---
 Part of the linkgit:git[1] suite
diff --git a/builtin/mktag.c b/builtin/mktag.c
index 031b750f0..0f5dae8d5 100644
--- a/builtin/mktag.c
+++ b/builtin/mktag.c
@@ -1,4 +1,5 @@
 #include "builtin.h"
+#include "parse-options.h"
 #include "tag.h"
 
 /*
@@ -15,6 +16,8 @@
  * the shortest possible tagger-line.
  */
 
+static int allow_missing_tagger;
+
 /*
  * We refuse to tag something we can't verify. Just because.
  */
@@ -41,8 +44,9 @@ static int verify_tag(char *buffer, unsigned long size)
 	unsigned char sha1[20];
 	const char *object, *type_line, *tag_line, *tagger_line, *lb, *rb;
 	size_t len;
+	const unsigned long min_size = allow_missing_tagger ? 71 : 84;
 
-	if (size < 84)
+	if (size < min_size)
 		return error("wanna fool me ? you obviously got the size wrong !");
 
 	buffer[size] = 0;
@@ -98,46 +102,46 @@ static int verify_tag(char *buffer, unsigned long size)
 	/* Verify the tagger line */
 	tagger_line = tag_line;
 
-	if (memcmp(tagger_line, "tagger ", 7))
+	if (!memcmp(tagger_line, "tagger ", 7)) {
+		/*
+		 * Check for correct form for name and email
+		 * i.e. " <" followed by "> " on _this_ line
+		 * No angle brackets within the name or email address fields.
+		 * No spaces within the email address field.
+		 */
+		tagger_line += 7;
+		if (!(lb = strstr(tagger_line, " <")) || !(rb = strstr(lb+2, "> ")) ||
+			strpbrk(tagger_line, "<>\n") != lb+1 ||
+			strpbrk(lb+2, "><\n ") != rb)
+			return error("char%"PRIuMAX": malformed tagger field",
+				(uintmax_t) (tagger_line - buffer));
+
+		/* Check for author name, at least one character, space is acceptable */
+		if (lb == tagger_line)
+			return error("char%"PRIuMAX": missing tagger name",
+				(uintmax_t) (tagger_line - buffer));
+
+		/* timestamp, 1 or more digits followed by space */
+		tagger_line = rb + 2;
+		if (!(len = strspn(tagger_line, "0123456789")))
+			return error("char%"PRIuMAX": missing tag timestamp",
+				(uintmax_t) (tagger_line - buffer));
+		tagger_line += len;
+		if (*tagger_line != ' ')
+			return error("char%"PRIuMAX": malformed tag timestamp",
+				(uintmax_t) (tagger_line - buffer));
+		tagger_line++;
+
+		/* timezone, 5 digits [+-]hhmm, max. 1400 */
+		if (!((tagger_line[0] == '+' || tagger_line[0] == '-') &&
+		      strspn(tagger_line+1, "0123456789") == 4 &&
+		      tagger_line[5] == '\n' && atoi(tagger_line+1) <= 1400))
+			return error("char%"PRIuMAX": malformed tag timezone",
+				(uintmax_t) (tagger_line - buffer));
+		tagger_line += 6;
+	} else if (!allow_missing_tagger)
 		return error("char%"PRIuMAX": could not find \"tagger \"",
-			(uintmax_t) (tagger_line - buffer));
-
-	/*
-	 * Check for correct form for name and email
-	 * i.e. " <" followed by "> " on _this_ line
-	 * No angle brackets within the name or email address fields.
-	 * No spaces within the email address field.
-	 */
-	tagger_line += 7;
-	if (!(lb = strstr(tagger_line, " <")) || !(rb = strstr(lb+2, "> ")) ||
-		strpbrk(tagger_line, "<>\n") != lb+1 ||
-		strpbrk(lb+2, "><\n ") != rb)
-		return error("char%"PRIuMAX": malformed tagger field",
-			(uintmax_t) (tagger_line - buffer));
-
-	/* Check for author name, at least one character, space is acceptable */
-	if (lb == tagger_line)
-		return error("char%"PRIuMAX": missing tagger name",
-			(uintmax_t) (tagger_line - buffer));
-
-	/* timestamp, 1 or more digits followed by space */
-	tagger_line = rb + 2;
-	if (!(len = strspn(tagger_line, "0123456789")))
-		return error("char%"PRIuMAX": missing tag timestamp",
-			(uintmax_t) (tagger_line - buffer));
-	tagger_line += len;
-	if (*tagger_line != ' ')
-		return error("char%"PRIuMAX": malformed tag timestamp",
-			(uintmax_t) (tagger_line - buffer));
-	tagger_line++;
-
-	/* timezone, 5 digits [+-]hhmm, max. 1400 */
-	if (!((tagger_line[0] == '+' || tagger_line[0] == '-') &&
-	      strspn(tagger_line+1, "0123456789") == 4 &&
-	      tagger_line[5] == '\n' && atoi(tagger_line+1) <= 1400))
-		return error("char%"PRIuMAX": malformed tag timezone",
-			(uintmax_t) (tagger_line - buffer));
-	tagger_line += 6;
+			     (uintmax_t) (tagger_line - buffer));
 
 	/* Verify the blank line separating the header from the body */
 	if (*tagger_line != '\n')
@@ -148,13 +152,25 @@ static int verify_tag(char *buffer, unsigned long size)
 	return 0;
 }
 
+static char const * const mktag_usage[] = {
+	N_("git mktag [<options>]"),
+	NULL
+};
+
+static struct option mktag_opts[] = {
+	OPT_BOOL(0, "allow-missing-tagger", &allow_missing_tagger, N_("allow the tagger field to be omitted")),
+	OPT_END(),
+};
+
 int cmd_mktag(int argc, const char **argv, const char *prefix)
 {
 	struct strbuf buf = STRBUF_INIT;
 	unsigned char result_sha1[20];
 
-	if (argc != 1)
-		usage("git mktag");
+	argc = parse_options(argc, argv, prefix, mktag_opts, mktag_usage, 0);
+
+	if (argc != 0)
+		usage_with_options(mktag_usage, mktag_opts);
 
 	if (strbuf_read(&buf, 0, 4096) < 0) {
 		die_errno("could not read from stdin");
diff --git a/git-filter-branch.sh b/git-filter-branch.sh
index 3a74602ef..05645064a 100755
--- a/git-filter-branch.sh
+++ b/git-filter-branch.sh
@@ -530,7 +530,7 @@ if [ "$filter_tag_name" ]; then
 					}' \
 				    -e '/^-----BEGIN PGP SIGNATURE-----/q' \
 				    -e 'p' ) |
-				git mktag) ||
+				git mktag --allow-missing-tagger) ||
 				die "Could not create new tag object for $ref"
 			if git cat-file tag "$ref" | \
 			   sane_grep '^-----BEGIN PGP SIGNATURE-----' >/dev/null 2>&1
diff --git a/t/t3800-mktag.sh b/t/t3800-mktag.sh
index 8eb47942e..3a77a26c8 100755
--- a/t/t3800-mktag.sh
+++ b/t/t3800-mktag.sh
@@ -340,7 +340,36 @@ check_verify_failure 'detect invalid header entry' \
 	'^error: char124: trailing garbage in tag header$'
 
 ############################################################
-# 24. create valid tag
+# 24. missing tagger ok with --allow-missing-tagger
+
+cat >tag.sig <<EOF
+object $head
+type commit
+tag mytag
+
+EOF
+
+test_expect_success \
+    'missing tagger with --allow-missing-tagger' \
+    'git mktag --allow-missing-tagger <tag.sig >.git/refs/tags/mytag 2>message'
+
+############################################################
+# 25. detect invalid header entry with --allow-missing-tagger
+
+cat >tag.sig <<EOF
+object $head
+type commit
+tag mytag
+this line should not be here
+EOF
+
+test_expect_success \
+    'detect invalid header entry with --allow-missing-tagger' \
+    '( test_must_fail git mktag --allow-missing-tagger <tag.sig 2>message ) &&
+       grep "^error: char70: trailing garbage in tag header$" message'
+
+############################################################
+# 26. create valid tag
 
 cat >tag.sig <<EOF
 object $head
@@ -355,7 +384,7 @@ test_expect_success \
     'git mktag <tag.sig >.git/refs/tags/mytag 2>message'
 
 ############################################################
-# 25. check mytag
+# 27. check mytag
 
 test_expect_success \
     'check mytag' \
-- 
2.11.0

