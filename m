Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B813F1FD99
	for <e@80x24.org>; Tue, 23 Aug 2016 16:14:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753319AbcHWQOC (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Aug 2016 12:14:02 -0400
Received: from mout.gmx.net ([212.227.15.19]:52608 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752958AbcHWQOA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Aug 2016 12:14:00 -0400
Received: from virtualbox ([37.24.141.250]) by mail.gmx.com (mrgmx002) with
 ESMTPSA (Nemesis) id 0MSv6D-1bk63s0UGD-00Ro7p; Tue, 23 Aug 2016 18:07:09
 +0200
Date:   Tue, 23 Aug 2016 18:07:08 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 05/15] sequencer: lib'ify read_and_refresh_cache()
In-Reply-To: <cover.1471968378.git.johannes.schindelin@gmx.de>
Message-ID: <131eea01901cc3c366bad2098f6abe8738922d58.1471968378.git.johannes.schindelin@gmx.de>
References: <cover.1471968378.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:musLMkaUqlc75nS2t2NU6GdXzXvzyovK92y/F4FCkdUUHL406kd
 5wQtHW4DJm0V1DFWbioZBpcifjj5FD24NhB9qP91+FTl9H3GI870Db9OniWEu/Gw5dbveDm
 EHEzWu4hLN8nK8ijqYBVff/qAbnJrwKYld1HsnxsCg4qqlRwdh8glG/WBh1DJX/TXte0gBo
 eIVg5wSFnWihSuT8oUbQw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:o/XfvIUFFMI=:VzGopjU1bxlLHUQ+Odn+cw
 hzprR54eQy2SwXAVx7mHijpE6zKxup8ySSUtbItx7mhvb2ZtJsnYITKsVjy20bl9RGlLUPuFS
 XMq12IF83jQUMKyOgS7CmKFOfTemA/GcsLgWKNIiJTJO+lCQj5RcD+6vdxQ3voirxjs0VgXrM
 FEqbe3pcNKYUf1eLFGVT55UlRXUD+ZmjG5GNZuOn0qGZ15RvTUqvKbPx24PMurqOu6UpUhU57
 Fn8zwlEKFKC+dNKRvFEkuzxORFaIiSMVdNxDT9yTDL5sn4rkYmUX3HWhuWzSuAuRu7233MfdR
 /ya/wvaFF+vN6OBNkNqTAnwbcsDp0kbb1V+0PXcfO7l+L3chUAftUF2Lhrn9J8NVN4fc6lAvD
 PdAZ7lyRFTLK8zD02zDI8JiYt5OiybJM6hOA5w1Ar4nKliTfoUCUPmwq3AQiB9xRV0xrQOEOk
 WNqG/F6rS83y6GTdx6knfiJzmstQ2CZW/guDI1EfptOX1405EuIpqMStjnb38AYWhQVMSalwg
 EFgIQLE27/Pn7FwwdW6Q+7J0VxXeeU2fxHgksiiOAZ6qYuHentoDqgnfR3PFsELccVRAhZStV
 ACLA4KwsEVPsZQYSjWq0kySolK7cIjZGEOwN0FanIYyycLdoyGjFxKhC1AVJ2mI7FuoxtRdck
 5QuNl4ztca6VdJZPRItyoAWVYRoE/UFcGja7ARfoGLpCJO7ulAJjLwoB4e/275iygVeBV4pe8
 hHKR+sIZZkg31F4WuLwUpjuBUZj8GJGVoZq7/Y0kmUnwc+lftmHdwBL78LXLHeTnnQM1OrAET
 L8DfCVm
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

To be truly useful, the sequencer should never die() but always return
an error.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 sequencer.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index b90294f..a8c3a48 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -638,18 +638,21 @@ static int prepare_revs(struct replay_opts *opts)
 	return 0;
 }
 
-static void read_and_refresh_cache(struct replay_opts *opts)
+static int read_and_refresh_cache(struct replay_opts *opts)
 {
 	static struct lock_file index_lock;
 	int index_fd = hold_locked_index(&index_lock, 0);
 	if (read_index_preload(&the_index, NULL) < 0)
-		die(_("git %s: failed to read the index"), action_name(opts));
+		return error(_("git %s: failed to read the index"),
+			action_name(opts));
 	refresh_index(&the_index, REFRESH_QUIET|REFRESH_UNMERGED, NULL, NULL, NULL);
 	if (the_index.cache_changed && index_fd >= 0) {
 		if (write_locked_index(&the_index, &index_lock, COMMIT_LOCK))
-			die(_("git %s: failed to refresh the index"), action_name(opts));
+			return error(_("git %s: failed to refresh the index"),
+				action_name(opts));
 	}
 	rollback_lock_file(&index_lock);
+	return 0;
 }
 
 static int format_todo(struct strbuf *buf, struct commit_list *todo_list,
@@ -977,7 +980,8 @@ static int pick_commits(struct commit_list *todo_list, struct replay_opts *opts)
 	if (opts->allow_ff)
 		assert(!(opts->signoff || opts->no_commit ||
 				opts->record_origin || opts->edit));
-	read_and_refresh_cache(opts);
+	if (read_and_refresh_cache(opts))
+		return -1;
 
 	for (cur = todo_list; cur; cur = cur->next) {
 		save_todo(cur, opts);
@@ -1041,7 +1045,8 @@ int sequencer_pick_revisions(struct replay_opts *opts)
 	if (opts->subcommand == REPLAY_NONE)
 		assert(opts->revs);
 
-	read_and_refresh_cache(opts);
+	if (read_and_refresh_cache(opts))
+		return -1;
 
 	/*
 	 * Decide what to do depending on the arguments; a fresh
-- 
2.10.0.rc1.99.gcd66998


