Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 767191FD99
	for <e@80x24.org>; Fri, 26 Aug 2016 13:48:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753008AbcHZNsj (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Aug 2016 09:48:39 -0400
Received: from mout.gmx.net ([212.227.15.15]:64588 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751569AbcHZNsh (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Aug 2016 09:48:37 -0400
Received: from virtualbox ([37.24.141.250]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0MAgzj-1bp8N63Yuh-00BtLu; Fri, 26 Aug 2016 15:47:39
 +0200
Date:   Fri, 26 Aug 2016 15:47:39 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 05/14] sequencer: lib'ify do_pick_commit()
In-Reply-To: <cover.1472219214.git.johannes.schindelin@gmx.de>
Message-ID: <39d03662fc6ea81d737c0650bb9b7292e812ae02.1472219214.git.johannes.schindelin@gmx.de>
References: <cover.1471968378.git.johannes.schindelin@gmx.de> <cover.1472219214.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:NHMEbA76Oai8nRs1PuMpYzRhqtBnYSqfFZMd/nxTv7vjNaW1rcv
 o0O1xXZZ/NZ2w+P/44yjKDYC2dyg/pMXCVQ5mPvyWGkUd7SdlZS92GWCLLOtmbJMAZYLXTa
 /os61EMFBeD6ozwsMlrNZqV1i0DtfeAiuY8kTuSMKGObb1T/epaQBs4GeTZdum3zimyHWP7
 NJtf6L5XrIhsvAszdpypA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Ju0H2u3PwwU=:C24KQnfVtxJEZUyp4Qh6G/
 LXfm9Np3Q04pKNd3a2Hy3UxQX0TFzS4d7j1g10k3ucZ4HuPEG/27kIbo9JzJkjlTz0c9CIfJ3
 JKFZNyXuYsUoGDGceOW0kjfEQkPop0EuuqfdHefXcESTw+lMTaeDZZaVNj7cQtuBE1X37mFjH
 xHNtz5x7gTmq+1ysmLe0876lnbSMvKj1htz7JohIyELEPzfbX0aij0TQFTrOmZR2qsEXFmUEl
 bgMyYs32QOUABHC1HMIjo+8liWGj/h5GY1R42WjC0TzHXRwpB+hxWNl0pSmCjLpK5i/0GlTpI
 LNsoEPM4c9PPBGuC4W5Hep2sEOPqWGZBIKWAJ923areOZA7VypYStbS0cVIsfXkOb3clEWKVU
 b0oHfy1E+x/FQl4rFWAG5mxP7AEEMAZ348Oy8tf6JzLN9aX7iYAP9EqwnQxTgKvcvKHWUdlh3
 gJrxqz30hdX3+6u1rDvBjxaDISyr5BdomzaMByDrQfA35NKf/QAyuajdMIOM4eaybpbRkV+9P
 yIVxKHLhdnOhRTNyoGpQWoE3YCYeDRwraPtLaV7Ppb7aLIkaGdn+/0qYfXItmyFLH3FlOAzHE
 /EST7hWDRTlz8EhHzCMgwT36BGuEZD7aoybDGWq7EthmUchCHwnG67I0fBMRT/5TonOackyo9
 WhDc13uZNIFKNViONWJsylYQXbSyzpVsFPEfsQGzOTpO2BoTRw2zesmUUeq2N9/niMkSdswBf
 ke91G9sjoWzD6kb5S5jpMTr0Uv7rs2FvY5vBKSok5s2YRQOaMyCTNSGNw7gEjOHUperNRAFo/
 2np14Ie
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Instead of dying there, let the caller high up in the callchain notice
the error and handle it (by dying, still).

The only two callers of do_pick_commit(), pick_commits() and
single_pick() already check the return value and pass it on to their
callers, so their callers must be already prepared to handle error
returns, and with this step, we make it notice an error return from
this function.

So this is a safe conversion to make do_pick_commit() callable from
new callers that want it not to die, without changing the external
behaviour of anything existing.

While at it, remove the superfluous space.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 sequencer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sequencer.c b/sequencer.c
index f6cdf65..7eef512 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -464,7 +464,7 @@ static int do_pick_commit(struct commit *commit, struct replay_opts *opts)
 		 * to work on.
 		 */
 		if (write_cache_as_tree(head, 0, NULL))
-			die (_("Your index file is unmerged."));
+			return error(_("Your index file is unmerged."));
 	} else {
 		unborn = get_sha1("HEAD", head);
 		if (unborn)
-- 
2.10.0.rc1.99.gcd66998


