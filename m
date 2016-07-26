Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BB553203E5
	for <e@80x24.org>; Tue, 26 Jul 2016 21:13:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758244AbcGZVNp (ORCPT <rfc822;e@80x24.org>);
	Tue, 26 Jul 2016 17:13:45 -0400
Received: from siwi.pair.com ([209.68.5.199]:15960 "EHLO siwi.pair.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758241AbcGZVNp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jul 2016 17:13:45 -0400
Received: from jeffhost-linux1.corp.microsoft.com (unknown [167.220.24.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
	(No client certificate requested)
	by siwi.pair.com (Postfix) with ESMTPSA id 18B1D84619;
	Tue, 26 Jul 2016 17:13:42 -0400 (EDT)
From:	Jeff Hostetler <git@jeffhostetler.com>
To:	git@vger.kernel.org
Cc:	gitster@pobox.com, Johannes.Schindelin@gmx.de,
	Jeff Hostetler <jeffhost@microsoft.com>,
	Jeff Hostetler <git@jeffhostetler.com>
Subject: [PATCH v3 3/8] status: support --porcelain[=<version>]
Date:	Tue, 26 Jul 2016 17:11:18 -0400
Message-Id: <1469567483-58794-4-git-send-email-git@jeffhostetler.com>
X-Mailer: git-send-email 2.8.0.rc4.17.gac42084.dirty
In-Reply-To: <1469567483-58794-1-git-send-email-git@jeffhostetler.com>
References: <1469567483-58794-1-git-send-email-git@jeffhostetler.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Update --porcelain argument to take optional version parameter
to allow multiple porcelain formats to be supported in the future.

The token "v1" is the default value and indicates the traditional
porcelain format.  (The token "1" is an alias for that.)

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
Signed-off-by: Jeff Hostetler <git@jeffhostetler.com>
---
 Documentation/git-status.txt |  7 +++++--
 builtin/commit.c             | 21 ++++++++++++++++++---
 t/t7060-wtstatus.sh          | 21 +++++++++++++++++++++
 3 files changed, 44 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-status.txt b/Documentation/git-status.txt
index e1e8f57..6b1454b 100644
--- a/Documentation/git-status.txt
+++ b/Documentation/git-status.txt
@@ -32,11 +32,14 @@ OPTIONS
 --branch::
 	Show the branch and tracking info even in short-format.
 
---porcelain::
+--porcelain[=<version>]::
 	Give the output in an easy-to-parse format for scripts.
 	This is similar to the short output, but will remain stable
 	across Git versions and regardless of user configuration. See
 	below for details.
++
+The version parameter is used to specify the format version.
+This is optional and defaults to the original version 'v1' format.
 
 --long::
 	Give the output in the long-format. This is the default.
@@ -96,7 +99,7 @@ configuration variable documented in linkgit:git-config[1].
 
 -z::
 	Terminate entries with NUL, instead of LF.  This implies
-	the `--porcelain` output format if no other format is given.
+	the `--porcelain=v1` output format if no other format is given.
 
 --column[=<options>]::
 --no-column::
diff --git a/builtin/commit.c b/builtin/commit.c
index a792deb..c3ae2c3 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -144,6 +144,21 @@ static struct strbuf message = STRBUF_INIT;
 
 static enum wt_status_format status_format = STATUS_FORMAT_UNSPECIFIED;
 
+static int opt_parse_porcelain(const struct option *opt, const char *arg, int unset)
+{
+	enum wt_status_format *value = (enum wt_status_format *)opt->value;
+	if (unset)
+		*value = STATUS_FORMAT_NONE;
+	else if (!arg)
+		*value = STATUS_FORMAT_PORCELAIN;
+	else if (!strcmp(arg, "v1") || !strcmp(arg,"1"))
+		*value = STATUS_FORMAT_PORCELAIN;
+	else
+		die("unsupported porcelain version '%s'", arg);
+
+	return 0;
+}
+
 static int opt_parse_m(const struct option *opt, const char *arg, int unset)
 {
 	struct strbuf *buf = opt->value;
@@ -1316,9 +1331,9 @@ int cmd_status(int argc, const char **argv, const char *prefix)
 			    N_("show status concisely"), STATUS_FORMAT_SHORT),
 		OPT_BOOL('b', "branch", &s.show_branch,
 			 N_("show branch information")),
-		OPT_SET_INT(0, "porcelain", &status_format,
-			    N_("machine-readable output"),
-			    STATUS_FORMAT_PORCELAIN),
+		{ OPTION_CALLBACK, 0, "porcelain", &status_format,
+		  N_("version"), N_("machine-readable output"),
+		  PARSE_OPT_OPTARG, opt_parse_porcelain },
 		OPT_SET_INT(0, "long", &status_format,
 			    N_("show status in long format (default)"),
 			    STATUS_FORMAT_LONG),
diff --git a/t/t7060-wtstatus.sh b/t/t7060-wtstatus.sh
index 44bf1d8..00e0ceb 100755
--- a/t/t7060-wtstatus.sh
+++ b/t/t7060-wtstatus.sh
@@ -228,4 +228,25 @@ test_expect_success 'status --branch with detached HEAD' '
 	test_i18ncmp expected actual
 '
 
+## Duplicate the above test and verify --porcelain=v1 arg parsing.
+test_expect_success 'status --porcelain=v1 --branch with detached HEAD' '
+	git reset --hard &&
+	git checkout master^0 &&
+	git status --branch --porcelain=v1 >actual &&
+	cat >expected <<-EOF &&
+	## HEAD (no branch)
+	?? .gitconfig
+	?? actual
+	?? expect
+	?? expected
+	?? mdconflict/
+	EOF
+	test_i18ncmp expected actual
+'
+
+## Verify parser error on invalid --porcelain argument.
+test_expect_success 'status --porcelain=bogus' '
+	test_must_fail git status --porcelain=bogus
+'
+
 test_done
-- 
2.8.0.rc4.17.gac42084.dirty

