Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88A5FC761A6
	for <git@archiver.kernel.org>; Fri, 31 Mar 2023 15:59:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232943AbjCaP7K (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 31 Mar 2023 11:59:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232887AbjCaP7I (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Mar 2023 11:59:08 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8813B44E
        for <git@vger.kernel.org>; Fri, 31 Mar 2023 08:59:06 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id u11-20020a05600c19cb00b003edcc414997so14214155wmq.3
        for <git@vger.kernel.org>; Fri, 31 Mar 2023 08:59:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680278345;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=9Y4h7kY6BWQSzs7yu2A4pl9KyXgR/n7xhejHN2FL2iU=;
        b=n2ZFTETC/VVzWp6dVFWbA3P6gJYgHCOn2RirWDpL5qYiuhdA1/BVg9f7h15Stubp0p
         ioCkDATkGj+U+ZJMIEHfvgPzrdq+a3O9O8bpO+O4mSejKOxVzw0kXFNvUI1/9v88XOZ5
         u5EAlhMQBvyBJ2ri1i7bWD55XYMROAT/k7ctEF7EuXwDke7sYHVzo8b8j248OcsrwnQG
         ydQmY+hkRUfUeH04pAhwvCkjteiRDN+uOSXvwid6QJy1A/4wnxLj9oXVGLldu+Jd1ubh
         +iRw4sb7YBoH8xCiL2C03+dg9j4Fi8lQ/2f9cCADyxcPw1VVTNc0uz7lec3P3pDv6Rli
         mYyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680278345;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9Y4h7kY6BWQSzs7yu2A4pl9KyXgR/n7xhejHN2FL2iU=;
        b=ik5LjzbJfhAYPsix+QYWepyrnMrWXhAEoxul5WNFbtN/LJ0MOfqboiXXC0jvBm4Aub
         BKprcPAYTCjS86egk2sSGyjTiX60X8e/5wE8Dngc+QZUWuIm5uruIv5sm25uBuc7Zipu
         wFCrv8tFMb6R+oHrEgE2pOepw+n+LvYeG4R/g0Hj69ojGcllRDHQbn0oX47kIL5ECC2T
         sxthqZzGvNQHt3IEVlgFVztDQ4PfSlfMIWvDcm3IQoQFiNFMRsnuGdWKlVGMqkiQCyDj
         f9EzJAar89w4jbSSy8JtZUxPPP1XOroA72DOEmrc+08jytNjFhvL/+r61/y1jNoNS0G7
         hNWw==
X-Gm-Message-State: AO0yUKXpQom0XUiur5l2u6Qcc4csyjEKM4dKL1pO5QrdtDu0pzNdv6Nc
        N60ITDRs3KQkB81+IUxh5xavk3CE3wE=
X-Google-Smtp-Source: AK7set/WNeDPOnaBcyQboCWeMBilvwWjcHUdlhZgyNqdUP1wlfO/QO7anyFXgbO/l+C/27fz2CafiQ==
X-Received: by 2002:a1c:6a13:0:b0:3ed:ec34:f1 with SMTP id f19-20020a1c6a13000000b003edec3400f1mr20096546wmc.35.1680278345080;
        Fri, 31 Mar 2023 08:59:05 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f16-20020adffcd0000000b002d5a8d8442asm2524294wrs.37.2023.03.31.08.59.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Mar 2023 08:59:04 -0700 (PDT)
Message-Id: <pull.1508.git.1680278344173.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 31 Mar 2023 15:59:04 +0000
Subject: [PATCH] fetch: download bundles once, even with --all
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     vdye@github.com, gitster@pobox.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <derrickstolee@github.com>

When fetch.bundleURI is set, 'git fetch' downloads bundles from the
given bundle URI before fetching from the specified remote. However,
when using non-file remotes, 'git fetch --all' will launch 'git fetch'
subprocesses which then read fetch.bundleURI and fetch the bundle list
again. We do not expect the bundle list to have new information during
these multiple runs, so avoid these extra calls by un-setting
fetch.bundleURI in the subprocess arguments.

Be careful to skip fetching bundles for the empty bundle string.
Fetching bundles from the empty list presents some interesting test
failures.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
    fetch: download bundles once, even with --all
    
    I noticed this in local testing where I had set up a bundle server for
    my Git repo, but wrote the wrong port number so I saw multiple warning
    messages during a git fetch --all run.
    
    Thanks, -Stolee

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1508%2Fderrickstolee%2Ffetch-bundles-multiple-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1508/derrickstolee/fetch-bundles-multiple-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1508

 builtin/fetch.c             |  7 ++++++-
 bundle-uri.c                |  9 +++++++++
 t/t5558-clone-bundle-uri.sh | 34 ++++++++++++++++++++++++++++++++++
 3 files changed, 49 insertions(+), 1 deletion(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 7221e57f352..8d8b2e0c26f 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -1955,7 +1955,12 @@ static int fetch_multiple(struct string_list *list, int max_children)
 			return errcode;
 	}
 
-	strvec_pushl(&argv, "fetch", "--append", "--no-auto-gc",
+	/*
+	 * Cancel out the fetch.bundleURI config when running subprocesses,
+	 * to avoid fetching from the same bundle list multiple times.
+	 */
+	strvec_pushl(&argv, "-c", "fetch.bundleURI=",
+		     "fetch", "--append", "--no-auto-gc",
 		     "--no-write-commit-graph", NULL);
 	add_options_to_argv(&argv);
 
diff --git a/bundle-uri.c b/bundle-uri.c
index 177c1810402..56390651b92 100644
--- a/bundle-uri.c
+++ b/bundle-uri.c
@@ -792,6 +792,15 @@ int fetch_bundle_uri(struct repository *r, const char *uri,
 
 	init_bundle_list(&list);
 
+	/*
+	 * Do not fetch a NULL or empty bundle URI. An empty bundle URI
+	 * could signal that a configured bundle URI has been disabled.
+	 */
+	if (!uri || !*uri) {
+		result = 0;
+		goto cleanup;
+	}
+
 	/* If a bundle is added to this global list, then it is required. */
 	list.mode = BUNDLE_MODE_ALL;
 
diff --git a/t/t5558-clone-bundle-uri.sh b/t/t5558-clone-bundle-uri.sh
index afd56926c53..996a08e90c9 100755
--- a/t/t5558-clone-bundle-uri.sh
+++ b/t/t5558-clone-bundle-uri.sh
@@ -1018,6 +1018,40 @@ test_expect_success 'creationToken heuristic with failed downloads (fetch)' '
 	test_cmp expect refs
 '
 
+test_expect_success 'bundles are downloaded once during fetch --all' '
+	test_when_finished rm -rf download-* trace*.txt fetch-mult &&
+
+	cat >"$HTTPD_DOCUMENT_ROOT_PATH/bundle-list" <<-EOF &&
+	[bundle]
+		version = 1
+		mode = all
+		heuristic = creationToken
+
+	[bundle "bundle-1"]
+		uri = bundle-1.bundle
+		creationToken = 1
+
+	[bundle "bundle-2"]
+		uri = bundle-2.bundle
+		creationToken = 2
+
+	[bundle "bundle-3"]
+		uri = bundle-3.bundle
+		creationToken = 3
+	EOF
+
+	git clone --single-branch --branch=left \
+		--bundle-uri="$HTTPD_URL/bundle-list" \
+		"$HTTPD_URL/smart/fetch.git" fetch-mult &&
+	git -C fetch-mult remote add dup1 "$HTTPD_URL/smart/fetch.git" &&
+	git -C fetch-mult remote add dup2 "$HTTPD_URL/smart/fetch.git" &&
+
+	GIT_TRACE2_EVENT="$(pwd)/trace-mult.txt" \
+		git -C fetch-mult fetch --all &&
+	grep "\"child_start\".*\"git-remote-https\",\"$HTTPD_URL/bundle-list\"" \
+		trace-mult.txt >bundle-fetches &&
+	test_line_count = 1 bundle-fetches
+'
 # Do not add tests here unless they use the HTTP server, as they will
 # not run unless the HTTP dependencies exist.
 

base-commit: 6369acd968d02899973a9a853c48029b92cea401
-- 
gitgitgadget
