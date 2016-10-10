Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1B446209B4
	for <e@80x24.org>; Mon, 10 Oct 2016 17:26:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753335AbcJJR0R (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Oct 2016 13:26:17 -0400
Received: from mout.gmx.net ([212.227.17.21]:55888 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752636AbcJJR0Q (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Oct 2016 13:26:16 -0400
Received: from virtualbox ([37.24.142.40]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0MRjd7-1bQjU23meH-00Sy5w; Mon, 10 Oct 2016 19:26:12
 +0200
Date:   Mon, 10 Oct 2016 19:26:11 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH v3 17/25] sequencer: support cleaning up commit messages
In-Reply-To: <cover.1476120229.git.johannes.schindelin@gmx.de>
Message-ID: <a0e8254fef108586d3c7a660861b5b1ae8d6e788.1476120229.git.johannes.schindelin@gmx.de>
References: <cover.1473590966.git.johannes.schindelin@gmx.de> <cover.1476120229.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:EXoRod68K8pHw1bVer6x3zWIVUKVgVGeJ+i0iAjXeq6J6EX/psf
 Ny5YI7f84BA3+tgS3qxG5nXQK1PDDTWfuzxCHkK6iI0rPUdwr+kSdekU81mZgDvdCJDLW0n
 n49HUEtLjLly2UoHlxNiUfSlYI3dmOgTfoLIIfswRSuRIm4QdyqvZTzZeUIsGuopVAp7J3y
 fw2KX7xzTM9Mnq96zZjoA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:d+s6z5M1YEI=:ubza/B/OeAmKrFMNTxIdBd
 YREpGwFhCh+3Z8an0dAJZ/TEufOz1uS92uzxAxwnFclTxevWXAfbf8mLWC4dj9qgOwlGxaNL0
 zGKT04T9qjYWf6/85kVnfogXCOLEFHayGw6jcFgNH16p+PojZuopb/3lucBOeq/faDb61wMAK
 0SoEyXHKf4/NnD3VDFHddpm+OenfzXd/lhbnC79luQFftwnpRNRiQE8uUwduNLx2bmEMneubb
 oXgssk21CxKiSPnc0pbc/VCex4DPCDMoSAGe5Bko7O1Y68UOTZ4rSsTg01IvPSb0zvZMzkuFY
 IaRnTfxzOXB5/JwyYxm0JaFZWKiJDir25+ZD9FkGFeFwjHVr5SoWHFRKttGl1OHrPHr12fYzw
 H4HYhKiZY7SLXbGDLKV5dZ2QRONOnAze8FGbw0Fyi+5Shf3vIT/92Fwc0xbsF1Z2Mp2h/FvZh
 tVHY2J0BJqt4kMBXh5cNC48wVHqKdVwgzHkqZ+QT8pxWgA6gK/M7LbgQRAMjWc730gWKEVUEa
 nrnZ0V2n3efi5oGu8T5jArJx7XioGi1dXgzbEsXe4XFLJqzmJRLmrPDlN1tfOG25b0DGLu6vJ
 0Bab29pMFOlbU8K+Wj7Y3oSA02f8EwoPd4lGVqvnllM6RRgWXKDVnmS4f+X8pngWji6hJu8GC
 FZvYqeyJHtVKtITjQdZ93UZ0j+QhVbiLG0Bv4EhYDlrHQVXjczWsrM6qzJkurx/X5jNKQRwkS
 GCyDmJRDIVx78prtqhzwZZlMXEI6bZLKa278uHFZlBiL92uH4TwprqmuT85iBnmZPgCAtMeYN
 jD4I2lY
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
index 403a4f0..108bca8 100644
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
 
@@ -787,7 +791,7 @@ static int do_pick_commit(enum todo_command command, struct commit *commit,
 	}
 	if (!opts->no_commit)
 		res = run_git_commit(opts->edit ? NULL : git_path_merge_msg(),
-				     opts, allow, opts->edit, 0);
+				     opts, allow, opts->edit, 0, 0);
 
 leave:
 	free_message(commit, &msg);
-- 
2.10.0.windows.1.325.ge6089c1


