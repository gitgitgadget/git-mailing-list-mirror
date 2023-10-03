Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADE2FE7545F
	for <git@archiver.kernel.org>; Tue,  3 Oct 2023 18:51:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240847AbjJCSvF (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Oct 2023 14:51:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232021AbjJCSvE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Oct 2023 14:51:04 -0400
Received: from mail.archlinux.org (mail.archlinux.org [95.216.189.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 281D3AB
        for <git@vger.kernel.org>; Tue,  3 Oct 2023 11:50:58 -0700 (PDT)
From:   "Jan Alexander Steffens (heftig)" <heftig@archlinux.org>
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=archlinux.org;
        s=dkim-ed25519; t=1696359054;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vAHSdsBzvo+OGcxgFxIjioDOevni9pbvU+ny/i+HTSg=;
        b=DNCbrXt+8MLfnq6HetImsin8f7XCULcdYnL40kUXbtUfYTIKgtQ3p7ih0mNM39RODkl0q9
        qzLxxKDSrgWs77DQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=archlinux.org;
        s=dkim-rsa; t=1696359054;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vAHSdsBzvo+OGcxgFxIjioDOevni9pbvU+ny/i+HTSg=;
        b=XBtj+Oi2SCAvg8RLbf2lyunawFQKO5H3piu4FhGWU9i+EyV6yG7931GEDhd0a1auAUAdd0
        K/yshvsObCx6Be0cynfrq36RN6i22r5cY83HpyibTVyQ/A+0jClfLPbWh6FupLCmi4KIbU
        2CbY69Fe1adQeba+4YVRgFr7G/yoa62d3KRz3olg9sTxbPLfwa6ZrQ1q6SZzDVRbsetdqu
        5+sBlnlSdR9hrdzyLJbE+WAgHWnNHL7/ffYdt7Qenv5S3h5BHxrYq7tlWvIaxdlNcSxAAK
        Zdtv/nTmiyCozlk3qkcCrGJIwudqLQYs/DMSQVQytpTeeoIcksBBaeV44ordUFRztJEsuZ
        NDktF4j42Y639HFd0i9LSvAIq/xdtLDkwh19PJOZUHQFuOGwa9Ky7/0pwaJXljTC4SThhf
        wCD/1z7pE2Lymu43S7Z0+xgMGX8VC0f3Oz/F2inNOZM7+p4yTqaAK1fbxnrjzAO05Pe55K
        a1+Yj573xudElY/ANXW76Kyvmd3UGFh8dXVqdSRdSUnnb5QA5eVHEkGznPy4aKEV5fJQM/
        zDR8mGupDp9jSUXjCtZ7BLbPX8Vl+DXYGpPznCWoyInW9jtP2xkH9oWhnSdz7OIMwb00J0
        Ilgv4gB+0DxyYNvj7TqvNyK0tZ69NVqMP/IyXvHjr390q8R77paBU=
Authentication-Results: mail.archlinux.org;
        auth=pass smtp.auth=heftig smtp.mailfrom=heftig@archlinux.org
To:     git@vger.kernel.org
Cc:     "Jan Alexander Steffens (heftig)" <heftig@archlinux.org>
Subject: [PATCH 2/6] submodule--helper: return error from set-url when modifying failed
Date:   Tue,  3 Oct 2023 20:50:43 +0200
Message-ID: <20231003185047.2697995-2-heftig@archlinux.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231003185047.2697995-1-heftig@archlinux.org>
References: <0a0a157f88321d25fdb0be771a454b3410a449f3.camel@archlinux.org>
 <20231003185047.2697995-1-heftig@archlinux.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

set-branch will return an error when setting the config fails so I don't
see why set-url shouldn't. Also skip the sync in this case.

Signed-off-by: Jan Alexander Steffens (heftig) <heftig@archlinux.org>
---
 builtin/submodule--helper.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index f376466a5e..e2175083a6 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -2890,39 +2890,41 @@ static int absorb_git_dirs(int argc, const char **argv, const char *prefix)
 
 static int module_set_url(int argc, const char **argv, const char *prefix)
 {
-	int quiet = 0;
+	int quiet = 0, ret;
 	const char *newurl;
 	const char *path;
 	char *config_name;
 	struct option options[] = {
 		OPT__QUIET(&quiet, N_("suppress output for setting url of a submodule")),
 		OPT_END()
 	};
 	const char *const usage[] = {
 		N_("git submodule set-url [--quiet] <path> <newurl>"),
 		NULL
 	};
 	const struct submodule *sub;
 
 	argc = parse_options(argc, argv, prefix, options, usage, 0);
 
 	if (argc != 2 || !(path = argv[0]) || !(newurl = argv[1]))
 		usage_with_options(usage, options);
 
 	sub = submodule_from_path(the_repository, null_oid(), path);
 
 	if (!sub)
 		die(_("no submodule mapping found in .gitmodules for path '%s'"),
 		    path);
 
 	config_name = xstrfmt("submodule.%s.url", sub->name);
-	config_set_in_gitmodules_file_gently(config_name, newurl);
+	ret = config_set_in_gitmodules_file_gently(config_name, newurl);
 
-	repo_read_gitmodules (the_repository, 0);
-	sync_submodule(sub->path, prefix, NULL, quiet ? OPT_QUIET : 0);
+	if (!ret) {
+		repo_read_gitmodules(the_repository, 0);
+		sync_submodule(sub->path, prefix, NULL, quiet ? OPT_QUIET : 0);
+	}
 
 	free(config_name);
-	return 0;
+	return !!ret;
 }
 
 static int module_set_branch(int argc, const char **argv, const char *prefix)
-- 
2.42.0

