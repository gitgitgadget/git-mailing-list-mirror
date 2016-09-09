Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1E6101F6BF
	for <e@80x24.org>; Fri,  9 Sep 2016 14:38:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753318AbcIIOia (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Sep 2016 10:38:30 -0400
Received: from mout.gmx.net ([212.227.17.21]:58634 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752850AbcIIOhY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Sep 2016 10:37:24 -0400
Received: from virtualbox ([37.24.141.250]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0MZfZi-1bTRuD0n6M-00LaDn; Fri, 09 Sep 2016 16:37:19
 +0200
Date:   Fri, 9 Sep 2016 16:37:18 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v3 07/17] sequencer: lib'ify prepare_revs()
In-Reply-To: <cover.1473431645.git.johannes.schindelin@gmx.de>
Message-ID: <c9f22511aabf3df7287b9279869691448e3305ed.1473431645.git.johannes.schindelin@gmx.de>
References: <cover.1472219214.git.johannes.schindelin@gmx.de> <cover.1473431645.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:bAVzW1YbcUE6cs0ZxlF+Mm7Us+Zl4dCvvs7VWwD/+kBsw7G+Czx
 0MsszHMbHNx7cZsoTk1yrXwZJWEcGDA1hGs9LSCQRCBqspwq8Km9BtjB0ic1BK+hLJdoh2R
 6010FxItqcRMaAJYgE+UC4JUJuhHJ8NRYLpSKTRQ7/IP9DGP5Nso5QFdtKZWznjMNCpVye9
 juMojvm4Tsc3QiBDe35JA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:JcajetncMVQ=:7NX8AUkP2f7QgSqrZinQ6i
 7tYkYLNAVOjqJqrK5M2Lp4YgDRhS4gcjINpVRpzYyTobTgS0yglyU9hDTGvjoq5d+OkX+LUSB
 iud37nfRMTnBD8jaavsuOcM54HqTGvhm1z3u3a5tEfRowDAOglXfy2i7UrBiffN/K4oSFigxz
 BtWutAUjknug/WtGBohSnm2lZ3VebG04E1UDGO/yG4fBNMmd3YXTlp8bM/Z2Cqz9eCjpLLIoi
 SsQrb3HIWCH4+TOeAxG/4gD1PER+84/H+ng5/dCHbkF2KU2DedVBUHP/ay1H3v9DdhT3fexHh
 y53LcXyhrS+2zUjYEuFwhWcCMkvf9IYSClAbs1sGrtrw3dt4lwHjIiQblNviC2OpOh0tlYWzi
 ruL7qhe/09PWJEdl9lUGBRowufkEoAYTqakBONghKIqV6JMFDNBuYAoGu5WYvP0ylkfLG//+/
 1IPmAYqpgTVwndevmJlpG2WXyY4zQoOeM36l23cwdfRFK+m9b8URiB5Q1WBiD2LBr/hwdZ2ac
 hk0I9V7RU/qC/LN6wY7ErmuDl8FoNOhEM0qbYQmw/N49DzCGBmfvEg/+m/5Z0/VRLdKwykYnT
 ZTLs3foRwbvFWA5/rrlswGv6r+J/sL9Pw8JbH7ukjhAi47AkLbMZsXfP/GcG0TVkxZaLZls/T
 vZ/rf/sVVWcx0QM9ZJbmcOBhx+pHQypnvUSrJk28YdPfuWkRVHeNyRj94kE+Wdr9dMdKQmNPO
 pwHOJiwrYT3KYnV94ALZyDluqv5dGcHZ1B+iCbHarfHSKPAcFHT47oyjcNdYuI8ZO3vQhlXHc
 OOTq4+a
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
index ab599e0..7fd0f99 100644
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
2.10.0.windows.1.10.g803177d


