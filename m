Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63C8FC433FE
	for <git@archiver.kernel.org>; Sat, 22 Oct 2022 16:51:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229992AbiJVQvb (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 22 Oct 2022 12:51:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229928AbiJVQvS (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 22 Oct 2022 12:51:18 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAABB1CD329
        for <git@vger.kernel.org>; Sat, 22 Oct 2022 09:51:11 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 54AE115ED13;
        Sat, 22 Oct 2022 12:51:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=Z6c8t4sZwyfR
        eMdy0dWVABrAjUuGq35tcsjAILme6QU=; b=bHf0o1UD+8lHw5AmQPIFViVXJJAR
        rm5TVbMz0j6v6aeue6d2XMKsy2uSy8iZx1n8hR9RwMrvxasFNEBOA51UPWWdt8gv
        CqfZNiFOzTBvwHD9tvjhoWS06B6SJr/fhmlFNiL6r5WgaB+FZ7annu3HsaIkLfQs
        fyVTZqGtHi8iPW8=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4BA4315ED12;
        Sat, 22 Oct 2022 12:51:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id AAEE615ED11;
        Sat, 22 Oct 2022 12:51:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH 3/3] git_parse_signed(): avoid integer overflow
References: <pull.1389.git.1666359915.gitgitgadget@gmail.com>
        <f058f391c3821b341a15fda9ae9fd20dda6a0494.1666359915.git.gitgitgadget@gmail.com>
        <xmqqpmeljae9.fsf@gitster.g>
        <80fe7c62-2c59-a715-3a8b-2dc2331d8e37@web.de>
Date:   Sat, 22 Oct 2022 09:51:08 -0700
In-Reply-To: <80fe7c62-2c59-a715-3a8b-2dc2331d8e37@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
        message of "Sat, 22 Oct 2022 10:09:26 +0200")
Message-ID: <xmqqv8obhkeb.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: BAA99000-5229-11ED-B00B-2AEEC5D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ren=C3=A9 Scharfe <l.s.r@web.de> writes:

>>> +		if (max < 0)
>>> +			BUG("max must be a positive integer");
>>
>> In parse_signed(), would we expect to accept end-user input that is
>> a negative integer?  We must.  Otherwise we would not be calling a
>> "signed" parser.  Now, are there cases where the valid value range
>> is bounded by a negative integer at the top?  No current callers may
>> pass such a value, but is it reasonable to add such a new constraints
>> to an existing API function?
>
> Hmm, if minimum and maximum are not symmetric, then we need to supply
> both, don't we?

Ah, thanks for injecting doze of sanity---I totally missed that the
bound was about the absolute value, so we can say "this is signed,
and the allowed values are (-3, -2, -1, 0, 1, 2, 3).  If so, then the
"reject negative max" in the posted patch is not a problem as I said
above.  I somehow thought that giving -1 as "max" would allow callers
to say "non-negative numbers are not allowed".  But that is not what
is going on.

Allowing callers to specify both lower and uppoer bounds so that
they can say "the allowed values are (-1, 0, 1, 2, 3)", while it
might make it more useful, is a separate new feature development and
outside the scope of "let's tighten the parsing of end user input"
Phillip has here.

Sorry about the thinko, and thanks for a new and interesting
tangent.
