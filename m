Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27862E776DB
	for <git@archiver.kernel.org>; Tue,  3 Oct 2023 18:51:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240842AbjJCSvH (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Oct 2023 14:51:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240810AbjJCSvE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Oct 2023 14:51:04 -0400
Received: from mail.archlinux.org (mail.archlinux.org [95.216.189.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28B8BB0
        for <git@vger.kernel.org>; Tue,  3 Oct 2023 11:50:59 -0700 (PDT)
From:   "Jan Alexander Steffens (heftig)" <heftig@archlinux.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=archlinux.org;
        s=dkim-rsa; t=1696359054;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cgx9OnfLVt0Jr1oy4hb+S0UwuXQOAhAGTnoEVMhwFo4=;
        b=ujzFQrHPXWuRp7gwWZTKwNCJBm1IV46z+GQyWxLAXJB5NvRXWOY2SBD1E+TaaauvYCr3fm
        M3fDGOwFhkvatRgYlun5UWEhZnWZVNo5GEejxvGAwbZ/spAKHn4cBBWlXidVBs/M8qS9tz
        axsJiOlb0dapBQ/+7ifKAexLgCZIbPewrDOlkhGBT69Lo/OkyKOuhFX8Vj/IpSV5ZRjupR
        FpKP2BJl17Co0VEH/scfvSsvWztosUYFlLlR5ImJZVmUmqHsYG7m/ux0LjNECcpalH+/HF
        9Ex7al4gJg55aJHRjQUNb+ff+zBuj9g8XskV3hbiJN5z9nQavdj1CfVYR5gQKe/8UW11Qh
        447Gl4rDxTzYf3j/EtI5CZgVbJbfMQBmF2+BlE28xhqJ/jXJ1uEr0DZRYd25I5MtpzQ5+k
        6uK/E0WNuy9MCclftI4D2yNxi3Zlr/pVaAiSB5jF5A4BfP8tqgwxApHRm9oZQgup3aFpcV
        jg1d25Cg5oZFmJKx3uDuQVJ9wkfwrdtifpFjj8TxNQZNiaBaNEI7tz9qlRj8YCOqjqkVIw
        wGSu7X5d0dSSUX1m4f5FdujD1iO6PH/7UPJvbpuAQYypJZOemx8om38xr1nXZ9csbodwSz
        84mnYxsdtvyZeyvZFX2UNf4w6CM6tgUbiXidfQuKSF2MzBc1z5qfM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=archlinux.org;
        s=dkim-ed25519; t=1696359054;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cgx9OnfLVt0Jr1oy4hb+S0UwuXQOAhAGTnoEVMhwFo4=;
        b=8JYQzCMx5lgGBdKNpSG6pbpOcTFzviP/36RJQ2W1h5Sj1GqV15ZttagK38SEkgxtPo1zv7
        e0pWmwqKweORiPDQ==
Authentication-Results: mail.archlinux.org;
        auth=pass smtp.auth=heftig smtp.mailfrom=heftig@archlinux.org
To:     git@vger.kernel.org
Cc:     "Jan Alexander Steffens (heftig)" <heftig@archlinux.org>
Subject: [PATCH 1/6] submodule--helper: use submodule_from_path in set-{url,branch}
Date:   Tue,  3 Oct 2023 20:50:42 +0200
Message-ID: <20231003185047.2697995-1-heftig@archlinux.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <0a0a157f88321d25fdb0be771a454b3410a449f3.camel@archlinux.org>
References: <0a0a157f88321d25fdb0be771a454b3410a449f3.camel@archlinux.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The commands need a path to a submodule but treated it as the name when
modifying the .gitmodules file, leading to confusion when a submodule's
name does not match its path.

Because calling submodule_from_path initializes the submodule cache, we
need to manually trigger a reread before syncing, as the cache is
missing the config change we just made.

Signed-off-by: Jan Alexander Steffens (heftig) <heftig@archlinux.org>
---
 builtin/submodule--helper.c | 22 ++++++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index f6871efd95..f376466a5e 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -2902,19 +2902,26 @@ static int module_set_url(int argc, const char **argv, const char *prefix)
 		N_("git submodule set-url [--quiet] <path> <newurl>"),
 		NULL
 	};
+	const struct submodule *sub;
 
 	argc = parse_options(argc, argv, prefix, options, usage, 0);
 
 	if (argc != 2 || !(path = argv[0]) || !(newurl = argv[1]))
 		usage_with_options(usage, options);
 
-	config_name = xstrfmt("submodule.%s.url", path);
+	sub = submodule_from_path(the_repository, null_oid(), path);
 
+	if (!sub)
+		die(_("no submodule mapping found in .gitmodules for path '%s'"),
+		    path);
+
+	config_name = xstrfmt("submodule.%s.url", sub->name);
 	config_set_in_gitmodules_file_gently(config_name, newurl);
-	sync_submodule(path, prefix, NULL, quiet ? OPT_QUIET : 0);
+
+	repo_read_gitmodules (the_repository, 0);
+	sync_submodule(sub->path, prefix, NULL, quiet ? OPT_QUIET : 0);
 
 	free(config_name);
-
 	return 0;
 }
 
@@ -2942,19 +2949,26 @@ static int module_set_branch(int argc, const char **argv, const char *prefix)
 		N_("git submodule set-branch [-q|--quiet] (-b|--branch) <branch> <path>"),
 		NULL
 	};
+	const struct submodule *sub;
 
 	argc = parse_options(argc, argv, prefix, options, usage, 0);
 
 	if (!opt_branch && !opt_default)
 		die(_("--branch or --default required"));
 
 	if (opt_branch && opt_default)
 		die(_("options '%s' and '%s' cannot be used together"), "--branch", "--default");
 
 	if (argc != 1 || !(path = argv[0]))
 		usage_with_options(usage, options);
 
-	config_name = xstrfmt("submodule.%s.branch", path);
+	sub = submodule_from_path(the_repository, null_oid(), path);
+
+	if (!sub)
+		die(_("no submodule mapping found in .gitmodules for path '%s'"),
+		    path);
+
+	config_name = xstrfmt("submodule.%s.branch", sub->name);
 	ret = config_set_in_gitmodules_file_gently(config_name, opt_branch);
 
 	free(config_name);
-- 
2.42.0

