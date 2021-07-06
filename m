Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 629C5C07E96
	for <git@archiver.kernel.org>; Tue,  6 Jul 2021 22:45:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4199B61CAA
	for <git@archiver.kernel.org>; Tue,  6 Jul 2021 22:45:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230003AbhGFWsE (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Jul 2021 18:48:04 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:37536 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229753AbhGFWsE (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 6 Jul 2021 18:48:04 -0400
Received: from camp.crustytoothpaste.net (unknown [72.12.180.34])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id DC05860450;
        Tue,  6 Jul 2021 22:44:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1625611495;
        bh=2EjPBcLNhkzO0pYRiNQNRYYA2ECP/AUa1PJfSdMtzvU=;
        h=From:To:Cc:Subject:Date:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=vEUVpcA0X/DA0MpB3xEIeRf79ioveFKJBs+zl06923rYheU2AHWBgSGSvD6pQLiki
         WheGMX9tUdTCqGEbE7elOyLz+8Rszhg6rFQtMccHRioDdClD4RX1ASYV/V88pc/J1L
         c1WSBLDxVcFNQxEPbBcx8JdlsThaU4Cf3qfr/8aXCRkEb8MITGaHFEPyuV7SJ/s5qP
         c97gIaDhs9VC2NOJ2aDffcTMNlWTKUFuMgh6xOeuXrg6Dm3XL1Aw8YDTOtf5axoOvh
         MAuaO0A8Z6M8mqTAPXRdkRePikfvQH2z9xVcnL3nNV0KUYtVAo5VUhWprz2PTXhHFm
         GmLgOEArcvm7EdyxQ0hZUYoOTjPEd9bNPGcJm48WYyo1mcsyKxjMI/jgWgOnalBjmx
         WyzWlqZJ72tfH9Hw8nUIk05s2IUopbV/KDJ5CQLiYjSpOwT6D/bCJQRlwBv4fpF2cH
         QL5Eg1qoRG/GLhNiEM2vsKxNqJpfBQCU+DAK+eoHNmqQi+23bkw
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>
Subject: [PATCH] rev-list: add option for --pretty without header
Date:   Tue,  6 Jul 2021 22:43:21 +0000
Message-Id: <20210706224321.14371-1-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.32.0.272.g935e593368
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In general, we encourage users to use plumbing commands, like git
rev-list, over porcelain commands, like git log, when scripting.
However, git rev-list has one glaring problem that prevents it from
being used in certain cases: when --pretty is used, it always prints out
a line containing "commit" and the object ID.  This makes it unsuitable
for many scripting needs, and forces users to use git log instead.

While we can't change this behavior for backwards compatibility, we can
add an option to suppress this behavior, so let's do so, and call it
"--no-commit-header".  Additionally, add the corresponding positive
option to switch it back on.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
This has come up a lot on the list and I'm sure most of the regulars
have run into it before.  It came up at $DAYJOB and I said I intended to
send a patch, so here it is.

I chose --no-commit-header because --header is already taken.  Of
course, suggestions for better names are welcome, since we all know my
naming skills are terrible.

 Documentation/rev-list-options.txt |  7 +++++++
 builtin/rev-list.c                 | 17 ++++++++++++++---
 revision.h                         |  3 ++-
 t/t6006-rev-list-format.sh         | 23 ++++++++++++++++++++++-
 4 files changed, 45 insertions(+), 5 deletions(-)

diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
index 5bf2a85f69..84b03a4cde 100644
--- a/Documentation/rev-list-options.txt
+++ b/Documentation/rev-list-options.txt
@@ -1064,6 +1064,13 @@ ifdef::git-rev-list[]
 --header::
 	Print the contents of the commit in raw-format; each record is
 	separated with a NUL character.
+
+--no-commit-header::
+	Suppress the header line containing "commit" and the object ID printed before
+	the specified format.
+
+--commit-header::
+	Overrides a previous `--no-commit-header`.
 endif::git-rev-list[]
 
 --parents::
diff --git a/builtin/rev-list.c b/builtin/rev-list.c
index 7677b1af5a..f571cc9598 100644
--- a/builtin/rev-list.c
+++ b/builtin/rev-list.c
@@ -132,7 +132,7 @@ static void show_commit(struct commit *commit, void *data)
 	if (revs->abbrev_commit && revs->abbrev)
 		fputs(find_unique_abbrev(&commit->object.oid, revs->abbrev),
 		      stdout);
-	else
+	else if (revs->include_header)
 		fputs(oid_to_hex(&commit->object.oid), stdout);
 	if (revs->print_parents) {
 		struct commit_list *parents = commit->parents;
@@ -153,7 +153,7 @@ static void show_commit(struct commit *commit, void *data)
 	show_decorations(revs, commit);
 	if (revs->commit_format == CMIT_FMT_ONELINE)
 		putchar(' ');
-	else
+	else if (revs->include_header)
 		putchar('\n');
 
 	if (revs->verbose_header) {
@@ -512,6 +512,7 @@ int cmd_rev_list(int argc, const char **argv, const char *prefix)
 	repo_init_revisions(the_repository, &revs, prefix);
 	revs.abbrev = DEFAULT_ABBREV;
 	revs.commit_format = CMIT_FMT_UNSPECIFIED;
+	revs.include_header = 1;
 
 	/*
 	 * Scan the argument list before invoking setup_revisions(), so that we
@@ -627,6 +628,16 @@ int cmd_rev_list(int argc, const char **argv, const char *prefix)
 			continue;
 		}
 
+		if (!strcmp(arg, ("--commit-header"))) {
+			revs.include_header = 1;
+			continue;
+		}
+
+		if (!strcmp(arg, ("--no-commit-header"))) {
+			revs.include_header = 0;
+			continue;
+		}
+
 		if (!strcmp(arg, "--disk-usage")) {
 			show_disk_usage = 1;
 			info.flags |= REV_LIST_QUIET;
@@ -639,7 +650,7 @@ int cmd_rev_list(int argc, const char **argv, const char *prefix)
 	if (revs.commit_format != CMIT_FMT_UNSPECIFIED) {
 		/* The command line has a --pretty  */
 		info.hdr_termination = '\n';
-		if (revs.commit_format == CMIT_FMT_ONELINE)
+		if (revs.commit_format == CMIT_FMT_ONELINE || !revs.include_header)
 			info.header_prefix = "";
 		else
 			info.header_prefix = "commit ";
diff --git a/revision.h b/revision.h
index 17698cb51a..7464434f60 100644
--- a/revision.h
+++ b/revision.h
@@ -215,7 +215,8 @@ struct rev_info {
 			missing_newline:1,
 			date_mode_explicit:1,
 			preserve_subject:1,
-			encode_email_headers:1;
+			encode_email_headers:1,
+			include_header:1;
 	unsigned int	disable_stdin:1;
 	/* --show-linear-break */
 	unsigned int	track_linear:1,
diff --git a/t/t6006-rev-list-format.sh b/t/t6006-rev-list-format.sh
index 35a2f62392..e68bf9f21c 100755
--- a/t/t6006-rev-list-format.sh
+++ b/t/t6006-rev-list-format.sh
@@ -54,9 +54,15 @@ test_expect_success 'setup' '
 
 # usage: test_format name format_string [failure] <expected_output
 test_format () {
+	local header_arg=
+	if test "$1" = "--no-commit-header"
+	then
+		header_arg="--no-commit-header"
+		shift
+	fi
 	cat >expect.$1
 	test_expect_${3:-success} "format $1" "
-		git rev-list --pretty=format:'$2' main >output.$1 &&
+		git rev-list $header_arg --pretty=format:'$2' main >output.$1 &&
 		test_cmp expect.$1 output.$1
 	"
 }
@@ -93,6 +99,14 @@ $head1
 $head1_short
 EOF
 
+test_format --no-commit-header hash-no-header %H%n%h <<EOF
+$head2
+$head2_short
+$head1
+$head1_short
+EOF
+
+
 test_format tree %T%n%t <<EOF
 commit $head2
 $tree2
@@ -181,6 +195,13 @@ $added
 
 EOF
 
+test_format --no-commit-header raw-body-no-header %B <<EOF
+$changed
+
+$added
+
+EOF
+
 test_expect_success 'basic colors' '
 	cat >expect <<-EOF &&
 	commit $head2
