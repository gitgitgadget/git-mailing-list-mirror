Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 472B0C433DB
	for <git@archiver.kernel.org>; Wed,  6 Jan 2021 04:06:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1E03722D04
	for <git@archiver.kernel.org>; Wed,  6 Jan 2021 04:06:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725815AbhAFEGI (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 Jan 2021 23:06:08 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:52934 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725730AbhAFEGI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Jan 2021 23:06:08 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id A1DA410BFED;
        Tue,  5 Jan 2021 23:05:27 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type
        :content-transfer-encoding; s=sasl; bh=50zB+C0lTsC1pE1wakjwXdGiY
        P8=; b=vg286KpzAU3oOlizKsOxMDpfF+KXaEemyuGFv52BHC7iMbtGTtL130Eqq
        Wfm2IcvVLLHNaYXUFOzVg/3OFyrz0tyzFPA9MDSs7oPPXzp5gNgPjAcPmTHvHs2c
        QbEgsjk5P8jDdo3MJ2NOEzQXzcvsSVAZM5LvrppKJu7DNP74HY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type
        :content-transfer-encoding; q=dns; s=sasl; b=VOFzl0bdfL4B/oPE6Kr
        dfxeo1U06pveGMl5yPkcSSNHOJWFcYpjX1gOyoBH8j/eAItmeyVR00xPY+temkbb
        Eb5sMYK5+dZiUaUhUC/+Avn5Uasn0UIHS0Pl+RxbrEDM/Sc7sb6YJ8d8t4Y7jkAW
        r5EeenWGbHN//kTj0+/BBUbU=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 878FD10BFEC;
        Tue,  5 Jan 2021 23:05:27 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 3052910BFEB;
        Tue,  5 Jan 2021 23:05:24 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
Cc:     Dan Moseley <Dan.Moseley@microsoft.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH] git-mv: fix git mv bug with case insensitive fs
References: <BYAPR21MB1158F64E1141453F7D00B46CE0D89@BYAPR21MB1158.namprd21.prod.outlook.com>
        <BYAPR21MB11585FFD46DEE7AD4EEEFEABE0D89@BYAPR21MB1158.namprd21.prod.outlook.com>
        <BYAPR21MB1158D9E88C96D51259A0CC04E0D89@BYAPR21MB1158.namprd21.prod.outlook.com>
        <20201231071357.mtcxmoxbg6jrq3gn@tb-raspi4>
Date:   Tue, 05 Jan 2021 20:05:22 -0800
Message-ID: <xmqq7doqwvzx.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 66D939E8-4FD4-11EB-96C2-D609E328BF65-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Torsten B=C3=B6gershausen <tboegi@web.de> writes:

> On Tue, Dec 29, 2020 at 02:06:37AM +0000, Dan Moseley wrote:
>
> First of all, thanks for submitting this to git.git.
> I take the freedom to add some comments here.
>
>> Fix git mv to not assert when src is already in the index under a
>> different casing, core.caseInsensitive=3Dtrue, and the file system
>> is case insensitive.
> The config variable is named core.ignorecase
>
> Does it make sense to illustrate the use case here, like this:
>
>  git init
>  echo foo >foo
>  git add foo
>  git mv foo FOO
>  git mv foo bar
>
>>
>> Since 9b906af657 the check that git mv does to ensure the src is in th=
e
>> cache respects caseInsensitive. As a result git mv allows a move from =
a
>> file that has a different case in the index than it does on disk.
>> After the rename on disk, git mv fails to find the file in the cache
>> in order to rename it in the index, and asserts.
>> Assertion failed: pos >=3D 0, file builtin/mv.c, line 295
>>
>> This is the simplest possible fix, suggested by @tboegi. It does leave
>> the file renamed on disk, but that is easy to reverse after the error.
>
> We can expand the short-ish "@tboegi" into a "Helped-by" line, please s=
ee below.
> And refrase the paragraf like this:
>
> This is the simplest possible fix, it avoids to leaving a .git/index.lo=
ck
> behind.  It does leave the file renamed on disk,
> but that is easy to reverse after the error.

Sorry but I feel lost here.  So this is not a fix with which the end
user does not have to do anything after kicking in?  The only thing
it "fixes" is to avoid hitting a BUG() or something that can leave
the .lock file behind (so that the user does not have to run "rm
.git/index.lock" after the operation)?

