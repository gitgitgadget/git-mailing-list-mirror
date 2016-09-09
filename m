Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8D4BF1F6BF
	for <e@80x24.org>; Fri,  9 Sep 2016 14:37:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753077AbcIIOhX (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Sep 2016 10:37:23 -0400
Received: from mout.gmx.net ([212.227.17.21]:53842 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753038AbcIIOhT (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Sep 2016 10:37:19 -0400
Received: from virtualbox ([37.24.141.250]) by mail.gmx.com (mrgmx101) with
 ESMTPSA (Nemesis) id 0LpObx-1b61ts2M5N-00fBX4; Fri, 09 Sep 2016 16:37:13
 +0200
Date:   Fri, 9 Sep 2016 16:37:12 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v3 05/17] sequencer: lib'ify do_pick_commit()
In-Reply-To: <cover.1473431645.git.johannes.schindelin@gmx.de>
Message-ID: <bc896e5c4611422d4d269c960dc3a33282de688e.1473431645.git.johannes.schindelin@gmx.de>
References: <cover.1472219214.git.johannes.schindelin@gmx.de> <cover.1473431645.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:9awu/rn2GZgCAZ7iDBn9sCqtVcgsbtyWkVo4V5Ad4CeHCoydGKw
 s6wvY5Yqxh1lBP9tZDdo1zFPSfg0QIbWFeYn3qi6mnBCFbpQQrFFCZZ8IqvgrHy+IIrtWJe
 CcpYT5gVHWwP0Z9bP1YSzEUkFv/9iucGAhsZe/IIt+wIwUwJSGYnULyLx9m0GP2A2ORrRFU
 zrkEkwU7Fi3BbujNZ7snA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:NyEGUU6p71g=:SKhKOezkjND+tUUE1Seein
 DSuW6il3tUpp917VcX7ihwz2d4TmtUg5YNXMTaRKu3a6+DpooJeui+EHPlcYhgNT2WIXLvYAq
 PwuAdiHyBnOvqfT6ZNa/YV5EA1OijaOGOENFZsk2u9PWXDFFSj1LwKZ6CL7SFwVFvVf8c4Ozy
 cC50V7TUq5vxqdj4oh22y47HilQI8gdSxHTbJufsrlXvpOVZ5BYW5XTjZXlLRtcnxLsiZp7ym
 Dko4NdZ9vpsFucRUYJHHvSwNMCqA8Se0TP4tUsz8+cOMKfZUWCNscsRNInoowaDwwYGGAf5bj
 KasVnjINbSPzvdRVdiylJtP9meaB2r2GnIGFZkNuap9h1jL8aJHQhMR4onZl3zloMe6cNzRKT
 AVYJ/mGseXuvc6/BcqCp26+FSGR+nv8UdOEr70u17XHFFJzqYYA5XZjZHLfJ0y2rXlokpur0z
 EaSwEoE9CGTJdANg+XpG/nTWQS97dLv4nd0hHyG9HygledSrtsYO7UCV4NyriyrU9QdHIzjRN
 EDiZK8kPOJnZm2yYlpClhMToDEuVunCT8D73zopU+Unw7sJ5LZEQjKS6M95+krmaPbkPVasda
 4O2em+bPu+uLyqP9dfhz39yX95B1amwJm+j/vk6e82UzuiqaKYGRP1v5WZED4Zhys29Hrv5Ir
 wudo53a9JEs+yKrCHj4HuykDIDPAqQOAGHDK5UjdgSeIpSWwagVdMYiPZRcqP4llVp+U5b/IO
 m6srVQMrTirWm5GgGCs1HdV48rZTWg6pcjFYmJvFCVfMuTg+pJymUrHlkiRR91yGIxwunqH7C
 GxgTywk
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
index eb70091..96b9ae1 100644
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
2.10.0.windows.1.10.g803177d


