Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 363FAC433EF
	for <git@archiver.kernel.org>; Mon, 13 Dec 2021 19:26:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240312AbhLMT0c (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Dec 2021 14:26:32 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52955 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238676AbhLMT0b (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Dec 2021 14:26:31 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2E0EC110691;
        Mon, 13 Dec 2021 14:26:31 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=nTfDZX/yTlyi
        RBFuzKXXZ6tk+Ql1wlBfmvDDQqDM1iw=; b=dL3BEJOdyLUnEj4kPfL6/D9PEFqj
        9AY+C1JzfRAPswS74svyFSqYcdwsoPXPk7W6o1K3dnWdVeouPNUJsaqrzg9XpNA8
        6V2ycMvr0C64lPi1yKCaf4xwOLMthArG+Jkjo6nIsqNSXNDlfrIz23H2gHzKkVvn
        d74iFuaWf8WJyBE=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2632E110690;
        Mon, 13 Dec 2021 14:26:31 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 55C4511068F;
        Mon, 13 Dec 2021 14:26:30 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Glen Choo <chooglen@google.com>, git@vger.kernel.org,
        Jonathan Tan <jonathantanmy@google.com>,
        Josh Steadmon <steadmon@google.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Subject: Re: [PATCH v3 5/5] branch.c: replace questionable exit() codes
References: <20211206215528.97050-1-chooglen@google.com>
        <20211209184928.71413-1-chooglen@google.com>
        <20211209184928.71413-6-chooglen@google.com>
        <211210.86ee6ldwlc.gmgdl@evledraar.gmail.com>
        <xmqq5yrsg9n2.fsf@gitster.g>
        <211213.8635mwamah.gmgdl@evledraar.gmail.com>
Date:   Mon, 13 Dec 2021 11:26:29 -0800
In-Reply-To: <211213.8635mwamah.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Mon, 13 Dec 2021 10:19:16 +0100")
Message-ID: <xmqqzgp4b922.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 92E89622-5C4A-11EC-81AF-E10CCAD8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> On Mon, Dec 13 2021, Junio C Hamano wrote:
>
>> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>>
>>> The latter should really be "exit(1)", not 128. We should reserve tha=
t
>>> for die().
>>
>> Is it because install_branch_config_multiple_remotes() gives enough
>> information to the user that the caller exits without its own
>> message?  In other words, are messages given by the callee to the
>> users are morally equivalent to what the caller would call die()
>> with, if the callee were silent?  If so, 128 is perfectly fine.  If
>> not, 1 or anything positive that is not 128 may be more appropriate.
>
> We don't really document this outside of this tidbit:
>    =20
>     Documentation/technical/api-error-handling.txt-- `die` is for fatal=
 application errors.  It prints a message to
>     Documentation/technical/api-error-handling.txt:  the user and exits=
 with status 128.
>     Documentation/technical/api-error-handling.txt-
>     Documentation/technical/api-error-handling.txt-- `usage` is for err=
ors in command line usage.  After printing its
>     Documentation/technical/api-error-handling.txt-  message, it exits =
with status 129.  (See also `usage_with_options`
>     Documentation/technical/api-error-handling.txt-  in the link:api-pa=
rse-options.html[parse-options API].)
>
> But while that doesn't say that you can *only* use 128 for die, and I
> wouldn't consider the existing code that calls exit(128) in dire need o=
f
> a change, most of the builtins simply return with 1 for generic errors,
> and reserve 128 for die()..
>
> So for any new code it makes sense to follow that convention.

Only when they are not calling die() for some technical reasons,
though.  IOW, if you would have called die() if you could, that is a
good indication that you would want to consistently use 128.

Capturing return value from die_message(), giving more message and
then dying with the 128 squarely falls into that pattern.  I am not
sure if the install_branch_config_multiple_remotes() case falls into
it, though.

And more importantly in the context of this topic, I am not
convinced install_branch_config_multiple_remotes() helper function
itself is a good idea to begin with.  It is to handle a case where
branch.$name.remote is set multiple times right?

This is because I do not think I saw anybody defined the right
semantics during the discussion (or written in the documentation)
and explained why being able to do so makes sense in the first
place, and it is not known if it makes sense to copy such a
configuration blindly to a new branch.  If it punts without doing
anything with a warning(), or calls a die(), it would be a more
sensible first step for this topic.  Users with real need for such a
configuration will then come to us with real use case, and what they
need may turn out to be something different from a blind copying of
the original.

Thanks.



