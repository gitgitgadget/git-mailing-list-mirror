Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 93FE41F6C1
	for <e@80x24.org>; Wed, 24 Aug 2016 19:39:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752876AbcHXTjc (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Aug 2016 15:39:32 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54163 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750899AbcHXTiD (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Aug 2016 15:38:03 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id EB7A4364BC;
        Wed, 24 Aug 2016 15:38:01 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=BDb4wsBzRz8LXQbGdyfARwnmFe4=; b=SNE1uz
        Hm8BG/jIc8Za9fBR5eGlha4i09aDICBu1B+vKDh+2K5xUYZErt0ThWD8jsylJk8+
        vN0hU8SHD/UDyarl6LyJFwbG5C9X4bE9njnxzg6YWP+Lxq7SPwQzXye40FUoCiXd
        /KReCPnSZDOTIShDML5wkch61rSa7Q2D9XMJ8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=RNBXmEahoKcHHf2Iv/p7skZlEVDtVnGq
        MN7omIVPGdHLcK7kWSGORS8Tgh9eJYJNPVAA1QIpXr/zqe0nbuLIBq6lEeg94TUS
        OdQar4p4z1Ops0/Wrap6QZnbRpLGYG70gczom+pJ4fPrF4xbm15ooLeUJ38UKy82
        e8fvKHMUGnU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E1D5D364BA;
        Wed, 24 Aug 2016 15:38:01 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id DE3F1364B8;
        Wed, 24 Aug 2016 15:38:00 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Stefan Beller <sbeller@google.com>, git@vger.kernel.org,
        hvoigt@hvoigt.net, Jens.Lehmann@web.de, iveqy@iveqy.com,
        leandro.lucarella@sociomantic.com
Subject: Re: [PATCHv2] push: change submodule default to check
References: <20160824173017.24782-1-sbeller@google.com>
        <20160824183112.ceekegpzavnbybxp@sigill.intra.peff.net>
Date:   Wed, 24 Aug 2016 12:37:58 -0700
In-Reply-To: <20160824183112.ceekegpzavnbybxp@sigill.intra.peff.net> (Jeff
        King's message of "Wed, 24 Aug 2016 14:31:13 -0400")
Message-ID: <xmqqh9aaot49.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4460C066-6A32-11E6-9924-51057B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

This seems to be dropped from the list, probably due to no "To:"
header in the original, which led to "no", "To-header" "on" and
"input <" on YOUR recipient list, so I am quoting it in full without
trimming.

> On Wed, Aug 24, 2016 at 10:30:17AM -0700, Stefan Beller wrote:
>
>> When working with submodules, it is easy to forget to push the submodules.
>> The setting 'check', which checks if any existing submodule is present on
>> at least one remote of the submodule remotes, is designed to prevent this
>> mistake.
>> 
>> Flipping the default to check for submodules is safer than the current
>> default of ignoring submodules while pushing.
>
> It is safer, and that's good. But it's also slower, because it requires
> an extra traversal of all of the pushed commits. And now people will
> have to pay the price even if they are not using submodules at all.
>
> For instance, try this from a checkout of linux.git:
>
>   for i in no check; do
> 	rm -rf dst.git
> 	git init --bare dst.git
> 	echo "==> Pushing with submodules=$i"
> 	time git push --recurse-submodules=$i dst.git HEAD
>   done
>
> The second case takes 30-40 seconds longer. This is a full push of
> history, so it's an extreme case[1], but it's still rather unfortunate.
>
> Can we tie this default to some sign that submodules are actually in
> use? I don't think the presence of .gitmodules is perfect (because you
> might be in a bare repo, for example, and have just fetched some other
> history you are relaying), but it may be a good compromise.  I'm
> envisioning something like "--recurse-submodules=auto-check" which
> auto-detects common situations (e.g., presence of .gitmodules or
> .git/modules checkouts) and enables "check", and then setting the
> default to that in the long run.
>
> -Peff
>
> [1] Actually, there is another much worse case lurking there. Try:
>
>       git push --recurse-submodules=check --mirror dst.git
>
>     from the kernel. I didn't let it finish, but I'd estimate it would
>     take on the order of 5 hours. The problem is that push feeds each
>     updated ref tip to find_unpushed_submodules(), so we end up walking
>     over the same history over and over.
>
>     I think it should feed all of the "before" and "after" ref tips it
>     proposes to update to a _single_ revision traversal.

That sounds massively ... broken.  So before even thinking about
flipping it to default, this needs to be fixed first.

>     I also notice that it uses "--remote=...", which is weird, because
>     push knows exactly what it proposes to update, which may be ahead of
>     where our refs/remotes/* cache is. Not to mention that we may be
>     pushing to a remote for which we do not keep tracking refs at all!
>
>     So I'd actually suspect that with your patch, a bare URL like:
>
>       git push https://github.com/peff/linux.git
>
>     would do the full 40-second walk, even if I was only pushing up one
>     or two objects.
