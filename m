Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70331C433E0
	for <git@archiver.kernel.org>; Wed, 10 Feb 2021 01:09:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1E6E064DD1
	for <git@archiver.kernel.org>; Wed, 10 Feb 2021 01:09:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234490AbhBJBJt (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Feb 2021 20:09:49 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:57210 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234777AbhBJBH7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Feb 2021 20:07:59 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 20FD110E1DC;
        Tue,  9 Feb 2021 20:07:09 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=75icpXqYPFVGiI1Ei09aYIFQ7FQ=; b=FU9lfT
        h5tnuXYyBxZ0++BZHQ4MrCGMuAz23gHt/LK4NIfqRjeTPLVbe5iucOrUejlT7zXb
        57x6xFuOORD5Devrk7d6PAl5WQbWGizI4mHWfF3tkDUZMMhffHLwRixGke4ixOKk
        ydf+592gQgsXlBuwRu5NIGOYsrG5PNn9+cjJk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=NjkRAhbeCgKDrhoh+SpdFPFvrrPR0PyE
        RzJ32dyulJ3E4CITbJmgy3KWu95ILIeTa6WUXR/ns/ObW75M0y5jr39+IfgT75ac
        oN3ROcYpovMn2TDocdQXZvVxd7MFWugtnvSEaQLvr+rjjaA2x7dHgm4qcSeDkwo8
        pEyr+o8YjyY=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 19E2610E1DB;
        Tue,  9 Feb 2021 20:07:09 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 6361A10E1DA;
        Tue,  9 Feb 2021 20:07:06 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Cc:     git <git@vger.kernel.org>
Subject: Re: [PATCH 2/2] checkout-index: omit entries with no tempname from
 --temp output
References: <cover.1612812581.git.matheus.bernardino@usp.br>
        <1275701345b7e198ec83ad4fdcc2dda6d9775ef3.1612812581.git.matheus.bernardino@usp.br>
        <xmqqmtwczzyv.fsf@gitster.c.googlers.com>
        <CAHd-oW4ddei-bRZkQUSpMevyZYgOBi2T6uQPzJ_XscTmfxhWtw@mail.gmail.com>
Date:   Tue, 09 Feb 2021 17:07:04 -0800
In-Reply-To: <CAHd-oW4ddei-bRZkQUSpMevyZYgOBi2T6uQPzJ_XscTmfxhWtw@mail.gmail.com>
        (Matheus Tavares Bernardino's message of "Tue, 9 Feb 2021 18:57:09
        -0300")
Message-ID: <xmqqa6scyblz.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4AED6712-6B3C-11EB-9044-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Matheus Tavares Bernardino <matheus.bernardino@usp.br> writes:

>> Hmph, is topath[][] array used after this function gets called and
>> in what way?  Whether have_tempname is true or not, wouldn't we want
>> to clear it?
>
> Yeah, topath[][] can be reused in the next checkout_entry() call. But
> if have_tempname is false, the positions that are going to be used
> again (either checkout_stage or 1, 2, and 3, if checkout_stage ==
> CHECKOUT_ALL) will be already empty. So I think we only need to clear
> topath[][] when have_tempname is false.

If so, clearing them unconditionally like the original code before
the introduction of have_tempname variable would be easier on
readers, as they won't be forced to reason about when to and when
not to clear these strings---figure out if the reason why we do not
always clear is because (1) we have info that we do not want to lose
if (!have_tempname), or (2) we know there is nothing to be cleared
if (!have_tempname).

Thanks.
