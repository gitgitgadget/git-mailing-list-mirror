Return-Path: <SRS0=1KXq=52=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35D09C2BA19
	for <git@archiver.kernel.org>; Fri, 10 Apr 2020 00:21:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 063222074F
	for <git@archiver.kernel.org>; Fri, 10 Apr 2020 00:21:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="LTNETTVn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726917AbgDJAVQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Apr 2020 20:21:16 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:60025 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726327AbgDJAVQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Apr 2020 20:21:16 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id CAAA5C3396;
        Thu,  9 Apr 2020 20:21:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Rq2rIKfkfEvFAo3qdSGPXhX2bDM=; b=LTNETT
        Vni9OPsVkZSi438tS01wR9dZ+qmSxvzbNeKzDQCUj3bfWRAlF9GEReNVwF4POrTy
        RfDFTePPMFeB903dCmoQsK/PfMYHqAcDaHAJh0Zai3U7SNpPmJ6wX6oTL3Kf+wxU
        PJSYyb1BFoBaWAmQpQLImhnYp/cTJEqtZLIM0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=XznxgYy+NiGq+c3kqkXpbrTusB7Nqtmq
        tOi4/MAvKW/6tj6VBBVCQK5jAY77kYOVOh6zrxTMiYOur6GAVZWcCYv5CUcHKQRu
        JIQg6aL+G0bgVYJ0C3No22MjKANdtyaHOKzBd67JCmwBOERDBG3PHDEptjtC8Iij
        FAwvdIRcQH8=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id C3143C3395;
        Thu,  9 Apr 2020 20:21:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 097C6C3394;
        Thu,  9 Apr 2020 20:21:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     <git@vger.kernel.org>, Jeff King <peff@peff.net>
Subject: Re: [PATCH] builtin/receive-pack: use constant-time comparison for HMAC value
References: <20200409233730.680612-1-sandals@crustytoothpaste.net>
        <xmqqr1wwkxqe.fsf@gitster.c.googlers.com>
Date:   Thu, 09 Apr 2020 17:21:07 -0700
In-Reply-To: <xmqqr1wwkxqe.fsf@gitster.c.googlers.com> (Junio C. Hamano's
        message of "Thu, 09 Apr 2020 17:09:29 -0700")
Message-ID: <xmqqmu7kkx70.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2D011058-7AC1-11EA-9A92-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
>
>> When we're comparing a push cert nonce, we currently do so using strcmp.
>> Most implementations of strcmp short-circuit and exit as soon as they
>> know whether two values are equal.  This, however, is a problem when
>> we're comparing the output of HMAC, as it leaks information in the time
>> taken about how much of the two values match if they do indeed differ.
>>
>> In our case, the nonce is used to prevent replay attacks against our
>> server via the embedded timestamp and replay attacks using requests from
>> a different server via the HMAC.  Push certs, which contain the nonces,
>> are signed, so an attacker cannot tamper with the nonces without
>> breaking validation of the signature.  They can, of course, create their
>> own signatures with invalid nonces, but they can also create their own
>> signatures with valid nonces, so there's nothing to be gained.  Thus,
>> there is no security problem.
>>
>> Even though it doesn't appear that there are any negative consequences
>> from the current technique, for safety and to encourage good practices,
>> let's use a constant time comparison function for nonce verification.
>> POSIX does not provide one, but they are easy to write.
>
> Devil's advocate mode on.
>
> If the HMAC plus digital signature are the real security, even
> though writing this patch may be a nice mental exercise, is there a
> merit in deliberately adding more code and making the code
> immesurably slower by applying it? 
>
> You just established in the previous paragraph that "for safety" is
> a red herring.

Ooops, sorry, I sent it a bit too soon.

"They are easy to write" is one thing, but there is cost for keeping
two variants of memcmp() and forcing the users to choose which one
to call.  If we were to encourage good practices, what we would
encourage would not be "when in doubt, always use this pessimized
version.", but "analyse the risk, and when there can be a valid
timing analysis threat, use this one."  And to lead by example, we
would *not* be calling it in this codepath.

A patch that adds constant_memequal() *without* calling it from
check_nonce(), because we realize that there is no legitimate threat
that deserves to be protected by a call to it in this codepath,
would be a very good thing to have, in other words, as that does
encourage good practices.

End of "Devil's advocate mode".

It's not like we have audited _other_ codepaths that may benefit by
having this helper, so if we were to add constant_memequal(), let's
do so in a more library-ish place, in wrapper.c perhaps.

Thanks.

