Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1C03C433F5
	for <git@archiver.kernel.org>; Tue,  7 Dec 2021 19:29:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231772AbhLGTdB (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Dec 2021 14:33:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbhLGTdB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Dec 2021 14:33:01 -0500
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA03CC061574
        for <git@vger.kernel.org>; Tue,  7 Dec 2021 11:29:30 -0800 (PST)
Received: by mail-pg1-x54a.google.com with SMTP id n22-20020a6563d6000000b0029261ffde9bso9326600pgv.22
        for <git@vger.kernel.org>; Tue, 07 Dec 2021 11:29:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=DHPHAkOuMXG7JiwlSeRaGFG8aO6tQoLTpqT79IzTRtc=;
        b=bH06DhHqx6QxG8xnM70qndP3LBcwKzKc6azU2/a00ygRb75nP1aRcK+RZEI9On93gB
         rJYluN5rIx2QJ/rGoiwaW8uAuIi73ZzEVYhei2in5nNlqS+Vjp0+mhAEKpfw+h4z6s7l
         lpkQ2RQ+hxYMUJvUglp7BHAy1GHNkeBxNb1LVdoR/YSNin2lolfv91Z4b4ZbGMXgelDv
         EZHmQ2jfu+T4zdy7gnGWPFRj6uYVEBcXOfIMy0c8//o3jRBujytG+ujlz6WhLQumjtV5
         6thwR/MxQkC2PJhJkl5N9AkmtLhL6nKhQPpFNNUWiLlz+rAMXTO753VlNrZQn4o/5rZj
         U3Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=DHPHAkOuMXG7JiwlSeRaGFG8aO6tQoLTpqT79IzTRtc=;
        b=B82N8bEYoFFp66YhLZGs2K771oyH57/M2i/1XZ22EhQ2M8EnaDZK+oA+pYK+H1eixx
         +PH+wP5tskVmxZCzwSxTdQtzKwQYYjJlx0ZahUB67DLtkkYIEVmRsYJQG63cRVydGlow
         N4O+Sg/KcSJiizuoMpArAuYDkNBKX3hf6XNzj2C++ppR+DbCgl3tMWefJWcNAi/8xnYB
         nMuAYsH4LATtBhy/rH5wLYy2l0uXP2ZitIAofnvsP8nryH+hBCYU9nKSgaaZWsDEwPbQ
         Csb5hVG7jgspQ/OTin40ur3xPRxVP8mG5E1/9CdZaIeTYTQtkXzSc8w0g+NyFRTYZSM/
         RzGQ==
X-Gm-Message-State: AOAM532lyE04WmJ6aUTLGINT3gBmN19GZIBsYCvhGbpiSa8Pp19Sw51W
        nXSylLv1s65LohDwTlw4d2xLNTsDSshgLXxn9bohIOQDv/ZIFgGfNX5BcbtzrQtKxXl+019U+1Z
        0mh8ChS7PM4UlqQA//vxo+exSAIReI7mtWOy2K634RATXz4QRHGZtIl1Chask3tg=
X-Google-Smtp-Source: ABdhPJxyJqEaDUVLI1iBLWEO117OF5fl+38dLhHDL5ir/GhdhHGoU5UJ3mNJPSh6lMcmihWFO1rzhRJD9cZwsA==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a05:6a00:244f:b0:4ab:1694:924 with SMTP
 id d15-20020a056a00244f00b004ab16940924mr1049293pfj.74.1638905370282; Tue, 07
 Dec 2021 11:29:30 -0800 (PST)
Date:   Tue,  7 Dec 2021 11:29:25 -0800
Message-Id: <20211207192925.67680-1-chooglen@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.34.1.173.g76aa8bc2d0-goog
Subject: [PATCH] builtin/fetch: skip unnecessary tasks when using --negotiate-only
From:   Glen Choo <chooglen@google.com>
To:     git@vger.kernel.org
Cc:     Glen Choo <chooglen@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

`git fetch --negotiate-only` does not fetch objects and thus, it should
not perform certain auxiliary tasks like updating submodules, updating
the commit graph, or running gc. Although send_pack() invokes `git fetch
--negotiate-only` correctly, cmd_fetch() also reads config variables,
leading to undesirable behavior, like updating submodules if
`submodule.recurse=true`.

Make cmd_fetch() return early if --negotiate-only was specified so that
these auxiliary tasks are skipped.

Signed-off-by: Glen Choo <chooglen@google.com>
---
`git fetch --negotiate-only` is used during push negotiation to
determine the reachability of commits. As its name implies, only
negotiation is performed, not the actual fetching of objects. However,
cmd_fetch() performs certain tasks with the assumption that objects are
fetched:

* Submodules are updated if enabled by recurse.submodules=true, but
  negotiation fetch doesn't actually update the repo, so this doesn't
  make sense (introduced in [1]).
* Commit graphs will be written if enabled by
  fetch.writeCommitGraph=true. But according to
  Documentation/config/fetch.txt [2], this should only be done if a
  pack-file is downloaded
* gc is run, but according to [3], we only do this because we expect
  `git fetch` to introduce objects

Instead of disabling these tasks piecemeal, let's just make cmd_fetch()
return early if --negotiate-only was given. To accommodate possible
future options that don't fetch objects, I opted to introduce another
`if` statement instead of putting the early return in the existing
`if (negotiate_only)` block.

[1] 7dce19d374 (fetch/pull: Add the --recurse-submodules option, 2010-11-12)
[2] 50f26bd035 (fetch: add fetch.writeCommitGraph config setting, 2019-09-02)
[3] 131b8fcbfb (fetch: run gc --auto after fetching, 2013-01-26)

 builtin/fetch.c       | 22 +++++++++++++++++-----
 t/t5516-fetch-push.sh | 12 ++++++++++++
 2 files changed, 29 insertions(+), 5 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index f7abbc31ff..01865b5c09 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -1996,6 +1996,17 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
 
 	argc = parse_options(argc, argv, prefix,
 			     builtin_fetch_options, builtin_fetch_usage, 0);
+
+	if (negotiate_only) {
+		/*
+		 * --negotiate-only should never recurse into
+		 * submodules, so there is no need to read .gitmodules.
+		 */
+		recurse_submodules = RECURSE_SUBMODULES_OFF;
+		if (!negotiation_tip.nr)
+			die(_("--negotiate-only needs one or more --negotiate-tip=*"));
+	}
+
 	if (recurse_submodules != RECURSE_SUBMODULES_OFF) {
 		int *sfjc = submodule_fetch_jobs_config == -1
 			    ? &submodule_fetch_jobs_config : NULL;
@@ -2005,9 +2016,6 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
 		fetch_config_from_gitmodules(sfjc, rs);
 	}
 
-	if (negotiate_only && !negotiation_tip.nr)
-		die(_("--negotiate-only needs one or more --negotiate-tip=*"));
-
 	if (deepen_relative) {
 		if (deepen_relative < 0)
 			die(_("Negative depth in --deepen is not supported"));
@@ -2112,6 +2120,12 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
 		result = fetch_multiple(&list, max_children);
 	}
 
+	string_list_clear(&list, 0);
+
+	/* skip irrelevant tasks if objects were not fetched  */
+	if (negotiate_only)
+		return result;
+
 	if (!result && (recurse_submodules != RECURSE_SUBMODULES_OFF)) {
 		struct strvec options = STRVEC_INIT;
 		int max_children = max_jobs;
@@ -2132,8 +2146,6 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
 		strvec_clear(&options);
 	}
 
-	string_list_clear(&list, 0);
-
 	prepare_repo_settings(the_repository);
 	if (fetch_write_commit_graph > 0 ||
 	    (fetch_write_commit_graph < 0 &&
diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
index 8212ca56dc..732031085e 100755
--- a/t/t5516-fetch-push.sh
+++ b/t/t5516-fetch-push.sh
@@ -229,6 +229,18 @@ test_expect_success 'push with negotiation proceeds anyway even if negotiation f
 	test_i18ngrep "push negotiation failed" err
 '
 
+test_expect_success 'push with negotiation does not attempt to fetch submodules' '
+	mk_empty submodule_upstream &&
+	test_commit -C submodule_upstream submodule_commit &&
+	git submodule add ./submodule_upstream submodule &&
+	mk_empty testrepo &&
+	git push testrepo $the_first_commit:refs/remotes/origin/first_commit &&
+	test_commit -C testrepo unrelated_commit &&
+	git -C testrepo config receive.hideRefs refs/remotes/origin/first_commit &&
+	git -c submodule.recurse=true -c protocol.version=2 -c push.negotiate=1 push testrepo refs/heads/main:refs/remotes/origin/main 2>err &&
+	! grep "Fetching submodule" err
+'
+
 test_expect_success 'push without wildcard' '
 	mk_empty testrepo &&
 
-- 
2.33.GIT

