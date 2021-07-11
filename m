Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EA65C07E96
	for <git@archiver.kernel.org>; Sun, 11 Jul 2021 21:55:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 605846100C
	for <git@archiver.kernel.org>; Sun, 11 Jul 2021 21:55:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229758AbhGKV6H (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 11 Jul 2021 17:58:07 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:39358 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229544AbhGKV6H (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 11 Jul 2021 17:58:07 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:a6ae:7d13:8741:9028])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id B8AEC6042E;
        Sun, 11 Jul 2021 21:55:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1626040519;
        bh=iNKMfweB5vzOhZ4ezoUmUzg6FS2eW5R3Yf1Yy9lIee4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=y+lRDvlZAlqIT314r1+SjB/Dz8llqYBz8ulUieohuTRjmkT2kcWwinBvu+OQXLYS1
         sjQjbZvdSGqY8jCaSkQzdiymPHV7GjrJdmjR3OTwkaJDWQ15jtC+uJ2PCIEjVDai7O
         Yseydx0zefUd75VE8NdqSd1Y4s4+0mq/irXRBnM95zOmcxBnfA3FZcRCx+fGeyJzJ9
         YiIHQfeM3xPqMWYrIfaqJFMAl4htJQn/y5lot/+ttjw6yV9bJvVFb31kLYVolBnwvP
         O5dgSm8J+yg9xPIkUnjgKDMyK8qQsvnMsfn4rZM9ZT3RgF0j3+DAMGvyt8D1fAJpMh
         q94jvoKoZawN4tPK/zEWzU+SyyYE+aDiXkraC/TdnaQ4occAB0s1iWq/rz2Rl/Raaq
         AAFb9hE6gZhDnCkVEhm9SZbf+EgJ/Sl1O7ouF+TUo1YOUbCnvcKP6+pJUgkE7DApJ1
         KFwuEDdyqjIo1wKp8ZUF6DBMwEkCykfsZuyff2vN24585ITo2b4
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        Taylor Blau <me@ttaylorr.com>, Jeff King <peff@peff.net>
Subject: [PATCH v2] rev-list: add option for --pretty=format without header
Date:   Sun, 11 Jul 2021 21:55:10 +0000
Message-Id: <20210711215510.191626-1-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.32.0.272.g935e593368
In-Reply-To: <20210706224321.14371-1-sandals@crustytoothpaste.net>
References: <20210706224321.14371-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In general, we encourage users to use plumbing commands, like git
rev-list, over porcelain commands, like git log, when scripting.
However, git rev-list has one glaring problem that prevents it from
being used in certain cases: when --pretty is used with a custom format,
it always prints out a line containing "commit" and the object ID.  This
makes it unsuitable for many scripting needs, and forces users to use
git log instead.

While we can't change this behavior for backwards compatibility, we can
add an option to suppress this behavior, so let's do so, and call it
"--no-commit-header".  Additionally, add the corresponding positive
option to switch it back on.

Note that this option doesn't affect the built-in formats, only custom
formats.  This is exactly the same behavior as users already have from
git log and is what most users will be used to.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
Changes from v1:
* Ensure this applies only to custom formats.
* Fix the issue with --abbrev-commit mentioned by Junio.
* Add tests for additional cases, including built-in formats.
* Update documentation to reflect this data.

 Documentation/rev-list-options.txt |  8 +++
 builtin/rev-list.c                 | 33 ++++++++----
 revision.h                         |  3 +-
 t/t6006-rev-list-format.sh         | 80 +++++++++++++++++++++++++++++-
 4 files changed, 112 insertions(+), 12 deletions(-)

diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
index 5bf2a85f69..23388f36c3 100644
--- a/Documentation/rev-list-options.txt
+++ b/Documentation/rev-list-options.txt
@@ -1064,6 +1064,14 @@ ifdef::git-rev-list[]
 --header::
 	Print the contents of the commit in raw-format; each record is
 	separated with a NUL character.
+
+--no-commit-header::
+	Suppress the header line containing "commit" and the object ID printed before
+	the specified format.  This has no effect on the built-in formats; only custom
+	formats are affected.
+
+--commit-header::
+	Overrides a previous `--no-commit-header`.
 endif::git-rev-list[]
 
 --parents::
diff --git a/builtin/rev-list.c b/builtin/rev-list.c
index 7677b1af5a..36cb909eba 100644
--- a/builtin/rev-list.c
+++ b/builtin/rev-list.c
@@ -127,13 +127,15 @@ static void show_commit(struct commit *commit, void *data)
 	if (info->header_prefix)
 		fputs(info->header_prefix, stdout);
 
