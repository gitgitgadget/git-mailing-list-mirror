Return-Path: <SRS0=5D3W=ZY=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D7AFC432C0
	for <git@archiver.kernel.org>; Mon,  2 Dec 2019 19:42:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4597D20661
	for <git@archiver.kernel.org>; Mon,  2 Dec 2019 19:42:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728100AbfLBTmd (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 Dec 2019 14:42:33 -0500
Received: from cloud.peff.net ([104.130.231.41]:36874 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727686AbfLBTmd (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Dec 2019 14:42:33 -0500
Received: (qmail 32672 invoked by uid 109); 2 Dec 2019 19:42:33 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 02 Dec 2019 19:42:33 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 8311 invoked by uid 111); 2 Dec 2019 19:46:37 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 02 Dec 2019 14:46:37 -0500
Authentication-Results: peff.net; auth=none
Date:   Mon, 2 Dec 2019 14:42:31 -0500
From:   Jeff King <peff@peff.net>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     Colin Stolley <cstolley@runbox.com>, git@vger.kernel.org
Subject: Re: [PATCH] packfile.c: speed up loading lots of packfiles.
Message-ID: <20191202194231.GA10707@sigill.intra.peff.net>
References: <20191127222453.GA3765@owl.colinstolley.com>
 <20191202174035.GJ23183@szeder.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191202174035.GJ23183@szeder.dev>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Dec 02, 2019 at 06:40:35PM +0100, SZEDER Gábor wrote:

> > When loading packfiles on start-up, we traverse the internal packfile
> > list once per file to avoid reloading packfiles that have already
> > been loaded. This check runs in quadratic time, so for poorly
> > maintained repos with a large number of packfiles, it can be pretty
> > slow.
> > 
> > Add a hashmap containing the packfile names as we load them so that
> > the average runtime cost of checking for already-loaded packs becomes
> > constant.
> [...]
> This patch break test 'gc --keep-largest-pack' in 't6500-gc.sh' when
> run with GIT_TEST_MULTI_PACK_INDEX=1, because there is a duplicate
> entry in '.git/objects/info/packs':

Good catch. The issue is that we only add entries to the hashmap in
prepare_packed_git(), but they may be added to the pack list by other
callers of install_packed_git(). It probably makes sense to just push
the hashmap maintenance down into that function, like below. That
requires an extra strhash() when inserting a new pack, but I don't think
that's a big deal.

diff --git a/packfile.c b/packfile.c
index 253559fa87..f0dc63e92f 100644
--- a/packfile.c
+++ b/packfile.c
@@ -757,6 +757,9 @@ void install_packed_git(struct repository *r, struct packed_git *pack)
 
 	pack->next = r->objects->packed_git;
 	r->objects->packed_git = pack;
+
+	hashmap_entry_init(&pack->packmap_ent, strhash(pack->pack_name));
+	hashmap_add(&r->objects->pack_map, &pack->packmap_ent);
 }
 
 void (*report_garbage)(unsigned seen_bits, const char *path);
@@ -864,11 +867,8 @@ static void prepare_pack(const char *full_name, size_t full_name_len,
 		/* Don't reopen a pack we already have. */
 		if (!hashmap_get(&data->r->objects->pack_map, &hent, pack_name)) {
 			p = add_packed_git(full_name, full_name_len, data->local);
-			if (p) {
-				hashmap_entry_init(&p->packmap_ent, hash);
-				hashmap_add(&data->r->objects->pack_map, &p->packmap_ent);
+			if (p)
 				install_packed_git(data->r, p);
-			}
 		}
 		free(pack_name);
 	}

-Peff
