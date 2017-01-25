Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.4 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BDA261F437
	for <e@80x24.org>; Wed, 25 Jan 2017 00:19:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751068AbdAYATj (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Jan 2017 19:19:39 -0500
Received: from zimbra-vnc.tngtech.com ([83.144.240.98]:4716 "EHLO
        proxy.tng.vnc.biz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751043AbdAYATi (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Jan 2017 19:19:38 -0500
Received: from localhost (localhost [127.0.0.1])
        by proxy.tng.vnc.biz (Postfix) with ESMTP id 581241E186E;
        Wed, 25 Jan 2017 01:19:35 +0100 (CET)
Received: from proxy.tng.vnc.biz ([127.0.0.1])
        by localhost (proxy.tng.vnc.biz [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 1D3KLpRFUCN4; Wed, 25 Jan 2017 01:19:34 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by proxy.tng.vnc.biz (Postfix) with ESMTP id B6FCB1E2D08;
        Wed, 25 Jan 2017 01:19:34 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
Received: from proxy.tng.vnc.biz ([127.0.0.1])
        by localhost (proxy.tng.vnc.biz [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id qQdN9d4lH1MB; Wed, 25 Jan 2017 01:19:34 +0100 (CET)
Received: from localhost.localdomain (aftr-185-17-206-134.dynamic.mnet-online.de [185.17.206.134])
        by proxy.tng.vnc.biz (Postfix) with ESMTPSA id 464411E186E;
        Wed, 25 Jan 2017 01:19:34 +0100 (CET)
From:   cornelius.weig@tngtech.com
To:     git@vger.kernel.org
Cc:     peff@peff.net, novalis@novalis.org, pclouds@gmail.com,
        Cornelius Weig <cornelius.weig@tngtech.com>
Subject: [PATCH] tag: add tag.createReflog option
Date:   Wed, 25 Jan 2017 01:19:06 +0100
Message-Id: <20170125001906.13916-1-cornelius.weig@tngtech.com>
X-Mailer: git-send-email 2.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Cornelius Weig <cornelius.weig@tngtech.com>

Git does not create a history for tags, in contrast to common
expectation to simply version everything. This can be changed by using
the `--create-reflog` flag when creating the tag. However, a config
option to enable this behavior by default is missing.

This commit adds the configuration variable `tag.createReflog` which
enables reflogs for new tags by default.

Signed-off-by: Cornelius Weig <cornelius.weig@tngtech.com>
---
 Documentation/config.txt  |  5 +++++
 Documentation/git-tag.txt |  8 +++++---
 builtin/tag.c             |  6 +++++-
 t/t7004-tag.sh            | 14 ++++++++++++++
 4 files changed, 29 insertions(+), 4 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index af2ae4c..9e5f6f6 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -2945,6 +2945,11 @@ submodule.alternateErrorStrategy
 	as computed via `submodule.alternateLocation`. Possible values are
 	`ignore`, `info`, `die`. Default is `die`.
 
+tag.createReflog::
+	A boolean to specify whether newly created tags should have a reflog.
+	If `--[no-]create-reflog` is specified on the command line, it takes
+	precedence. Defaults to `false`.
+
 tag.forceSignAnnotated::
 	A boolean to specify whether annotated tags created should be GPG signed.
 	If `--annotate` is specified on the command line, it takes
diff --git a/Documentation/git-tag.txt b/Documentation/git-tag.txt
index 5055a96..f2ed370 100644
--- a/Documentation/git-tag.txt
+++ b/Documentation/git-tag.txt
@@ -13,7 +13,7 @@ SYNOPSIS
 	<tagname> [<commit> | <object>]
 'git tag' -d <tagname>...
 'git tag' [-n[<num>]] -l [--contains <commit>] [--points-at <object>]
-	[--column[=<options>] | --no-column] [--create-reflog] [--sort=<key>]
+	[--column[=<options>] | --no-column] [--[no-]create-reflog] [--sort=<key>]
 	[--format=<format>] [--[no-]merged [<commit>]] [<pattern>...]
 'git tag' -v <tagname>...
 
@@ -149,8 +149,10 @@ This option is only applicable when listing tags without annotation lines.
 	all, 'whitespace' removes just leading/trailing whitespace lines and
 	'strip' removes both whitespace and commentary.
 
---create-reflog::
-	Create a reflog for the tag.
+--[no-]create-reflog::
+	Force to create a reflog for the tag, or no reflog if `--no-create-reflog`
+	is used. Unless the `tag.createReflog` config variable is set to true, no
+	reflog is created by default. See linkgit:git-config[1].
 
 <tagname>::
 	The name of the tag to create, delete, or describe.
diff --git a/builtin/tag.c b/builtin/tag.c
index 73df728..1f13e4d 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -30,6 +30,7 @@ static const char * const git_tag_usage[] = {
 
 static unsigned int colopts;
 static int force_sign_annotate;
+static int create_reflog;
 
 static int list_tags(struct ref_filter *filter, struct ref_sorting *sorting, const char *format)
 {
@@ -165,6 +166,10 @@ static int git_tag_config(const char *var, const char *value, void *cb)
 		force_sign_annotate = git_config_bool(var, value);
 		return 0;
 	}
+	if (!strcmp(var, "tag.createreflog")) {
+		create_reflog = git_config_bool(var, value);
+		return 0;
+	}
 
 	if (starts_with(var, "column."))
 		return git_column_config(var, value, "tag", &colopts);
@@ -325,7 +330,6 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 	const char *object_ref, *tag;
 	struct create_tag_options opt;
 	char *cleanup_arg = NULL;
-	int create_reflog = 0;
 	int annotate = 0, force = 0;
 	int cmdmode = 0, create_tag_object = 0;
 	const char *msgfile = NULL, *keyid = NULL;
diff --git a/t/t7004-tag.sh b/t/t7004-tag.sh
index 1cfa8a2..67b39ec 100755
--- a/t/t7004-tag.sh
+++ b/t/t7004-tag.sh
@@ -90,6 +90,20 @@ test_expect_success '--create-reflog does not create reflog on failure' '
 	test_must_fail git reflog exists refs/tags/mytag
 '
 
+test_expect_success 'option tag.createreflog creates reflog by default' '
+	test_when_finished "git tag -d tag_with_reflog" &&
+	git config tag.createReflog true &&
+	git tag tag_with_reflog &&
+	git reflog exists refs/tags/tag_with_reflog
+'
+
+test_expect_success 'option tag.createreflog overridden by command line' '
+	test_when_finished "git tag -d tag_without_reflog" &&
+	git config tag.createReflog true &&
+	git tag --no-create-reflog tag_without_reflog &&
+	test_must_fail git reflog exists refs/tags/tag_without_reflog
+'
+
 test_expect_success 'listing all tags if one exists should succeed' '
 	git tag -l &&
 	git tag
-- 
2.10.2

