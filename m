Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C49E0C433EF
	for <git@archiver.kernel.org>; Fri,  8 Oct 2021 21:46:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A4B5460F9C
	for <git@archiver.kernel.org>; Fri,  8 Oct 2021 21:46:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243485AbhJHVsb (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Oct 2021 17:48:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243348AbhJHVsa (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Oct 2021 17:48:30 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19DCBC061762
        for <git@vger.kernel.org>; Fri,  8 Oct 2021 14:46:35 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id b12so2846189qtq.3
        for <git@vger.kernel.org>; Fri, 08 Oct 2021 14:46:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Uv+MYi9c4NDJHzdoFHgNmYx/Y2px+7lWAV8mGl5WV6U=;
        b=ChjoQFi3lA7QqGEX6s8vJrsXb9+DPX9cXHTS02l3m7JO8fNfsXit5BcPVoQWi3h0CB
         uPXpIKzXo/3eWPOn9PIQ7D7rp4eFPqgXVy66iZJy6BjzurOY38gIzDQrfe5cd5b6ST+K
         /dYxkFFGOkvHr+JA9JZHbhRTlpnIIinMbTekvje69zoQJ3ankf/vFe6REW/+jh074k7c
         /6nIgZCq2sZYVHXbukwiqkmH6koOKTIHcLlnsEmP1IfROH9gPg3BrPsGGj/sAlWD6Lyj
         vTl5goolRjlmkoPNjXoQtzlHvW/w8ZbGNl2btMtwYoTxqbgQcajWrBxKMYdhDrjU/Pwk
         Q1WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Uv+MYi9c4NDJHzdoFHgNmYx/Y2px+7lWAV8mGl5WV6U=;
        b=oEH1HrAt4HgarzZ4MsenXjOB9gvupNJSFRBw81I3n0aGYJyjAWua+n2h0sCAEP4xk3
         9ArufhaMLy5V0kgg8lREj6trDfzJ5c2Dz7tmtiCHChi12pcsmhlinkmDNj16a2x7AKCX
         1m1/PUvmdi6EVRoAMQP1I5YkE58hIqRMOUcFL3/RcquAvPG7IavDUvnYyOLq5o1mck4R
         6BaiM1JmIdYfsBtp1u6dUwTGookxrP3jWCCasTfe1Md++mzw9mNfPA2lRkLxA3OTkMEh
         ur//WL3IQtxuGkLzYImBy3my65OideIW6CWbPhAOZ7rHjwanlooL4yfcn+hFnZYKPb6d
         rcBg==
X-Gm-Message-State: AOAM531a99G/COH0kHKT2goWUlGVmcnqT/LRIGEZ2dDzowXpqyyxdkJs
        euyfIqClPW0Tvb2MgjazchwWlruFxvamJA==
X-Google-Smtp-Source: ABdhPJx4UZFroAOJND+wznCmkiOLsc6LkIZ7+JZx1OkuXs1CT8w7jMACuTn4aPHRcDmYeeGAoJvo1w==
X-Received: by 2002:ac8:7351:: with SMTP id q17mr855021qtp.336.1633729593273;
        Fri, 08 Oct 2021 14:46:33 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id y23sm361944qtv.58.2021.10.08.14.46.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Oct 2021 14:46:33 -0700 (PDT)
Date:   Fri, 8 Oct 2021 17:46:32 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     Johannes.Schindelin@gmx.de, dstolee@microsoft.com,
        jeffhost@microsoft.com, peff@peff.net
Subject: [PATCH 2/4] midx.c: lookup MIDX by object directory during expire
Message-ID: <84e95aacbdfb092082d0ca467892552982134774.1633729502.git.me@ttaylorr.com>
References: <cover.1633729502.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1633729502.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Before a new MIDX can be written, expire_midx_packs() first loads the
existing MIDX, figures out which packs can be expired, and then writes a
new MIDX based on that information.

In order to load the existing MIDX, it uses load_multi_pack_index(),
which mmaps the multi-pack-index file, but does not store the resulting
`struct multi_pack_index *` in the object store.

write_midx_internal() also needs to open the existing MIDX, and it does
so by iterating the results of get_multi_pack_index(), so that it reuses
the same pointer held by the object store. But before it can move the
new MIDX into place, it close_object_store() to munmap() the
multi-pack-index file to accommodate platforms like Windows which don't
allow overwriting files which are memory mapped.

That's where things get weird. Since expire_midx_packs has its own
*separate* memory mapped copy of the MIDX, the MIDX file is still memory
mapped! Interestingly, this doesn't seem to cause a problem in our
tests. (I believe that this has much more to do with my own lack of
familiarity with Windows than it does a lack of coverage in our tests).

In any case, we can side-step the whole issue by teaching
expire_midx_packs() to use the `struct multi_pack_index` pointer it
found via the object store instead of maintain its own copy. That way,
when write_midx_internal() calls `close_object_store()`, we know that
there are no memory mapped copies of the MIDX laying around.

A couple of other small notes about this patch:

  - As far as I can tell, passing `local == 1` to the call to
    load_multi_pack_index() was an error, since object_dir could be an
    alternate. But it doesn't matter, since even though we write
    `m->local = 1`, we never read that field back later on.

  - Setting `m = NULL` after write_midx_internal() was likely to prevent
    a double-free back from when that function took a `struct
    multi_pack_index *` that it called close_midx() on itself. We can
    rely on write_midx_internal() to call that for us now.

Finally, this enforces the same "the value of --object-dir must be the
local object store, or an alternate" rule from f57a739691 (midx: avoid
opening multiple MIDXs when writing, 2021-09-01) to the `expire`
sub-command, too.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
This does leak the MIDX write_midx_internal returns before calling
close_object_store(). We can't just blindly call close_object_store()
here, either, since it's susceptible to double-frees. I'll think about
improving this in a separate series.

 midx.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/midx.c b/midx.c
index b66b75a3cd..7f1addf4b6 100644
--- a/midx.c
+++ b/midx.c
@@ -1707,7 +1707,7 @@ int expire_midx_packs(struct repository *r, const char *object_dir, unsigned fla
 {
 	uint32_t i, *count, result = 0;
 	struct string_list packs_to_drop = STRING_LIST_INIT_DUP;
-	struct multi_pack_index *m = load_multi_pack_index(object_dir, 1);
+	struct multi_pack_index *m = lookup_multi_pack_index(r, object_dir);
 	struct progress *progress = NULL;

 	if (!m)
@@ -1752,12 +1752,11 @@ int expire_midx_packs(struct repository *r, const char *object_dir, unsigned fla

 	free(count);

-	if (packs_to_drop.nr) {
+	if (packs_to_drop.nr)
 		result = write_midx_internal(object_dir, NULL, &packs_to_drop, NULL, NULL, flags);
-		m = NULL;
-	}

 	string_list_clear(&packs_to_drop, 0);
+
 	return result;
 }

--
2.33.0.96.g73915697e6

