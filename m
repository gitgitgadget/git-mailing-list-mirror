Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B38D8C433F5
	for <git@archiver.kernel.org>; Mon, 22 Nov 2021 12:48:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239386AbhKVMv7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Nov 2021 07:51:59 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:59496 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229797AbhKVMv6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Nov 2021 07:51:58 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id CF0C41FD26;
        Mon, 22 Nov 2021 12:48:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1637585330; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=f0rrMUW9IOAukHzqDg+ugwszMv4waZRZuoS6EzeJKtA=;
        b=zZueHinogrvs8+lXpZR6QkG2SyiJHLHkYmXE6qeZyV4gBfZmcUtq+QAxeIy0QcMjCVzS+G
        6axphUN7KXK+AghJuk5Yms0/65Ust7kEzBLgDDtdVFElMNiV/8cxfYZFcMBY9dv0bbbz9R
        ew0rhEeCehSd2p1zbqmtfo9+BfvyC58=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1637585330;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=f0rrMUW9IOAukHzqDg+ugwszMv4waZRZuoS6EzeJKtA=;
        b=1yA0cNUX+Bs941OXsrejr5Ii3oPicmmR1Bpr+lFTCn8B9GxWmzfo53A0+SU3dHc20XTAWG
        UzbpE7jyXcmEIMDA==
Received: from quack2.suse.cz (unknown [10.100.200.198])
        by relay2.suse.de (Postfix) with ESMTP id B944FA3B84;
        Mon, 22 Nov 2021 12:48:50 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 9B9D81F2B50; Mon, 22 Nov 2021 13:48:50 +0100 (CET)
Date:   Mon, 22 Nov 2021 13:48:50 +0100
From:   Jan Kara <jack@suse.cz>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Chris Torek <chris.torek@gmail.com>, Jan Kara <jack@suse.cz>,
        Git List <git@vger.kernel.org>
Subject: Re: [PATCH 01/27] bisect: Fixup test rev-list-bisect/02
Message-ID: <20211122124850.GD24453@quack2.suse.cz>
References: <20211118164940.8818-1-jack@suse.cz>
 <20211118164940.8818-2-jack@suse.cz>
 <CAPx1GvdKuBmxN0XM3PKJO+0V=P3OoyB4VDzmqshv7N+3vFF8gw@mail.gmail.com>
 <nycvar.QRO.7.76.6.2111191653390.63@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.2111191653390.63@tvgsbejvaqbjf.bet>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri 19-11-21 17:31:22, Johannes Schindelin wrote:
> Hi,
> 
> On Thu, 18 Nov 2021, Chris Torek wrote:
> 
> > On Thu, Nov 18, 2021 at 10:38 AM Jan Kara <jack@suse.cz> wrote:
> > > diff --git a/t/t6002-rev-list-bisect.sh b/t/t6002-rev-list-bisect.sh
> > > index b95a0212adff..48db52447fd3 100755
> > > --- a/t/t6002-rev-list-bisect.sh
> > > +++ b/t/t6002-rev-list-bisect.sh
> > > @@ -247,8 +247,9 @@ test_expect_success 'set up fake --bisect refs' '
> > >  test_expect_success 'rev-list --bisect can default to good/bad refs' '
> > >         # the only thing between c3 and c1 is c2
> > >         git rev-parse c2 >expect &&
> > > -       git rev-list --bisect >actual &&
> > > -       test_cmp expect actual
> > > +       git rev-parse b2 >>expect &&
> > > +       actual=$(git rev-list --bisect) &&
> > > +       grep &>/dev/null $actual expect
> >
> > `&>` is a bashism; you need `>/dev/null 2>&1` here for general portability.
> 
> More importantly, why do you suppress the output in the first place? This
> will make debugging breakages harder.
> 
> Let's just not redirect the output?

Sure, I can leave error output alone. I'll do that.

> I do see a more structural problem here, though. Throughout the test
> suite, it is our custom to generate files called `expect` with what we
> consider the expected output, and then generate `actual` with the actual
> output. We then compare the results and complain if they are not
> identical.

A lot of bisection tests do not work like that. Just look through
t/t6030-bisect-porcelain.sh for example. I agree that the usage of 'expect'
and 'actual' may be misleading after my changes though so I will rename
them.

> With this patch, we break that paradigm. All of a sudden, `expect` is not
> at all the expected output anymore, but a haystack in which we want to
> find one thing.
> 
> And even after reading the commit message twice, I am unconvinced that b2
> (whatever that is) might be an equally good choice. I become even more
> doubtful about that statement when I look at the code comment at the
> beginning of the test case:
> 
> 	# the only thing between c3 and c1 is c2
> 
> So either this code comment is wrong, or the patch. And if the code
> comment is wrong, I would like to know when it became wrong, and how, and
> why it slipped through our review.

I agree the comment is confusing but it is more incomplete than outright
wrong. I can fix that. The graph operated by this test looks like:

b1--b2
 \    \
  \c1--c2--c3

b1 and c1 are marked as good, c3 is marked as bad. Now b2 & c2 are indeed
equivalent bisection choices because after picking any of them we may need
one more bisection step to identify the bad commit.

The test including the comment was introduced by 03df567fbf6a
("for_each_bisect_ref(): don't trim refnames") but I cannot really comment
on why the comment passed review :). IMO because it seems obvious enough...

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
