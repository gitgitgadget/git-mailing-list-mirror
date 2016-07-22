Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 28591203E2
	for <e@80x24.org>; Fri, 22 Jul 2016 19:15:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751767AbcGVTPn (ORCPT <rfc822;e@80x24.org>);
	Fri, 22 Jul 2016 15:15:43 -0400
Received: from bsmtp3.bon.at ([213.33.87.17]:63999 "EHLO bsmtp3.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750989AbcGVTPm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Jul 2016 15:15:42 -0400
Received: from dx.site (unknown [93.83.142.38])
	by bsmtp3.bon.at (Postfix) with ESMTPSA id 3rx0jS2HFsz5tlF;
	Fri, 22 Jul 2016 21:15:40 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.site (Postfix) with ESMTP id E40B252DC;
	Fri, 22 Jul 2016 21:15:39 +0200 (CEST)
Subject: [PATCH 2/2] submodule-helper: fix indexing in clone retry error
 reporting path
To:	Stefan Beller <sbeller@google.com>
References: <8c0e116b-b604-ee83-197a-538eedf6e0ea@kdbg.org>
Cc:	Git Mailing List <git@vger.kernel.org>,
	Jens Lehmann <Jens.Lehmann@web.de>
From:	Johannes Sixt <j6t@kdbg.org>
Message-ID: <4d40da99-2f66-a380-840f-1828dc5b9324@kdbg.org>
Date:	Fri, 22 Jul 2016 21:15:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.2
MIME-Version: 1.0
In-Reply-To: <8c0e116b-b604-ee83-197a-538eedf6e0ea@kdbg.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

'git submodule--helper update-clone' has logic to retry failed clones
a second time. For this purpose, there is a list of submodules to clone,
and a second list that is filled with the submodules to retry. Within
these lists, the submodules are identified by an index as if both lists
were just appended.

This works nicely except when the second clone attempt fails as well. To
report an error, the identifying index must be adjusted by an offset so
that it can be used as an index into the second list. However, the
calculation uses the logical total length of the lists so that the result
always points one past the end of the second list.

Pick the correct index.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 builtin/submodule--helper.c | 2 +-
 t/t5815-submodule-protos.sh | 4 ++--
 t/t7400-submodule-basic.sh  | 4 ++--
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index b22352b..6f6d67a 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -795,7 +795,7 @@ static int update_clone_task_finished(int result,
 		suc->failed_clones[suc->failed_clones_nr++] = ce;
 		return 0;
 	} else {
-		idx = suc->current - suc->list.nr;
+		idx -= suc->list.nr;
 		ce  = suc->failed_clones[idx];
 		strbuf_addf(err, _("Failed to clone '%s' a second time, aborting"),
 			    ce->name);
diff --git a/t/t5815-submodule-protos.sh b/t/t5815-submodule-protos.sh
index 112cf40..06f55a1 100755
--- a/t/t5815-submodule-protos.sh
+++ b/t/t5815-submodule-protos.sh
@@ -18,7 +18,7 @@ test_expect_success 'setup repository with submodules' '
 	git commit -m "add submodules"
 '
 
-test_expect_failure 'clone with recurse-submodules fails' '
+test_expect_success 'clone with recurse-submodules fails' '
 	test_must_fail git clone --recurse-submodules . dst
 '
 
@@ -32,7 +32,7 @@ test_expect_success 'update of ssh allowed' '
 	git -C dst submodule update ssh-module
 '
 
-test_expect_failure 'update of ext not allowed' '
+test_expect_success 'update of ext not allowed' '
 	test_must_fail git -C dst submodule update ext-module
 '
 
diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
index 7c8b90b..b77cce8 100755
--- a/t/t7400-submodule-basic.sh
+++ b/t/t7400-submodule-basic.sh
@@ -352,7 +352,7 @@ test_expect_success 'sync should fail with unknown submodule' '
 	test_failure_with_unknown_submodule sync
 '
 
-test_expect_failure 'update should fail when path is used by a file' '
+test_expect_success 'update should fail when path is used by a file' '
 	echo hello >expect &&
 
 	echo "hello" >init &&
@@ -361,7 +361,7 @@ test_expect_failure 'update should fail when path is used by a file' '
 	test_cmp expect init
 '
 
-test_expect_failure 'update should fail when path is used by a nonempty directory' '
+test_expect_success 'update should fail when path is used by a nonempty directory' '
 	echo hello >expect &&
 
 	rm -fr init &&
-- 
2.9.0.443.ga8520ad

