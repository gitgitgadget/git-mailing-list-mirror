Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C28331FF6D
	for <e@80x24.org>; Fri, 16 Dec 2016 00:13:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936571AbcLPANn (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Dec 2016 19:13:43 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:50769 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S933300AbcLPANl (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Dec 2016 19:13:41 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A2968596CB;
        Thu, 15 Dec 2016 19:13:40 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=6rg6GYOEfwo6Vh4mjFKYQ382f98=; b=eqtMsR
        DaVx+oCvp2acn3ifaQ85LU/IAgu7LuRsV4Gt5ea8NYI+gbcgWS/zEX7RD40jmk34
        UAu00uFO/dkRXWDo29usralDlfOwZaj+DHldi6VGVMmqWk4hoeVoDv+ZmkQsGwDA
        TL/oykRsFYBjko665DoIYsN3vZkn30ad/gY+M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=JgDrwgY78tDknVya/nSHdwEnncVKCI18
        zQr213lU4zvLlBAUnTVWhH8WPWO2kQVRF8xpDftaeWI5PRCOxP9D9a1aEIsNMdj+
        yEGlP5RVWkarqGpSDGCRsq8kBN9mseUhN7CqkHF5bpr7QwyU4xGZ8VlFkgnNj/Ia
        fVPO+rR9HYs=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 98C97596CA;
        Thu, 15 Dec 2016 19:13:40 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 16426596C9;
        Thu, 15 Dec 2016 19:13:40 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: index-pack outside of repository?
References: <20161215204000.avlcfaqjwstkptu2@sigill.intra.peff.net>
Date:   Thu, 15 Dec 2016 16:13:38 -0800
In-Reply-To: <20161215204000.avlcfaqjwstkptu2@sigill.intra.peff.net> (Jeff
        King's message of "Thu, 15 Dec 2016 15:40:00 -0500")
Message-ID: <xmqqshpou3wt.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7F29AB86-C324-11E6-BFE8-E98412518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> In older versions of git will just blindly write into
> ".git/objects/pack", even though there's no repository there.
>
> So I think complaining to the user is the right thing to do here. I
> started to write a patch to have index-pack notice when it needs a repo
> and doesn't have one, but the logic is actually a bit unclear.  Do we
> need to complain early _just_ when --stdin is specified, or does that
> miss somes cases?  Likewise, are there cases where --stdin can operate
> without a repo? I couldn't think of any.

I think there are two and only two major modes; --stdin wants to put
the result in the repository it is working on, while the other mode
takes a filename to deposit the result in, so the latter does not
technically need a repository.

> I'm actually wondering if the way it calls die() in 'next' is a pretty
> reasonable way for things to work in general. It happens when we lazily
> try to ask for the repository directory. So we don't have to replicate
> logic to say "are we going to need a repo"; at the moment we need it, we
> notice we don't have it and die. The only problem is that it says "BUG"
> and not "this operation must be run in a git repository".

Isn't what we currently have is a good way to discover which
codepaths we missed to add a check to issue the latter error?

> That strategy _might_ be a problem for some programs, which would want
> to notice the issue early before doing work. But it seems like a
> reasonable outcome for index-pack. Thoughts?

That is, once we know which codepaths should require a repository, I
think it is reasonable to add a check that is done earlier than the
place where we currently try to see where we have one (which could
be deep in the callchain).  But we are all human and can miss things,
so the BUG() thing is probably fine.  We are cooking it exactly because
we would want to find such corner cases we missed, no?
