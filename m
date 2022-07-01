Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D222BC433EF
	for <git@archiver.kernel.org>; Fri,  1 Jul 2022 01:34:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230202AbiGABeo (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Jun 2022 21:34:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbiGABem (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Jun 2022 21:34:42 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C893D53D3E
        for <git@vger.kernel.org>; Thu, 30 Jun 2022 18:34:40 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id 65so1026605pfw.11
        for <git@vger.kernel.org>; Thu, 30 Jun 2022 18:34:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9Rub2ceeORYffZxUkYsz92+s6TYPsxZqzBtaUoDXmhs=;
        b=wGzm2vO4LtzVj8VYV4dhjNFE37PgrBvtkokot82t5q2nnM6hxlTbhIDAAxUVStciZL
         B2qIcDZj57yCHhZWeCLYlVk/3pnKrK0i5Goo+wDycvJFV66jThsItTjazILu7kbl81MH
         2EhUseVVV1XPURKWrPx58Tqb+Dlaliw3wPYx58dyz1/JCC469SpnSR1uauZlO97w2xD0
         AVGVwtmWCICiu2iRx58QX3kfJMoxTcmfIL4mgPsREGbQIp/MfmlpvSawGRIQ9bnF1I7A
         kTlosNgrWwewYOOAhpCRsND7oJRGU7TDjDJhR1IV//oXYvYd+/e47MPRupXqfDwVUU6B
         zRxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9Rub2ceeORYffZxUkYsz92+s6TYPsxZqzBtaUoDXmhs=;
        b=WMCrvLofnq5tMKVDpFh5/Krff6ROfoJdImJzPTTbmKYlQhZiguYqrTYcBWeyqgnBAO
         30Dg7YE/BIR37YCrxCd5H4x8pMzGRviUpvviIzcXu03FeqAPDmf45vIr9dWrTIrKJ8r5
         JDP5BvfC9Dv6aS/lMEkcgvgQKXkeqdSsqIBBhdTbHMNw8SHOLWL9adbMGHCtC0jUplyY
         Czueft6BNJkXPiu/94VLImasUNQsvOoEPs1i6rD/H81c1+ABP0a5pvp7oV2qxXMCQyJP
         wqyqj2PwcRTclnjHzmdtEXjJiJT6vyFCHjCOymxpXKVrm70oyhH8fGDUa/5PLmGAQA85
         cxuw==
X-Gm-Message-State: AJIora/eExl+FxHxqM2sET8qVXL5BG0Zgch6euvBDjmNeN9R0L683PHj
        ekqXGazboYEzvNsLU5VNSt4peA==
X-Google-Smtp-Source: AGRyM1uMN/OyUIxCWs/iMmuuVcZf+a2Z+s0QH9OWP6l5hFELJAnPVXvJ6rcIZN09CC2I81ozxWEdTw==
X-Received: by 2002:a65:604a:0:b0:3f9:f423:b474 with SMTP id a10-20020a65604a000000b003f9f423b474mr9870731pgp.527.1656639280285;
        Thu, 30 Jun 2022 18:34:40 -0700 (PDT)
Received: from JMHNXMC7VH.bytedance.net ([139.177.225.243])
        by smtp.gmail.com with ESMTPSA id k2-20020a17090a658200b001ef3cec7f47sm2245820pjj.52.2022.06.30.18.34.36
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 30 Jun 2022 18:34:39 -0700 (PDT)
From:   Han Xin <hanxin.hx@bytedance.com>
To:     hanxin.hx@bytedance.com
Cc:     chiyutianyi@gmail.com, derrickstolee@github.com,
        git@vger.kernel.org, haiyangtand@gmail.com,
        jonathantanmy@google.com, me@ttaylorr.com,
        Junio C Hamano <gitster@pobox.com>, ps@pks.im
Subject: [PATCH v4 0/1] no lazy fetch in lookup_commit_in_graph()
Date:   Fri,  1 Jul 2022 09:34:29 +0800
Message-Id: <cover.1656593279.git.hanxin.hx@bytedance.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover.1656381667.git.hanxin.hx@bytedance.com>
References: <cover.1656381667.git.hanxin.hx@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Changes since v3:

* Move run_with_limited_processses() into 
  t5330-no-lazy-fetch-with-commit-graph.sh without touching test-lib.sh.

* Squash "setup: prepare any commit to fetch" into the main body of the
  test.

* Minor grammar/comment etc. fixes throughout.

Han Xin (1):
  commit-graph.c: no lazy fetch in lookup_commit_in_graph()

 commit-graph.c                             |  2 +-
 t/t5330-no-lazy-fetch-with-commit-graph.sh | 70 ++++++++++++++++++++++
 2 files changed, 71 insertions(+), 1 deletion(-)
 create mode 100755 t/t5330-no-lazy-fetch-with-commit-graph.sh

Range-diff against v3:
1:  ad0a539759 < -:  ---------- test-lib.sh: add limited processes to test-lib
2:  3cdb1abd43 ! 1:  96d4bb7150 commit-graph.c: no lazy fetch in lookup_commit_in_graph()
    @@ commit-graph.c: struct commit *lookup_commit_in_graph(struct repository *repo, c
      
      	commit = lookup_commit(repo, id);
     
    - ## t/t5329-no-lazy-fetch-with-commit-graph.sh (new) ##
    + ## t/t5330-no-lazy-fetch-with-commit-graph.sh (new) ##
     @@
     +#!/bin/sh
     +
    @@ t/t5329-no-lazy-fetch-with-commit-graph.sh (new)
     +
     +. ./test-lib.sh
     +
    ++run_with_limited_processses () {
    ++	# bash and ksh use "ulimit -u", dash uses "ulimit -p"
    ++	if test -n "$BASH_VERSION"
    ++	then
    ++		ulimit_max_process="-u"
    ++	elif test -n "$KSH_VERSION"
    ++	then
    ++		ulimit_max_process="-u"
    ++	fi
    ++	(ulimit ${ulimit_max_process-"-p"} 512 && "$@")
    ++}
    ++
    ++test_lazy_prereq ULIMIT_PROCESSES '
    ++	run_with_limited_processses true
    ++'
    ++
     +if ! test_have_prereq ULIMIT_PROCESSES
     +then
     +	skip_all='skipping tests for no lazy fetch with the commit-graph, ulimit processes not available'
    @@ t/t5329-no-lazy-fetch-with-commit-graph.sh (new)
     +
     +test_expect_success 'setup: change the alternates to what without the commit' '
     +	git init --bare without-commit &&
    ++	git -C with-commit-graph cat-file -e $oid &&
     +	echo "$(pwd)/without-commit/objects" \
     +		>with-commit-graph/.git/objects/info/alternates &&
     +	test_must_fail git -C with-commit-graph cat-file -e $oid
     +'
     +
    -+test_expect_success 'setup: prepare any commit to fetch' '
    -+	test_commit -C with-commit any-commit &&
    -+	anycommit=$(git -C with-commit rev-parse HEAD)
    -+'
    -+
     +test_expect_success 'fetch any commit from promisor with the usage of the commit graph' '
    ++	# setup promisor and prepare any commit to fetch
     +	git -C with-commit-graph remote add origin "$(pwd)/with-commit" &&
     +	git -C with-commit-graph config remote.origin.promisor true &&
     +	git -C with-commit-graph config remote.origin.partialclonefilter blob:none &&
    -+	run_with_limited_processses env GIT_TRACE="$(pwd)/trace" \
    ++	test_commit -C with-commit any-commit &&
    ++	anycommit=$(git -C with-commit rev-parse HEAD) &&
    ++
    ++	run_with_limited_processses env GIT_TRACE="$(pwd)/trace.txt" \
     +		git -C with-commit-graph fetch origin $anycommit 2>err &&
    -+	test_i18ngrep ! "fatal: promisor-remote: unable to fork off fetch subprocess" err &&
    -+	test $(grep "fetch origin" trace | wc -l) -eq 1
    ++	! grep "fatal: promisor-remote: unable to fork off fetch subprocess" err &&
    ++	grep "git fetch origin" trace.txt >actual &&
    ++	test_line_count = 1 actual
     +'
     +
     +test_done
-- 
2.36.1

