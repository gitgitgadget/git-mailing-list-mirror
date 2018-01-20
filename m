Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 649531F424
	for <e@80x24.org>; Sat, 20 Jan 2018 22:14:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756732AbeATWOz (ORCPT <rfc822;e@80x24.org>);
        Sat, 20 Jan 2018 17:14:55 -0500
Received: from imap.thunk.org ([74.207.234.97]:41206 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756652AbeATWOv (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 Jan 2018 17:14:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=thunk.org;
         s=ef5046eb; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=2e4dqcjMge9DYIPHTxEF2qXFQFb4zvzaSioR4/Z7KlI=; b=JaKtLTLJf2KYAeKRFCpe3h5K7/
        8jLOd6bxCgJU1Hf1pZ8OmBwjFqiSWUxvsUCcSSxRDzeYDRmjaGAhxb8RdwqTec52IzbYo2FIOtrZu
        fTjFC2Sdz+kpCHl5pzPgdDBau56IurOTS5Ng39AlvJqHUbtPWmyt9qJYVrg8qh18ZiHo=;
Received: from root (helo=callcc.thunk.org)
        by imap.thunk.org with local-esmtp (Exim 4.89)
        (envelope-from <tytso@thunk.org>)
        id 1ed1PS-00082T-Mq; Sat, 20 Jan 2018 22:14:46 +0000
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 057D4C0021E; Sat, 20 Jan 2018 17:14:45 -0500 (EST)
Date:   Sat, 20 Jan 2018 17:14:45 -0500
From:   Theodore Ts'o <tytso@mit.edu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Chris Mason <clm@fb.com>
Subject: Re: [PATCH] enable core.fsyncObjectFiles by default
Message-ID: <20180120221445.GA4451@thunk.org>
References: <20180117184828.31816-1-hch@lst.de>
 <xmqqd128s3wf.fsf@gitster.mtv.corp.google.com>
 <87h8rki2iu.fsf@evledraar.gmail.com>
 <CA+55aFzJ2QO0MH3vgbUd8X-dzg_65A-jKmEBMSVt8ST2bpmzSQ@mail.gmail.com>
 <20180117235220.GD6948@thunk.org>
 <CA+55aFxgg6MT5Z+Jox2xyG28g9jNJ4cL3jNZ5AgTOmUODuiBsA@mail.gmail.com>
 <20180118162721.GA26078@lst.de>
 <xmqqzi59psxt.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqzi59psxt.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 19, 2018 at 11:08:46AM -0800, Junio C Hamano wrote:
> So..., is it fair to say that the one you sent in
> 
>   https://public-inbox.org/git/20180117193510.GA30657@lst.de/
> 
> is the best variant we have seen in this thread so far?  I'll keep
> that in my inbox so that I do not forget, but I think we would want
> to deal with a hotfix for 2.16 on case insensitive platforms before
> this topic.

It's a simplistic fix, but it will work.  There may very well be
certain workloads which generate a large number of loose objects
(e.g., git repack -A) which will make things go significantly more
slowly as a result.  It might very well be the case that if nothing
else is going on, something like "write all the files without
fsync(2), then use syncfs(2)" would be much faster.  The downside with
that approach is if indeed you were downloading a multi-gigabyte DVD
image at the same time, the syncfs(2) will force a writeback of the
partially writte DVD image, or some other unrelated files.

But if the goal is to just change the default, and then see what
shakes out, and then apply other optimizations later, that's certainly
a valid result.  I've never been fond of the "git repack -A" behavior
where it can generate huge numbers of loose files.  I'd much prefer it
if the other objects ended up in a separate pack file, and then some
other provision made for nuking that pack file some time later.  But
that's expanding the scope significantly over what's currently being
discussed.

						- Ted
