Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81E7FE95A61
	for <git@archiver.kernel.org>; Sat,  7 Oct 2023 17:20:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344065AbjJGRUf (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 7 Oct 2023 13:20:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344046AbjJGRUe (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 7 Oct 2023 13:20:34 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 489FD83
        for <git@vger.kernel.org>; Sat,  7 Oct 2023 10:20:33 -0700 (PDT)
Received: (qmail 19365 invoked by uid 109); 7 Oct 2023 17:20:32 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 07 Oct 2023 17:20:32 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16894 invoked by uid 111); 7 Oct 2023 17:20:32 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 07 Oct 2023 13:20:32 -0400
Authentication-Results: peff.net; auth=none
Date:   Sat, 7 Oct 2023 13:20:31 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Patrick Steinhardt <ps@pks.im>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH] repack: free existing_cruft array after use
Message-ID: <20231007172031.GA1524950@coredump.intra.peff.net>
References: <cover.1694123506.git.me@ttaylorr.com>
 <cover.1696293862.git.me@ttaylorr.com>
 <e7beb2060dad648ec5c3fa8984e432ee243ae012.1696293862.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e7beb2060dad648ec5c3fa8984e432ee243ae012.1696293862.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 02, 2023 at 08:44:32PM -0400, Taylor Blau wrote:

> +static void collapse_small_cruft_packs(FILE *in, size_t max_size,
> +				       struct existing_packs *existing)
> +{
> +	struct packed_git **existing_cruft, *p;
> +	struct strbuf buf = STRBUF_INIT;
> [...]
> +
> +	strbuf_release(&buf);
> +}

Coverity (using the just-merged-to-next version of the workflow file!)
flagged a leak here. Since the topic (tb/repack-max-cruft-size) is in
'next', I think we'd want this on top:

-- >8 --
Subject: [PATCH] repack: free existing_cruft array after use

We allocate an array of packed_git pointers so that we can sort the list
of cruft packs, but we never free the array, causing a small leak. Note
that we don't need to free the packed_git structs themselves; they're
owned by the repository object.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/repack.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/builtin/repack.c b/builtin/repack.c
index a1a893d952..69e8f302c0 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -955,6 +955,7 @@ static void collapse_small_cruft_packs(FILE *in, size_t max_size,
 			existing->non_kept_packs.items[i].string);
 
 	strbuf_release(&buf);
+	free(existing_cruft);
 }
 
 static int write_cruft_pack(const struct pack_objects_args *args,
-- 
2.42.0.884.gc318dcfe19

