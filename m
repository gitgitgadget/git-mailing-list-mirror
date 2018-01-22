Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 185381F404
	for <e@80x24.org>; Mon, 22 Jan 2018 18:09:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751170AbeAVSJK (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 Jan 2018 13:09:10 -0500
Received: from imap.thunk.org ([74.207.234.97]:45382 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751102AbeAVSJJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Jan 2018 13:09:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=thunk.org;
         s=ef5046eb; h=In-Reply-To:Content-Transfer-Encoding:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=1uJ8enMKTYS7OuXV32ob47wQabDbc1FBmV4dbPIU0NE=; b=gYkUw8dJUT2HBVEp+JLMFinos6
        20JAAUYpYPn0zg6/P/mJgBUfJTtbS098Dv2ZJ70oxDXoh4kJfXIPltZplhCRywETh7G1yQWubfMAj
        07g1J8CVHyzXumTI2rsg3JqXj5ay4PkwSRFfCnZn6kMXnege/UqX7rnwuVMmOxPzgMYg=;
Received: from root (helo=callcc.thunk.org)
        by imap.thunk.org with local-esmtp (Exim 4.89)
        (envelope-from <tytso@thunk.org>)
        id 1edgWm-0004Kk-9T; Mon, 22 Jan 2018 18:09:04 +0000
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 3A7DBC00387; Mon, 22 Jan 2018 13:09:03 -0500 (EST)
Date:   Mon, 22 Jan 2018 13:09:03 -0500
From:   Theodore Ts'o <tytso@mit.edu>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Christoph Hellwig <hch@lst.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Git Mailing List <git@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Chris Mason <clm@fb.com>, Jeff King <peff@peff.net>
Subject: Re: [PATCH] enable core.fsyncObjectFiles by default
Message-ID: <20180122180903.GB3513@thunk.org>
References: <xmqqd128s3wf.fsf@gitster.mtv.corp.google.com>
 <87h8rki2iu.fsf@evledraar.gmail.com>
 <CA+55aFzJ2QO0MH3vgbUd8X-dzg_65A-jKmEBMSVt8ST2bpmzSQ@mail.gmail.com>
 <20180117235220.GD6948@thunk.org>
 <CA+55aFxgg6MT5Z+Jox2xyG28g9jNJ4cL3jNZ5AgTOmUODuiBsA@mail.gmail.com>
 <20180118162721.GA26078@lst.de>
 <xmqqzi59psxt.fsf@gitster.mtv.corp.google.com>
 <20180120221445.GA4451@thunk.org>
 <xmqqefmknp3f.fsf@gitster.mtv.corp.google.com>
 <871siihqvw.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <871siihqvw.fsf@evledraar.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jan 22, 2018 at 04:09:23PM +0100, Ævar Arnfjörð Bjarmason wrote:
> > What's tricky is to devise a way to allow us to salvage objects that
> > are placed in a cruft pack because they are accessed recently,
> > proving themselves to be no longer crufts.  It could be that a good
> > way to resurrect them is to explode them to loose form when they are
> > accessed out of a cruft pack.  We need to worry about interactions
> > with read-only users if we go that route, but with the current
> > "explode unreachable to loose, touch their mtime when they are
> > accessed" scheme ends up ignoring accesses from read-only users that
> > cannot update mtime, so it might not be too bad.
> 
> Wouldn't it also make gc pruning more expensive? Now you can repack
> regularly and loose objects will be left out of the pack, and then just
> rm'd, whereas now it would entail creating new packs (unless the whole
> pack was objects meant for removal).

The idea is that the cruft pack would be all objects that were no
longer referenced.  Hence the proposal that if they ever *are*
accessed, they would be exploded to a loose object at that point.  So
in the common case, the GC would go quickly since the entire pack
could just be rm'ed once it hit the designated expiry time.

Another way of doing things would be to use the mtime of the cruft
pack for the expiry time, and if the curft pack is ever referenced,
its mtime would get updated.  Yet a third way would be to simply clear
the "cruft" bit if it ever *is* referenced.  In the common case, it
would never be referenced, so it could just get deleted, but in the
case where the user has manually "rescued" a set of commits (perhaps
by explicitly setting a branch head to commit id found from a reflog),
the objects would be saved.

So there are many ways it could be managed.

							- Ted
