Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CC2441F6BF
	for <e@80x24.org>; Fri,  9 Sep 2016 14:38:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753127AbcIIOh1 (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Sep 2016 10:37:27 -0400
Received: from mout.gmx.net ([212.227.17.20]:57872 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752989AbcIIOhN (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Sep 2016 10:37:13 -0400
Received: from virtualbox ([37.24.141.250]) by mail.gmx.com (mrgmx101) with
 ESMTPSA (Nemesis) id 0LnTjW-1b7OoP3A2I-00hfEZ; Fri, 09 Sep 2016 16:37:07
 +0200
Date:   Fri, 9 Sep 2016 16:37:05 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v3 03/17] sequencer: lib'ify write_message()
In-Reply-To: <cover.1473431645.git.johannes.schindelin@gmx.de>
Message-ID: <cdd0b6551b11171b4173ce4252078aa806f4a942.1473431645.git.johannes.schindelin@gmx.de>
References: <cover.1472219214.git.johannes.schindelin@gmx.de> <cover.1473431645.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:gxlcpPlzXjO1qGjaXyAWppMDW/+QlpLDE1f3pq1sBKZoCpEFhct
 TtjYiK7pnoBn54hwOk/2aQUx+h8bo020nSa8eNNMjDHHD3MmazXnEfyEtmTd/Xz8R5tG58d
 AaD3uaEgCmW0DpTgCCNFppKdBcMvIwa5KybXCSlaBmoq6UN6J8VDvxYc86aYCFBw4r16htB
 EeFJdP9BtumRC70qUP9QA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:31rM2CH7ThA=:ikATwL08SvYws0/ExMrYSm
 4nM5PthfAm6PF4kAcghM66eL/T0XCSeXHxc/wDowpjQiH6Kox4w+wvM9+ooCWoUsSwhm4hGUt
 /J2BgZ4MBMKuqM0d+QR6AKz5ezCmlwVbiTfbmSSUJAUJWajstaISL8EUVQzoWY881czwHqsWI
 i+fm6lx4nX6cSngaD2GCSfJXx8xlABfVtcfjcrKujR/bgUjERdddOZvLvddLBPWnPpiYlV9LU
 cxqYFvTIM9euMXdJ/8mh3LFcFM4mBX8vF5xrwaiuY2g7h60oRk6xhNhsgoiQzD9vbX/1WJhFH
 mpjThEtg1jGQCjqIfbnimCr+tSfwjLkiulSGTKHq4ey9KcNl29hco9nfwHsA8XxfUZkldwftg
 IrjRD5aeVreQBclOcwHejn67RtWJoS08jhVaaSn6rgoVq9PtVP4Q6AM38jeSx2cVkGdLjJzph
 f1q1ByFfZSFv/amWBPkUfO4OSaxGBvGrHHydMyUvovLXbBdv+gLXDaENer3GYFD9l0B+oe011
 T0kX79VWE65KqJNu5GAT78KKG0IKhywZ2N+eHoEFB7+mYMyPF7waGoTFK/oqqotw/6FFTKJZX
 VPDEJ92+P4pbC7R8av6Yv6f2+IiEUDniJn8zuGVCx4E2J+niIXIoYIxrb7tla2TlhzJd8VrCN
 W8dBJ9jmhroEk76XijwssEgKMRJdTMM/r7G0y2m8Q5TJdAFScfRl05Gl2Jp7xD5phjA3C4YYv
 WhK/CJfaLixqZrux2qncUpdfkm//zExm4mJjXAJ/Lry06Z4PdpL02zOUXz6q34K0sYnmv+TTy
 TMjK7PO
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Instead of dying there, let the caller high up in the callchain
notice the error and handle it (by dying, still).

The only caller of write_message(), do_pick_commit() already checks
the return value and passes it on to its callers, so its caller must
be already prepared to handle error returns, and with this step, we
make it notice an error return from this function.

So this is a safe conversion to make write_message() callable
from new callers that want it not to die, without changing the
external behaviour of anything existing.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 sequencer.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index baf6b40..ec85fe7 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -180,17 +180,20 @@ static void print_advice(int show_hint, struct replay_opts *opts)
 	}
 }
 
-static void write_message(struct strbuf *msgbuf, const char *filename)
+static int write_message(struct strbuf *msgbuf, const char *filename)
 {
 	static struct lock_file msg_file;
 
-	int msg_fd = hold_lock_file_for_update(&msg_file, filename,
-					       LOCK_DIE_ON_ERROR);
+	int msg_fd = hold_lock_file_for_update(&msg_file, filename, 0);
+	if (msg_fd < 0)
+		return error_errno(_("Could not lock '%s'"), filename);
 	if (write_in_full(msg_fd, msgbuf->buf, msgbuf->len) < 0)
-		die_errno(_("Could not write to %s"), filename);
+		return error_errno(_("Could not write to %s"), filename);
 	strbuf_release(msgbuf);
 	if (commit_lock_file(&msg_file) < 0)
-		die(_("Error wrapping up %s."), filename);
+		return error(_("Error wrapping up %s."), filename);
+
+	return 0;
 }
 
 static struct tree *empty_tree(void)
@@ -564,16 +567,16 @@ static int do_pick_commit(struct commit *commit, struct replay_opts *opts)
 					 head, &msgbuf, opts);
 		if (res < 0)
 			return res;
-		write_message(&msgbuf, git_path_merge_msg());
+		res |= write_message(&msgbuf, git_path_merge_msg());
 	} else {
 		struct commit_list *common = NULL;
 		struct commit_list *remotes = NULL;
 
-		write_message(&msgbuf, git_path_merge_msg());
+		res = write_message(&msgbuf, git_path_merge_msg());
 
 		commit_list_insert(base, &common);
 		commit_list_insert(next, &remotes);
-		res = try_merge_command(opts->strategy, opts->xopts_nr, opts->xopts,
+		res |= try_merge_command(opts->strategy, opts->xopts_nr, opts->xopts,
 					common, sha1_to_hex(head), remotes);
 		free_commit_list(common);
 		free_commit_list(remotes);
-- 
2.10.0.windows.1.10.g803177d


