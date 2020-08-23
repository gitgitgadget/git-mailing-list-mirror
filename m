Return-Path: <SRS0=2KbR=CB=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAC5CC433DF
	for <git@archiver.kernel.org>; Sun, 23 Aug 2020 20:41:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB50120774
	for <git@archiver.kernel.org>; Sun, 23 Aug 2020 20:41:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726765AbgHWUlq (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 23 Aug 2020 16:41:46 -0400
Received: from mimir.eigenstate.org ([206.124.132.107]:7614 "EHLO
        mimir.eigenstate.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726483AbgHWUlq (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 23 Aug 2020 16:41:46 -0400
Received: from oneeye (pool-74-101-2-6.nycmny.fios.verizon.net [74.101.2.6])
        by mimir.eigenstate.org (OpenSMTPD) with ESMTPSA id 5b2327d1 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256:NO);
        Sun, 23 Aug 2020 13:41:46 -0700 (PDT)
Date:   Sun, 23 Aug 2020 13:41:44 -0700
From:   Ori Bernstein <ori@eigenstate.org>
To:     =?UTF-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] Avoid infinite loop in malformed packfiles
Message-Id: <20200823134144.d57c80322f479eb554bab9d1@eigenstate.org>
In-Reply-To: <672843a1-b98c-7567-a078-a2dacd4b7074@web.de>
References: <20200823005236.10386-1-ori@eigenstate.org>
        <20200823031151.10985-1-ori@eigenstate.org>
        <672843a1-b98c-7567-a078-a2dacd4b7074@web.de>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; amd64-portbld-freebsd12.0)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, 23 Aug 2020 08:26:14 +0200, René Scharfe <l.s.r@web.de> wrote:

> Am 23.08.20 um 05:11 schrieb Ori Bernstein:
> > In packfile.c:1680, there's an infinite loop that tries to get
> > to the base of a packfile. With offset deltas, the offset needs
> > to be greater than 0, so it's always walking backwards, and the
> > search is guaranteed to terminate.
> >
> > With reference deltas, there's no check for a cycle in the
> > references, so a cyclic reference will cause git to loop
> > infinitely, growing the delta_stack infinitely, which will
> > cause it to consume all available memory as as a full CPU
> > core.
> 
> "as as"?  Perhaps "and"?

I think I meant 'As well as' -- will fix.
 
> 
> b5c0cbd8083 (pack-objects: use bitfield for object_entry::depth,
> 2018-04-14) limited the delta depth for new packs to 4095, so 10000
> seems reasonable.  Users with unreasonable packs would need to repack
> them with an older version of Git, though.  Not sure if that would
> affect anyone in practice.
> 
> >  #define UNPACK_ENTRY_STACK_PREALLOC 64
> 
> Hmm, setting a hard limit may allow to allocate the whole stack on the,
> ehm, stack.  That would get rid of the hybrid stack/heap allocation and
> thus simplify the code a bit.  10000 entries with 24 bytes each would be
> quite big, though, but that might be OK without recursion.  (And not in
> this patch anyway, of course.)
> 
> >  struct unpack_entry_stack_ent {
> >  	off_t obj_offset;
> > @@ -1715,6 +1716,12 @@ void *unpack_entry(struct repository *r, struct packed_git *p, off_t obj_offset,
> >  			break;
> >  		}
> >
> > +		if (delta_stack_nr > UNPACK_ENTRY_STACK_LIMIT) {
> > +			error("overlong delta chain at offset %jd from %s",
> > +			      (uintmax_t)curpos, p->pack_name);
> > +			goto out;
> > +		}
> 
> Other error handlers in this loop set data to NULL.  That's actually
> unnecessary because it's NULL to begin with and the loop is exited after
> setting it to some other value.  So not doing it here is fine.  (And a
> separate cleanup patch could remove the dead stores in the other
> handlers.)

Is there anything you'd like me to do in this patch, other than fixing
the typo?

-- 
    Ori Bernstein
