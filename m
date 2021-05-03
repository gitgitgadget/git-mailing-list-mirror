Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E60BDC433B4
	for <git@archiver.kernel.org>; Mon,  3 May 2021 02:57:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 99F7861376
	for <git@archiver.kernel.org>; Mon,  3 May 2021 02:57:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232401AbhECC5x (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 2 May 2021 22:57:53 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55172 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230368AbhECC5x (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 2 May 2021 22:57:53 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 613F8C2EDD;
        Sun,  2 May 2021 22:57:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=sQ5SE7GJb08vEzCBuEARLDlUkBR8mFVfek4jex
        u/9yQ=; b=iJfz0+/eM9ZWghek4o/bSSnhvsIbbJE+deoeJNB1rEn9m08VyqsUIA
        ocRZkMlFV1+1FBz+C79wbamIFanBp7cP1ODJJR4zFtB8tS8IYZcOOQ+EHI4X1sy0
        lmGLEWFcmqE/yycP5EPHEBjzUtwkY5DWuOxNGsZ9VR113woIMOFPY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 531B4C2EDC;
        Sun,  2 May 2021 22:57:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id CA46EC2EDB;
        Sun,  2 May 2021 22:56:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     ZheNing Hu <adlternative@gmail.com>
Cc:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Christian Couder <chriscool@tuxfamily.org>,
        Hariom Verma <hariom18599@gmail.com>
Subject: Re: [PATCH] [GSOC] ref-filter: add %(notes) format atom
References: <pull.944.git.1619691880696.gitgitgadget@gmail.com>
        <38083c1b-f92b-7624-67b7-3a5dcf213d79@web.de>
        <CAOLTT8TGaVxxHJRF_-Dq0Gnd50_H-80C6zPhjQAQruiO59qw2A@mail.gmail.com>
Date:   Mon, 03 May 2021 11:56:59 +0900
In-Reply-To: <CAOLTT8TGaVxxHJRF_-Dq0Gnd50_H-80C6zPhjQAQruiO59qw2A@mail.gmail.com>
        (ZheNing Hu's message of "Sun, 2 May 2021 14:12:09 +0800")
Message-ID: <xmqqsg34a5j8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3ACA5830-ABBB-11EB-BB09-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

ZheNing Hu <adlternative@gmail.com> writes:

> Note that `cat-file --batch` should be a superset of `ref-filter` and
> `--pretty`, because
> it supports all objects, while `ref-filter` only supports "commit" and
> "tag" two kinds
> of objects, and `--pretty` only supports "commit" one kind of object.

What?  A ref can point at any kind of objects, not necessarily
commits and tags.  %(objectname), %(objecttype), etc. obviously
are applicable to any type of object.

Another thing worth noting is that ref-filter needs to deal with
traits that are not tied to any particular object, but to the ref
itself, like who its upstream is and where it would be pushed to.

> So it may be reasonable to provide `%(notes)` to "commit","tag"
> objects in `cat-file --batch`
> in the future, now integrate them into ref-filter firstly.

And you can attach notes to objects of any type, not limited to
commits and tags.

>> >     So in this patch, I tried to migrate --pretty=%N to --format=%(notes).

What do you mean by "migrate"?  Are you making both available?

>> > diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for-each-ref.txt
>> > index 2ae2478de706..07f037a16e13 100644
>> > --- a/Documentation/git-for-each-ref.txt
>> > +++ b/Documentation/git-for-each-ref.txt
>> > @@ -139,6 +139,9 @@ deltabase::
>> >       given object, if it is stored as a delta.  Otherwise it
>> >       expands to the null object name (all zeroes).
>> >
>> > +notes::
>> > +     The notes associated with the ref.

"The notes associated with the object pointed at by the ref".

A note is never associated with a ref.  It can only associated with
an object.

If we are going to have %(notes), it may be natural to desire
grabbing notes for the given object from specified notes ref, e.g.

    git for-each-ref --format="%(notes:amlog) %(subject)" zh/pretty-date-human

may want to give the same kind of information as

    git show -s --format='%N %s' --notes=amlog zh/pretty-date-human

The underlying notes machinery however may not be prepared to work
with more than one notes tree at the same time, so

    git for-each-ref --format="%(notes) %(subject)" --notes=amlog zh/pretty-date-human

might be a better syntax, as --format="%(notes:X) %(notes:Y)" may
not be something you can easily support.

