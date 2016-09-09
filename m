Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C372820705
	for <e@80x24.org>; Fri,  9 Sep 2016 14:37:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753039AbcIIOhR (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Sep 2016 10:37:17 -0400
Received: from mout.gmx.net ([212.227.17.20]:61229 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752936AbcIIOhQ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Sep 2016 10:37:16 -0400
Received: from virtualbox ([37.24.141.250]) by mail.gmx.com (mrgmx101) with
 ESMTPSA (Nemesis) id 0LzGV3-1aw5lX2jYH-014Rx6; Fri, 09 Sep 2016 16:37:10
 +0200
Date:   Fri, 9 Sep 2016 16:37:10 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v3 04/17] sequencer: lib'ify do_recursive_merge()
In-Reply-To: <cover.1473431645.git.johannes.schindelin@gmx.de>
Message-ID: <6d105cab003f2a28108557e889ddbbea70b1c453.1473431645.git.johannes.schindelin@gmx.de>
References: <cover.1472219214.git.johannes.schindelin@gmx.de> <cover.1473431645.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:5gTlVPNndcGy0QyRA27yD1QSuwZjiZrOXFtGl8w8OKeD3sJFT+G
 Mwpz9TM7yaNRjG6HR5vkvbmfyYtA3jLygngSdAkxM5JZSc2z02gd0k9ZBNM9fMTh/6oefGl
 N30QP0nf/eRselIMpOkS5cnzz5xmtHd07tp3dfWUbXJXgJTFNhTMU48EEWkLqAKpKsDK415
 200NZ663voNPkgNKUMThA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Wq6nqIl8vhk=:29XVbzbmP/s1SYsHdRqnm6
 CQXDWMX3byjtS/8P4gRTEd/OxHOX8UlnCX43iqjHkRaOaLoICaszD9VYB3klOQpYP0KrbM/MH
 mkTZz6pT5trjGwhH2qoqbAuomJochQg3VsfhYLDsYq/EJY1p637tqHPEGHqb8DborriKlppRF
 YCy8mw/hW1bPirQZfh48/lXtXlZDAgvWrx5Rl99G1PnnULsKcyvX/gZzMjIozAdnaIrzU96ah
 Evhz4ABoBQ2jBIrYkIlCPj1ngur1iujVxhcXD+0F6m+AFp6e2O+u9yft+KeE6AOR1AvlaVAzG
 F3l3Uf0BZy95U7lYxLP+x6VPMYInCIC+9OrusQ2FqHbE1OBDHKsDQBIQtVW5wKL5R8FipfI89
 i8Qp/kdNQWhzq058/+RfL8sjuREYMR6VFn4mJ/yLQhHSf1EBd46jvdVJd7WA4uXJ5uCGZDhMT
 hZA2AZRkWL0gzgtGmsG36WfrYo/8TTZoY6mW/5d2I5ARF3lNrDWL/HlF1e6rPcw1GkGAlgHs+
 D9IAbn4iJW5iWvIwhgEmQ6YuGqItdQH+go04NP+H2aixXTbqi0bjWl38034De9ES5/o10amRx
 3i+4Am9DectClBsAJlXtIGlAZ9Zafrw6hkYfC+jexpZXX+EsiILHUCTHO8ILJv1rL3I1E1XyG
 ND1ZAm3H94vwlXJP0rWHsfJbZ79jvaUVGSwNgZDjoXOsAPFMRvS/TcmzR6oLAKqSesgOmNLqj
 2qlM5T6c3tOunigmvZRiDEAe2cbY6QILaLEBNmZnLTmL0OJfmRdc4tbK1m+G0tYKyO8cOoukP
 2oygApI
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Instead of dying there, let the caller high up in the callchain
notice the error and handle it (by dying, still).

The only caller of do_recursive_merge(), do_pick_commit() already
checks the return value and passes it on to its callers, so its caller
must be already prepared to handle error returns, and with this step,
we make it notice an error return from this function.

So this is a safe conversion to make do_recursive_merge() callable
from new callers that want it not to die, without changing the
external behaviour of anything existing.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 sequencer.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sequencer.c b/sequencer.c
index ec85fe7..eb70091 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -303,7 +303,8 @@ static int do_recursive_merge(struct commit *base, struct commit *next,
 	if (active_cache_changed &&
 	    write_locked_index(&the_index, &index_lock, COMMIT_LOCK))
 		/* TRANSLATORS: %s will be "revert" or "cherry-pick" */
-		die(_("%s: Unable to write new index file"), action_name(opts));
+		return error(_("%s: Unable to write new index file"),
+			action_name(opts));
 	rollback_lock_file(&index_lock);
 
 	if (opts->signoff)
-- 
2.10.0.windows.1.10.g803177d


