Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 494D620A1E
	for <e@80x24.org>; Thu, 13 Dec 2018 12:09:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728833AbeLMMJo (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Dec 2018 07:09:44 -0500
Received: from avasout06.plus.net ([212.159.14.18]:44157 "EHLO
        avasout06.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729086AbeLMMJn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Dec 2018 07:09:43 -0500
Received: from hashpling.plus.com ([212.159.69.125])
        by smtp with ESMTP
        id XPoCgIPGUuugZXPoDgxzP6; Thu, 13 Dec 2018 12:09:42 +0000
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=bLE43s2Z c=1 sm=1 tr=0
 a=wpJ/2au8Z6V/NgdivHIBow==:117 a=wpJ/2au8Z6V/NgdivHIBow==:17 a=BNFp--SqAAAA:8
 a=A1X0JdhQAAAA:8 a=Ey4yazBVl3HHiNmCqCQA:9 a=uj3p00XF9m0A:10
 a=wCHOS_8tIzIYXQCUOVd6:22 a=Df3jFdWbhGDLdZNm0fyq:22
From:   CB Bailey <cb@hashpling.org>
To:     git@vger.kernel.org
Subject: [RFC/PATCH] Use mailmap by default in log, show and whatchanged
Date:   Thu, 13 Dec 2018 12:09:40 +0000
Message-Id: <20181213120940.26477-1-cb@hashpling.org>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfMrMBzSG7gQWQbeo4fwiN1Qev1Idnx1Kitj6tAC1+mU3MLHqTZhmJFf/j8TaAg45SWVhIk0kzclEEHHt0LSqXd6gBk6i/vaCGTCijg3alebMm86/U/kv
 b5r+1P8SfVHKOjJNNycqgbUeu9T32y5lBCLCUc+ahCWK/fffpQ+577sF9w8SG93/Lf7Whihq/15vpw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: CB Bailey <cbailey32@bloomberg.net>

People who have changed their name or email address will usually know
that they need to set 'log.mailmap' in order to have their new details
reflected for old commits with 'git log', but others who interact with
them may not know or care enough to enable this option.

Change the default for 'git log' and friends to always use mailmap so
that everyone gets to see canonical names and email addresses.

Signed-off-by: CB Bailey <cbailey32@bloomberg.net>
---

Related to my patch to make shortlog pass the mailmap into the revision
walker which may end up being configuratble behavior, I thought I'd
propose this for discussion.

For people who change their names during their involvement in a project,
it can be important that the people with whom they work only see their
correct name, even when browsing old history.

I had a dig around in the mailing list archives and couldn't find any
specific reason not to use a mailmap in log where one is in use. I did
find this message which suggests that it makes sense to make it the
default for human-consumed formats. This patch doesn't affect
"--pretty=raw" formatting.

 Documentation/config/log.txt |  4 ++--
 Documentation/git-log.txt    | 12 +++++++++---
 builtin/log.c                |  2 +-
 t/t4203-mailmap.sh           | 18 ++++++++++++++++++
 4 files changed, 30 insertions(+), 6 deletions(-)

diff --git a/Documentation/config/log.txt b/Documentation/config/log.txt
index 78d9e4453a..8a01eed46b 100644
--- a/Documentation/config/log.txt
+++ b/Documentation/config/log.txt
@@ -39,5 +39,5 @@ log.showSignature::
 	linkgit:git-whatchanged[1] assume `--show-signature`.
 
 log.mailmap::
-	If true, makes linkgit:git-log[1], linkgit:git-show[1], and
-	linkgit:git-whatchanged[1] assume `--use-mailmap`.
+	If false, makes linkgit:git-log[1], linkgit:git-show[1], and
+	linkgit:git-whatchanged[1] assume `--no-use-mailmap`.
diff --git a/Documentation/git-log.txt b/Documentation/git-log.txt
index 90761f1694..7815c9a6cb 100644
--- a/Documentation/git-log.txt
+++ b/Documentation/git-log.txt
@@ -50,9 +50,11 @@ OPTIONS
 	commit was reached.
 
 --use-mailmap::
-	Use mailmap file to map author and committer names and email
-	addresses to canonical real names and email addresses. See
-	linkgit:git-shortlog[1].
+--no-use-mailmap::
+	Use (or don't use) mailmap file to map author and committer names and
+	email addresses to canonical real names and email addresses. The default
+	is to use the mailmap file, but this can be overriden with the
+	`log.mailmap` configuration option. See linkgit:git-shortlog[1].
 
 --full-diff::
 	Without this flag, `git log -p <path>...` shows commits that
@@ -205,6 +207,10 @@ log.showRoot::
 	`git log -p` output would be shown without a diff attached.
 	The default is `true`.
 
+log.mailmap::
+	If `false`, makes `git log` and related commands assume
+	`--no-use-mailmap`.
+
 log.showSignature::
 	If `true`, `git log` and related commands will act as if the
 	`--show-signature` option was passed to them.
diff --git a/builtin/log.c b/builtin/log.c
index e8e51068bd..41a5eefb20 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -46,7 +46,7 @@ static int default_follow;
 static int default_show_signature;
 static int decoration_style;
 static int decoration_given;
-static int use_mailmap_config;
+static int use_mailmap_config = 1;
 static const char *fmt_patch_subject_prefix = "PATCH";
 static const char *fmt_pretty;
 
diff --git a/t/t4203-mailmap.sh b/t/t4203-mailmap.sh
index 43b1522ea2..efb145c4cd 100755
--- a/t/t4203-mailmap.sh
+++ b/t/t4203-mailmap.sh
@@ -424,6 +424,24 @@ EOF
 
 test_expect_success 'Log output with --use-mailmap' '
 	git log --use-mailmap | grep Author >actual &&
+	test_cmp expect actual &&
+# --use-mailmap is the default
+	git log | grep Author >actual &&
+	test_cmp expect actual
+'
+
+cat >expect <<\EOF
+Author: CTO <cto@coompany.xx>
+Author: claus <me@company.xx>
+Author: santa <me@company.xx>
+Author: nick2 <nick2@company.xx>
+Author: nick2 <bugs@company.xx>
+Author: nick1 <bugs@company.xx>
+Author: A U Thor <author@example.com>
+EOF
+
+test_expect_success 'Log output with --no-use-mailmap' '
+	git log --no-use-mailmap | grep Author >actual &&
 	test_cmp expect actual
 '
 
-- 
2.20.0

