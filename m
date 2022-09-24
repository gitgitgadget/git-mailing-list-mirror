Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9502C07E9D
	for <git@archiver.kernel.org>; Sat, 24 Sep 2022 16:24:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229737AbiIXQYh (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 24 Sep 2022 12:24:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbiIXQYf (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Sep 2022 12:24:35 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82AAB5FA2
        for <git@vger.kernel.org>; Sat, 24 Sep 2022 09:24:31 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C107615952B;
        Sat, 24 Sep 2022 12:24:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=AbKgHr4iaBr/
        ZirLpNiR+pJZslcwFd7fuOeduVFP+Lc=; b=jImgO9SWvureSWHnKBuEARj26E2b
        /6lsKJzrGwxv9GveCmU1WRWPlfJ+MBupTTB52ji4SU8vU0dToUoUWSKakGfAxSYH
        KQVExDybhAl810MVjingox9FLrsNg6ZGZ7i9GOkd+0f48E4E1Nc6RB+HHBLH+laz
        7JvUrhBmVKpHZlc=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B7BE915952A;
        Sat, 24 Sep 2022 12:24:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 212F6159529;
        Sat, 24 Sep 2022 12:24:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
Cc:     Claus Fischer <claus.fischer@clausfischer.com>,
        git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>
Subject: Re: Scriptable mode for git bisect
References: <Yy4c6/jHupgThj7j@clausfischer.com> <Yy5g80OtVG4op8L1@danh.dev>
Date:   Sat, 24 Sep 2022 09:24:29 -0700
In-Reply-To: <Yy5g80OtVG4op8L1@danh.dev> (=?utf-8?B?IsSQb8OgbiBUcuG6p24g?=
 =?utf-8?B?Q8O0bmc=?= Danh"'s message of
        "Sat, 24 Sep 2022 08:44:19 +0700")
Message-ID: <xmqqwn9srb9e.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 5DAE405E-3C25-11ED-ACB0-2AEEC5D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C4=90o=C3=A0n Tr=E1=BA=A7n C=C3=B4ng Danh  <congdanhqx@gmail.com> writes=
:

> On 2022-09-23 22:54:03+0200, Claus Fischer <claus.fischer@clausfischer.=
com> wrote:
>>=20
>> Dear Git maintainers,
>>=20
>> I have looked at the manpage of git bisect but have not found
>> what I need:
>> I would like git bisect not just to report the 'bad' revision
>> within a bunch of text but instead either stop at the first
>> bad revision (the last good will then be HEAD~1) or report
>> it in a scriptable way, i.e.
>>=20
>>   BADHEAD=3D$(git bisect run --shut-up-and-report-the-bad)
>>=20
>> Have I overlooked anything?
>
> After running "git bisect run"
> You can take its revisions with:
>
> 	BADHEAD=3D$(git rev-parse --verify refs/bisect/bad)

Christian, who invested quite a lot of work in the command (cc'ed),
may have more tricks up his sleeve.

You can also check .git/BISECT_LOG; the value of refs/bisect/bad is
the source of truth, as the final verdict message given by the
command (cf. builtin/bisect--helper.c::bisect_successful() that
reads from "refs/bisect/$bad" which is called when "the first bad
commit" is found by bisect.c::bisect_next_all()).

One thing that may confuse a new user is that the commit HEAD, when
"git bisect" finds the first bad commit, may not be a bad one.  You
start from a longer streatch of history (time flows from left to right,
B and G are known bad and good ones, ? are not known)

               ?---?---?
              /         \
    -----G---?---?---?---?---?---B

and then go narrowing down by answering "is this one good?"
questions.  Answering "Good" paints all its unknown ancestors as
"Good".  The final step may look like this, where the sole '?' is
the commit that is checked out to be tested:

               G---G---G
              /         \
    -----G---G---G---?---B---B---B

And the answer to the final step may be "good" or "bad".  If it is
"good", then the first bad commit would be its child commit, which
is a merge commit that introduced the badness into the history.

But still, the first bad commit is found at refs/bisect/bad
