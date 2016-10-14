Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8B47D1F4F8
	for <e@80x24.org>; Fri, 14 Oct 2016 13:19:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932669AbcJNNTB (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Oct 2016 09:19:01 -0400
Received: from mout.gmx.net ([212.227.15.18]:51903 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932335AbcJNNSf (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Oct 2016 09:18:35 -0400
Received: from virtualbox ([37.24.142.40]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0M7HGA-1crfBC3mg2-00x1PE; Fri, 14 Oct 2016 15:18:29
 +0200
Date:   Fri, 14 Oct 2016 15:18:28 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH v4 17/25] sequencer: support cleaning up commit messages
In-Reply-To: <cover.1476450940.git.johannes.schindelin@gmx.de>
Message-ID: <4173eb7716e8f4fbd083961a05dc4329686a9912.1476450940.git.johannes.schindelin@gmx.de>
References: <cover.1476120229.git.johannes.schindelin@gmx.de> <cover.1476450940.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:r3cxbDphM/g5sE64FOVLDD2lKUSBaxPsaCWe0J3GyvTy5ViEW9E
 x4skS+rguE4QN6u4HgYD4tKu4JwdyG3lTVyGxGpOU7RgH3g5wDF2/fkXZyqyitFWWbMBhzz
 Mow5LlI9438T2l1T8wqzo99JFSBwWDRGhrO+N2zGj5hyj2z6iorpRNMLZxDQztVjEZN94KK
 dZpC8LG/xyvppo/1u3MjQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:RlSYqzv0ALo=:BhwyqiwXBiiYzuCy+kUdgU
 JBp5zKRkLOduRixy1PyEnAHDojjFi7P0AvbrKLrjEwv2jQp778u18HVlOzyaFx7CcgpzM7wwz
 5j1kzh97TxYgcKP1boYRD15GuL236K/veAfa8bOYiTT9QBZtXCnBNuj8HSHmLNptROMeH6XH7
 U48Y8s7OmY56yHC/w2zj1OvnQzTYfkQTxKefnQTVBjSDWOugzENV6QOws7Dq56v6Li+igf2Jl
 X/wa0cDEln/JOu3GQQLEP7LzupclgjIcms8NZhJHBLFfM8G+wD/ID6nI1DYYcdU5OTXahEdtY
 GKNga1mtf5gjnpYrFwovAtYVGU7xYwu5oeh/y+x2P9pPZCD5tJwxZPdBb1BPxHgnz2PMTYK8i
 WuRYL1blp7XdOQB43WmrMSQ6q+DR7sa5I9GI7sde5yoNy9i6MHKUWhYaHQqgvbb1gtoFJshbq
 FbTwDyWH7w7e+unP4SkdB93hxlvT1dMZ4wVYiX2NqHf5Y85PkJJ1OxgTScVX7bbCxZPV1fPZH
 jSJK3SOsjNtrTlkCQ315N4FYZcvG7tfXLz0WdUd5LNqPEKO3nmK3d2cKB190ZsmS+P1b77oUe
 PP1KSn7nfkuVdJw/lt8tcWWcp3oJB1jHUzxAYFWU9t+Z0P669IS1zm9atLQh7E9DFmHIk+f0P
 TL7v890wrBuvgiI3KuihGZhc/lVn+o8IRiHUDe+cw0yDO7HUV5VNM3WZy2FA+zftDH3FsXxGv
 kszZpyTy4BA58HgiacuDcGHuWUfvx8eHIdBwaQSIUmutz48Kl47w5kxe6Yjspf+VbTHb/4ilv
 eil78P4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The run_git_commit() function already knows how to amend commits, and
with this new option, it can also clean up commit messages (i.e. strip
out commented lines). This is needed to implement rebase -i's 'fixup'
and 'squash' commands as sequencer commands.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 sequencer.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index fa77c82..cbc3742 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -481,7 +481,8 @@ static char **read_author_script(void)
  * author metadata.
  */
 static int run_git_commit(const char *defmsg, struct replay_opts *opts,
-			  int allow_empty, int edit, int amend)
+			  int allow_empty, int edit, int amend,
+			  int cleanup_commit_message)
 {
 	char **env = NULL;
 	struct argv_array array;
@@ -518,9 +519,12 @@ static int run_git_commit(const char *defmsg, struct replay_opts *opts,
 		argv_array_push(&array, "-s");
 	if (defmsg)
 		argv_array_pushl(&array, "-F", defmsg, NULL);
+	if (cleanup_commit_message)
+		argv_array_push(&array, "--cleanup=strip");
 	if (edit)
 		argv_array_push(&array, "-e");
-	else if (!opts->signoff && !opts->record_origin &&
+	else if (!cleanup_commit_message &&
+		 !opts->signoff && !opts->record_origin &&
 		 git_config_get_value("commit.cleanup", &value))
 		argv_array_push(&array, "--cleanup=verbatim");
 
@@ -785,7 +789,7 @@ static int do_pick_commit(enum todo_command command, struct commit *commit,
 	}
 	if (!opts->no_commit)
 		res = run_git_commit(opts->edit ? NULL : git_path_merge_msg(),
-				     opts, allow, opts->edit, 0);
+				     opts, allow, opts->edit, 0, 0);
 
 leave:
 	free_message(commit, &msg);
-- 
2.10.1.513.g00ef6dd


