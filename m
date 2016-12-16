Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN:  
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B20F91FF40
	for <e@80x24.org>; Fri, 16 Dec 2016 21:40:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933681AbcLPVkT (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Dec 2016 16:40:19 -0500
Received: from sub3.mail.dreamhost.com ([69.163.253.7]:56078 "EHLO
        homiemail-a18.g.dreamhost.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933002AbcLPVkS (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 16 Dec 2016 16:40:18 -0500
X-Greylist: delayed 2084 seconds by postgrey-1.27 at vger.kernel.org; Fri, 16 Dec 2016 16:40:18 EST
Received: from homiemail-a18.g.dreamhost.com (localhost [127.0.0.1])
        by homiemail-a18.g.dreamhost.com (Postfix) with ESMTP id 14F77258067;
        Fri, 16 Dec 2016 13:40:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=novalis.org; h=message-id
        :subject:from:to:cc:date:in-reply-to:references:content-type
        :mime-version:content-transfer-encoding; s=novalis.org; bh=hEW96
        q/RByg2y1HxrPKNj2do7JM=; b=ikhD6g14Eegrx647jpsIJtItaQm4L39GbtuyU
        nwp/pDClnS4u8YLLdUhLxhfNagzh8tDQe9CJxWNsmP47A22s18BLeuOBMHjCzDt3
        XTFVL5B8dGIvPltk2dBSe8QSMkBARhAiXDTJkCQq6dhm+LmWdVv1J8G7OPotmG7u
        iKCf2Y=
Received: from [172.31.11.72] (gzac10-107-1.nje.twosigma.com [208.77.214.155])
        (using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: novalis@novalis.org)
        by homiemail-a18.g.dreamhost.com (Postfix) with ESMTPSA id 9621F258066;
        Fri, 16 Dec 2016 13:40:17 -0800 (PST)
Message-ID: <1481924416.28176.19.camel@frank>
Subject: Re: "disabling bitmap writing, as some objects are not being
 packed"?
From:   David Turner <novalis@novalis.org>
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        =?UTF-8?Q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc?= Duy 
        <pclouds@gmail.com>
Date:   Fri, 16 Dec 2016 16:40:16 -0500
In-Reply-To: <20161216213214.z3mzkp2xqnwrqkh2@sigill.intra.peff.net>
References: <1481922331.28176.11.camel@frank>
         <xmqqpokrr2cf.fsf@gitster.mtv.corp.google.com>
         <20161216213214.z3mzkp2xqnwrqkh2@sigill.intra.peff.net>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, 2016-12-16 at 16:32 -0500, Jeff King wrote:
> On Fri, Dec 16, 2016 at 01:28:00PM -0800, Junio C Hamano wrote:
> 
> > > 2. I don't understand what would cause that message.  That is, what bad
> > > thing am I doing that I should stop doing?  I've briefly skimmed the
> > > code and commit message, but the answer isn't leaping out at me.
> > 
> > Enabling bitmap generation for incremental packing that does not
> > cram everything into a single pack is triggering it, I would
> > presume.  Perhaps we should ignore -b option in most of the cases
> > and enable it only for "repack -a -d -f" codepath?  Or detect that
> > we are being run from "gc --auto" and automatically disable -b?  I
> > have a feeling that an approach along that line is closer to the
> > real solution than tweaking report_last_gc_error() and trying to
> > deduce if we are making any progress.
> 
> Ah, indeed. I was thinking in my other response that "git gc" would
> always kick off an all-into-one repack. But "gc --auto" will not in
> certain cases. And yes, in those cases you definitely would want
> --no-write-bitmap-index. I think it would be reasonable for "git repack"
> to disable bitmap-writing automatically when not doing an all-into-one
> repack.

I do not have alternates and am not using --local.  Nor do I have .keep
packs.

I would assume, based on the documentation, that auto gc would be doing
an all-into-one repack:
"If the number of packs exceeds the value of gc.autopacklimit, then
 existing packs (except those marked with a .keep file) are
 consolidated into a single pack by using the -A option of git
 repack."

I don't have any settings that limit the size of packs, either.  And a
manual git repack -a -d creates only a single pack.  Its loneliness
doesn't last long, because pretty soon a new pack is created by an
incoming push.

Unless this just means that some objects are being kept loose (perhaps
because they are unreferenced)? 


