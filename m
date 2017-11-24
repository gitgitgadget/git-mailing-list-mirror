Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8071220A40
	for <e@80x24.org>; Fri, 24 Nov 2017 05:29:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753192AbdKXF3P (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 Nov 2017 00:29:15 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52718 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750992AbdKXF3O (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Nov 2017 00:29:14 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 395F1AC077;
        Fri, 24 Nov 2017 00:29:13 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Ysoh8Qm6fwgTitBhFI9KM2NwuCw=; b=dok5xB
        TQR4QLgoGCXmk56twQ3l4PqGU9NGZ0zQX0gMelcGrSNzD6ObmnxQ6uOZ+nwe30R3
        qA1HzQvfnUndRpkDuY3dsAVB3+mygfD0AoNrrZxfSlwzadFcwDZTHnLCOLJWMubY
        jMPzAXAp2PXwHyyHMKEe4UkUYtco/ACZxb82A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=trxWPPEfxAX1/d9nn/jARcyYMKFHmzRx
        SYKJna06qcYUkQUGAm0aoHBWvy9teunwjX9HHYq38yF6hqvq/2d4gIMnI4iLAXRK
        YGTIrxG/imw8xOYizZN4TLlpe5UgeRqMLfFozmOWk6j+JztvjiXmKzJenYUi6MuI
        9skTthMSG+c=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 300D4AC076;
        Fri, 24 Nov 2017 00:29:13 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 9221BAC074;
        Fri, 24 Nov 2017 00:29:12 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Adam Dinwoodie <adam@dinwoodie.org>,
        Christian Couder <christian.couder@gmail.com>,
        git <git@vger.kernel.org>
Subject: Re: Bisect marking new commits incorrectly
References: <20171122143902.GO20681@dinwoodie.org>
        <CAP8UFD35-z9qA_m28EbpvN-X_HVcDvEirn69DJNESikJ=Txg7g@mail.gmail.com>
        <20171122170129.GS20681@dinwoodie.org> <20171122213751.GC2854@sigill>
Date:   Fri, 24 Nov 2017 14:29:11 +0900
In-Reply-To: <20171122213751.GC2854@sigill> (Jeff King's message of "Wed, 22
        Nov 2017 16:37:52 -0500")
Message-ID: <xmqq8tewp7mg.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6781A7FA-D0D8-11E7-83E8-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Yeah, I really would have expected this to work, too. Should we be
> taking the merge base of the set of "new" commits, and using that as the
> true "new"?
> ...
> So maybe that's not workable.
>
> (I've never really dug into the bisect algorithm, and this is written
> largely off the cuff, so I'm fine if the response is "nope, you have no
> idea what you are talking about").

You reached the right conclusion, I think.  

A single merge-base case still might be worth optimizing for (and
IIRC, unlike the "git log A..B" traversal that could be fooled by
clock skew, merge-base reliably rejects falsely independent bases in
the presence of clock skew, so it should be safe to do), but in a
scenario your second illustration depicts, the merge-bases would not
help us that much.  

When starting from D and F, both of which are known to be "bad", all
we know is that some of the merge bases between them are "bad",
while other bases are not "bad" as they do not inherit the badness
in the common ancestor of those "bad" bases.  

And taking a merge base of these multiple merge-bases recursively
would not help us there.  We started from "all of these, i.e. D and
F, are known to be bad", which is different from "some of these
among multiple bases are bad, but we do not know which ones", so
even if we were to go recursive, the first step needs to be "now
let's see which one of these multiple bases are bad, so that we can
take merge-base across them".

      
