Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1EE5D1FADF
	for <e@80x24.org>; Thu, 18 Jan 2018 15:35:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932662AbeARPfm (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 Jan 2018 10:35:42 -0500
Received: from mout.gmx.net ([212.227.15.19]:54196 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932640AbeARPfi (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Jan 2018 10:35:38 -0500
Received: from [10.122.129.233] ([46.142.197.184]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MA9Yv-1eVpVv0PNp-00BOAI; Thu, 18
 Jan 2018 16:35:34 +0100
Date:   Thu, 18 Jan 2018 16:35:34 +0100 (STD)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        Jacob Keller <jacob.keller@gmail.com>
Subject: [PATCH 3/8] sequencer: fast-forward merge commits, if possible
In-Reply-To: <cover.1516225925.git.johannes.schindelin@gmx.de>
Message-ID: <9878bd57cc82daf08309943305460c1e8a050518.1516225925.git.johannes.schindelin@gmx.de>
References: <cover.1516225925.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:kjL5xEEhGIYL4Q3kSDqnRCB19R5xpKEa+hmbaRC7jqZReT9Uq/B
 MZCB70N7EBIN0lNd9qpF3GmRCFHkrjg2Wt1wUR+Kg6NxAo+WDZ3REdrKFd4exyygquTvYdk
 C3mNcvPLxneQJJy3/TmaIfyvYJS4I4ROF0LycoQTzuZPMA2DXxtsjeDcjGqsavPY4Qrb53A
 Tj3rk3T/LwRSK0G5qNlkA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:+cQZwjnjcpE=:0HCyivH4xgGP8q5G5h5OIg
 PtJx/fFQY3IbUqGRZRMorJYpiY//R+82UE8YdTFEmZHwtDrKyQ/vbD8CpNnku2wxrbSOZqJTZ
 eoMk2KiW4egHvwCGOqXhfMeSH3v/y33xaF05KMB1fYIpVJqULdf4E5P7YM3Xp1Uzc84ypR+ws
 8Ter3f0uN3J2x4HWsBdS4CbNtv5GhvsmgpeIGcY5Hp0TNSrsslrSg8EDdiBQ8JJFNs1ob6S01
 oRKTp9hN6AlT1t3w0LElMQodeYNurt940ZzTPjki027urNqn79DdiwJPiwktVR//UT6hJ3JyT
 LsGPjWAfZJIkl0Ai04aaaaGHwhxpQ9O7lfRFIhbmAh0ynRRk1JftZzN/4RXigXC35L4qZmvlx
 Lzz5JIqKLXwzvJ3omtNJlmB8naYFVx/ggKR3H+pKPXFdNwD8DeWAhkbSYKnnCuwrLljTXsqC5
 b3qr9JhNRDx9vAKhZPIh0XZQWf0Li3HZ/2NJIY4M/so8hlpdts03F7trKH6C884mjtk2vHi3y
 DjzygmiSPejRzS+sqvqDBCHe7XiItZZ2fqoeiW7KE8MUsJbLDIm7wMQgkEg3lvcKFE6aQH7pc
 B+2nHDMh0P/xU7hVMC98mN/pYAdcJ/pQ7VPIBlLwOhD+Fliqsb3d1Ev3Nom0kmXC186/jdNHU
 Yvgm9LxsuUgcoCJFxXdh+mC/MbPCxBBxTQOuGWbf50r8Ly11OwRwRsr3vdcZr943GggmOJXFd
 MwhdS9heQ3Z0wm2PF4uzAo7i+DmqEbS09V0XAvrRLfxzHly1CwPWtvgP8qdpIWT39C12AgkWY
 Gy1mvT4LX+4gyWu3VLFgN5nTVO9IGndh66H3PlBH0i7C+tYCaw=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Just like with regular `pick` commands, if we are trying to recreate a
merge commit, we now test whether the parents of said commit match HEAD
and the commits to be merged, and fast-forward if possible.

This is not only faster, but also avoids unnecessary proliferation of
new objects.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 sequencer.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/sequencer.c b/sequencer.c
index 567cfcbbe8b..a96255426e7 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -2085,7 +2085,7 @@ static int do_merge(struct commit *commit, const char *arg, int arg_len,
 	struct commit *head_commit, *merge_commit, *i;
 	struct commit_list *common, *j, *reversed = NULL;
 	struct merge_options o;
-	int ret;
+	int can_fast_forward, ret;
 	static struct lock_file lock;
 
 	for (merge_arg_len = 0; merge_arg_len < arg_len; merge_arg_len++)
@@ -2151,6 +2151,14 @@ static int do_merge(struct commit *commit, const char *arg, int arg_len,
 		return error(_("Cannot merge without a current revision"));
 	}
 
+	/*
+	 * If HEAD is not identical to the parent of the original merge commit,
+	 * we cannot fast-forward.
+	 */
+	can_fast_forward = commit && commit->parents &&
+		!oidcmp(&commit->parents->item->object.oid,
+			&head_commit->object.oid);
+
 	strbuf_addf(&ref_name, "refs/rewritten/%.*s", merge_arg_len, arg);
 	merge_commit = lookup_commit_reference_by_name(ref_name.buf);
 	if (!merge_commit) {
@@ -2164,6 +2172,17 @@ static int do_merge(struct commit *commit, const char *arg, int arg_len,
 		rollback_lock_file(&lock);
 		return -1;
 	}
+
+	if (can_fast_forward && commit->parents->next &&
+	    !commit->parents->next->next &&
+	    !oidcmp(&commit->parents->next->item->object.oid,
+		    &merge_commit->object.oid)) {
+		strbuf_release(&ref_name);
+		rollback_lock_file(&lock);
+		return fast_forward_to(&commit->object.oid,
+				       &head_commit->object.oid, 0, opts);
+	}
+
 	write_message(oid_to_hex(&merge_commit->object.oid), GIT_SHA1_HEXSZ,
 		      git_path_merge_head(), 0);
 	write_message("no-ff", 5, git_path_merge_mode(), 0);
-- 
2.15.1.windows.2.1430.ga56c4f9e2a9


