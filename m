Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B59502018E
	for <e@80x24.org>; Fri, 26 Aug 2016 13:49:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753113AbcHZNs5 (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Aug 2016 09:48:57 -0400
Received: from mout.gmx.net ([212.227.17.20]:61169 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751547AbcHZNsh (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Aug 2016 09:48:37 -0400
Received: from virtualbox ([37.24.141.250]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0Me5Q2-1bTsT03ytq-00PvL9; Fri, 26 Aug 2016 15:47:37
 +0200
Date:   Fri, 26 Aug 2016 15:47:36 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 04/14] sequencer: lib'ify do_recursive_merge()
In-Reply-To: <cover.1472219214.git.johannes.schindelin@gmx.de>
Message-ID: <28807445076a3d1d5f0077697ef8517f3c8d8c17.1472219214.git.johannes.schindelin@gmx.de>
References: <cover.1471968378.git.johannes.schindelin@gmx.de> <cover.1472219214.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:fvumn3usSmfdONDE56Oj2VXLfeBYD5aozGc9NrHP/JnPt967qrJ
 Rn4TMoCr2B9TvHZvDPSKcoAhsDUBjISTUOTzVFYykNOLIGSWjwHBHJyla6KscOZV936WDHF
 ln9vc5QEmz1/yvxUyMielTb8X5h0uF6BCajPNnFsVsZMtTtcGd/vGnrLVpWzdsSXN7I+zxx
 CPVCfLeTIMwM91yb0Iqgg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:ETVNK+Gj0uw=:BZPNae3bcMcHy6fPetRftE
 6vLLdZFc5GQsVYn5wgnrcr0rpthriSTcBeD7hIVWJG29dRQyAOW6reHBp9pKUTHt8NtbILiVC
 TSp8NZ2vM+vcGcGMnjNDXgoHxuo1WXFqpnrFbOJ8oxVyQbnyI2x6DJ8ypSmF8JD55PreFLVpt
 hFqSJQSonzCDdhphSm9iabKXEwbfIhK/unxoOWmRNdo/CVPwDKfKOLwKwqGEaTGeQgOOG7TPz
 tZAppbV6zOnCMYoTlhrrtx+MurRgf5LrQ2EplS/ukpW+Z3INugjB0iXhrqU53blKp5a/jQJ5S
 1R0JnzuAN8KggI9bNotmvPoPSpBoNF2yuy04sjK+Js1GbRuap9rL+0dfC5Gq0PHtI83DcP4a9
 oRKlAOfT8oTFLN4NLwuRrLEg28aycQ8SSIUCBYYL0hFPfd0+RralY2bt+yEDHlT7Sy7Gq6wjd
 DXEW5z6wM4ZZwY1fiAJ93OX595IafcI06kqcufJyUbZT+Zi8r4M+yVOP6rtTVnS7qV+e0EeSZ
 MN4pOkokQR9sBzXVsKG08xzUwKA/ZbMCAjM0aUVl/TzmhJM57DdwGdyUx7jOV6Q76I3fDIHpu
 e7/TPsJ7u5ucd3ZE3+KLEjnJtIqHN6tS40D6vb833LwWA7D9wr2GkWLFRYiQedAzaVa5pmbRc
 ptvGoy0c4tH8hSHyM14qtW9CC0yXA1dIkmMCAN3AUAT0AYlr1e48ndXD6RHd9hUx6kRb/CDCd
 a4zUHbJLQU/hoYasNxIKN+/L502FQ1gCAuLHfoxIiSSRZCFmCpLCCjosrIuL/FOlqO4O4bRA7
 4NY/75x
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
index 17bee60..f6cdf65 100644
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
2.10.0.rc1.99.gcd66998


