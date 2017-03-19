Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BF7D520323
	for <e@80x24.org>; Sun, 19 Mar 2017 12:55:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751297AbdCSMz1 (ORCPT <rfc822;e@80x24.org>);
        Sun, 19 Mar 2017 08:55:27 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56723 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751369AbdCSMzZ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 19 Mar 2017 08:55:25 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 388986D150;
        Sun, 19 Mar 2017 08:55:23 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=arKV2Y+rUG1/
        0tOV99wZwzxUDRg=; b=LNUwXgHvBWfxpt2G1vibhVXZf8PZEj1DgRinBwFGnz5E
        E4hLUTYuAaLweSwccUJ1e9Sg3NdXBy60d0YL5tOiKaRglRJ1ma14BmAtbdVvIKUc
        X6i9Xe/jaA8Sphv53S1AVWjZfX+R6iHxHVK/SYAuoMi+YrBtt81L1Dh/5W1Sy60=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=S50iH7
        eNKNzrLBsd91MobVdonuffL7ny/BVD2ASs0o7k+KbY8Z0r2dCFovnyBo21RJzK9m
        YxQqcQcY1QTfmePkPpuGZ8qlxSBV/9ISKmuc/fjQHlN+XtIsX4mE+6FWZ9hoCQqp
        kBYY8NBMie0JkbXb7I4JLdzdfLxkA2XmHDIMk=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 307A36D14F;
        Sun, 19 Mar 2017 08:55:23 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 87F0B6D14D;
        Sun, 19 Mar 2017 08:55:22 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Conrad Irwin <conrad.irwin@gmail.com>,
        Sitaram Chamarty <sitaramc@gmail.com>,
        Michael J Gruber <git@drmicha.warpmail.net>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Jeff King <peff@peff.net>, Richard Hansen <rhansen@bbn.com>,
        "Brian M . Carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH] rev-parse: match @{u}, @{push} and ^{<type>} case-insensitively
References: <20170318223409.13441-1-avarab@gmail.com>
Date:   Sun, 19 Mar 2017 05:55:21 -0700
In-Reply-To: <20170318223409.13441-1-avarab@gmail.com> (=?utf-8?B?IsOGdmFy?=
 =?utf-8?B?IEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Sat, 18 Mar 2017 22:34:09 +0000")
Message-ID: <xmqqtw6pzarq.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 5068CC78-0CA3-11E7-9481-97B1B46B9B0B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Change the revision parsing logic to match @{upstream}, @{u}, @{push},
> ^{commit}, ^{tree} etc. case-insensitively. All of these cases
> currently emit "unknown revision or path not in the working tree"
> errors.
>
> This change makes them equivalent to their lower-case versions, and
> consistent with other revision format specifications, e.g. 'master@{6
> hours ago}', which is equivalent to 'master@{6 HoUrS aGo}'.

Approxidate is not just case insensitive, but it takes random
non-word characters (e.g. a dot and a slash in "@{4.minutes/}") that
are not spaces at word boundaries, and I do not think you want to
accept @{.Upstream.} for consistency.

It is an odd-man-out and "consistency" with it is a nonsense
justification.

> The use-case for this is being able to hold the shift key down while
> typing @{u} on certain keyboard layouts, which makes the sequence
> easier to type, and reduces cases where git throws an error at the
> user where it could do what he means instead.

This, on the hand, is a sane justification that can be sympathized.

> The objection from Junio at the time[2] was that by lower-casing
> {...}:
>
>     [The door would be closed on] allow[ing] @{/regexp} to find a
>     reflog entry that matches the given pattern, and in such a use
>     case we would certainly want to take the pattern in a case
>     sensitive way.
>
> This appears to be an objection related to the code structure at the
> time,...

This objection, which is not about code structure but about design,
still applies, I would think, if your justification is "consistency
by making everything case-insensitive". =20

Whoever is doing @{/<pattern>} cannot add the feature in a case
sensitive way without violating the declaration you are making here:
"everything inside @{...} is case-insensitive".

And if you extend that declaration to say "everything inside ^{...},
too, is case-insensitive", I think it already is broken as I think
"^{/<pattern>}" is case sensitive, by the way.

So don't pretend that this is about consistency.  You are making a
choice for one class of strings that can go inside @{...} and the
choice does not depend on the case sensitivity of different classes
of strings that can go the same place.  There is no sensible
"consistency" justification possible.

I think "immediately after typing '{', you often have SHIFT
pressed", even though it may sound lame, is a much better
justification.  At least, it is an honest one.  And I do not mind
too much if the way this feature is sold to the users were "these
keywards inside @{...} can be spelled in any case: push, upstream.
Type names in the peel-onion operator ^{<type>} can be too", not as
a general rule but as special cases.  Unlike end-user supplied
strings taken from an unbounded set (e.g. /<search patterns>), there
is no strong reason to insist that a set of keywords taken from a
limited vocabulary has to be spelled in one case, as long as it does
not introduce ambiguity or limit our possible future.  It's not like
we may want to keep the door open to make @{push} and @{PUSH} mean
different things later.

Even in that case, however, I'd strongly prefer to spell all the
examples in lowercase and declare that lowercase is the canonical
spelling in our documentation.  What I want to avoid is to have
three Git textbooks, that use @{UPSTREAM}, @{Upstream}, and
@{upstream} in their samples and descriptions, and have the readers
waste their time wondering, and waste our time by asking here, where
the different preferences of the authors of these three books come
from and which one the canonical way to spell it is.

Thanks.
