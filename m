Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2C84C25B06
	for <git@archiver.kernel.org>; Thu,  4 Aug 2022 21:09:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234862AbiHDVJ1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Aug 2022 17:09:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232163AbiHDVJ0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Aug 2022 17:09:26 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91B3A6FA34
        for <git@vger.kernel.org>; Thu,  4 Aug 2022 14:09:25 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C2B5A13F998;
        Thu,  4 Aug 2022 17:09:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=NVXqI/WQbStf
        T85k731KygLhj+E360u+HGlg0Kf6mdQ=; b=Pj7etS2tsl2DYBYpWBLGfkwKpvyx
        pQLZdpFlB1/UH6qB4cnp/Z9IW5w40O196ADSeNPXFMWhR71p5xK8FjluJR7DviT0
        Km/0nX3JavGS3Yx/VWsYDgBnSQlpbHwVvvPveWui79xqkFxcccln4jIw3CrA++fF
        nS0ty0/XSxhyV0A=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B6DDD13F997;
        Thu,  4 Aug 2022 17:09:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.145.39.32])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 1744D13F996;
        Thu,  4 Aug 2022 17:09:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, derrickstolee@github.com,
        johannes.schindelin@gmx.de, Victoria Dye <vdye@github.com>
Subject: Re: [PATCH v2 03/10] scalar-diagnose: add directory to archiver
 more gently
References: <pull.1310.git.1659388498.gitgitgadget@gmail.com>
        <pull.1310.v2.git.1659577543.gitgitgadget@gmail.com>
        <23349bfaf8fc5f5001f1ed1fa19e9b3909466ae3.1659577543.git.gitgitgadget@gmail.com>
        <220804.868ro4fryg.gmgdl@evledraar.gmail.com>
        <xmqq35ec6igq.fsf@gitster.g>
        <220804.8635ebu55j.gmgdl@evledraar.gmail.com>
Date:   Thu, 04 Aug 2022 14:09:22 -0700
In-Reply-To: <220804.8635ebu55j.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Thu, 04 Aug 2022 22:12:56 +0200")
Message-ID: <xmqqsfmb3ed9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: B7689C48-1439-11ED-BFA5-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> I'm mainly noting that the point of this step is to produce an archive
> for the consumption of the remote end.
>
> Therefore it seems to me like it would me much more useful to note thes=
e
> "oddities" in some log that we're about to zip up, rather than issue a
> warning().

Hmph, the receiving end that inspects the archive will know that a
directory did not get archived, but they cannot tell if that is
because it did not exist, or because it was unreadable, and the
trouble the user may be having can well be the result of having
the directory unreadable.  So from that point of view, in addition
to these warnings and errors, it would be helpful to record the
errors we encounter while we generate the diagnostic archive in the
archive itself for inspection.

But the warning on the local side has merit to warn the user of an
unusual situation.  "I am puzzled why the hook I thought I wrote did
not trigger, but the diag tool says I do not have .git/hooks at all"
is a welcome side effect, even though it may not be the primary
effect we are aiming to gain by having these warning messages.

> I'm pointing out that we don't need to include that part in the message=
,
> because warning_errno() will already give us that for free. I.e.:
>
> 	warning: could not archive directory '<some dir>': No such file or dir=
ectory
>
> v.s.:
>
> 	warning: could not archive missing directory '<some dir>'
>
> The advantages of doing so being:
>
>  * It's clear (at least to the keen eye) that it's using the "errno
>    format", so you know it's not just saying "could not for <whatever
>    reason>", it specifically got ENOENT.

Funny.  I find it much clearer if we can use our own message without
having to rely on whatever strerror(error) gives us.  We know better
than the C library why we got ENOENT and be more readable.  They say
"No such file or directory" because from ENOENT alone they cannot
tell you if it was a file or a directory that was missing, but we
have a better context like "we were trying to create an archive" and
"we tried opendir, expecting that the thing is a directory".

>  * The i18n for the strerror() comes from the C library, which will be
>    translated already, whereas a new git.pot message won't be (but we'l=
l
>    hopefully bridge the gap eventually).

As I said above, I do not think it is an advantage in this case that
strerror() is translated, as the point of having a separate message
is because we can be more to-the-point, and we do not need to use
the strerror() result in there.

>  * This way we we can share the message, whatever the errno happens to
>    be, so we could e.g.:
>
>       errno =3D ENOENT;
>       warning_errno(_("could not archive directory '%s'"), "<some dir>"=
);
>       errno =3D ENOMEM;
>       error_errno(_("could not archive directory '%s'"), "<some dir>");
>
>    Whereas putting the reason for why we couldn't (which just duplicate=
s
>    the errno) in the message forces the messages & i18n to diverge.

And an added clarity that we can use a separate message is something
I think is worth having, compared to the cost of having an extra
message over the more generic one for any errno.
