Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3140A20450
	for <e@80x24.org>; Wed,  1 Nov 2017 06:09:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751165AbdKAGJl (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 Nov 2017 02:09:41 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:64549 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750716AbdKAGJk (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Nov 2017 02:09:40 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 818379917A;
        Wed,  1 Nov 2017 02:09:39 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=3r1cH2I76s13Zt4wZkx/SSNcZIw=; b=n405Yr1EfXUBR7VXhHA8
        7+9rIlpkT/6CoBwhFxdP/D8Eq0xwXI3vTu+SjPUXHq3me72eJoMiCuvhIpmPPUHc
        BlvgQcjfp/myyZSGSHaU9rSwjwqgI8usPQpQlN5TO3RvQjjwcvXQhiuPU2gDlbIb
        rvW0wZrPqqr7dNJdHH/45Lc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         q=dns; s=sasl; b=K1JF4dscIhxOPKbQ/5EFUVxDz2+uWuYsaRNpcz6Ko3b89R
        UCMiHGs45nHtECjTz0YxI1sBec9ik0FAXsk4kMw7wiwgfUQeC6pZmR1ucfl1qyP+
        VOV30CWZLgN5OGPEhEb9+uctdurvTfVuTShzeMs72pxJElSlI1ojjhD+Ty4Sw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7975399177;
        Wed,  1 Nov 2017 02:09:39 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id DC8A899176;
        Wed,  1 Nov 2017 02:09:38 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Ben Peart <peartben@gmail.com>, Alex Vandiver <alexmv@dropbox.com>,
        Ben Peart <benpeart@microsoft.com>, git@vger.kernel.org,
        chriscool@tuxfamily.org, t.gummerer@gmail.com, l.s.r@web.de,
        jsorianopastor@gmail.com,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2] read_index_from(): Skip verification of the cache entry order to speed index loading
References: <20171018142725.10948-1-benpeart@microsoft.com>
        <20171024144544.7544-1-benpeart@microsoft.com>
        <11666ccf-6406-d585-f519-7a1934c2973a@gmail.com>
        <20171030180334.ddursnmj5wqgimqu@sigill.intra.peff.net>
        <alpine.DEB.2.10.1710301727160.10801@alexmv-linux>
        <f671ea09-d4aa-64aa-8225-c1fbf2eac175@gmail.com>
        <20171031171058.vs5aau5x26ebx7kq@sigill.intra.peff.net>
Date:   Wed, 01 Nov 2017 15:09:37 +0900
Message-ID: <xmqqo9omttr2.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3E3BCC96-BECB-11E7-BB7E-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Tue, Oct 31, 2017 at 09:01:45AM -0400, Ben Peart wrote:
>
>> > > But what we probably _do_ need is to make sure that "git fsck" would
>> > > detect such an out-of-order index. So that developers and users alike
>> > > can diagnose suspected problems.
>> > 
>> > Agree -- that seems like a better home for this logic.
>> 
>> That is how version 1 of this patch worked but the feedback to that patch
>> was to remove it "not only during the normal operation but also in fsck."
>
> Sorry for the mixed messages (I think they are mixed between different
> people, and not mixed _just_ from me ;) ).
>
> For what it's worth, I like your v1, but can live with either approach.

I agree that v1 is the less bad one between the two.

To be honest, if the original code were done in that way (i.e. the
state with v1 applied), I probably would have had a very hard time
to justify accepting a patch to "make it safer by always checking at
runtime" (i.e. a reverse of v1 patch).

So, let's go with v1.  Thanks, all.

