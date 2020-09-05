Return-Path: <SRS0=od8b=CO=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AFB1C433E2
	for <git@archiver.kernel.org>; Sat,  5 Sep 2020 19:24:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5C3FD20757
	for <git@archiver.kernel.org>; Sat,  5 Sep 2020 19:24:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728443AbgIETYW (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 5 Sep 2020 15:24:22 -0400
Received: from mail-gateway-shared10.cyon.net ([194.126.200.61]:58804 "EHLO
        mail-gateway-shared10.cyon.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728400AbgIETYV (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 5 Sep 2020 15:24:21 -0400
Received: from s019.cyon.net ([149.126.4.28])
        by mail-gateway-shared10.cyon.net with esmtpsa (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim)
        (envelope-from <bb@drbeat.li>)
        id 1kEdnL-00038p-Ec
        for git@vger.kernel.org; Sat, 05 Sep 2020 21:24:18 +0200
Received: from [10.20.10.231] (port=50884 helo=mail.cyon.ch)
        by s019.cyon.net with esmtpa (Exim 4.93)
        (envelope-from <bb@drbeat.li>)
        id 1kEdnK-009PN7-9p; Sat, 05 Sep 2020 21:24:14 +0200
Received: by drbeat.li (Postfix, from userid 1000)
        id D8F5A180FBB; Sat,  5 Sep 2020 21:24:13 +0200 (CEST)
From:   Beat Bolli <dev+git@drbeat.li>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, Beat Bolli <dev+git@drbeat.li>
Subject: [PATCH] pretty: allow to override the built-in formats
Date:   Sat,  5 Sep 2020 21:24:06 +0200
Message-Id: <20200905192406.74411-1-dev+git@drbeat.li>
X-Mailer: git-send-email 2.26.0.277.gb8618d28a9
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - s019.cyon.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - drbeat.li
X-Get-Message-Sender-Via: s019.cyon.net: authenticated_id: ig@drbeat.li
X-Authenticated-Sender: s019.cyon.net: ig@drbeat.li
X-OutGoing-Spam-Status: No, score=-1.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In 1f0fc1db8599 (pretty: implement 'reference' format, 2019-11-19), the
"reference" format was added. As a built-in format, it cannot be
overridden, although different projects may have divergent conventions
on how to format a commit reference. E.g., Git uses

    <hash> (<subject>, <short-date>) [1]

while Linux uses

    <hash> ("<subject>") [2]

Teach pretty to look at a different set of config variables, all
starting with "override" (e.g. "pretty.overrideReference"), to override
the built-in formats. Note that a format called "override" by itself is
not affected. The prefix was chosen to make it clear to the user that
this should not be done without thought, as it may cause issues with
other tools that expect the built-in formats to be immutable.

[1] https://github.com/git/git/blob/3a238e539bcdfe3f9eb5010fd218640c1b499f7a/Documentation/SubmittingPatches#L144
[2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?h=v5.9-rc3#n167

Signed-off-by: Beat Bolli <dev+git@drbeat.li>
---
I intend to also submit a patch to gitk that will use "git show -s
--pretty=reference" if it is available, with a fallback to reading
"pretty.overrideReference", so there's a single point of configuration
for the reference format.

 Documentation/config/pretty.txt |  6 ++++--
 pretty.c                        | 20 +++++++++++++++-----
 t/t4205-log-pretty-formats.sh   |  8 ++++++++
 3 files changed, 27 insertions(+), 7 deletions(-)

diff --git a/Documentation/config/pretty.txt b/Documentation/config/pretty.txt
index 063c6b63d9..d9dac7b3ee 100644
--- a/Documentation/config/pretty.txt
+++ b/Documentation/config/pretty.txt
@@ -5,5 +5,7 @@ pretty.<name>::
 	running `git config pretty.changelog "format:* %H %s"`
 	would cause the invocation `git log --pretty=changelog`
 	to be equivalent to running `git log "--pretty=format:* %H %s"`.
-	Note that an alias with the same name as a built-in format
-	will be silently ignored.
+	Note that you can override a built-in format by prefixing its
+	name with `override`, e.g. `pretty.overrideReference` to override
+	the built-in reference format. Doing so can cause interoperability
+	issues with tools that expect a built-in format to be immutable.
diff --git a/pretty.c b/pretty.c
index 2a3d46bf42..a8f8ade470 100644
--- a/pretty.c
+++ b/pretty.c
@@ -46,18 +46,28 @@ static int git_pretty_formats_config(const char *var, const char *value, void *c
 {
 	struct cmt_fmt_map *commit_format = NULL;
 	const char *name;
+	const char *suffix;
 	const char *fmt;
 	int i;
 
 	if (!skip_prefix(var, "pretty.", &name))
 		return 0;
-
-	for (i = 0; i < builtin_formats_len; i++) {
-		if (!strcmp(commit_formats[i].name, name))
-			return 0;
+	if (skip_prefix(name, "override", &suffix) && *suffix) {
+		name = suffix;
+		/* also search the built-in formats */
+		i = 0;
+	} else {
+		for (i = 0; i < builtin_formats_len; i++) {
+			if (!strcmp(commit_formats[i].name, name))
+				return 0;
+		}
+		/*
+		 * Here, i == builtin_formats_len, so we only search the
+		 * user-defined formats
+		 */
 	}
 
-	for (i = builtin_formats_len; i < commit_formats_len; i++) {
+	for (; i < commit_formats_len; i++) {
 		if (!strcmp(commit_formats[i].name, name)) {
 			commit_format = &commit_formats[i];
 			break;
diff --git a/t/t4205-log-pretty-formats.sh b/t/t4205-log-pretty-formats.sh
index 204c149d5a..55c37be392 100755
--- a/t/t4205-log-pretty-formats.sh
+++ b/t/t4205-log-pretty-formats.sh
@@ -52,6 +52,14 @@ test_expect_success 'alias masking builtin format' '
 	test_cmp expected actual
 '
 
+test_expect_success 'overriding builtin format' '
+	git log --pretty=%H >expected &&
+	git config pretty.overrideOneline "%H" &&
+	git log --pretty=oneline >actual &&
+	git config --unset pretty.overrideOneline &&
+	test_cmp expected actual
+'
+
 test_expect_success 'alias user-defined format' '
 	git log --pretty="format:%h" >expected &&
 	git config pretty.test-alias "format:%h" &&
-- 
2.26.0.277.gb8618d28a9

