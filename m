Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D38731F462
	for <e@80x24.org>; Wed, 29 May 2019 23:10:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726576AbfE2XKR (ORCPT <rfc822;e@80x24.org>);
        Wed, 29 May 2019 19:10:17 -0400
Received: from resqmta-po-08v.sys.comcast.net ([96.114.154.167]:51274 "EHLO
        resqmta-po-08v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726411AbfE2XKQ (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 29 May 2019 19:10:16 -0400
Received: from resomta-po-08v.sys.comcast.net ([96.114.154.232])
        by resqmta-po-08v.sys.comcast.net with ESMTP
        id W0cWh6jlcFpWYW7i3hMMcb; Wed, 29 May 2019 23:10:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
        s=20190202a; t=1559171415;
        bh=kwctEUOiVi0cuerA4rLis2CK//dE0OJwHJHCNB4fI7E=;
        h=Received:Received:Date:From:To:Subject:Message-ID:MIME-Version:
         Content-Type;
        b=DORR3Ji/R+/fuC15GL2SGCJQrDX49BjArKP7lExU0JSiwK9iO0TcJ1Lr2jLG8DoIg
         E9at6to1LxRI/cZKGPXreqZ05v2zX+d825zJeUlYEKeQM2XMwL1YOhaqqKUn3FV4FD
         fLUdC/N4bqyKDPfmGCbUlKPXb/nHyTDba4ej1Fu8MDQsXCcPnHTDjU70rbysqBRnZW
         IK6ixBH0w5exjMh2kj//8r52jjd6GmIDYrsx0Xsa4zvfLSOVwotG+EbNzDFil/+Z/x
         +Km1Jgh3ZiRzHxObnNl5A0bgoAl96l12QfCOI1fhfG0XO0gu/m6dLXvjuMaEXlifWQ
         ZeXOG2PWpS+gw==
Received: from comcast.net ([IPv6:2601:647:4b02:2491:fc46:edea:c698:2e7a])
        by resomta-po-08v.sys.comcast.net with ESMTPSA
        id W7i1hsrFjtVCgW7i2hUf0P; Wed, 29 May 2019 23:10:15 +0000
X-Xfinity-VMeta: sc=-100;st=legit
Date:   Wed, 29 May 2019 16:10:13 -0700
From:   Matthew DeVore <matvore@comcast.net>
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Matthew DeVore <matvore@google.com>, jonathantanmy@google.com,
        jrn@google.com, git@vger.kernel.org, dstolee@microsoft.com,
        jeffhost@microsoft.com, jrnieder@gmail.com, pclouds@gmail.com
Subject: Re: [PATCH] list-objects-filter: merge filter data structs
Message-ID: <20190529231013.GD4700@comcast.net>
References: <cover.1558484115.git.matvore@google.com>
 <341bc55d4a3f5438b1523525cf683f96d75e8c3e.1558484115.git.matvore@google.com>
 <20190524004938.GB46998@google.com>
 <20190528184801.GA4556@comcast.net>
 <20190528224010.GA4700@comcast.net>
 <xmqq4l5dyrcu.fsf@gitster-ct.c.googlers.com>
 <e9147614-80f9-4c18-b431-539e2376295d@jeffhostetler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e9147614-80f9-4c18-b431-539e2376295d@jeffhostetler.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> > I am hoping that I am not misreading the intention but you do not
> > plan to use the above so that you can say "apply 'tree:depth=4' and
> > 'blobs:limit=1G' at the same time" by filling the fields in a single
> > struct, do you?  For combined filter, you'll still have multiple
> > instances of filter_data struct, strung together in a list that says
> > "all of these must be satisfied" or something like that, right?

It is the latter and not the former. I don't want to populate multiple filters
in a single struct. My idea was basically that when the fields got too numerous
we could use unions or add NULLable pointers for the bigger filter data structs,
so the data would be properly "optional".

On Wed, May 29, 2019 at 04:57:23PM -0400, Jeff Hostetler wrote:
> I'm not sure I like the combined structure as proposed.
> But let's think about it.
> 
> I think part of problem with my original version was putting the
> filter_fn and filter_free_fn in the traversal_context rather than
> inside the filter_*_data structure.

Agreed. This cleanup I'm proposing is basically something I was itching to do in
the process of bundling up the filter_fn and filter_free_fn pointers in a single
pointer, which makes the LOFC_COMBINE-particular filter data more concise.

I can still bundle up the pointers into a single pointer and make this cleanup
less aggressive.

> I did a simple combined structure for the list_objects_filter_options
> and kind of regretted it because it wasn't obvious which data fields
> were defined or undefined in each filter constructor.  But it was
> convenient when parsing the command line.
> 
> I think having a combined structure with a union enclosing a structure
> for the data fields in each filter type would be worth considering.
> That way you have a somewhat self-documenting sub-structure for each
> filter type that indicates which fields are defined.

I'm OK with the union approach. The drawback is that the __free function now
needs a switch block to choose the correct union, but the union is also good for
the self-documenting aspect you mention.

> 
> I'd also suggest keeping the "oidset omits" inside each of the
> sub-structures, but that's just me.
> 
> 
> BTW, I don't see a free_fn.  That may collapse out with your proposal
> but I wanted to ask.

See the list_objects_filter__free function. It's trivial, but it inherits the
leakiness of the sparse filters' free function it subsumes.

Thank you for considering the patch.
