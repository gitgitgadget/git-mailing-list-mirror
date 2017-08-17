Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 00EAF208D0
	for <e@80x24.org>; Thu, 17 Aug 2017 19:22:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753147AbdHQTW3 (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 Aug 2017 15:22:29 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56916 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752403AbdHQTW3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Aug 2017 15:22:29 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7FCECA9EA7;
        Thu, 17 Aug 2017 15:22:21 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=VZ4HMomKMiGXKMlOrUjnEwckhlw=; b=hv/WlQ
        Y/JJhgWH7FKmGSN0yAfGNwiqD6dy4r/tPuLRfusxeLLbBZQvSAYvkfTpe0aaC+wk
        U7OV2UbX5s1umsDTBXyICwRwv4HJcD3ODnS3+GIvbuY8mzQJEOLqhIbBBdjM8LQk
        Iej/6aNjCh9mKfcyGlfEr5C7QiZgDCHlJ82xA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=KcuM4NV4oLHNxopDE8SiE0inRMocUtPR
        r1tIA4zmjcQdP+2PuT2OOwHEg+UQoNWQYvkYPIggJzTvzhkYtjF4oT/p7sHpD9MJ
        QU0mdwPMJJEv7KsThEC85bsSuBXDH7WFdz5W7F+BXHEjHa2NF0/eBHU5i+0vciKm
        CnJ/sT5vw3g=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 739F6A9EA6;
        Thu, 17 Aug 2017 15:22:21 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id D6211A9EA5;
        Thu, 17 Aug 2017 15:22:20 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Simon Ruderich <simon@ruderich.org>, git@vger.kernel.org
Subject: Re: git add -p breaks after split on change at the top of the file
References: <20170816202442.aumzwa443spqgyul@ruderich.org>
        <20170817084109.ba7g2hnymtwqeclw@sigill.intra.peff.net>
        <20170817090308.yh3jnztgfmkwtqpr@sigill.intra.peff.net>
        <20170817091503.vsd4lncogphy5gxx@sigill.intra.peff.net>
Date:   Thu, 17 Aug 2017 12:22:19 -0700
In-Reply-To: <20170817091503.vsd4lncogphy5gxx@sigill.intra.peff.net> (Jeff
        King's message of "Thu, 17 Aug 2017 05:15:04 -0400")
Message-ID: <xmqq60dmgftg.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 63F1BF48-8381-11E7-99FC-9D2B0D78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Of course this is a pretty ridiculous input in the first place. In
> theory it _could_ be figured out, but overlapping hunks like this are
> always going to cause problems (in this case, context from the second
> hunk became a removal, and the second hunk no longer applies).

To be honest, I do not think it could be figured out by "git apply",
but "git add -p" _should_ be able to.  I've said already this
earlier in the discussion:

  https://public-inbox.org/git/7vab5cn7wr.fsf@alter.siamese.dyndns.org/

"add -p" knows how the hunk _before_ it gave the user to edit looked
like, and it knows how the hunk after the user edited looks like, so
it may have enough information to figure it out.  But the "(e)dit"
feature was done in a way to discard that information and forced an
impossible "guess what the correct shape of the patch would be, out
of this broken patch input" with --recount and --allow-overlap.  

If we want to make "add -p/(e)dit" work in the corner cases and make
it trustworthy, "apply" is a wrong tree to back at.  A major part of
the effort to fix would go to "add -p", not to "apply".

