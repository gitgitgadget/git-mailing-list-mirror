Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DFA211F6BF
	for <e@80x24.org>; Fri,  9 Sep 2016 14:38:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753312AbcIIOi0 (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Sep 2016 10:38:26 -0400
Received: from mout.gmx.net ([212.227.17.22]:58943 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753285AbcIIOiV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Sep 2016 10:38:21 -0400
Received: from virtualbox ([37.24.141.250]) by mail.gmx.com (mrgmx101) with
 ESMTPSA (Nemesis) id 0MbKXI-1bRnzn1ETE-00IipI; Fri, 09 Sep 2016 16:38:15
 +0200
Date:   Fri, 9 Sep 2016 16:38:00 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v3 16/17] lib'ify checkout_fast_forward_to()
In-Reply-To: <cover.1473431645.git.johannes.schindelin@gmx.de>
Message-ID: <f624be21280cb2f7624ed7bb4d890903cccf1c7d.1473431645.git.johannes.schindelin@gmx.de>
References: <cover.1472219214.git.johannes.schindelin@gmx.de> <cover.1473431645.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:WyujOWrOf1F4OGc6TXeAipS8AW3GJh6H3CG7BLZA/aBk3VK2Oni
 HyAJ12/2oYkJPLFmECdOGWkXV9lkx2YJrEcveYp6+yhso+AucyvD+p/Rxc31gFpaIPKR3yS
 VDc3kBp+pUFt8jhe8+tPMFRsOetkvW4govesjM7MXdnNLSTynp96FU3py1Kdvso2vjvbftQ
 Alb57A0eZbhtWeBKacDzw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:6bEddmysGdg=:ht0GfA/5gUrwD8/XUnvTl0
 nIvgjUvEgw8BPfQ90Af8TAEp09+0wdp3Y5c6gxzMF/WVf7ssQZg1NE7D8NCwAwHoIBRqm2R2C
 Ck4AsVhZzrevTJ7dblWj5RNIahm4i3lTgtn5957mHQIZiGal5NYBKzzgZ9sgS+MwXvS7y3Et5
 fEskNPzwbZkJb6YuSkcjVoU2L8/PT5xG8TzOpo57Ccj7xM+Dyx4ehEkp+JObQEPLUvbgy+7Cw
 eq4xcu4a1Hl066cBiOqgXP+NvJ76tr2NdjVBvVieVzirrQXzeZ/sRddNz+JVvV81FzcfoyaY5
 xbkoiaa3Kr05T2fV5CvJ/o+YTGgD96+x4DP9YgimZE5A1rwsHNyMQ8GIk/lQZCYw0WUWRWRO+
 eJvdHhu3J9pyi4nHftWcl8HxGKy/bizgaMZPog/P8exV/0qUM5+0ebAYjNre0ChRyerMTO2mp
 Ask6+5edTvNzKdhh6Y4oXoQUN+VtYDCGBK5rVs85pNBbqyRBfXq/RLHDRji//PUEKvkizTYng
 zqQKqlCanr6S9wmjgz6CrxLd2L8oqi/dHepumaXZKUDM1OsYh6Vz2+u3vyyhH6hlHFlOqj9Je
 LVBlut2QgLkL0Zp5JcCoHfSylIPtkanFL42UAztzhFFX9EgAg0ywD9SuZtpyyVqNwye22uH0y
 CCMNe5JJEvnayIsBk4Nx/WSTUFC2E/NsDnEne1yJD0WjTtet49RswmkUzp2awmh11fP/kJyfx
 i4szTi7UvQyp9kuuPNDbfelg3jwnoBq5mWArx9YBHJ1WxuVVSy5GKk+EOsv1Uv/Pplja9kLj+
 GMfWw/u
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Instead of dying there, let the caller high up in the callchain
notice the error and handle it (by dying, still).

The only callers of checkout_fast_forward_to(), cmd_merge(),
pull_into_void(), cmd_pull() and sequencer's fast_forward_to(),
already check the return value and handle it appropriately. With this
step, we make it notice an error return from this function.

So this is a safe conversion to make checkout_fast_forward_to()
callable from new callers that want it not to die, without changing
the external behaviour of anything existing.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 merge.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/merge.c b/merge.c
index 5db7d56..23866c9 100644
--- a/merge.c
+++ b/merge.c
@@ -57,7 +57,8 @@ int checkout_fast_forward(const unsigned char *head,
 
 	refresh_cache(REFRESH_QUIET);
 
-	hold_locked_index(lock_file, 1);
+	if (hold_locked_index(lock_file, 0) < 0)
+		return -1;
 
 	memset(&trees, 0, sizeof(trees));
 	memset(&opts, 0, sizeof(opts));
@@ -90,7 +91,9 @@ int checkout_fast_forward(const unsigned char *head,
 	}
 	if (unpack_trees(nr_trees, t, &opts))
 		return -1;
-	if (write_locked_index(&the_index, lock_file, COMMIT_LOCK))
-		die(_("unable to write new index file"));
+	if (write_locked_index(&the_index, lock_file, COMMIT_LOCK)) {
+		rollback_lock_file(lock_file);
+		return error(_("unable to write new index file"));
+	}
 	return 0;
 }
-- 
2.10.0.windows.1.10.g803177d


