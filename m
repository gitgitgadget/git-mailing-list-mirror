Return-Path: <SRS0=BxWL=AF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B1AAC433E1
	for <git@archiver.kernel.org>; Wed, 24 Jun 2020 19:58:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 591562080C
	for <git@archiver.kernel.org>; Wed, 24 Jun 2020 19:58:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="kSWES7Uo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391395AbgFXT6x (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 Jun 2020 15:58:53 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:56652 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391349AbgFXT6w (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Jun 2020 15:58:52 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 5C2B6CD360;
        Wed, 24 Jun 2020 15:58:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=pYR80dXYdNXAitu0+rp9VXksTKY=; b=kSWES7
        UoTNngv+PPgq6foTULqSHm32IdrguCJfqSb+/RFjwfDwx6jj7dTrDfHmn9A+aiDX
        op8Z7n4lfUUMHLxikWYywyI/3jwxFEKV8ppPYqcp5K5v3PFHky23KBhcRKu+aKHn
        wcmgpp1nZebbsPKffL8VDZE+iYtuIcZUlemf0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=AntbvVtYDLwVPo8fj8nBEUhCD2peqyKt
        /2ZFMRWEYCsm85PZzfWh9jhmweYj8IXb02r4BS4CCtYGMQXWTfE3AaRv5XHqjocd
        Ih1n3sh4Z1cHJ6M2gcEXIp0Odxq9GIYbJBCbRx1umMBQTZlqMyKdkQN3d/NPdSk4
        GgdS3Fn48aY=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 54DE8CD35F;
        Wed, 24 Jun 2020 15:58:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 9AA4ECD35D;
        Wed, 24 Jun 2020 15:58:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 08/10] fast-export: add a "data" callback parameter to anonymize_str()
References: <20200623152436.GA50925@coredump.intra.peff.net>
        <20200623152503.GH1435482@coredump.intra.peff.net>
Date:   Wed, 24 Jun 2020 12:58:45 -0700
In-Reply-To: <20200623152503.GH1435482@coredump.intra.peff.net> (Jeff King's
        message of "Tue, 23 Jun 2020 11:25:03 -0400")
Message-ID: <xmqqzh8s5j7u.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1DCA1F7E-B655-11EA-AE37-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> The anonymize_str() function takes a generator callback, but there's no
> way to pass extra context to it. Let's add the usual "void *data"
> parameter to the generator interface and pass it along.
>
> This is mildly annoying for existing callers, all of which pass NULL,
> but is necessary to avoid extra globals in some cases we'll add in a
> subsequent patch.

> While we're touching each of these callbacks, we can further observe
> that none of them use the existing orig/len parameters at all. This
> makes sense, since the point is for their output to have no discernable
> basis in the original (my original version had some notion that we might
> use a one-way function to obfuscate the names, but it was never
> implemented). So let's drop those extra parameters. If a caller really
> wants to do something with them, it can pass a struct through the new
> data parameter.

I guess it was giving a perfect proof that the anonymization is
good---you cannot leak the info in data you did not even look at
;-).

And we must keep passing the <orig,len> pair to the anonymize API,
of course, because that would be used as a look-up key for the
customized/seeded mapping, which makes sense.  But of course it is
not necessary to pass them to the lower-level "generate" callbacks.

