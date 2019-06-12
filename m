Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F22291F462
	for <e@80x24.org>; Wed, 12 Jun 2019 16:34:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438116AbfFLQeG (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Jun 2019 12:34:06 -0400
Received: from bsmtp7.bon.at ([213.33.87.19]:7469 "EHLO bsmtp7.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2438237AbfFLQeF (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Jun 2019 12:34:05 -0400
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp7.bon.at (Postfix) with ESMTPSA id 45PCB16QQsz5tlS;
        Wed, 12 Jun 2019 18:34:01 +0200 (CEST)
Received: from dx.site (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 6426920A5;
        Wed, 12 Jun 2019 18:34:01 +0200 (CEST)
From:   Johannes Sixt <j6t@kdbg.org>
To:     git@vger.kernel.org
Cc:     szeder.dev@gmail.com, gitster@pobox.com,
        Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH v2 0/4] Reduce number of processes spawned by git-mergetool
Date:   Wed, 12 Jun 2019 18:33:44 +0200
Message-Id: <cover.1560356675.git.j6t@kdbg.org>
X-Mailer: git-send-email 2.21.0.285.gc38d92e052
In-Reply-To: <cover.1560152205.git.j6t@kdbg.org>
References: <cover.1560152205.git.j6t@kdbg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

git-mergetool spawns an enormous amount of processes. For this reason,
the test script, t7610, is exceptionally slow, in particular, on
Windows. Most of the processes are invocations of git. There are
also some that can be replaced with shell builtins.

I've measured the number of processes and the number of
non-git commands invoked with

  strace -e execve,clone -f -o /tmp/git.strace ./t7610-mergetool.sh
  # processes:
  grep 'stack=NULL' /tmp/git.strace | wc -l
  # non-git commands:
  grep 'execve(' /tmp/git.strace | grep -v 'execve(".home' | wc -l

          non-git
processes commands
13775     3082    baseline
13690     3082    t7610-mergetool: do not place pipelines headed by `yes` in subshells
13645     3082    t7610-mergetool: use test_cmp instead of test $(cat file) = $txt
13084     2521    mergetool: dissect strings with shell variable magic instead of `expr`
11542     2007    mergetool: use shell variable magic instead of `awk`

Notes on v2:
- Followed Gábor's suggestion to transform test ($cat ..) = txt
  (new patch 2).  It does not help a lot, but neither does
  patch 1, the pipe-in-subshell conversion.  Both are foremost
  clean-ups.
- Commit message tweaks; see below.
- Did not include measurement results in the commit messages, because
  I would have to repeat the measurement method every time.

Johannes Sixt (4):
  t7610-mergetool: do not place pipelines headed by `yes` in subshells
  t7610-mergetool: use test_cmp instead of test $(cat file) = $txt
  mergetool: dissect strings with shell variable magic instead of `expr`
  mergetool: use shell variable magic instead of `awk`

 git-mergetool.sh     |  45 +++++--
 t/t7610-mergetool.sh | 309 +++++++++++++++++++++++++------------------
 2 files changed, 208 insertions(+), 146 deletions(-)

Range-diff against v1:
1:  75c812bd48 = 1:  75c812bd48 t7610-mergetool: do not place pipelines headed by `yes` in subshells
-:  ---------- > 2:  82bafc90de t7610-mergetool: use test_cmp instead of test $(cat file) = $txt
2:  2a33ca20af ! 3:  ad34a9a7ab mergetool: dissect strings with shell variable magic instead of `expr`
    @@ -4,7 +4,7 @@
     
         git-mergetool spawns an enormous amount of processes. For this reason,
         the test script, t7610, is exceptionally slow, in particular, on
    -    Windows. Most of the processes are invocations of git, but there are
    +    Windows. Most of the processes are invocations of git. There are
         also some that can be replaced with shell builtins. Do so with `expr`.
     
         Signed-off-by: Johannes Sixt <j6t@kdbg.org>
3:  d6675b0291 ! 4:  99a6a89339 mergetool: use shell variable magic instead of `awk`
    @@ -4,7 +4,7 @@
     
         git-mergetool spawns an enormous amount of processes. For this reason,
         the test script, t7610, is exceptionally slow, in particular, on
    -    Windows. Most of the processes are invocations of git, but there are
    +    Windows. Most of the processes are invocations of git. There are
         also some that can be replaced with shell builtins. Avoid repeated
         calls of `git ls-files` and `awk`.
     
-- 
2.21.0.285.gc38d92e052

