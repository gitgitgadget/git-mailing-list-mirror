Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9030720564
	for <e@80x24.org>; Thu, 26 Oct 2017 01:00:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751984AbdJZBAA (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Oct 2017 21:00:00 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51855 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751868AbdJZA77 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Oct 2017 20:59:59 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1B4D59740B;
        Wed, 25 Oct 2017 20:59:59 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=blbI5ZDdk2d3g9ZJfQB3EKtQPwQ=; b=ycRq0y
        0HqzhYExvBT3ZCX/MFVedSlAc4eie1lSfO1gMPdXcLScKqVYny3YvtbJF2mH3xY2
        xrBC78z8yI9qn04S3n7poZbPCcK/GjtffzLP3OgmJMEPLUO6l/rrGaGCYbMY1bQ0
        Elb0rYmSzorFy0sV/Ts5GFvHcQAr/ZY7ZCxUw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=LWpD9ZoWUWbL4AKM3z7LTmgH1K4/5gWd
        49aZCRJ+7wO1oPk3dT8CNTx46q4S20mP5OCtWCEiF6xYmsNcgJkOY+6GOsCEXTFJ
        ISnvftxr51HJbGbOSQ9vAUuoRWE/F0I665apYvTh3FLOl/Vu1FNb2s9s+Pd553u9
        qXZTruRqUx4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 10C1E9740A;
        Wed, 25 Oct 2017 20:59:59 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 66E5697406;
        Wed, 25 Oct 2017 20:59:58 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org, spearce@spearce.org, git@jeffhostetler.com,
        jonathantanmy@google.com, jrnieder@gmail.com, peff@peff.net,
        sbeller@google.com
Subject: Re: [RFC] protocol version 2
References: <20171020171839.4188-1-bmwill@google.com>
        <xmqqbmkxkpn9.fsf@gitster.mtv.corp.google.com>
        <20171024183557.GB79163@google.com>
Date:   Thu, 26 Oct 2017 09:59:57 +0900
In-Reply-To: <20171024183557.GB79163@google.com> (Brandon Williams's message
        of "Tue, 24 Oct 2017 11:35:57 -0700")
Message-ID: <xmqqbmkuhgfm.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: FCED161E-B9E8-11E7-8E81-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Brandon Williams <bmwill@google.com> writes:

> On 10/24, Junio C Hamano wrote:
>> Brandon Williams <bmwill@google.com> writes:
>> 
>> >   <refspec>: When specified, only references matching the given patterns
>> >              are displayed.
>> 
>> I do not think you meant <refspec> here.
>> 
>> The side that is listing what it has has no reason to know what the
>> recipient plans to do with the result, so you must be only sending
>> the LHS of a refspec.  If your explanation says "given patterns",
>> then replace <refspec> with <pattern>.  Do not abuse a term that has
>> specific and established meaning for something else.
>
> Yes, you're right i intended that to mean <pattern> instead so that the
> client could send "refs/heads/*" or some other such pattern and have the
> server limit its output.

Speaking of limiting the bandwidth consumed by the ref
advertisement, I think another trick that came up in past
discussions may be worth considering, which is to allow the
requestor to say, "oh by the way, I made exactly the same request as
this one earlier to you, and your response hashed down to this
value".  The responder may choose to give an incremental response
relative to the known result the requestor claims to have.

So for example, a requestor may have made an earlier ls-refs request
and can still recall that it got:

	refs/heads/maint	ObjectID A
	refs/heads/master	ObjectID B
	refs/tags/v1.0		ObjectId C

Also assume that these three lines together (textually) hashes to Z.

When the requestor asks about the two hierarchies, it may say "I know
you gave a result that hashes to Z" with an additional parameter:

	command=ls-ref
		refspec=refs/heads/*
		refspec=refs/tags/*
		known=Z

If the current response for refs/heads/* and refs/tags/* when fully
spelt out were like this (i.e. we updated a ref, gained another, and
lost one):

	refs/heads/master	ObjectID D
	refs/tags/v1.0		ObjectId C
	refs/tags/v1.1		ObjectID E

then the responder can send the fully spelt version, or it can
choose to say, "It's good that you know the state Z; relative to
that, refs/heads/maint no loner exists, refs/heads/master is now at
D and refs/tags/v1.1 at E has been added", if the latter results in
a shorter response (and if it recognises Z and map it back to the
set of refs and their values it responded with).

The "known" request parameter could further be refined (I do not
think this possibility was discussed in the past) to say "among the
values I received earlier from you, the ones that match this pattern
hashes to this", e.g. the earlier example request might become

	command=ls-ref
		refspec=refs/heads/*
		refspec=refs/tags/*
		known=X for refs/heads/*
		known=Y for refs/tags/*

