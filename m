Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4EC631F915
	for <e@80x24.org>; Sat, 14 Jul 2018 00:35:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731560AbeGNAwN (ORCPT <rfc822;e@80x24.org>);
        Fri, 13 Jul 2018 20:52:13 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:57566 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729658AbeGNAwN (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 13 Jul 2018 20:52:13 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:5996:38d5:9b31:ef84])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id D767B60102;
        Sat, 14 Jul 2018 00:35:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1531528513;
        bh=UqFl9FECYSiLrh0YIAoCWSHa1cHmJnCjlqKysKn55rA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
         Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
         In-Reply-To:References:Content-Type:Content-Disposition;
        b=hHKtdAdHXWfAL7XprCCrkOBYsKU8cNcETrQdQvaUcK64cULYxLXqyTlBjgDEx/qnQ
         FTs4Bx8izpkswMsmtAW9KGZ1K8BGfBmgVHjvpCZAAR61ycDVSsXbcwfuKaacXfGFxY
         Pgxih95M+kBHvM9LniBeO+B3mEpqL+KoGNWlrIOOxSH0y+cYeJwYbaODnvyml4SAHq
         65i0Zqdl0HKjYiENLtHlu15POalap+5eK1awnodPoS9QjuUL38GsWaUsPrg4A3uB/n
         i/AA92TUNcxMLO/hCdhrzOCndIT9CB7fvFted3Y7FdwKAJg1wInSab6dYyvr3aZbhj
         7Q7slc3skxjgOmoN+m1GFrSsQE7uTKnCdtNFcMRKrMvvyCSwqX+1KOluZNb1n4LoyB
         Cz0YWz23XyPZKOrUi09+UXmQDHpRRKH3c8qVIKplLesGynztKMaKT3THP33LSxz0J1
         5cdMBv20xgrrK05D5z1iLYfsD/qUugdDH3mZTlwk7x4q9AWlaIT
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Cc:     Jacob Keller <jacob.keller@gmail.com>, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Vitali Lovich <vlovich@gmail.com>
Subject: [PATCH] sequencer: pass absolute GIT_WORK_TREE to exec commands
Date:   Sat, 14 Jul 2018 00:35:05 +0000
Message-Id: <20180714003505.67650-1-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.18.0.399.gad0ab374a1
In-Reply-To: <20180713230548.GC1042117@genre.crustytoothpaste.net>
References: <20180713230548.GC1042117@genre.crustytoothpaste.net>
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

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
Dscho, is this test going to cause a problem on Windows with the forward
slash in the grep statement?

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
