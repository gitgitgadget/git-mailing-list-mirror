Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A605E20899
	for <e@80x24.org>; Thu, 17 Aug 2017 18:22:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753285AbdHQSWm (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 Aug 2017 14:22:42 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59575 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752236AbdHQSWl (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Aug 2017 14:22:41 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D1D68A828C;
        Thu, 17 Aug 2017 14:22:40 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=f6JPytJ21gAo/uuXXQFrthC0vGI=; b=pWTXYA
        hsyslllFpTeBqwUgbr3fM2Oh7VYhrEKAzWM5YoabKQ4ap9fAkrEhoWj8Bn9OUq6l
        nkSAQdv9/fg2x0WWEm26AmIvn/znd+HRt7KfL7qW/XS+6lt8jakqBupwfdoTtSSY
        u3XwJ2APhJ37Cmw1l7QJskbRQeIdqZTrvAAhQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=gT8HldHivwHFh6sTAanKxI+xIMfWHhSA
        1dtqgeXQH4+YIlJDga1c2+vBDFJAlp87e1lye2y67zC/yWFrWb1UBIjjyUtIEsov
        z2J+Czl57B80eMkKXme7vQNSK6ffjVPLdYCYLrdBuVxINA5px91VT2U7W5IYUjup
        zmLoR/Jp9tA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C964BA828B;
        Thu, 17 Aug 2017 14:22:40 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 25567A8288;
        Thu, 17 Aug 2017 14:22:40 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Michael Haggerty <mhagger@alum.mit.edu>
Cc:     Shawn Pearce <spearce@spearce.org>, git <git@vger.kernel.org>,
        David Borowitz <dborowitz@google.com>,
        Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>
Subject: Re: reftable [v7]: new ref storage format
References: <CAJo=hJsZcAM9sipdVr7TMD-FD2V2W6_pvMQ791EGCDsDkQ033w@mail.gmail.com>
        <xmqq60dnjka0.fsf@gitster.mtv.corp.google.com>
        <CAMy9T_GuU68mQTAvmPkaa6jPiNnoDAKCqA8y76rf3UrmMeyfTA@mail.gmail.com>
Date:   Thu, 17 Aug 2017 11:22:38 -0700
In-Reply-To: <CAMy9T_GuU68mQTAvmPkaa6jPiNnoDAKCqA8y76rf3UrmMeyfTA@mail.gmail.com>
        (Michael Haggerty's message of "Thu, 17 Aug 2017 10:06:54 +0200")
Message-ID: <xmqqefsagikx.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0DB4AFBC-8379-11E7-B4AE-9D2B0D78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Michael Haggerty <mhagger@alum.mit.edu> writes:

> On Wed, Aug 16, 2017 at 11:05 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> I found it a slightly odd that we do not insist that update_indices
>> that appear in a single reftable file are consecutive, yet we
>> require that min_update_index of a reftable file must be one greater
>> than the max_update_index of a previous one.  That is not a new
>> issue in v7, though.
>
> I think of `update_index` like a pseudo-time, and the
> `min_update_index` and `max_update_index` to be stating that "this
> reftable covers the time interval specified". So it's reasonable to
> say that the reftable files, together, should cover all time.
>
> But it might be that there are values of `update_index` for which no
> events survived within a reftable file that covers that time interval.
> This can happen if reference update records have been compacted away
> because later reference updates overwrote their effects, and either
>
> * reflogs were turned off for those updates, or
> * the corresponding reflogs have been compacted into a separate file, or
> * the corresponding reflog entries for those updates have been expired.

Yeah, and I think it is reasonable that the specification does not
dictate that indices within a single reftable must be consecutive.

And if update_indices within a single reftable are allowed to be
sparse, e.g. recording three transactions with indices 1 3 and 5, it
is not immediately obvious to me why the transactions that are
recorded in the next reftable cannot be with indices 7 8 and 10,
leaving a gap between the max in the first table (i.e. 5) and the
min in the second table (i.e. 7).  That is what I found slightly
odd.



