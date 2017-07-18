Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1629420356
	for <e@80x24.org>; Tue, 18 Jul 2017 19:05:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752182AbdGRTFj (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Jul 2017 15:05:39 -0400
Received: from mail-pg0-f41.google.com ([74.125.83.41]:34744 "EHLO
        mail-pg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751480AbdGRTFi (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Jul 2017 15:05:38 -0400
Received: by mail-pg0-f41.google.com with SMTP id 123so17586608pgj.1
        for <git@vger.kernel.org>; Tue, 18 Jul 2017 12:05:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=lv1xXHqO8j0RnReuKrDZ5fV3vUfBDL7fRuTKTQQIHtw=;
        b=Q1Liu2Duldd9GMns0T/nQKLE0xKG53UEKqTvFNXss7EA5SCNoH6nCDntpBqTmMkyoB
         iTmSVX56qHTEB8V0+7EKEnO4o3guhewFz6tSRIofI5KwpFawrUsPheWavC8I4TSEUVeN
         OGn9s3YLeHrugN/84SnCqXALrL3rRwvr6uaQKtcFj0EJ+3c9K4wPu6gHF3/eDtjWPHPd
         DaYiyJn8XZR4S66kkBsQBzfux84RbJOmbG5IVOLXtGMK/LV02fHjRAJyMQhIGdY/bWXI
         42IMmvTTHdr2slHaMHpscrhTup6DOQ8nExyDX4sWDiuqu7jMbekfRWiWRtQUwQyoS8YZ
         ARrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=lv1xXHqO8j0RnReuKrDZ5fV3vUfBDL7fRuTKTQQIHtw=;
        b=oaau7DvrR7LzvcLRZlXzrqsdnyXISPjIc3DruaG2dZEC8l+zYaAaY/6+WXIaDtU0pG
         pERs4kOUTx0dB/zcbcPggeYrz4AcsOy3JeYpwPi6yL0PNhYL2e5tzDhUkdQdZmsldZT2
         VFKKQkTDuYNw15rCzOjCHJwBvDt6WuPwHjVlKRl1GmrEd3+DY3zttkMrfgzbeEqgmCOF
         hcUQRNoPD/7YN1TCoztGA/4oc1wpsQpvWbxQ9sMZLpx8vsgYIVneQiIAnyWtbXR5TuEp
         qMwvJYrlGsecEGbywsIyDOcy2+OFHDI9VnVCgikGuCJw03zpCJgHfueIcFlAweDgqmO5
         o3cQ==
X-Gm-Message-State: AIVw111n7/jJGdxfTxpsw/kd+jwXQVH/2r8vn7W252rUknNduer6OlIA
        BjJDdHJVEIniMRw91VdoCA==
X-Received: by 10.84.232.74 with SMTP id f10mr3288551pln.154.1500404737089;
        Tue, 18 Jul 2017 12:05:37 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id t11sm6894649pfi.66.2017.07.18.12.05.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 18 Jul 2017 12:05:36 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, jrnieder@gmail.com, gitster@pobox.com,
        Brandon Williams <bmwill@google.com>
Subject: [PATCH v3 00/10] Convert grep to recurse in-process
Date:   Tue, 18 Jul 2017 12:05:17 -0700
Message-Id: <20170718190527.78049-1-bmwill@google.com>
X-Mailer: git-send-email 2.13.2.932.g7449e964c-goog
In-Reply-To: <20170714222826.81148-1-bmwill@google.com>
References: <20170714222826.81148-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Changes in v3:
 * Fixes a bug with repo_read_gitmodules() where it was possible to
   segfault when a repository didn't have a worktree.  
 * In order to fix the above bug repo_read_gitmodules() and gitmodules_config()
   were merged so that there won't be any duplicate logic.  In order to merge
   these functions the parsing of submodule.fetchjobs and
   fetch.recursesubmodules were removed from the submodule-config parsing logic
   and instead moved into fetch and update-clone.  This also makes it easier to
   ensure that no additonal non-submodule specific configuration like this will
   be added to .gitmodules in the future.

Brandon Williams (10):
  repo_read_index: don't discard the index
  repository: have the_repository use the_index
  cache.h: add GITMODULES_FILE macro
  config: add config_from_gitmodules
  submodule: remove submodule.fetchjobs from submodule-config parsing
  submodule: remove fetch.recursesubmodules from submodule-config
    parsing
  submodule: check for unstaged .gitmodules outside of config parsing
  submodule: check for unmerged .gitmodules outside of config parsing
  submodule: merge repo_read_gitmodules and gitmodules_config
  grep: recurse in-process using 'struct repository'

 Documentation/git-grep.txt  |   7 -
 builtin/fetch.c             |  26 ++-
 builtin/grep.c              | 396 ++++++++++----------------------------------
 builtin/mv.c                |   2 +-
 builtin/rm.c                |   2 +-
 builtin/submodule--helper.c |  17 +-
 cache.h                     |   2 +-
 config.c                    |  17 ++
 config.h                    |  10 ++
 git.c                       |   2 +-
 grep.c                      |  13 --
 grep.h                      |   1 -
 repository.c                |   6 +-
 repository.h                |   8 +
 setup.c                     |  12 +-
 submodule-config.c          |   8 +
 submodule-config.h          |   1 +
 submodule.c                 | 147 +++++++---------
 submodule.h                 |   6 +-
 19 files changed, 240 insertions(+), 443 deletions(-)

-- 
2.13.2.932.g7449e964c-goog

