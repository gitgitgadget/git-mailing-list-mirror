Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 084FDC433F5
	for <git@archiver.kernel.org>; Wed, 23 Mar 2022 11:13:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243763AbiCWLOm (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Mar 2022 07:14:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234132AbiCWLOk (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Mar 2022 07:14:40 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 510F41400E
        for <git@vger.kernel.org>; Wed, 23 Mar 2022 04:13:09 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 4435918268C;
        Wed, 23 Mar 2022 07:13:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type
        :content-transfer-encoding; s=sasl; bh=Wt6jU55wiZjKwpX/zAS4zaEux
        2FMB1gnGM+zAyxDgl0=; b=jzAHrkWMK8CawWudHzgAnsp6S1HevGMJ1Ok9ALBoE
        t0D6GyUFIelVLAA+bZDITREhCl2veBbX1CvhHD2U1AY/4DvJPDzQsXVxEe1iZtmL
        NL8yznn/l7x2jY9Oky0qWgy/lUl8q0pDtLz3NGZ9O0qWBUycUSoFU5XV2aSSEMBs
        YU=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 3CB2518268B;
        Wed, 23 Mar 2022 07:13:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.227.145.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id A7300182689;
        Wed, 23 Mar 2022 07:13:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Elia Pinto <gitter.spiros@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH 00/41] use the stdlib EXIT_SUCCESS or EXIT_FAILURE exit
 status
References: <20220321225523.724509-1-gitter.spiros@gmail.com>
        <220322.86r16unzer.gmgdl@evledraar.gmail.com>
Date:   Wed, 23 Mar 2022 04:13:05 -0700
Message-ID: <xmqqsfr8udku.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 370DBDB6-AA9A-11EC-A2DA-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> We also document for some of these programs that on failure we'll
> return 1 specifically, not whatever EXIT_FAILURE is.

I view this as a real issue.  EXIT_FAILURE could by happenstance be
defined to be the same value on all platforms we care about, but if
it leaves the possibility that the next major thing will break our
assumption, I do not see much point in adopting it.  Whole-sale
rewriting of 0 and 1 to EXIT_SUCCESS and EXIT_FAILURE smells like
adopting a bad standardization without thinking things through, only
for the sake of adopting "standardization".

> ... but we should fix the exit(-1) cases, and that's best done
> with some new GIT_TEST_ASSERT_NO_UNPORTABLE_EXIT testing or
> whatever.

That is probably a good #leftoverbit, even a candidate for future
#microprojects.

> I think we'd be much better off with something like this in
> git-compat-util.h:
>
>     #ifndef BYPASS_EXIT_SANITY
>     #ifdef EXIT_SUCCESS
>     #if EXIT_SUCCESS !=3D 0
>     #error "git assumes EXIT_SUCCESS is 0, not whatever yours is, pleas=
e report this. Build with -DBYPASS_EXIT_SANITY to continue building at yo=
ur own risk"

This is not a good idea.  EXIT_SUCCESS does not have to be literally
0.  It only has to be a value that causes the process to exit with 0
when passed to exit().

>     #endif
>     #endif
>     #ifdef EXIT_FAILURE
>     #if EXIT_FAILURE !=3D 0

I think you meant "!=3D 1".  If we were to take these 41 patches, we
must have this hunk, as we want our plumbing tools to be drivable by
shell scripts, i.e.=20

	git foo ||
	case $? in
	1) # generic failure
		...
	esac

and we do not want to be forced to write something like

	. git-stdlib-util.sh ;# for platform-dependent $EXIT_FAILURE

	...
	git foo ||
	case $? in
	$EXIT_FAILURE) # generic failure
		...
	esac
=09
instead.
