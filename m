Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 930631F915
	for <e@80x24.org>; Sat, 14 Jul 2018 18:39:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729629AbeGNS7D (ORCPT <rfc822;e@80x24.org>);
        Sat, 14 Jul 2018 14:59:03 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:58088 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726960AbeGNS7D (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 14 Jul 2018 14:59:03 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:5996:38d5:9b31:ef84])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 7E17A6047B;
        Sat, 14 Jul 2018 18:39:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1531593546;
        bh=+SHDIPkf83xxWVe9pJvRtTParnCz3ZpYS9WspTX5EJQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=OHMEklh9Xz+za0n1J9ATiluNrLpSDjr06ys0s0Y/sDSYK4xX+ic91Bs7o5B37Copd
         +b8k83Kmx7o+5DLtklM6ZQmHzCaPKPfu/VaWStHDe6GUqkIR+JSS0gNoND4eLAmcDq
         t0fFA2unMRcjx/yrJ81guJxwI/fXv+kAZTSRHJ4cTHEThUEvpHU/EnzPkyuK74w7xe
         01RH/arKFPGjDHxLjByf0/RBf3iQlpsR2xbfCX9CDdr/GTDWP+EIoVlmF0Ah1YlPIk
         QUj9+ufld5vyPPGBly2/p94hsg56ay/gZ+pxPMJjayFTBI6Y752QLtqFijv5PU3rAy
         walpLzfJ97+wjPA7bV8B2XJqzjkcIdAE/ifZctWH68pK2IA8U5Nr2b40N1WjfFaG3g
         3lu4u/F6+urtFPqSZke3t2WHMapvxqa6p4BQlzZVcMKUl6IWlQPHefIteUYXLFS8Dq
         esjNveMoLEUw4cotbRERwu17esLz1w7sJKK+TJj9PRM9LeBhzct
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Jacob Keller <jacob.keller@gmail.com>, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Vitali Lovich <vlovich@gmail.com>
Subject: [PATCH v2] sequencer: pass absolute GIT_WORK_TREE to exec commands
Date:   Sat, 14 Jul 2018 18:38:59 +0000
Message-Id: <20180714183859.97988-1-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.18.0.399.gad0ab374a1
In-Reply-To: <20180714175555.GD1042117@genre.crustytoothpaste.net>
References: <20180714175555.GD1042117@genre.crustytoothpaste.net>
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The sequencer currently passes GIT_DIR, but not GIT_WORK_TREE, to exec
commands.  In that configuration, we assume that whatever directory
we're in is the top level of the work tree, and git rev-parse
--show-toplevel responds accordingly.  However, when we're in a
subdirectory, that isn't correct: we respond with the subdirectory as
the top level, resulting in unexpected behavior.

Ensure that we pass GIT_WORK_TREE as well as GIT_DIR so that git
operations within subdirectories work correctly.

Note that we are guaranteed to have a work tree in this case: the
relevant sequencer functions are called only from revert, cherry-pick,
and rebase--helper; all of these commands require a working tree.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 sequencer.c                   | 2 ++
 t/t3404-rebase-interactive.sh | 9 +++++++++
 2 files changed, 11 insertions(+)

diff --git a/sequencer.c b/sequencer.c
index 5354d4d51e..c8e16f9168 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -2636,6 +2636,8 @@ static int do_exec(const char *command_line)
 	fprintf(stderr, "Executing: %s\n", command_line);
 	child_argv[0] = command_line;
 	argv_array_pushf(&child_env, "GIT_DIR=%s", absolute_path(get_git_dir()));
+	argv_array_pushf(&child_env, "GIT_WORK_TREE=%s",
+			 absolute_path(get_git_work_tree()));
 	status = run_command_v_opt_cd_env(child_argv, RUN_USING_SHELL, NULL,
 					  child_env.argv);
 
diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index 352a52e59d..d03055d149 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -119,6 +119,15 @@ test_expect_success 'rebase -i with exec allows git commands in subdirs' '
 	)
 '
 
+test_expect_success 'rebase -i sets work tree properly' '
+	test_when_finished "rm -rf subdir" &&
+	test_when_finished "test_might_fail git rebase --abort" &&
+	mkdir subdir &&
+	git rebase -x "(cd subdir && git rev-parse --show-toplevel)" HEAD^ \
+		>actual &&
+	! grep "/subdir$" actual
+'
+
 test_expect_success 'rebase -i with the exec command checks tree cleanness' '
 	git checkout master &&
 	set_fake_editor &&
