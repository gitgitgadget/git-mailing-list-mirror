Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_DKIMWL_WL_HIGH
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 550A11F462
	for <e@80x24.org>; Thu, 23 May 2019 22:54:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388493AbfEWWyJ (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 May 2019 18:54:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:41340 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387693AbfEWWyI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 May 2019 18:54:08 -0400
Received: from localhost.localdomain (c-71-237-40-145.hsd1.co.comcast.net [71.237.40.145])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A7D872177E;
        Thu, 23 May 2019 22:54:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558652047;
        bh=qOTsKmcwvA5gGpu3UJAXLfz7tF7JJu0z1G+L5wgXPNQ=;
        h=From:To:Cc:Subject:Date:From;
        b=QfE4wvkqqgAzUrib/quIC29fQTee88RP2WxDe0fhFU9mr6gkePQnoZrrd8HSJ3sdF
         RHQHINyEr3aa9nNK/JDHkXjKkppyMTIRDnfQQZlEN09PWqqUC1xlKNHfgxU+jNtx5L
         /Ddyw6NH5CyXqFN2dKhdHx8bCF8B7cpbwnn64bXc=
From:   Vishal Verma <vishal@kernel.org>
To:     git@vger.kernel.org
Cc:     Vishal Verma <vishal@stellar.sh>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Rafael=20Ascens=C3=A3o?= <rafa.almas@gmail.com>
Subject: [PATCH v3] builtin/merges: clarify --squash behavior with --commit
Date:   Thu, 23 May 2019 16:53:38 -0600
Message-Id: <20190523225338.14619-1-vishal@kernel.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Vishal Verma <vishal@stellar.sh>

Convert option_commit to tristate, representing the states of
'default/untouched', 'enabled-by-cli', 'disabled-by-cli'. With this in
place, check whether option_commit was enabled by cli when squashing a
merge. If so, error out, as this is not supported.

Previously, when --squash was supplied, 'option_commit' was silently
dropped. This could have been surprising to a user who tried to override
the no-commit behavior of squash using --commit explicitly.

Add a note to the --squash option for git-merge to clarify the
incompatibility, and add a test case to t7600-merge.sh

Cc: Junio C Hamano <gitster@pobox.com>
Cc: Rafael Ascensão <rafa.almas@gmail.com>
Signed-off-by: Vishal Verma <vishal@stellar.sh>
---

v3: Add a test case for this behavior in t7600-merge.sh

 Documentation/merge-options.txt |  2 ++
 builtin/merge.c                 | 18 +++++++++++++++++-
 t/t7600-merge.sh                |  6 ++++++
 3 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/Documentation/merge-options.txt b/Documentation/merge-options.txt
index 61876dbc33..79a00d2a4a 100644
--- a/Documentation/merge-options.txt
+++ b/Documentation/merge-options.txt
@@ -102,6 +102,8 @@ merge.
 +
 With --no-squash perform the merge and commit the result. This
 option can be used to override --squash.
++
+With --squash, --commit is not allowed, and will fail.
 
 -s <strategy>::
 --strategy=<strategy>::
diff --git a/builtin/merge.c b/builtin/merge.c
index e96f72af80..4730b075c1 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -58,7 +58,7 @@ static const char * const builtin_merge_usage[] = {
 };
 
 static int show_diffstat = 1, shortlog_len = -1, squash;
-static int option_commit = 1;
+static int option_commit = -1;
 static int option_edit = -1;
 static int allow_trivial = 1, have_message, verify_signatures;
 static int overwrite_ignore = 1;
@@ -1336,9 +1336,25 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 	if (verbosity < 0)
 		show_diffstat = 0;
 
+	/*
+	 * This indicates option_commit was influenced by the command line.
+	 * Check and error out for the squash case.
+	 */
+	if ((option_commit > 0) && squash)
+		die(_("You cannot combine --squash with --commit."));
+
+	/* If option_commit is the default '-1', we can 'enable' it */
+	if (option_commit < 0)
+		option_commit = 1;
+
 	if (squash) {
 		if (fast_forward == FF_NO)
 			die(_("You cannot combine --squash with --no-ff."));
+		/*
+		 * squash can now silently disable option_commit - this is not
+		 * a problem as it is only overriding the default, not a user
+		 * supplied option.
+		 */
 		option_commit = 0;
 	}
 
diff --git a/t/t7600-merge.sh b/t/t7600-merge.sh
index 7f9c68cbe7..4ec5d9ec79 100755
--- a/t/t7600-merge.sh
+++ b/t/t7600-merge.sh
@@ -570,6 +570,12 @@ test_expect_success 'combining --squash and --no-ff is refused' '
 	test_must_fail git merge --no-ff --squash c1
 '
 
+test_expect_success 'combining --squash and --commit is refused' '
+	git reset --hard c0 &&
+	test_must_fail git merge --squash --commit c1 &&
+	test_must_fail git merge --commit --squash c1
+'
+
 test_expect_success 'option --ff-only overwrites --no-ff' '
 	git merge --no-ff --ff-only c1 &&
 	test_must_fail git merge --no-ff --ff-only c2
-- 
2.21.0

