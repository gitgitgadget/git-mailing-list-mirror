Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6D6C820357
	for <e@80x24.org>; Fri, 14 Jul 2017 22:28:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751105AbdGNW2r (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Jul 2017 18:28:47 -0400
Received: from mail-pg0-f53.google.com ([74.125.83.53]:33689 "EHLO
        mail-pg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751085AbdGNW2q (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Jul 2017 18:28:46 -0400
Received: by mail-pg0-f53.google.com with SMTP id k14so51813970pgr.0
        for <git@vger.kernel.org>; Fri, 14 Jul 2017 15:28:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=kGi7rD39wT2Je3fpnea3lumt4A19BMptjYttl7wLsjQ=;
        b=UzONSatahsdweHl93TAMbNBOs6/DcXRBI/W5AbGGecpW5y+DJoTemPrcjzMRwfzxps
         wk73MVFAKVU/iVeo0qUsAaS9ukeSX53wL55UaYwKLVuwWou8SQOyZ69Gr50jJNxbwyM2
         Je0DYCit6KFwRQFoIRixUc+HnExQMudQd65ap2zzx8zcBqQqTysIgc/lKE7w6AZTRuzJ
         AJMuYkWoPdSvqB0/F+4fiwOPJU6FqDDgA/Pmu2o+KoyPc08DzuesI03EevJsC63BUENI
         abJRLrnX6fzRAufskH5MQ7LMn49HDQK57e7XmJK+qp+hv4aLX9m8ldV2v7GF8XHzbuo5
         7oGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=kGi7rD39wT2Je3fpnea3lumt4A19BMptjYttl7wLsjQ=;
        b=rQwrWadP9e8ta6ZstGHncDcxe+rdXiT6qhKrDy9ehNSdFYE/QM+31Wcs393zIgLb/Q
         64MI7EM7UtHYJC0cwSgcB3whU5uudoXdoYGwK2axZm41M0f/7mGCCoDo+fHHTb7yVcGF
         VPiyGfqYPDlm7xkxbclLjS3oLcl6ciOLfd48uedqqsh31i1R137sYJU6zgs+3yWF+Vo3
         7ekx5+DEc5BEG5kQXBk0ZoJV7V2mAnebovt195/3p6Mk19k65Nof7zcXckYMjuC21afY
         lie+XJTtxeW1dL0O2X9JT/LbT3lmftgFz4LKTP+5Wb4g3fUDqzInfezkjhF1JzvCmeox
         WpyA==
X-Gm-Message-State: AIVw112dnRSU2c5RK2+eq89rrKD9xrDZ7xEuu50wtiXGWjwCdIAb2vz1
        vfQoMdjiILiCM71s0reo1A==
X-Received: by 10.98.113.71 with SMTP id m68mr7600275pfc.220.1500071325858;
        Fri, 14 Jul 2017 15:28:45 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id 204sm19749989pfc.32.2017.07.14.15.28.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 14 Jul 2017 15:28:44 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, peff@peff.net, gitster@pobox.com,
        jrnieder@gmail.com, jacob.keller@gmail.com,
        Brandon Williams <bmwill@google.com>
Subject: [PATCH v2 0/3] Convert grep to recurse in-process
Date:   Fri, 14 Jul 2017 15:28:23 -0700
Message-Id: <20170714222826.81148-1-bmwill@google.com>
X-Mailer: git-send-email 2.13.2.932.g7449e964c-goog
In-Reply-To: <20170711220408.173269-1-bmwill@google.com>
References: <20170711220408.173269-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Changes in v2:
* small style nits fixed.
* Comment describing function contract for repo_read_index
* NEEDSWORK comment in grep to describe the issue with adding the submodule's
  object store as an alternate.
* the_repository->index = &the_index was removed from setup.c and instead this
  is done as a static initializer.

Brandon Williams (3):
  repo_read_index: don't discard the index
  repository: have the_repository use the_index
  grep: recurse in-process using 'struct repository'

 Documentation/git-grep.txt |   7 -
 builtin/grep.c             | 396 ++++++++++-----------------------------------
 cache.h                    |   1 -
 git.c                      |   2 +-
 grep.c                     |  13 --
 grep.h                     |   1 -
 repository.c               |   6 +-
 repository.h               |   8 +
 setup.c                    |  12 +-
 9 files changed, 99 insertions(+), 347 deletions(-)

-- 
2.13.2.932.g7449e964c-goog

