Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C3D6C83F15
	for <git@archiver.kernel.org>; Mon, 28 Aug 2023 14:50:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231836AbjH1OuD (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Aug 2023 10:50:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231967AbjH1Ots (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Aug 2023 10:49:48 -0400
Received: from out-252.mta0.migadu.com (out-252.mta0.migadu.com [91.218.175.252])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B648E1
        for <git@vger.kernel.org>; Mon, 28 Aug 2023 07:49:45 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cmpwn.com; s=key1;
        t=1693234183;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=sI1RvM/Yn//Ud/uVl56yAPKNSW2u9yw3ej1IC8VLN6M=;
        b=Ad1DWWBKsibd/TPOpMqirKGP/Unp02QftEZUzwbTPZR9XvStBj84qXd08QTKnQUhoi+TKI
        feIMDh0NWf/ROJiKsO2aX2nfQHkIYhyorWj13FwThn7m3Mskxf96fNASxIPTwh/Jja1u6L
        EI5u+yVaK7j4nppgoe81zAul9pbrGMfEUM3YAijnknv6IIPPRxUi1DJDiXyxzL/j2U3big
        YL3wdW9tmgZSgjuEUltfsnOUXsSRsNHUVAEJ8nwzAbY2DCaUXZ1qpsVEhcjUA8PBMpCEZa
        vmU0jJjcflmoQXSLIEIFlf9sa9YvOw2qoH4HAvLAgtITGMM4+1qOTWmQ0jYLkg==
From:   Drew DeVault <sir@cmpwn.com>
To:     git@vger.kernel.org
Cc:     Drew DeVault <sir@cmpwn.com>
Subject: [PATCH v2] builtin/log.c: prepend "RFC" on --rfc
Date:   Mon, 28 Aug 2023 16:48:49 +0200
Message-ID: <20230828144940.18245-1-sir@cmpwn.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Rather than replacing the configured subject prefix (either through the
git config or command line) entirely with "RFC PATCH", this change
prepends RFC to whatever subject prefix was already in use.

This is useful, for example, when a user is working on a repository that
has a subject prefix considered to disambiguate patches:

	git config format.subjectPrefix 'PATCH my-project'

Prior to this change, formatting patches with --rfc would lose the
'my-project' information.

Signed-off-by: Drew DeVault <sir@cmpwn.com>
---
v2 incorporates feedback from Jeff King regarding the lifetime of the
heap-allocated "RFC %s" formatted string.

 Documentation/git-format-patch.txt |  6 +++---
 builtin/log.c                      | 12 +++++++++++-
 t/t4014-format-patch.sh            |  9 +++++++++
 3 files changed, 23 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-format-patch.txt b/Documentation/git-format-patch.txt
index 373b46fc0d..fdc52cf826 100644
--- a/Documentation/git-format-patch.txt
+++ b/Documentation/git-format-patch.txt
@@ -229,9 +229,9 @@ populated with placeholder text.
 	variable, or 64 if unconfigured.
 
 --rfc::
-	Alias for `--subject-prefix="RFC PATCH"`. RFC means "Request For
-	Comments"; use this when sending an experimental patch for
-	discussion rather than application.
+	Prepends "RFC" to the subject prefix (producing "RFC PATCH" by
+	default). RFC means "Request For Comments"; use this when sending
+	an experimental patch for discussion rather than application.
 
 -v <n>::
 --reroll-count=<n>::
diff --git a/builtin/log.c b/builtin/log.c
index db3a88bfe9..854216ee9c 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -1476,9 +1476,19 @@ static int subject_prefix_callback(const struct option *opt, const char *arg,
 
 static int rfc_callback(const struct option *opt, const char *arg, int unset)
 {
+	/*
+	 * The subject_prefix in rev_info is not heap-allocated except in this
+	 * specific case, so there is no obvious place to free it. Since this
+	 * value is retained for the lifetime of the process, we just
+	 * statically allocate storage for it here.
+	 */
+	static char *prefix;
 	BUG_ON_OPT_NEG(unset);
 	BUG_ON_OPT_ARG(arg);
-	return subject_prefix_callback(opt, "RFC PATCH", unset);
+
+	free(prefix);
+	prefix = xstrfmt("RFC %s", ((struct rev_info *)opt->value)->subject_prefix);
+	return subject_prefix_callback(opt, prefix, unset);
 }
 
 static int numbered_cmdline_opt = 0;
diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
index 3cf2b7a7fb..a7fe839683 100755
--- a/t/t4014-format-patch.sh
+++ b/t/t4014-format-patch.sh
@@ -1377,6 +1377,15 @@ test_expect_success '--rfc' '
 	test_cmp expect actual
 '
 
+test_expect_success '--rfc does not overwrite prefix' '
+	cat >expect <<-\EOF &&
+	Subject: [RFC PATCH foobar 1/1] header with . in it
+	EOF
+	git format-patch -n -1 --stdout --subject-prefix "PATCH foobar" --rfc >patch &&
+	grep ^Subject: patch >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success '--from=ident notices bogus ident' '
 	test_must_fail git format-patch -1 --stdout --from=foo >patch
 '
-- 
2.42.0

