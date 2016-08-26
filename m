Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6D4061FD99
	for <e@80x24.org>; Fri, 26 Aug 2016 13:49:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753087AbcHZNsy (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Aug 2016 09:48:54 -0400
Received: from mout.gmx.net ([212.227.15.19]:52863 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752679AbcHZNsh (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Aug 2016 09:48:37 -0400
Received: from virtualbox ([37.24.141.250]) by mail.gmx.com (mrgmx002) with
 ESMTPSA (Nemesis) id 0MHoC5-1bgqvB0ixJ-003eTJ; Fri, 26 Aug 2016 15:47:48
 +0200
Date:   Fri, 26 Aug 2016 15:47:46 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 07/14] sequencer: lib'ify prepare_revs()
In-Reply-To: <cover.1472219214.git.johannes.schindelin@gmx.de>
Message-ID: <1d53ae5e3f4f3d294baa0f9ae96fce1c3516adf3.1472219214.git.johannes.schindelin@gmx.de>
References: <cover.1471968378.git.johannes.schindelin@gmx.de> <cover.1472219214.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:nvZ/xfBw5KDn+xn802WY4kJrbbAMJErQnDlPOfqAsKIIdyjEVJd
 P4GUU+Mju1SqXyyJDpBdwpcIJ3uTCH4UuwqD4OL5CyXLJLbbckL1Q4PNXWKz+FNv8xfljob
 KL7ILTfHF/IKwZXpBaQgFtmVUQAdujQucAviktKTzut8ycZ8ye64AEVmF7KSr4CjyiLZ2n9
 /Qtfe3zh/CFaRBTucR8sg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:nOR9e4+PhtQ=:lPfdvid0GOnOzLwi+2d+e6
 SiWKgPge7g5v6chlNn8+C+rlxk74LfGnx1be/CywGmQ38ccDkOH8aqezKw+XvMkTVp8m8Tn99
 X0dyntr2P6SlNVjkU5s6vqvEbavFbdh2saSB9nquYF70ktWJAxSpwXroLOj2KdEHhTe2FJbjC
 3UfjtSQcL7ba86gs7YAFufHiQ9WuieANzNQNEaGTeRopgm6TH8wurg7RODNOYLF7tLOolvqim
 QhdI25Ko8dwswtv6p5JHZaDppl8hspzn/yXFjZokYBjKCzBMFlOvBakhFvh1DF4VVht8B+4WA
 1joeyiSVNxEkvkPw8/Ong6/PXrjP03DnGsl+p1KKBN20dGUfadPuVEbQFGyo/cOHsigERrRpl
 2/06fw1xyMaAtZlHtgb1RYU2fpexfa0UCJYPdRmH94Y3EtnOH2ke/WRXVh79FtiD/mRiAWu5A
 J1+fPx4AoX+qwH2eZ+tMz6LPnly8uWse+sWiuTZVU1xqLWFL3Kt2CitoglwBC0RmoCWxsCP3J
 8fud7ms+y1gX2YFLoucz6Ywd7sFQPMNcs5S32hLvMJ6FivjT8yrCoe1vW+IVHEgPfeaZ3jbiF
 6vLXv/OcjqHwuDeNoS7rH4dOIs3TW7AyhnyNbpmqnnRgD+Mf9D/l4PtCH5gl4NzE1WX+73PHX
 JES3LMzw5EriWJByBkF49FUT3pXM5Rnnu16r+3qe8rbhirXh0EZObS4VF5ebRAc16CiRC8QdD
 fAth7WHCjCUGM5iPSkukIYeBaX+m7OEL/QTyJm5hcfJ27aUH6VFGJrQfAWJ3TkwkKy97JpbCs
 s85Z6Id
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Instead of dying there, let the caller high up in the callchain notice
the error and handle it (by dying, still).

The only caller of prepare_revs(), walk_revs_populate_todo() was just
taught to return errors, after verifying that its callers are prepared
to handle error returns, and with this step, we make it notice an
error return from this function.

So this is a safe conversion to make prepare_revs() callable from new
callers that want it not to die, without changing the external
behaviour of anything existing.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 sequencer.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index ea2681e..c006cae 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -623,7 +623,7 @@ static int do_pick_commit(struct commit *commit, struct replay_opts *opts)
 	return res;
 }
 
-static void prepare_revs(struct replay_opts *opts)
+static int prepare_revs(struct replay_opts *opts)
 {
 	/*
 	 * picking (but not reverting) ranges (but not individual revisions)
@@ -633,10 +633,11 @@ static void prepare_revs(struct replay_opts *opts)
 		opts->revs->reverse ^= 1;
 
 	if (prepare_revision_walk(opts->revs))
-		die(_("revision walk setup failed"));
+		return error(_("revision walk setup failed"));
 
 	if (!opts->revs->commits)
-		die(_("empty commit set passed"));
+		return error(_("empty commit set passed"));
+	return 0;
 }
 
 static void read_and_refresh_cache(struct replay_opts *opts)
-- 
2.10.0.rc1.99.gcd66998


