Return-Path: <SRS0=dWK1=36=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BE03C3B186
	for <git@archiver.kernel.org>; Mon, 10 Feb 2020 15:06:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 651AA20714
	for <git@archiver.kernel.org>; Mon, 10 Feb 2020 15:06:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728815AbgBJPGo (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Feb 2020 10:06:44 -0500
Received: from s3.sipsolutions.net ([144.76.43.62]:58084 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726809AbgBJPGo (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Feb 2020 10:06:44 -0500
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.93)
        (envelope-from <johannes@sipsolutions.net>)
        id 1j1Ae2-0004iO-72; Mon, 10 Feb 2020 16:06:42 +0100
Message-ID: <a52c8163abfba107a27b359a1588a68efdc581a8.camel@sipsolutions.net>
Subject: Re: [PATCH] pack-format: correct multi-pack-index description
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Derrick Stolee <stolee@gmail.com>, git@vger.kernel.org
Date:   Mon, 10 Feb 2020 16:06:41 +0100
In-Reply-To: <08dbc3be-34a7-fb8d-e0bd-56a79ab5b65a@gmail.com> (sfid-20200210_160205_899758_698E8FB8)
References: <20200207221640.46876-1-johannes@sipsolutions.net>
         <8d50143b-adb9-c642-5ca6-d51662c37dda@gmail.com>
         <526a7a3d8d135c9b97890c1c238ca5baaa138c3c.camel@sipsolutions.net>
         <28b6fd7f-85ea-9ef1-1977-888cdd737c6d@gmail.com>
         <c077a2100038edf2b0c486c0d364bd00f3921074.camel@sipsolutions.net>
         <08dbc3be-34a7-fb8d-e0bd-56a79ab5b65a@gmail.com>
         (sfid-20200210_160205_899758_698E8FB8)
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.2 (3.34.2-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, 2020-02-10 at 10:02 -0500, Derrick Stolee wrote:
> Git loads the multi-pack-index file, which includes a sorted list of
> the packs it covers. It then scans the "pack" directory for pack-indexes
> and checks if they are covered by the multi-pack-index. If not, then
> Git will add them to the packed_git struct and use them as normal.
> The hope is that this list of "uncovered" packs is small compared to
> the data covered by the multi-pack-index.
> 
> This allows Git to continue functioning after an action like "git fetch"
> that adds a new pack but may not want to rewrite the multi-pack-index.

Ah, ok.

So then perhaps I'll just make bup write the multi-pack-index file as
is. This is fine, there's no real need to have multiple, I just didn't
want to have to make sure the file was always consistent.

Or maybe just call git to do it, and only be able to read the resulting
file :-)

> Our background maintenance essentially runs these commands:
> 
>  1. git multi-pack-index write
>  2. git multi-pack-index expire
>  3. git multi-pack-index repack
> 
> Step 1 ensures all packs are pulled into the multi-pack-index. Step 2
> deletes any pack-files whose objects are contained in newer pack-files.
> Step 3 creates a new pack-file containing all objects from a set of
> small pack-files (using the --batch-size=X option). This process helps
> incrementally reduce the size and number of packs. That may be helpful
> for your backup took, too.

I'll have to look at this in more detail later, and understand exactly
what the steps do here. Evidently that modifies pack files, which I
hadn't expected for a type of "index" command :-)

> Perhaps after an incremental multi-pack-index is added, then Git could
> (optionally) have a mode that only checks the multi-pack-index to
> avoid scanning the packs directory. It would require inserting a
> multi-pack-index write into the index-pack logic so Git.

I guess you'd still want to read non-covered pack files just in case old
git was used or something though.

> I'm not sure if that mode would be helpful, since the pack directory
> scan is typically done once per command and is relatively fast.

Right.

> > > That said: if someone wanted to contribute an incremental format,
> > > then I would be happy to review it!
> > 
> > I might still get motivated to do so :-)
> 
> YOU CAN DO IT! (Did that help?)

:-)

Thanks,
johannes

