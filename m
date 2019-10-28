Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A521B1F4C0
	for <e@80x24.org>; Mon, 28 Oct 2019 00:59:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728958AbfJ1A70 (ORCPT <rfc822;e@80x24.org>);
        Sun, 27 Oct 2019 20:59:26 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:54244 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728837AbfJ1A7Z (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 27 Oct 2019 20:59:25 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 69F8C61C4E;
        Mon, 28 Oct 2019 00:59:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1572224364;
        bh=szYvy2mSpCujZRSSprNcG9wOI3Zrx6ghlQzEQlbpcHY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=R45wtL2iMmTZr2TT68/9XCWEtnNzDhgsxlCXH6iEsqnIWCPN7XHNVl1oKq1gTw+9A
         oaNzf9T48oBjhZliygugvemDy57cbhxta9mzb98cztNyO8S/U2o+Z0Y6fy4OFzFydZ
         QXWjNi57biWWPzrg3YI8CRuBQzxOaqkHtAxxO4ZKPKvC+z0HA8Jo/aD6r0VsKTk7hk
         1MsUwU1dwE8uVzYHLFSFZfXHTnKwnU2lnumZg47ZN4LKmWICnMdFTE7hEHyWO3f7JJ
         2q/+48Xn/AQYYJ+2MktQLPm7NMyETo3pgpZCR9qw+VdAa+cxS8gGO/Gi0SllGyrlx8
         4lEfNgRPOHYJU/8j26LAeB41BZfaLbcr2Hx4STQ4I6fF7tp4ZQ5PzpJIVd/J5QYEIC
         iAnBY0hkduS7nmUOOfmvNTHdTYX5JEaJT6RCeGZtheQ0wSU5TfySJV43j6VSj5IVto
         hBU5zkE6dUR8g170F4uCdPKhYjoTR4d5OAa94ikqp78JZW8Fh0A
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Derrick Stolee <dstolee@microsoft.com>,
        Stefan Beller <stefanbeller@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH v2 03/15] rev-parse: add a --show-object-format option
Date:   Mon, 28 Oct 2019 00:58:55 +0000
Message-Id: <20191028005907.24985-4-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.24.0.rc0.303.g954a862665
In-Reply-To: <20191028005907.24985-1-sandals@crustytoothpaste.net>
References: <20191028005907.24985-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add an option to print the object format used for input, output, or
storage. This allows shell scripts to discover the hash algorithm in
use.

Since the transition plan allows for multiple input algorithms, document
that we may provide multiple results for input, and the format that the
results may take. While we don't support this now, documenting it early
means that script authors can future-proof their scripts for when we do.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 Documentation/git-rev-parse.txt |  7 +++++++
 builtin/rev-parse.c             | 11 +++++++++++
 t/t1500-rev-parse.sh            | 15 +++++++++++++++
 3 files changed, 33 insertions(+)

diff --git a/Documentation/git-rev-parse.txt b/Documentation/git-rev-parse.txt
index e72d332b83..9985477efe 100644
--- a/Documentation/git-rev-parse.txt
+++ b/Documentation/git-rev-parse.txt
@@ -274,6 +274,13 @@ print a message to stderr and exit with nonzero status.
 	Show the path to the shared index file in split index mode, or
 	empty if not in split-index mode.
 
+--show-object-format[=(storage|input|output)]::
+	Show the object format (hash algorithm) used for the repository
+	for storage inside the `.git` directory, input, or output. For
+	input, multiple algorithms may be printed, space-separated.
+	If not specified, the default is "storage".
+
+
 Other Options
 ~~~~~~~~~~~~~
 
diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
index 308c67e4fc..85ce2095bf 100644
--- a/builtin/rev-parse.c
+++ b/builtin/rev-parse.c
@@ -919,6 +919,17 @@ int cmd_rev_parse(int argc, const char **argv, const char *prefix)
 				show_datestring("--min-age=", arg);
 				continue;
 			}
+			if (opt_with_value(arg, "--show-object-format", &arg)) {
+				const char *val = arg ? arg : "storage";
+
+				if (strcmp(val, "storage") &&
+				    strcmp(val, "input") &&
+				    strcmp(val, "output"))
+					die("unknown mode for --show-object-format: %s",
+					    arg);
+				puts(the_hash_algo->name);
+				continue;
+			}
 			if (show_flag(arg) && verify)
 				die_no_single_rev(quiet);
 			continue;
diff --git a/t/t1500-rev-parse.sh b/t/t1500-rev-parse.sh
index 01abee533d..0177fd815c 100755
--- a/t/t1500-rev-parse.sh
+++ b/t/t1500-rev-parse.sh
@@ -59,6 +59,7 @@ test_rev_parse () {
 ROOT=$(pwd)
 
 test_expect_success 'setup' '
+	test_oid_init &&
 	mkdir -p sub/dir work &&
 	cp -R .git repo.git
 '
@@ -131,6 +132,20 @@ test_expect_success 'rev-parse --is-shallow-repository in non-shallow repo' '
 	test_cmp expect actual
 '
 
+test_expect_success 'rev-parse --show-object-format in repo' '
+	echo "$(test_oid algo)" >expect &&
+	git rev-parse --show-object-format >actual &&
+	test_cmp expect actual &&
+	git rev-parse --show-object-format=storage >actual &&
+	test_cmp expect actual &&
+	git rev-parse --show-object-format=input >actual &&
+	test_cmp expect actual &&
+	git rev-parse --show-object-format=output >actual &&
+	test_cmp expect actual &&
+	test_must_fail git rev-parse --show-object-format=squeamish-ossifrage 2>err &&
+	grep "unknown mode for --show-object-format: squeamish-ossifrage" err
+'
+
 test_expect_success 'showing the superproject correctly' '
 	git rev-parse --show-superproject-working-tree >out &&
 	test_must_be_empty out &&
