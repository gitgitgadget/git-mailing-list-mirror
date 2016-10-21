Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4329C20229
	for <e@80x24.org>; Fri, 21 Oct 2016 12:26:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932743AbcJUM0N (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Oct 2016 08:26:13 -0400
Received: from mout.gmx.net ([212.227.17.22]:56052 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932708AbcJUM0N (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Oct 2016 08:26:13 -0400
Received: from virtualbox ([37.24.142.40]) by mail.gmx.com (mrgmx101) with
 ESMTPSA (Nemesis) id 0LezI3-1cilof0WPn-00qm9c; Fri, 21 Oct 2016 14:26:06
 +0200
Date:   Fri, 21 Oct 2016 14:26:05 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH v5 21/27] sequencer: refactor write_message() to take a
 pointer/length
In-Reply-To: <cover.1477052405.git.johannes.schindelin@gmx.de>
Message-ID: <f4df322de90cfa5cb399ba6f471e33b27e09f4d7.1477052405.git.johannes.schindelin@gmx.de>
References: <cover.1476450940.git.johannes.schindelin@gmx.de> <cover.1477052405.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:lPJOcYwHANk6OOHmM9XFDZuKGnPTXP2olvnsMjPcanyCG5e4+4d
 hBo+wUeqDXjgzDV+vg1YHMfnmkzv/5LwYA9ohQ4wM3u8W2GeCprrIu/K0nvE33LmfyylIJV
 vPprLe7s56lwE+NFu++JFD1k1UllazKfCtwgH0w6Ol7gPM2ecXPqfjU7rPamXnZjBENKG/n
 SyDa8CcKHN6w/hZsRJFsQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:6MNHc9098s8=:eS34QwnMPpO/qkHHZIrgwg
 xXjTJA0hIBMYLtzaiLqhd9dP4FDfzs9SlsCJOrtPgg7LDSgp9i51VTdTPEU7YWPZDGgdeRvPx
 j+qWjJ+6Yx4yQmGXC0lr1Y4WpgYpUFPnK6AEWf0HToUv6prs+dzBpQ+fsZfEdzMDS8GG3dE3P
 HyAFV3HuFTJIKSasXknc8RhstR0phRZyBQINAFGWoDRyqmGh0IpLzElvbDJriXGBXoMdixkbl
 r8rX+GqyBLcP2tzg6sRE37G6ec1taPxCekG1uR/Y3JM+iDYtLbz7GlrBAvZe+oH//euAbsc/F
 RiTS5qJx8GvV3t7F3qqGkl05wF0ghA1hVIk9BgVyUes/ivoglT3ycu8Lbi3ra6cB+A2X7BwJW
 jQWRp+GgN5rCm5pH56Hao88LcQOEZeCRPx2os0hZFHQVbS0BXFiGCBC25+Oufv46D68ONKABR
 4Bm1u6bezWT4emLF5wp9AWmt0xXTq8oaNpY8SosC2YrWW1vhMXsXewZhc8jpOHy6txA3kGZqd
 +BSWQVYBB0VAHurdsXNeYJp/1FCweyYCW9Oh5u16asNx9oC4zd7TdMSkzQLmB7ViVy02AcgvS
 9L5cF27MiVzZqyhignlP4foW4Q258/1IlfhObOhvC33GTH3s28Orof0xpOjpJQre2vSMXHheF
 lvDfZ4abFq+A3wUe4G1B4Akgs4BVBv286TF+LBJdrUU4eONNbwNn6fr6o43y92Wy1NlCsqm23
 ppkRPz0mNA79XDaY3Mq5drRUfcUYVUaHtkyrkg8nrtGfrgUgri8xxs2WqGqzUxWailOh0bM2l
 5ABtu20
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Previously, we required an strbuf. But that limits the use case too much.
In the upcoming patch series (for which the current patch series prepares
the sequencer), we will want to write content to a file for which we have
a pointer and a length, not an strbuf.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 sequencer.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 9fced42..300952f 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -234,14 +234,14 @@ static void print_advice(int show_hint, struct replay_opts *opts)
 	}
 }
 
-static int write_message(struct strbuf *msgbuf, const char *filename)
+static int write_message(const void *buf, size_t len, const char *filename)
 {
 	static struct lock_file msg_file;
 
 	int msg_fd = hold_lock_file_for_update(&msg_file, filename, 0);
 	if (msg_fd < 0)
 		return error_errno(_("Could not lock '%s'"), filename);
-	if (write_in_full(msg_fd, msgbuf->buf, msgbuf->len) < 0) {
+	if (write_in_full(msg_fd, buf, len) < 0) {
 		rollback_lock_file(&msg_file);
 		return error_errno(_("Could not write to '%s'"), filename);
 	}
@@ -747,12 +747,14 @@ static int do_pick_commit(enum todo_command command, struct commit *commit,
 					 head, &msgbuf, opts);
 		if (res < 0)
 			return res;
-		res |= write_message(&msgbuf, git_path_merge_msg());
+		res |= write_message(msgbuf.buf, msgbuf.len,
+				     git_path_merge_msg());
 	} else {
 		struct commit_list *common = NULL;
 		struct commit_list *remotes = NULL;
 
-		res = write_message(&msgbuf, git_path_merge_msg());
+		res = write_message(msgbuf.buf, msgbuf.len,
+				    git_path_merge_msg());
 
 		commit_list_insert(base, &common);
 		commit_list_insert(next, &remotes);
-- 
2.10.1.583.g721a9e0


