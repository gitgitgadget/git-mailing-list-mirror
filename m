Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0A90C1F462
	for <e@80x24.org>; Mon, 10 Jun 2019 08:59:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388508AbfFJI73 (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Jun 2019 04:59:29 -0400
Received: from bsmtp7.bon.at ([213.33.87.19]:5286 "EHLO bsmtp7.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388190AbfFJI72 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Jun 2019 04:59:28 -0400
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp7.bon.at (Postfix) with ESMTPSA id 45MnBQ4NtXz5tlB;
        Mon, 10 Jun 2019 10:59:26 +0200 (CEST)
Received: from dx.site (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id DC231450;
        Mon, 10 Jun 2019 10:59:25 +0200 (CEST)
From:   Johannes Sixt <j6t@kdbg.org>
To:     git@vger.kernel.org
Cc:     Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH 0/3] Reduce number of processes spawned by git-mergetool
Date:   Mon, 10 Jun 2019 10:58:57 +0200
Message-Id: <cover.1560152205.git.j6t@kdbg.org>
X-Mailer: git-send-email 2.21.0.285.gc38d92e052
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

git-mergetool spawns an enormous amount of processes. For this reason,
the test script, t7610, is exceptionally slow, in particular, on
Windows. Most of the processes are invocations of git, but there are
also some that can be replaced with shell builtins.

I've measured the number of processes with

  ps; ./t7610-mergetool.sh >/dev/null; ps

on a quiet system and the number of non-git commands invoked with

  strace -e execve -f -o /tmp/git.strace ./t7610-mergetool.sh
  grep 'execve(' /tmp/git.strace | grep -v 'execve(".home' | wc -l

baseline:
15628 pts/1    00:00:00 ps
29413 pts/1    00:00:00 ps

=> 13785 processes
=> 3082 non-git commands

t7610-mergetool: do not place pipelines headed by `yes` in subshells
12620 pts/1    00:00:00 ps
26348 pts/1    00:00:00 ps

=> 13728 processes
=> 3082 non-git commands

mergetool: dissect strings with shell variable magic instead of `expr`
 8766 pts/1    00:00:00 ps
21913 pts/1    00:00:00 ps

=> 13147 processes
=> 2521 non-git commands

mergetool: use shell variable magic instead of `awk`
 2081 pts/1    00:00:00 ps
14393 pts/1    00:00:00 ps

=> 12312 processes
=> 2007 non-git commands

The reduction of processes is not as dramatic as I hoped, but still
more than 10%.

Johannes Sixt (3):
  t7610-mergetool: do not place pipelines headed by `yes` in subshells
  mergetool: dissect strings with shell variable magic instead of `expr`
  mergetool: use shell variable magic instead of `awk`

 git-mergetool.sh     |  45 ++++++++----
 t/t7610-mergetool.sh | 170 +++++++++++++++++++++----------------------
 2 files changed, 116 insertions(+), 99 deletions(-)

-- 
2.21.0.285.gc38d92e052

