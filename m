Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFA4DC433EF
	for <git@archiver.kernel.org>; Thu,  4 Nov 2021 21:24:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D1A4460F39
	for <git@archiver.kernel.org>; Thu,  4 Nov 2021 21:24:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232182AbhKDV1I (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Nov 2021 17:27:08 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55519 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230162AbhKDV1H (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Nov 2021 17:27:07 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4D1ECFDD6F;
        Thu,  4 Nov 2021 17:24:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=3lAB81ElV0SW
        b6BVHlW3O3hAZBCXHPyDJcNXsWk58Vw=; b=rQfaLjZmsfawpqycLfdESNwYQqax
        FAezUKnw3oY3ZXgmA+Nxb6z+4jjNWg5sP6o3gG0bklh5LRY2wATtxXvx/e8hg+8t
        KyZqHZw+RF70u8Ju72+nFguzadWiGH/12qFEZKjDrgR3l1g1CgmpJyE8hUTwA4+s
        YEorZG7gnYYc7tw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 42D83FDD6E;
        Thu,  4 Nov 2021 17:24:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 93543FDD6D;
        Thu,  4 Nov 2021 17:24:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org,
        Eric Wong <e@80x24.org>,
        "Neeraj K. Singh" <neerajsi@microsoft.com>
Subject: Re: [PATCH] refs: sync loose refs to disk before committing them
References: <dd65718814011eb93ccc4428f9882e0f025224a6.1636029491.git.ps@pks.im>
        <211104.86ilx8hwvi.gmgdl@evledraar.gmail.com>
Date:   Thu, 04 Nov 2021 14:24:26 -0700
In-Reply-To: <211104.86ilx8hwvi.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Thu, 04 Nov 2021 14:14:54 +0100")
Message-ID: <xmqqk0hn1unp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 972B2F78-3DB5-11EC-9048-CD991BBA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> I think it would probably be best to create a git_fsync_fd() function
> which is non-fatal and has that config/while loop, and have
> fsync_or_die() be a "..or die()" wrapper around that, then you could
> call that git_fsync_fd() here.

Adding git_fsync_fd() smells like a poor taste, as git_fsync() takes
an fd already.  How about making the current one into a static helper

	-int git_fsync(int fd, enum fsync_action action)
	+static int git_fsync_once(int fd, enum fsync_action action)
	 ...

and then hide the looping behavior behind git_fsync() proper?

        int git_fsync(int fd, enum fsync_action action)
        {
                while (git_fsync_once(fd, action) < 0)
                        if (errno !=3D EINTR)
                                return -1;
                return 0;
        }

fsync_or_die() can be simplified by getting rid of its loop.

None of that needs to block Patrick's work, I think.  A version that
uses raw fsync() and punts on EINTR can graduate first, which makes
the situation better than the status quo, and all the ongoing work
that deal with fsync can be extended with an eye to make it also
usable to replace the fsync() call Patrick's fix adds.
