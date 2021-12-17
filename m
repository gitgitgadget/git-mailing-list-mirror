Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8E23C433EF
	for <git@archiver.kernel.org>; Fri, 17 Dec 2021 00:02:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230116AbhLQACn (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Dec 2021 19:02:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230211AbhLQACm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Dec 2021 19:02:42 -0500
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 969B3C061574
        for <git@vger.kernel.org>; Thu, 16 Dec 2021 16:02:42 -0800 (PST)
Received: by mail-qt1-x849.google.com with SMTP id v17-20020a05622a131100b002aea167e24aso926940qtk.5
        for <git@vger.kernel.org>; Thu, 16 Dec 2021 16:02:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=l1ypxq5sN1XaiTtKGJVIQJhrf9oiU9y+ngIai306ik4=;
        b=HE5KNq4miIV8GorYC2yM0BHL/HvAswi2Niy0BSK1bL3sgkbNICQz5mH9n1MSKPH6Cs
         Kv8zvJtjUufOQrVWc0iPha517X/FMeWb1P0wWwCajEr/RqOAs+zf99D/waw3iPLp7104
         ws1OLonOQ2VOb3qIIgFzQM7OGRZH/QFpvKZLaNef5pu/1r7HWmCylQH/jHerMKEJXFhJ
         vhyx5TKeEEyl9vQcnCFektOApkjJ2mIRA2sC0k33vmjbU1hal+O8pKsEGI6G4nZydTia
         r2qtt2ix6eY0TRRoRnOi/70aP3nIreZvtniI0BhfL3UZhJy7eS7b8jqs6gken5pzTMTq
         Z4oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=l1ypxq5sN1XaiTtKGJVIQJhrf9oiU9y+ngIai306ik4=;
        b=ZFPlPqm8hM2wf3YfLimagHAuxNk2S2KO4NdYCcQffNXQGiuVIITuPQREdDp08aj4Zl
         U8jGcU+IbYvJqy+Y8+DbSeUEoPek2dz8kjZbsXEa4z+HGHSRxDkjxCOXcXJ3tSpPf9Hw
         A8VhD891lW8u6WBkZEzh4AkikFohZIKstpKKzxfmXWQWRUEwtLfP9Ygrj5Y8UaDX27JU
         IQbtaI4eWJsMhecSK7tViaVa8Kztzn5cN2F0k0q/S0/nCMpgbYATjdUl7V8u4zcs7+5o
         IIr0ooYC2WwTRNvTijuSD04L6pwyNupWh+w6k+z1cOQBS7Y5tYLkMHrzthV4N3flH0Mm
         b2dg==
X-Gm-Message-State: AOAM532LQcxr56PqOE84Xm+js56S8Qxh20pDtJ/pHxTij+qPGCXKnK6L
        2xSbrlYhQgnc8ED0Xkmy0T858Z6I1O+CJfrnkFEbd8DShtmCcwFmB02cMxWjZlx4AufI6oI3VxN
        vceZOpCxNSteiGUbct1CmR3hvd7QxWK1i+JNcSqr97knochevyuV3uFFjN8ewOzs=
X-Google-Smtp-Source: ABdhPJxobZ6Ir5jaGa+HOtBJbHnuCVnMRDGY5Y57Vm5Qnm1/bk1dwNPD3xOVdkHJcSet8lz8+5+XyLxF1f4Jcg==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a05:622a:113:: with SMTP id
 u19mr389457qtw.274.1639699361683; Thu, 16 Dec 2021 16:02:41 -0800 (PST)
Date:   Thu, 16 Dec 2021 16:02:35 -0800
In-Reply-To: <20211207192925.67680-1-chooglen@google.com>
Message-Id: <20211217000235.68996-1-chooglen@google.com>
Mime-Version: 1.0
References: <20211207192925.67680-1-chooglen@google.com>
X-Mailer: git-send-email 2.34.1.173.g76aa8bc2d0-goog
Subject: [PATCH v2] builtin/fetch: skip unnecessary tasks when using --negotiate-only
From:   Glen Choo <chooglen@google.com>
To:     git@vger.kernel.org
Cc:     Glen Choo <chooglen@google.com>,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

cmd_fetch() performs certain tasks with the assumption that objects are
fetched, but `git fetch --negotiate-only` does not fetch objects, as its
name implies. This is results in behavior that is unnecessary at best,
and incorrect at worst:

* Submodules are updated if enabled by recurse.submodules=true, but
  negotiation fetch doesn't actually update the repo, so this doesn't
  make sense (introduced in [1]).
* Commit graphs will be written if enabled by
  fetch.writeCommitGraph=true. But according to
  Documentation/config/fetch.txt [2], this should only be done if a
  pack-file is downloaded.
* gc is run, but according to [3], we only do this because we expect
  `git fetch` to introduce objects.

Instead of disabling these tasks piecemeal, make cmd_fetch() return
early if we know for certain that objects will not be fetched. We can
return early whenever objects are not fetched, but for now this only
considers --negotiate-only.

[1] 7dce19d374 (fetch/pull: Add the --recurse-submodules option, 2010-11-12)
[2] 50f26bd035 (fetch: add fetch.writeCommitGraph config setting, 2019-09-02)
[3] 131b8fcbfb (fetch: run gc --auto after fetching, 2013-01-26)

Signed-off-by: Glen Choo <chooglen@google.com>
---
Thanks for the review, Jonathan! 

Changes since v1:
* added more context to commit message
* added a NEEDSWORK comment 

Interdiff against v1:
  diff --git a/builtin/fetch.c b/builtin/fetch.c
  index 01865b5c09..85091af99b 100644
  --- a/builtin/fetch.c
  +++ b/builtin/fetch.c
  @@ -2122,7 +2122,14 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
   
   	string_list_clear(&list, 0);
   
  -	/* skip irrelevant tasks if objects were not fetched  */
  +	/*
  +	 * Skip irrelevant tasks because we know objects were not
  +	 * fetched.
  +	 *
  +	 * NEEDSWORK: as a future optimization, we can return early
  +	 * whenever objects were not fetched e.g. if we already have all
  +	 * of them.
  +	 */
   	if (negotiate_only)
   		return result;
   

 builtin/fetch.c       | 29 ++++++++++++++++++++++++-----
 t/t5516-fetch-push.sh | 12 ++++++++++++
 2 files changed, 36 insertions(+), 5 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index f7abbc31ff..85091af99b 100644
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
@@ -2112,6 +2120,19 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
 		result = fetch_multiple(&list, max_children);
 	}
 
+	string_list_clear(&list, 0);
+
+	/*
+	 * Skip irrelevant tasks because we know objects were not
+	 * fetched.
+	 *
+	 * NEEDSWORK: as a future optimization, we can return early
+	 * whenever objects were not fetched e.g. if we already have all
+	 * of them.
+	 */
+	if (negotiate_only)
+		return result;
+
 	if (!result && (recurse_submodules != RECURSE_SUBMODULES_OFF)) {
 		struct strvec options = STRVEC_INIT;
 		int max_children = max_jobs;
@@ -2132,8 +2153,6 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
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

