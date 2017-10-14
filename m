Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4CBB420445
	for <e@80x24.org>; Sat, 14 Oct 2017 02:37:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753235AbdJNChc (ORCPT <rfc822;e@80x24.org>);
        Fri, 13 Oct 2017 22:37:32 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61350 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751572AbdJNChb (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Oct 2017 22:37:31 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E648B9E464;
        Fri, 13 Oct 2017 22:37:30 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ZmlLtZz08PKv0HhjwN1fv0ynyCI=; b=DxbnK/
        8LH1pYuqX21tSOrb4rnESWKgYuRckcW5o+x8FU+Hz/vaT3MrGAf6ehVh25uzEixr
        iDoBsFZdbyocJi0yzNrSygKwC5gxI9JaIQ0H4zYkOxzh998sIElSfsgncFH6O8f/
        tk7Q94b8sFnqFYfMHfgfoQskax438/+9uhet4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=qaSZJUkpSYwRxV/w6nBos+dxJtHF5Iek
        ZNiQHXzI8/hgnU7kn39H5PP6iyIcDSyPYwYfsi8KFEU4gefBgG5LNSa1ynvwRPAm
        4P2RttVGFJvH4nEnVNuoX0/IlD8/ZzOTtxfdZ6HxLZvfTgofUQ2tVsHS2VOLbesi
        kGd+c9xlMww=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id DF5449E463;
        Fri, 13 Oct 2017 22:37:30 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 53CDE9E460;
        Fri, 13 Oct 2017 22:37:30 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Anthony Sottile <asottile@umich.edu>, git@vger.kernel.org
Subject: Re: [PATCH] diff: alias -q to --quiet
References: <20171013164415.6632-1-asottile@umich.edu>
        <20171013175656.qitarz6lvrppyb5f@sigill.intra.peff.net>
Date:   Sat, 14 Oct 2017 11:37:28 +0900
In-Reply-To: <20171013175656.qitarz6lvrppyb5f@sigill.intra.peff.net> (Jeff
        King's message of "Fri, 13 Oct 2017 13:56:56 -0400")
Message-ID: <xmqq60biv4if.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9FF20172-B088-11E7-B302-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> So there are two separate questions/tasks:
>
>   1. Should we remove the special handling of "-q" leftover from this
>      deprecation? I think the answer is yes.
>
>   2. Should we teach the diff machinery as a whole to treat "-q" as a
>      synonym for "--quiet".

Good questions.  And thanks for archaeology.

The topic #1 above is something that should have happened when "-q" stopped working
as "--diff-filter=d", and we probably should have started to error
out then, so that scripts that relied on the original behaviour
would have been forced to update.  That did not happen which was a
grave mistake.

By doing so, we would have made sure any script that uses "-q" died
out, and after a while, we can talk about reusing it for other
purposes, like the topic #2 above.

Is it worth making "-q" error out while doing #1 and keep it error
out for a few years?  I have a feeling that the answer might be
unfortunately yes _if_ we want to also do #2.  Even though we broke
"-q" for the scripts who wanted to see it ignore only the removals 4
years ago and left it broken since then.  Removals are much rarer
than modifications and additions, so it wouldn't be surprising if
the users of these scripts simply did not notice the old breakage,
but if we made "-q" to mean "--quiet" without doing #1, they will
break, as all diffs these scripts work on will suddenly give an
empty output.

If we aren't doing #2, then I do not think we need to make "-q"
error out when we do #1, though.

In any case, if we were to do both of the above two, they must
happen in that order, not the other way around.

Thanks.

