Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9734620958
	for <e@80x24.org>; Sat,  1 Apr 2017 18:04:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751829AbdDASEj (ORCPT <rfc822;e@80x24.org>);
        Sat, 1 Apr 2017 14:04:39 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59942 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751791AbdDASEj (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 1 Apr 2017 14:04:39 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 342438B735;
        Sat,  1 Apr 2017 14:04:38 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=r8e3GkKM31pGv9WMpUdlYvUJ1rs=; b=ABQ3bl
        m9WAFmC6gU6PBGUVLCRlfmf0s4DXAzt1lK5PkRQZIupIQGA7XhxRf2gfDmCJ5C4o
        dJdObLxtqWYW9z8PfgL6X0ADWzyqOje+pZ2jQjD1/EETCtDYAq5oCIHtEzCTR8Ai
        Eg5C2skdmNYmqXAmXDGxb1/e/c+6B1NLSaQs4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=GhJmJxstCUW0bfcCtPRvvTJ8cag28Ba7
        OJaYca4IQV8VDIhTrvm0k34JhqqQGKWjFzAtal4L9+mruNv+pmYAuQOTmTcTMbfv
        P3WjQniNFORM3nDkQfSFdqvLddPhw9vtSJ3dspCuETVMQbrimBkERwEg/YRfv5iE
        pjPTNHRb6Lo=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2ACD88B734;
        Sat,  1 Apr 2017 14:04:38 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 323F08B733;
        Sat,  1 Apr 2017 14:04:37 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Lars Schneider <larsxschneider@gmail.com>,
        Git List <git@vger.kernel.org>
Subject: Re: [PATCH 2/2] index-pack: detect local corruption in collision check
References: <20170401080349.lccextuc3l6fgs6j@sigill.intra.peff.net>
        <20170401080931.t67jbtta4w4enui6@sigill.intra.peff.net>
Date:   Sat, 01 Apr 2017 11:04:34 -0700
In-Reply-To: <20170401080931.t67jbtta4w4enui6@sigill.intra.peff.net> (Jeff
        King's message of "Sat, 1 Apr 2017 04:09:32 -0400")
Message-ID: <xmqqshlsuhql.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: AB2C5546-1705-11E7-B9C9-97B1B46B9B0B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> is not a collision but rather local corruption. We should
> reoprt that instead (just like we do if reading the rest of
> the object content fails a few lines later).

s/reoprt/report/ (locally amended while queuing).

> We may want to tighten that up. In the long run, I'd love to see
> unpack-objects go away in favor of teaching index-pack how to write
> loose objects. The two had very similar code once upon a time, but
> index-pack has grown a lot of feature and bugfixes over the years.

This sounds like a nice future to aspire to reach.  

Besides having to maintain two separate executables, another
downside of the current arrangement is that we have to make the
decision between streaming to a single pack and exploding into loose
objects too early and base our decision solely on the object count.
If we are moving to a single receiver, it is conceivable to switch
to a scheme based on the size of the incoming pack (e.g. spool the
first N MB and if we run out we write out loose objects, otherwise
create a new pack, and dump the spooled part and stream the rest
into it while indexing).

Thanks.
