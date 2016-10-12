Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2EB01207EC
	for <e@80x24.org>; Wed, 12 Oct 2016 17:37:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755840AbcJLRhl (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Oct 2016 13:37:41 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51016 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1755806AbcJLRhi (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Oct 2016 13:37:38 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D35F745DDD;
        Wed, 12 Oct 2016 13:37:35 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=raUPDrQ7SFBCoE1Q2ursfxINRGw=; b=U/+BzR
        EtNT2rdxcLW91UcB70kkXFsIl+FsXWa50Jizl0Xw3WfRCo35lPJgH4wzhpH1h2hg
        p/UAkdE934glLuyrsUSuQJXzNHo5jEuBEFwWgWWwlYgVRIcfzwot1iUPMUuT4g6E
        hQxvZbqszgvchL9xdC4EV4L2j/vx+l/OzIs+g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=atSajpMC8BJ2o/dS/9dwuVwSSTqyWvYn
        /jAfPruRuFx8oc/JCXPOS7Nt7p9QFw37WpVfQeaYJAEPImzBk9TG/HcnT9m+hRgc
        f1k/fIpRyj3henxDUKj0Kh1GWRvXsvq2n7cdX5LNU/75wWb0kEsEyBGu6BOqmg+0
        PVaSyLh6O2w=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C9C4845DDC;
        Wed, 12 Oct 2016 13:37:35 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 32D1D45DDB;
        Wed, 12 Oct 2016 13:37:35 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Heiko Voigt <hvoigt@hvoigt.net>
Cc:     Jeff King <peff@peff.net>, Stefan Beller <sbeller@google.com>,
        git@vger.kernel.org, Jens.Lehmann@web.de,
        Fredrik Gustafsson <iveqy@iveqy.com>,
        Leandro Lucarella <leandro.lucarella@sociomantic.com>
Subject: Re: [PATCH v2 3/3] batch check whether submodule needs pushing into one call
References: <cover.1475851621.git.hvoigt@hvoigt.net>
        <cover.1475851621.git.hvoigt@hvoigt.net>
        <67d4c48dc0129f20041c88d27a49c7a21188c882.1475851621.git.hvoigt@hvoigt.net>
        <xmqqlgxvbype.fsf@gitster.mtv.corp.google.com>
        <20161012133338.GD84247@book.hvoigt.net>
Date:   Wed, 12 Oct 2016 10:37:33 -0700
In-Reply-To: <20161012133338.GD84247@book.hvoigt.net> (Heiko Voigt's message
        of "Wed, 12 Oct 2016 15:33:38 +0200")
Message-ID: <xmqqwphd4gf6.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8FC9B63E-90A2-11E6-88AF-F99D12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Heiko Voigt <hvoigt@hvoigt.net> writes:

>> If we do not even have these commits locally, then there is no point
>> attempting to push, so returning 0 (i.e. it is not "needs pushing"
>> situation) is correct but it is a but subtle.  It's not "we know
>> they already have them", but it is "even if we tried to push, it
>> won't do us or the other side any good."  A single-liner in-code
>> comment may help.
>
> First the naming part. How about:
>
> 	submodule_has_commits()

Nice.

> Returning 0 here means: "No push needed" but the correct answer would
> be: "We do not know". 

Is it?  Perhaps I am misreading the "submodule-has-commits"; I
thought it was "the remote may or may not need updating, but we
ourselves don't have what they may need to have commits in their
submodule that are referenced by their superproject, so it would not
help them even if we pushed our submodule to them".  It indeed is
different from "No push needed" (rather, "our pushing would be
pointless").

> So how about:
>
>
> 	if (!submodule_has_hashes(path, hashes))
> 		/* NEEDSWORK: The correct answer here is "We do not
> 		 * know" instead of "No". We currently proceed pushing
> 		 * here as if the submodules commits are available on a
> 		 * remote, which is not always correct. */
> 		return 0;

I am not sure.  

What should happen in this scenario?

 * We have two remotes, A and B, for our superproject.

 * We are not interested in one submodule at path X.  Our repository
   is primarily used to work on the superproject and possibly other
   submodules but not the one at path X.

 * We pulled from A to update ourselves.  They were actively working
   on the submodule we are not interested in, and path X in the
   superproject records a new commit that we do not have.

 * We are now trying to push to B.

Should different things happen in these two subcases?

 - We are not interested in submodule at path X, so we haven't even
   done "submodule init" on it.

 - We are not interested in submodule at path X, so even though we
   do have a rather stale clone of it, we do not usually bother
   updating what is checked out at path X and commit our changes
   outside that area.

I tend to think that in these two cases the same thing should
happen.  I am not sure if that same thing should be rejection
(i.e. "you do not know for sure that the commit at path X of the
superproject you are pushing exists in the submodule repository at
the receiving end, so I'd refuse to push the superproject"), as it
makes the only remedy for the situation is for you to make a full
clone of the submodule you are not interested in and you have never
touched yourself in either of these two subcases.


