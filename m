Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3172C47094
	for <git@archiver.kernel.org>; Thu, 10 Jun 2021 05:30:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D85E0613E2
	for <git@archiver.kernel.org>; Thu, 10 Jun 2021 05:30:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229725AbhFJFcq (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Jun 2021 01:32:46 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61798 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbhFJFcq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Jun 2021 01:32:46 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 58E5ACAAEF;
        Thu, 10 Jun 2021 01:30:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type
        :content-transfer-encoding; s=sasl; bh=RAsvtdfNG9PQqOfjNjK33cgN0
        YuzW8tzE/hEROEZ+IM=; b=auQX2jgA6jz9R8zwtS3tCgBVyDywwoxUjztyndIT/
        lz2n/mPapZlaJFaTUlNppom4lEXG1DlvFfQjzOgC8e6IymCTnp2o6rkzkIxvI+xB
        ycYaQQ5lamMm38puAm2/jSehjKYm9xpPiZI2v9EyMjPYobBN+M2lNo81cdwGdFRe
        SU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 50519CAAEE;
        Thu, 10 Jun 2021 01:30:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.172.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C5A54CAAED;
        Thu, 10 Jun 2021 01:30:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Derrick Stolee <stolee@gmail.com>, git@vger.kernel.org,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: [PATCH 2/2] read-cache: fix incorrect count and progress bar
 stalling
References: <cover-0.2-0000000000-20210607T144206Z-avarab@gmail.com>
        <patch-2.2-042f598826-20210607T144206Z-avarab@gmail.com>
        <8f336b1b-6cb7-8277-79d5-0f331159b00c@gmail.com>
        <87k0n54qb6.fsf@evledraar.gmail.com>
        <eaf2b6b0-4202-d5ea-87a2-b828fdbc60a1@web.de>
        <8735tt4fhx.fsf@evledraar.gmail.com> <xmqqczsxtf8g.fsf@gitster.g>
        <87wnr4394y.fsf@evledraar.gmail.com>
        <74183ce6-e17f-1b11-1ceb-7a8d873bc1c7@web.de>
        <87lf7k2bem.fsf@evledraar.gmail.com>
Date:   Thu, 10 Jun 2021 14:30:48 +0900
Message-ID: <xmqq4ke6ffqv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 03FB635C-C9AD-11EB-B539-8B3BC6D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> I was too quick with that "But yes, I agree with the issue in theory".
>
> Having thought about it some more I think you're wrong, it doesn't make
> sense to use the API in the way you're suggesting.

Sorry, I've read the message I am responding to a few times, but I
couldn't tell what you are arguing against in the suggestion given
earlier by Ren=C3=A9, which offered two possibile ways to consistently
call display() with the number of things that we have DONE
processing (not the number of things that we are about to touch) [*1*].

> Why? Because:
>
>     /* 1. Setup progress */
>     large_number =3D 3;
>     progress =3D start_progress(title, total);
>
>     /* 2. Before we "actually" do anything */
>     for (i =3D 0; i < 3; i++) {
>         /* 3. Now doing O(large_number) work */
>         display_progress(progress, i + 1);
>     }
>
>     /* 4. Done */
>     stop_progress(&progress);
>
> As you'll see if you insert a sleep or whatever at "2" we'll signal and
> display the progress bar even if we haven't called display_progress()
> yet.

That is, the signal start_progress_delay() kicking in?  But
progress_test_force_update() is a curiosity that appears only in
test-tool and in real life programs, you'd have to call display
yourself, so a long delay at "3" will appear as a long silence,
I would think.

In any case, if we somehow managed to cause display_progress() to
happen somewhere near "2", we haven't finished even a single item
yet at that point, so "we are giving progress bar, and we have
finished 0%" that is an output from such a call would make sense.
As we finish one item, we'd increment it to 1 (that happens after we
spent time at "3" during the first iteration, and display_progress()
is called with "i+1").

> Thus calling display_progress with n=3D0 makes "we are doing the first
> item" indistinguishable from "we haven't gotten to the first item
> yet".

I am guessing that you are talking about "what value should we call
display() if '2' takes a long time and we want to give progress
early even before we enter the loop?"

I do not view such a call as "we haven't gotten to" or "we are
doing"; an extra call we would make with display(n=3D0) around "2" is
"how much have we finished?  we have completed none".

> When you're in the loop the first item should be n=3D1.

Doesn't that depend on where in the loop you do the work?

If you spend cycles and finish processing the first item _before_
calling display_progress(), you are reporting how many you have
finished, so at the end of the first iteration of the loop, you'd
call with n=3D1.

If on the other hand you somehow report at the beginning (perhaps
because otherwise you'd have tough time structuring the code when
the loop body has a continue etc.) before finishing the processing
for the first item, you'd call with n=3D0 (and make sure before
calling stop_progress(), you'd call another display() after exiting
the loop).

And I think that is consistent with what R=C3=A9ne suggested earlier, so
I am not sure where your "I am right you are wrong" is coming from.
To me, you two seem to be agreeing.


[Footnote]

*1* <eaf2b6b0-4202-d5ea-87a2-b828fdbc60a1@web.de>

> Showing only the completed items makes sense.  That the next one is
> being processed is self-understood.  Once all of them are done, 100% is
> shown and the progress line is finished.
>=20
> So I think this pattern works:
>=20
> 	for (i =3D 0; i < nr; i++) {
> 		display_progress(p, i);
> 		/* work work work */
> 	}
> 	display_progress(p, nr);
>=20
> Alternatively, if the work part doesn't contain continue statements:
>=20
> 	for (i =3D 0; i < nr; i++) {
> 		/* work work work */
> 		display_progress(p, i + 1);
> 	}


