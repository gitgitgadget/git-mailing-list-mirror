Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6FBFD2042F
	for <e@80x24.org>; Tue, 13 Dec 2016 15:32:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934062AbcLMPbz (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Dec 2016 10:31:55 -0500
Received: from mout.gmx.net ([212.227.15.15]:52912 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933753AbcLMPbq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Dec 2016 10:31:46 -0500
Received: from virtualbox ([37.24.141.236]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0Ln7wj-1cpJz43uJx-00hJpn; Tue, 13
 Dec 2016 16:30:44 +0100
Date:   Tue, 13 Dec 2016 16:30:42 +0100 (CET)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>, Kevin Daudt <me@ikke.info>,
        Dennis Kaarsemaker <dennis@kaarsemaker.net>
Subject: [PATCH v2 12/34] sequencer (rebase -i): skip some revert/cherry-pick
 specific code path
In-Reply-To: <cover.1481642927.git.johannes.schindelin@gmx.de>
Message-ID: <09d0f53cf310c6a81ac6ffabe90f45aeeec39d9b.1481642927.git.johannes.schindelin@gmx.de>
References: <cover.1472633606.git.johannes.schindelin@gmx.de> <cover.1481642927.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:4GGc35FezXQG1gWBbP6xh3DASEbzY6bEZ1wF4B/VYv4ZiyUIYw3
 3uAy2K+dv80HEiXiauRACg6FhXI22CaiH37LlhxVXqkxQcmum4ErFnijEQOO11WvDd57xT/
 ILGegnA0//zK+mU2UiQgp7tfbfn2aeyIciB8DaPWkCYgOTugAUXgfjEB8SHRDFjAcQtnJHC
 Rj5cMw5FpHGm9xUtYJCvA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:+mfp1m4BbK4=:V4qknWEWnsk4ab7EDdhIb8
 OeTdIUYGyHHlE4u9glDKceRBBarYkr5Zkn17tZxGX/6lmwRm8vzHrHa//DS9HNPAWYC3xDnqj
 6yKY2ndX6a0hZMdRJDDrmmltUxW7G2bvvu04NEyJPXcvC3+cMVI9cHR4roqN/3RQf0ha30sQP
 HRIDbyEqCjR4Yee6ZCi0ekf1GP83O7okX11AE6k7WXwjtFD1lFaRnFku8ItTZzFuGu0iaBVue
 a21EPCE83G7HLc/utIVzqL3KNfCVa69c+VyU+z/x605siGVrGcm3axOBKT+9HHwFWn+BtZZCg
 TSQhp6Eaau9qQ/Lam15rBOho/qX6BC/v4QtWkU+PlN9fFPG05p9V+qx42pOseNxjirCHPdaxy
 dBnT9VFbz8HVCKgsJcDPhYkUH/Mt9+M2Z6QiLrRiXXfY1vFqHfl5XLVLhYJ4L+IL1nJqL9G46
 RAxIsIbqcygDdzDfqVOLnAGoNTcauV0xP5B5GCPjo4RsKObgH973PtW6EYGdFsaygNWzTsbnh
 6leovejCgt9r2BO1XdF6V1iwAtz4EqbH/ln+Zk99nlfI6Xoz7AXPmBcNqpvrYbc976sQLMRBB
 RDMW0K4MXFQcdiONL9lxxQajoFn3B5ZHXSzL+O1POKp9/O3YfClCwVDFf9UiOS0NIG6VxzFmM
 VN3gwL4oyYCmGd5/JNX3ylJ91Q42I/CzZ5IBNemmN0jqiipc5zVXIClIHzpT8eDF3W5jXqcEx
 kTvSMtimhYed2ZSAP1cShCBPMtfSy7rLak2b0iQJQwfx5Iv20fT1Dn9K7/DLJp6xqnjWKdSbI
 vwqRbQb
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When a cherry-pick continues without a "todo script", the intention is
simply to pick a single commit.

However, when an interactive rebase is continued without a "todo
script", it means that the last command has been completed and that we
now need to clean up.

This commit guards the revert/cherry-pick specific steps so that they
are not executed in rebase -i mode.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 sequencer.c | 25 ++++++++++++++-----------
 1 file changed, 14 insertions(+), 11 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index abffaf3b40..4ceb6f3ac5 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -1882,25 +1882,28 @@ int sequencer_continue(struct replay_opts *opts)
 		if (commit_staged_changes(opts))
 			return -1;
 	}
-	if (!file_exists(get_todo_path(opts)))
+	else if (!file_exists(get_todo_path(opts)))
 		return continue_single_pick();
 	if (read_populate_opts(opts))
 		return -1;
 	if ((res = read_populate_todo(&todo_list, opts)))
 		goto release_todo_list;
 
-	/* Verify that the conflict has been resolved */
-	if (file_exists(git_path_cherry_pick_head()) ||
-	    file_exists(git_path_revert_head())) {
-		res = continue_single_pick();
-		if (res)
+	if (!is_rebase_i(opts)) {
+		/* Verify that the conflict has been resolved */
+		if (file_exists(git_path_cherry_pick_head()) ||
+		    file_exists(git_path_revert_head())) {
+			res = continue_single_pick();
+			if (res)
+				goto release_todo_list;
+		}
+		if (index_differs_from("HEAD", 0, 0)) {
+			res = error_dirty_index(opts);
 			goto release_todo_list;
+		}
+		todo_list.current++;
 	}
-	if (index_differs_from("HEAD", 0, 0)) {
-		res = error_dirty_index(opts);
-		goto release_todo_list;
-	}
-	todo_list.current++;
+
 	res = pick_commits(&todo_list, opts);
 release_todo_list:
 	todo_list_release(&todo_list);
-- 
2.11.0.rc3.windows.1


