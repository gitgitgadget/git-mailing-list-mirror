Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9E68720960
	for <e@80x24.org>; Mon, 10 Apr 2017 23:49:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752787AbdDJXt2 (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Apr 2017 19:49:28 -0400
Received: from mail-pf0-f174.google.com ([209.85.192.174]:34636 "EHLO
        mail-pf0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751710AbdDJXt1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Apr 2017 19:49:27 -0400
Received: by mail-pf0-f174.google.com with SMTP id c198so29095858pfc.1
        for <git@vger.kernel.org>; Mon, 10 Apr 2017 16:49:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=H5OtIllASFTtutaTi+YWKz4KaP0NR29NbqjVzIIhyzU=;
        b=k7JBMMWQRpQLXslysQrgt5DiRhjbmEp6A5/7/M55wEbNB9Z8WTOMNMZhaUPDK8b9lw
         gzdXk+xRzGBoobLWVTD6nTCwU1RgoJEomc2QxNTiLqjyiKvoJ0G9qW0sbs3FVb+aEZrd
         eIbb6n9CeAZwnE2KQMe0KKQ6/8PwUkUN0kxBSmlujqM1XrhYutASqCgK9SjasM6i7q/l
         DFt+1K0M+NkSgBxsrFHiZ7kaOOtt8TvEcD3rpV+TADKoeV+JV9iPQW7CfwUvrCZlilvO
         eSyRfjNPF79glzduByG/sTHRvzF+fV4Z4me1NtVaNWoA84KSlIobJFgyUlVwSfQpdyVm
         7BgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=H5OtIllASFTtutaTi+YWKz4KaP0NR29NbqjVzIIhyzU=;
        b=mV4MmHow2Ixp+NaZCfbd6U1E0cJFu+wmYSbWPbahLiVoi7Kugfv+wWzobU4DnrfF9z
         Fa3fy8/yS+oPDAL5CHCtjC8/Sq4QlqURahFCMpBgvvTxX7zCVIkGOx872LxRVIF0QYcW
         JETz8YIfs6BqNgZLjCWL/kZojUz1hL1owuhOmBjd060qf1zS6mMpXM8ilq6vkqEA7vFy
         JYNl6Cfj86xpcUC/vNf5NY42xqdkga81JJ+vrhblzOJUdc2F8SvuqOEaxxHoA9v1PNWh
         6wfMLN5HrrmM9zXSozgd+OBJVWmdqE5wu4tP1Z/d1UPMYqzBh1g6xv1DeWo4i7qm4YOe
         UyqA==
X-Gm-Message-State: AFeK/H3oJGIG4QrHl4coFrBNTJhFXCvJUNfVyNHsKuGWLJZ2JY1svzAt96ITvc9Dym2gaYhp
X-Received: by 10.99.110.6 with SMTP id j6mr59589086pgc.64.1491868167024;
        Mon, 10 Apr 2017 16:49:27 -0700 (PDT)
Received: from roshar.mtv.corp.google.com ([100.96.238.26])
        by smtp.gmail.com with ESMTPSA id x204sm26225132pgx.63.2017.04.10.16.49.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 10 Apr 2017 16:49:25 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>
Subject: [PATCH 0/5] forking and threading
Date:   Mon, 10 Apr 2017 16:49:14 -0700
Message-Id: <20170410234919.34586-1-bmwill@google.com>
X-Mailer: git-send-email 2.12.2.715.g7642488e1d-goog
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Forking and threading is a difficult thing to get right due to potential
deadlocks which can occur if one thread holds a lock while another forks.  The
resulting process will still have the lock in a locked state with no hope of it
ever being released (since forking doesn't replicate the threads as well).

The aim of this series is to push the allocation done between fork/exec to
before the call to 'fork()' so that calls to malloc can't deadlock in a forked
child process.

Most standard implementations of malloc (e.g. glibc) do the appropriate thing
and register fork handlers in order ensure that locks are in a usable state
after forking.  Unfortunately other implementations don't do this so to account
for this lets just avoid calls to functions which may require locking.

As far as I understand the only instance of threading and forking which exists
in the current code base is 'git grep --recurse-submodules', and the standard
builds against glibc shouldn't exhibit any of this deadlocking.

Brandon Williams (5):
  run-command: convert sane_execvp to sane_execvpe
  run-command: prepare argv before forking
  run-command: allocate child_err before forking
  run-command: prepare child environment before forking
  run-command: add note about forking and threading

 cache.h       |   3 +-
 exec_cmd.c    |   2 +-
 run-command.c | 151 +++++++++++++++++++++++++++++++++++++++++++++-------------
 3 files changed, 119 insertions(+), 37 deletions(-)

-- 
2.12.2.715.g7642488e1d-goog

