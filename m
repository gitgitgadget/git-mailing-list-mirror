Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B85F9C001E0
	for <git@archiver.kernel.org>; Tue,  8 Aug 2023 21:53:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232142AbjHHVx7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Aug 2023 17:53:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231500AbjHHVxr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Aug 2023 17:53:47 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2BE72108
        for <git@vger.kernel.org>; Tue,  8 Aug 2023 14:53:08 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id CD8791A38FF;
        Tue,  8 Aug 2023 17:53:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=EZs2TMqlVb+3
        etdWEvg9n3YfCp4w+NBWZzMIdWkwtm8=; b=xUCBgKRhgv9Z3PDlayGA3Ux8bAhW
        hmyHZgGPtOK3FcKPQV4WIxXfQ+JJKNI2NSBUHKyIJ9FVhLFX+d+dzOHU7iIhZusg
        wEyheUuVzZsJGUd7goA1RYfKYOLNEewMAgR22tfJWYA2dZYtg4febqqenORB4C9y
        67PvdMmyMMFKbDU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id BFC231A38FE;
        Tue,  8 Aug 2023 17:53:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.168.215.201])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 65E641A38F9;
        Tue,  8 Aug 2023 17:53:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
Cc:     Sebastian Thiel via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Sebastian Thiel <sebastian.thiel@icloud.com>
Subject: Re: [PATCH] fix `git mv existing-dir non-existing-dir`*
References: <pull.1561.git.1691506431114.gitgitgadget@gmail.com>
        <xmqqy1il77wp.fsf@gitster.g>
        <20230808184054.cjhiboifschkwuoz@tb-raspi4>
Date:   Tue, 08 Aug 2023 14:53:05 -0700
In-Reply-To: <20230808184054.cjhiboifschkwuoz@tb-raspi4> ("Torsten
        =?utf-8?Q?B=C3=B6gershausen=22's?= message of "Tue, 8 Aug 2023 20:40:54
 +0200")
Message-ID: <xmqqmsz16w1q.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: F4DCD4B2-3635-11EE-BA09-307A8E0A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Torsten B=C3=B6gershausen <tboegi@web.de> writes:

> On Tue, Aug 08, 2023 at 10:36:54AM -0700, Junio C Hamano wrote:
>> "Sebastian Thiel via GitGitGadget" <gitgitgadget@gmail.com> writes:
>>
>> > From: Sebastian Thiel <sebastian.thiel@icloud.com>
>> >
>
> The patch makes sense to me, Junio's comments included.
>
>> Shouldn't it do something similar to
>>
>>     $ mv D1 D2
>
> Couldn't resist to test it ;-)
>
> The result would be
>  renamed: D1/file1 -> D2/D1/file1

Sure.  The lstat() in question is about the case where a different
D2/D1 already exists, either as a file (which will definitely break
as we do not and should not do unlink-and-then-mkdir) or as a
directory (which may be OK in some cases to get a union of the
contents in the original D1 and D2/D1, but in general not a good
idea).

And in the latter case, i.e. when D2/D1 exists as a directory, we
should not say "cannot move directory over file".  So, the check
that does not care what the dest_dir's type is fine. but the error
message is wrong.

    "cannot move directory over file, source=3DD1, destination=3DD1/D2"

is the message we would get in such a case.  We probably just should
say

    "destination already exists, source=3DD1, destination=3DD1/D2"

or something like that.
