Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFACBC4338F
	for <git@archiver.kernel.org>; Tue, 24 Aug 2021 07:51:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C0F746127B
	for <git@archiver.kernel.org>; Tue, 24 Aug 2021 07:51:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235076AbhHXHve (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Aug 2021 03:51:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235143AbhHXHvd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Aug 2021 03:51:33 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7AA9C061760
        for <git@vger.kernel.org>; Tue, 24 Aug 2021 00:50:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=PyaPguE0BHMg+08tVNO9DOTbbUvII3Mbssd6daQ/y5c=;
        t=1629791449; x=1631001049; b=gP4BzDOsA/MSruwE2DPqfVM1eR8uNx3wxnXH2DHvIP3B7e7
        IKX87RYf/+Yh0JR4sSEbHlR2G77DWkWn+5bGSGOfGn47snpSztjis3K3/udkbXw8Iw+Gclx0gH7/W
        qKWWYqjm+/WOBGxRT+RwDaSmQ69zx7ZO8slXB7BodWEemKsStrzC9uAxKyAO6ScyZH4lk+72+pwyC
        uTpgCHNRt4VJ2v+IzSj+DB5p2yPFsU6wksQwqAqG9vm5lbp9cAl1qvPD2Xx3uITirSEwnqHPNcwJg
        1i8lzZnZiVvsMWXk9zOwX3KRCFibi7Sj2el94C/z1w1klBlAPxnxqjJTPjdN/ZqA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94.2)
        (envelope-from <johannes@sipsolutions.net>)
        id 1mIRCk-00FClg-Sc; Tue, 24 Aug 2021 09:50:43 +0200
Message-ID: <255fb1277db09f66e5cfddc6bbe34181effca3dc.camel@sipsolutions.net>
Subject: Re: [PATCH v3] multi-pack-index: fix *.rev cleanups with
 --object-dir
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>,
        Jeff King <peff@peff.net>
Date:   Tue, 24 Aug 2021 09:50:41 +0200
In-Reply-To: <YSQ7wVKbE2HTkEz0@nand.local>
References: <20210823171011.80588-1-johannes@sipsolutions.net>
         <YSQ7wVKbE2HTkEz0@nand.local>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, 2021-08-23 at 20:22 -0400, Taylor Blau wrote:
> 
> > +	rev="objdir-test-repo/$objdir/pack/multi-pack-index-abcdef123456.rev" &&
> > +	touch $rev &&
> 
> This is the only non-obvious part of the patch, but is necessary because
> there's no way to trigger the MIDX code to write a reverse index
> (thankfully so, since this means that we're not affecting anybody in the
> wild cleaning up .rev's that we shouldn't be).
> 
> It may be worth returning to this in the future when we have support for
> MIDX bitmaps (which will trigger writing a .rev file)

No argument there, though it doesn't matter much for this test how you
arrive at a repo that has a .rev file.

> > +	nongit git multi-pack-index --object-dir="$(pwd)/objdir-test-repo/$objdir" write &&
> > +	test_path_is_file objdir-test-repo/$objdir/pack/multi-pack-index &&
> > +	test_path_is_missing $rev
> 
> Makes sense. There's no point in testing that we ignore a .rev file in
> the outer repository, since we're using nongit to trigger this bug.
> 
> But it may be worth adding an additional test which doesn't use nongit,
> and instead invokes 'git multi-pack-index' from a Git repository, but
> points at another repo's object directory. That should give us some
> confidence that we're not deleting .rev files that we shouldn't.

Maybe you can just send that as a separate follow-up patch? :)

I'm not _entirely_ sure what you'd want to test, you could do at least
these things:

 * test like this that the correct file is deleted, from another repo
   instead of nongit
 * additionally arrange the *other* repo to have a .rev file and check
   that it's *not* deleted?

But to me all of the three (including my test) seem quite equivalent, at
least as long as we assume that the code won't grow a "try to delete all
the .rev files anywhere I can find" thing :)

johannes


