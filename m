Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E29CA1F87F
	for <e@80x24.org>; Fri, 16 Nov 2018 03:32:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727124AbeKPNna (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Nov 2018 08:43:30 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58203 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726718AbeKPNna (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Nov 2018 08:43:30 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1DEE1129904;
        Thu, 15 Nov 2018 22:32:47 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=uTkNce83qDOERUPrvK+KdROILZE=; b=jl3vYr
        ULh8JsUKfrZ0Pz1bCytWuumtVHGCkjpZVrO5B4hfQ/0+XIXag7UbcBVgKx8OTPJi
        QO7m40vXrKoYEgDpibilRLyJznCLOaenr/eoxefoACyVNz8bjRqPshVcEqB3rDPh
        isZY+TUtjc/QkWYdSpl01But8KSBFR3DoCyXg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=wjKOrWAmRsc6G0c6ysjLp/SMoN5ViwPL
        xnvMHBBYDm67lMij61A7H5EiqlAA/DpANQSmyiLeyo+E+KlNp6Ezj80TEtE+3ue9
        aUWNBhrjSmUMWJwOxqIFbMa/fwHR15MUODpTPecUehR5ZV+tHusuCfi2Im10D4pF
        Ax4cqEw/1uA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 16E08129903;
        Thu, 15 Nov 2018 22:32:47 -0500 (EST)
Received: from pobox.com (unknown [35.187.50.168])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 88BCE129902;
        Thu, 15 Nov 2018 22:32:46 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [RFC PATCH 1/2] commit: don't add scissors line if one exists
References: <cover.1542172724.git.liu.denton@gmail.com>
        <1c16b9497bd630f0636aa7729082da7a90ba42d9.1542172724.git.liu.denton@gmail.com>
        <xmqqwopgm6bb.fsf@gitster-ct.c.googlers.com>
        <20181114180608.GA2299@archbookpro.localdomain>
Date:   Fri, 16 Nov 2018 12:32:45 +0900
In-Reply-To: <20181114180608.GA2299@archbookpro.localdomain> (Denton Liu's
        message of "Wed, 14 Nov 2018 13:06:08 -0500")
Message-ID: <xmqqzhu9lmsi.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 48F8EFA0-E950-11E8-B645-BFB3E64BB12D-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Denton Liu <liu.denton@gmail.com> writes:

>> If the current invocation of "git commit" added a scissors line in
>> the buffer to be edited already, and we are adding another one in
>> this function, is it possible that the real problem that somebody
>> else has called wt_status_add_cut_line() before this function is
>> called, in which case that other caller is what we need to fix,
>> instead of this one?
>> 
>
> In patch 2/2, I intentionally inserted a scissors line into MERGE_MSG so
> this patch ensures that we don't get duplicate scissors.

That is exactly what the paragraph you are responding to questions.
Is the code that adds a scissors line before this function is called
done the right way?  Shouldn't it be doing something differnetly?
Looking for an existing scissors looking line in this function does
not let this function differenciate two cases, i.e. we deliberately
added one already before calling this function (in which case this
function should not add another one), or we didn't add anything on
our own, but the material supplied by the end user had one (in which
case, not adding ours is losing information---imagine that the user
notices a scissors-looking line that came from the original maerial
and want to munge it, as it is part of proper message, so that it
would remain in the committed result, but because [PATCH 1/2]
stopped adding a scissors line at the right location, the user would
have to guess where to add one).

There must be an explicit way (e.g. a bit in a flag word parameter
given to this function) for the caller who knows when the new code
in [PATCH 2/2] triggers, to tell this function not to add another
one, instead of a sloppy (and less efficient) "lets's scan to see if
there already is a scissors looking line".

> With the existing behaviour, any messages that contain a scissors
> looking line will get cut at the earliest scissors anyway, so I believe
> that this patch would not change the behaviour. If the users were
> dealing with commit messages with a scissors looking line, the current
> behaviour already requires users to be extra careful to ensure that the
> scissors don't get accidentally removed so in the interest of preserving
> the existing behaviour, I don't think that any extra information would
> be lost from this patch.

Doing the "is there already a scissors looing line" approach will
*make* it harder to fix that issue, so the patch is making things
worse.