-	if (!revs->graph)
-		fputs(get_revision_mark(revs, commit), stdout);
-	if (revs->abbrev_commit && revs->abbrev)
-		fputs(find_unique_abbrev(&commit->object.oid, revs->abbrev),
-		      stdout);
-	else
-		fputs(oid_to_hex(&commit->object.oid), stdout);
+	if (revs->include_header) {
+		if (!revs->graph)
+			fputs(get_revision_mark(revs, commit), stdout);
+		if (revs->abbrev_commit && revs->abbrev)
+			fputs(find_unique_abbrev(&commit->object.oid, revs->abbrev),
+			      stdout);
+		else
+			fputs(oid_to_hex(&commit->object.oid), stdout);
+	}
 	if (revs->print_parents) {
 		struct commit_list *parents = commit->parents;
 		while (parents) {
@@ -153,7 +155,7 @@ static void show_commit(struct commit *commit, void *data)
 	show_decorations(revs, commit);
 	if (revs->commit_format == CMIT_FMT_ONELINE)
 		putchar(' ');
-	else
+	else if (revs->include_header)
 		putchar('\n');
 
 	if (revs->verbose_header) {
@@ -512,6 +514,7 @@ int cmd_rev_list(int argc, const char **argv, const char *prefix)
 	repo_init_revisions(the_repository, &revs, prefix);
 	revs.abbrev = DEFAULT_ABBREV;
 	revs.commit_format = CMIT_FMT_UNSPECIFIED;
+	revs.include_header = 1;
 
 	/*
 	 * Scan the argument list before invoking setup_revisions(), so that we
@@ -627,6 +630,16 @@ int cmd_rev_list(int argc, const char **argv, const char *prefix)
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
@@ -636,10 +649,12 @@ int cmd_rev_list(int argc, const char **argv, const char *prefix)
 		usage(rev_list_usage);
 
 	}
+	if (revs.commit_format != CMIT_FMT_USERFORMAT)
+		revs.include_header = 1;
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
index 35a2f62392..41d0ca00b1 100755
--- a/t/t6006-rev-list-format.sh
+++ b/t/t6006-rev-list-format.sh
@@ -41,22 +41,59 @@ test_expect_success 'setup' '
 	echo "$added_iso88591" | git commit -F - &&
 	head1=$(git rev-parse --verify HEAD) &&
 	head1_short=$(git rev-parse --verify --short $head1) &&
+	head1_short4=$(git rev-parse --verify --short=4 $head1) &&
 	tree1=$(git rev-parse --verify HEAD:) &&
 	tree1_short=$(git rev-parse --verify --short $tree1) &&
 	echo "$changed" > foo &&
 	echo "$changed_iso88591" | git commit -a -F - &&
 	head2=$(git rev-parse --verify HEAD) &&
 	head2_short=$(git rev-parse --verify --short $head2) &&
+	head2_short4=$(git rev-parse --verify --short=4 $head2) &&
 	tree2=$(git rev-parse --verify HEAD:) &&
 	tree2_short=$(git rev-parse --verify --short $tree2) &&
 	git config --unset i18n.commitEncoding
 '
 
-# usage: test_format name format_string [failure] <expected_output
+# usage: test_format [argument...] name format_string [failure] <expected_output
 test_format () {
+	local args=
+	while true
+	do
+		case "$1" in
+		--*)
+			args="$args $1"
+			shift;;
+		*)
+			break;;
+		esac
+	done
 	cat >expect.$1
 	test_expect_${3:-success} "format $1" "
-		git rev-list --pretty=format:'$2' main >output.$1 &&
+		git rev-list $args --pretty=format:'$2' main >output.$1 &&
+		test_cmp expect.$1 output.$1
+	"
+}
+
+# usage: test_pretty [argument...] name format_name [failure] <expected_output
+test_pretty () {
+	local args=
+	while true
+	do
+		case "$1" in
+		--*)
+			args="$args $1"
+			shift;;
+		*)
+			break;;
+		esac
+	done
+	cat >expect.$1
+	test_expect_${3:-success} "pretty $1 (without --no-commit-header)" "
+		git rev-list $args --pretty='$2' main >output.$1 &&
+		test_cmp expect.$1 output.$1
+	"
+	test_expect_${3:-success} "pretty $1 (with --no-commit-header)" "
+		git rev-list $args --no-commit-header --pretty='$2' main >output.$1 &&
 		test_cmp expect.$1 output.$1
 	"
 }
@@ -93,6 +130,20 @@ $head1
 $head1_short
 EOF
 
+test_format --no-commit-header hash-no-header %H%n%h <<EOF
+$head2
+$head2_short
+$head1
+$head1_short
+EOF
+
+test_format --abbrev-commit --abbrev=0 --no-commit-header hash-no-header-abbrev %H%n%h <<EOF
+$head2
+$head2_short4
+$head1
+$head1_short4
+EOF
+
 test_format tree %T%n%t <<EOF
 commit $head2
 $tree2
@@ -181,6 +232,31 @@ $added
 
 EOF
 
+test_format --no-commit-header raw-body-no-header %B <<EOF
+$changed
+
+$added
+
+EOF
+
+test_pretty oneline oneline <<EOF
+$head2 $changed
+$head1 $added
+EOF
+
+test_pretty short short <<EOF
+commit $head2
+Author: $GIT_AUTHOR_NAME <$GIT_AUTHOR_EMAIL>
+
+    $changed
+
+commit $head1
+Author: $GIT_AUTHOR_NAME <$GIT_AUTHOR_EMAIL>
+
+    $added
+
+EOF
+
 test_expect_success 'basic colors' '
 	cat >expect <<-EOF &&
 	commit $head2
