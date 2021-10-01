Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FB9CC433EF
	for <git@archiver.kernel.org>; Fri,  1 Oct 2021 00:12:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6144461267
	for <git@archiver.kernel.org>; Fri,  1 Oct 2021 00:12:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350162AbhJAAOJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Sep 2021 20:14:09 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:56040 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345765AbhJAAOJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Sep 2021 20:14:09 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 0BDCC15D937;
        Thu, 30 Sep 2021 20:12:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=8/PuRAX2kFf6
        a2TMiN1wVKKFqfFIOkgRma4GsaJ7kYQ=; b=mU+1hI/Ml8h637rHC7idtC/ri5Bd
        csIDOIRnl2mETWxxXm89t2W2oncrBiL1JRhzZfIuc/nMf7UyKrSrrzefgAV46Pmd
        qP2FTff07NsZpWOpiTyf1+8ojA/pRj4Ftaj0GH5zGsHkdtl3g6PObObcKbz3oHOO
        QhY5gQSCYUgViVE=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 0406715D936;
        Thu, 30 Sep 2021 20:12:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 6600315D934;
        Thu, 30 Sep 2021 20:12:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     David Aguilar <davvid@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        =?utf-8?B?w4Z2YXIgQXJuZmo=?= =?utf-8?B?w7Zyw7A=?= Bjarmason 
        <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v6 3/5] difftool: avoid returning -1 to cmd_main() from
 run_dir_diff()
References: <20210930170146.61489-1-davvid@gmail.com>
        <20210930170146.61489-3-davvid@gmail.com> <xmqq7dexafch.fsf@gitster.g>
        <CAJDDKr41qzbUudAHgokRARK-kEG4araFwJ0UhLmJ4Pca=xFZRA@mail.gmail.com>
Date:   Thu, 30 Sep 2021 17:12:22 -0700
In-Reply-To: <CAJDDKr41qzbUudAHgokRARK-kEG4araFwJ0UhLmJ4Pca=xFZRA@mail.gmail.com>
        (David Aguilar's message of "Thu, 30 Sep 2021 16:25:10 -0700")
Message-ID: <xmqqmtnt8uxl.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 405D1988-224C-11EC-B152-F327CE9DA9D6-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

David Aguilar <davvid@gmail.com> writes:

>> Among them, the return value from run_command_v_opt() eventually
>> come from wait_or_whine(), I think, so it may be generic -1 or
>> it may be WEXITSTATUS() of the child process.
>>
>> But I am not sure if this particular caller cares.  It is not
>
> The property I was trying to maintain is that we would forward the resu=
lt
> from the child process in most situations, so we should try and forward
> the result from run_command_v_opt() whenever possible.

Oh, if it were the case, then I agree that !!ret would not be
sufficient.

I just had an impression that this particular caller of the
run_command_v_opt() did not care, as it did not special case -1
returned from the function as different from what came from
WEXITSTATUS().

> That suggests that =C3=86var's sug is better...
>
>     return (ret < 0) ? 1 : ret;

Yup, that would work, as long as exit status 1 from the external
diff tool is not all that special (in which case, we cannot tell
it from 1 that came from ret =3D error()).

Thanks.
