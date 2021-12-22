Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4AC1C433F5
	for <git@archiver.kernel.org>; Wed, 22 Dec 2021 00:11:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238952AbhLVALy (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Dec 2021 19:11:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239057AbhLVALw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Dec 2021 19:11:52 -0500
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98361C061574
        for <git@vger.kernel.org>; Tue, 21 Dec 2021 16:11:52 -0800 (PST)
Received: by mail-pl1-x64a.google.com with SMTP id m15-20020a170902bb8f00b0014382b67873so56430pls.19
        for <git@vger.kernel.org>; Tue, 21 Dec 2021 16:11:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Ahvy+SY6KIwEv/qUeGDTeL0R3FlvQuyn/9DiUntmS3E=;
        b=TFNqYiS5KUwwB3O0/zkLCwdy6vcWz1+rcVPOpEZiKtZ3AhbwtC0cAnzZybC1iUK74I
         /YfdY05epGioxcm1E4LX9OtFSLbRmgqYizMgojK5VBaoXpvF9WRx1ngVjHMBxjDS8xXU
         LEmmekKUTG1hPBwuVWz3jBR/1Cwv9fP8sLB5R037o7LgH45b5JVnfOyyQvDxcyCLq16C
         XuAV0Lr/1y+8NVR34cJtRtdh2K6GJ097C1Xfozvrhp14YmwX04WiomIyj8N/HXnDJzR8
         AWuA/HUYM9JHWjtICrKhip5WPYHGh6saviXdy8dhhAAnZgWfXQeHLpzIU4LX/8clRBI6
         sW2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Ahvy+SY6KIwEv/qUeGDTeL0R3FlvQuyn/9DiUntmS3E=;
        b=jAdy8W5oGQ2Gu7P8xN0Fnanmpy8iDTZieYJS/jN5c5L8C76tnQocLHGLanxsU/EDBR
         ixFIwNLKzZJO6miJU5McchRAaHXIrkYhmUTTz8e2UAv+5iwF4Ciyfg3cFLVEIAlxwL2i
         xUzbM+S3Mfi0MxmbM4Xal4uyGHNFFhF0AzqILOUx9EC+2l04AWd3Q+1FrKcTIH2FSdRa
         ECH99TMsM/EKzUPdhzjbcZknqznlrEj4rwWaBVDOzhsApqjCZxFfAl0+K05hfyxkEiSn
         3d2OIiMZdbFYf7VVNH3IOSRr+EkoGzlQqb0yUFOwS3O1hpVtfLWgFO82DFeUglaP0NOw
         u1gA==
X-Gm-Message-State: AOAM530HLqYZKLIZUe78k3z4bVSi5ZyijbDAcQE7T+GWELyRKjC+bIwH
        Z9Sl8+8U1K0GOqc9OvcNaRpPDEKgqBpd9Jobyez0c5yjO8vdv7BdFBjTDEiWy4dK4QN9WoSGe0K
        uj8GHveLANrgWkMufRcbtwbbItKLnbCS4CGuPHF9UojkldrXfQzngroLwU5BnIlY=
X-Google-Smtp-Source: ABdhPJyhXokdSW33LvY//VBijtUry7x7LPl87dHdMiz1r/549qESvBpzrRRAppt0txxGSdXeDUf3rVSq0WKI+A==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a63:7986:: with SMTP id
 u128mr687085pgc.204.1640131911993; Tue, 21 Dec 2021 16:11:51 -0800 (PST)
Date:   Tue, 21 Dec 2021 16:11:33 -0800
In-Reply-To: <20211222001134.28933-1-chooglen@google.com>
Message-Id: <20211222001134.28933-3-chooglen@google.com>
Mime-Version: 1.0
References: <20211217000235.68996-1-chooglen@google.com> <20211222001134.28933-1-chooglen@google.com>
X-Mailer: git-send-email 2.34.1.307.g9b7440fafd-goog
Subject: [PATCH v3 2/3] builtin/fetch: skip unnecessary tasks when using --negotiate-only
From:   Glen Choo <chooglen@google.com>
To:     git@vger.kernel.org
Cc:     Glen Choo <chooglen@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Junio C Hamano <gitster@pobox.com>
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

A similar optimization would be to skip irrelevant tasks in `git fetch
--dry-run`. This optimization was not done in this commit because a dry
run will actually fetch objects; we'd presumably still want to recurse
into submodules and run gc.

[1] 7dce19d374 (fetch/pull: Add the --recurse-submodules option, 2010-11-12)
[2] 50f26bd035 (fetch: add fetch.writeCommitGraph config setting, 2019-09-02)
[3] 131b8fcbfb (fetch: run gc --auto after fetching, 2013-01-26)

Signed-off-by: Glen Choo <chooglen@google.com>
---
 builtin/fetch.c       | 20 ++++++++++++++++++++
 t/t5516-fetch-push.sh | 12 ++++++++++++
 2 files changed, 32 insertions(+)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index eab73d7417..883bb1b10c 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -1996,6 +1996,15 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
 
 	argc = parse_options(argc, argv, prefix,
 			     builtin_fetch_options, builtin_fetch_usage, 0);
+
+	if (negotiate_only) {
+		/*
+		 * --negotiate-only should never recurse into
+		 * submodules, so there is no need to read .gitmodules.
+		 */
+		recurse_submodules = RECURSE_SUBMODULES_OFF;
+	}
+
 	if (recurse_submodules != RECURSE_SUBMODULES_OFF) {
 		int *sfjc = submodule_fetch_jobs_config == -1
 			    ? &submodule_fetch_jobs_config : NULL;
@@ -2113,6 +2122,17 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
 		result = fetch_multiple(&list, max_children);
 	}
 
+	/*
+	 * Skip irrelevant tasks because we know objects were not
+	 * fetched.
+	 *
+	 * NEEDSWORK: as a future optimization, we can return early
+	 * whenever objects were not fetched e.g. if we already have all
+	 * of them.
+	 */
+	if (negotiate_only)
+		goto cleanup;
+
 	if (!result && (recurse_submodules != RECURSE_SUBMODULES_OFF)) {
 		struct strvec options = STRVEC_INIT;
 		int max_children = max_jobs;
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

