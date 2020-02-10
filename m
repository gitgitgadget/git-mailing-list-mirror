Return-Path: <SRS0=dWK1=36=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CFC1C352A3
	for <git@archiver.kernel.org>; Mon, 10 Feb 2020 14:51:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 029802082F
	for <git@archiver.kernel.org>; Mon, 10 Feb 2020 14:51:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727944AbgBJOu7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Feb 2020 09:50:59 -0500
Received: from s3.sipsolutions.net ([144.76.43.62]:57760 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727923AbgBJOu6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Feb 2020 09:50:58 -0500
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.93)
        (envelope-from <johannes@sipsolutions.net>)
        id 1j1AOm-0002in-Hq; Mon, 10 Feb 2020 15:50:56 +0100
Message-ID: <c077a2100038edf2b0c486c0d364bd00f3921074.camel@sipsolutions.net>
Subject: Re: [PATCH] pack-format: correct multi-pack-index description
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Derrick Stolee <stolee@gmail.com>, git@vger.kernel.org
Date:   Mon, 10 Feb 2020 15:50:54 +0100
In-Reply-To: <28b6fd7f-85ea-9ef1-1977-888cdd737c6d@gmail.com> (sfid-20200210_154659_712260_04ADD45B)
References: <20200207221640.46876-1-johannes@sipsolutions.net>
         <8d50143b-adb9-c642-5ca6-d51662c37dda@gmail.com>
         <526a7a3d8d135c9b97890c1c238ca5baaa138c3c.camel@sipsolutions.net>
         <28b6fd7f-85ea-9ef1-1977-888cdd737c6d@gmail.com>
         (sfid-20200210_154659_712260_04ADD45B)
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.2 (3.34.2-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, 2020-02-10 at 09:46 -0500, Derrick Stolee wrote:

> Part of my initial plan was to have this incremental file format.
> The commit-graph uses a very similar mechanism. The difference may
> be that you likely allow multiple .midx files found by scanning the
> pack directory, 

Right, just scan and use any midx that exist, then compare the packs in
there against all the packs found, and then remove any packs that
actually *are* in an midx from the search list. That leaves you with all
information, but optimised by midx where possible.

> but I would expect something like the
> "commit-graph-chain" file that provides an ordered list of the
> incremental files. This can be important for deciding when to merge
> layers or delete old files, and would be critical to the possibility
> of converting reachability bitmaps to rely on a stable object order
> stored in the multi-pack-index instead of pack-order.

Right, if we delete then we have to also remove any midx covering the
deleted pack, that's pretty rare in bup as a backup tool though.

> The reason the multi-pack-index has not become incremental is that
> VFS for Git no longer needs to write it very often. We write the
> entire multi-pack-index during a background job that triggers once
> per day. If we needed to write it more frequently, then the incremental
> format would be more important to us.

So, wait, what if a new pack is created? Does it just get used in
addition to the multi-pack-index, if it's not covered by it, like I
described above?

If so, I guess it wouldn't actually really matter here. I was afraid
(but didn't check yet) that git would always use only the single multi-
pack-index file, and not also search additional packs, so that it always
has to be maintained in "perfect order" ...

> That said: if someone wanted to contribute an incremental format,
> then I would be happy to review it!

I might still get motivated to do so :-)

johannes

