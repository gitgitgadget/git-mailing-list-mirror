Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D10D82047F
	for <e@80x24.org>; Wed, 20 Sep 2017 02:44:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751480AbdITCow (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Sep 2017 22:44:52 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56223 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751009AbdITCov (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Sep 2017 22:44:51 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E1908A9C2B;
        Tue, 19 Sep 2017 22:44:50 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=fSPAbzvaOSjJxZ9/WpXsjSeqLUk=; b=qVLEW8
        rGfDC+mmUEgdC7DupF7206F6fqCBEXYf4+qalU7nOf3JwhjZvOiVrw2g2kHoT/9k
        skTspYXHn7niAZ7w2YYbIy5QR1GK+jZ8X1fetJK6WnpRzHw8Shrhz5iPd+SxwlAp
        EvBnC6SGVVeJEeyIXm/uLQT12YWN0vOW4GE8M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=JKMLndaPdx+4PIHTeohBuwnQ/nkkYNkP
        chNtIW3uSwnNlOj2b9j2yMXWox/2YCx2ZcKpHTO7aaZaCI80DLwTEMFR87wVNfQj
        HEMNeJEenkCmFqOY0vRDcn+ZsCcNuYqel+mbCIa1eTzQg+KoVRnYFWnJ69V7mZaH
        JYbADwaz6TE=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D8C8CA9C2A;
        Tue, 19 Sep 2017 22:44:50 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 39A26A9C29;
        Tue, 19 Sep 2017 22:44:50 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v2 0/2] fix read past end of array in alternates files
References: <20170918155059.54f7z6cnrl47f5el@sigill.intra.peff.net>
        <20170919194044.3prgaxd4sqandy75@sigill.intra.peff.net>
Date:   Wed, 20 Sep 2017 11:44:48 +0900
In-Reply-To: <20170919194044.3prgaxd4sqandy75@sigill.intra.peff.net> (Jeff
        King's message of "Tue, 19 Sep 2017 15:40:44 -0400")
Message-ID: <xmqqmv5qozq7.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: AC3AA508-9DAD-11E7-8F6F-FE4B1A68708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Mon, Sep 18, 2017 at 11:51:00AM -0400, Jeff King wrote:
>
>> This series fixes a regression in v2.11.1 where we might read past the
>> end of an mmap'd buffer. It was introduced in cf3c635210, but I didn't
>> base the patch on there, for a few reasons:
>
> Here's a v2 that fixes a minor leak in the first patch (I carefully
> remembered to free() the path buffer on the error path, but forgot to do
> it in the normal one. Oops).

Thanks.

> I also tried to address Jonathan's "should this be in the commit
> message" comment. The information above _is_ in there, but maybe putting
> it at the top as a sort of tl;dr makes it easier to find?

Probably.

> The second patch is unchanged.
>
> Junio, I see you ended up back-porting it to v2.11. Would you prefer me
> to have done it that way in the first place? I was trying to reduce your
> work by basing it on "maint" (figuring that we wouldn't bother making a
> v2.11.x release anyway, and that skips you having to apply the second
> patch separately after the merge).

Upon seeing that this dated back to 2.11, because I am lazy and do
not assess how much the fix needs to go to older tracks when I am
queuing (remember: my attention span during patch queueing is
measured in minutes, as people send changes to different areas), I
tend to first try to see what's the oldest maintenance track we can
practically apply the patch to.  It turned out that the conflict
resolution to apply on maint-2.11 wasn't that painful, so I took the
lazy route all the way---the real fix on the oldest, even though I
do not know (because I refused to think and decide due to laziness)
if a next v2.11.x release is necessary, followed by a nice-to-have
warning that uses newer features on the maintenance track.  That
way, when we decide that the fix won't be a big deal to require a
new v2.11.x, but it is nice to have in v2.13.x, we could merge the
first one, without having to cherry-pick.

All of the above is part of how the daily maintainer workflow goes,
and there is no strong preference on my side, if the original is on
the theoretically oldest (i.e. maint-2.11) or on the oldest
practical (i.e. maint), as long as the conflicts are not too
painful.

