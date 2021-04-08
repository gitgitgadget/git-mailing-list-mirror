Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A41BCC433B4
	for <git@archiver.kernel.org>; Thu,  8 Apr 2021 23:43:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7588F61106
	for <git@archiver.kernel.org>; Thu,  8 Apr 2021 23:43:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232819AbhDHXnW (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Apr 2021 19:43:22 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59093 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232426AbhDHXnV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Apr 2021 19:43:21 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8232DC60D0;
        Thu,  8 Apr 2021 19:43:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=UnRIeA+XvWH7LNTvvwz5Cpb2wsA=; b=pR+NEb
        qFJFdQZ1AF2U1Uf0bCp9Qu8wUuT3biUT90H36PbDVYiXqNf2GCjytYRa8UkaRnks
        GVDdXVw7DAFEC/fyzjTgy5fsgTVoJtWT3fYazQDyHltPG+l1dHSKGW2oFQzi9weZ
        ydGmPNw5uLBtkGY1nSuvovPpS0YCQH2nsjJ1k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=EEcD1ulGpGI25k+RVXmw4+oiVG428ZBz
        PYOBaqiD18Zh2xyWihsOBbfJYlz/G8ZIVNCSkz79HkCCIsKlxyw6CmNZv8pyDCKW
        rbSOudLoDcAuvVAgRp5A3lvDj5ovKZ3GsauNRjfnMDYTnktyqiZgOAXDE/CH4RCS
        vWL+1hzui/0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7A667C60CF;
        Thu,  8 Apr 2021 19:43:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.243.138.161])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 09FBAC60CE;
        Thu,  8 Apr 2021 19:43:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Subject: Re: [PATCH] config: Introduce GIT_CONFIG_NOGLOBAL
References: <a23382059bb57022dd1e40d1c2c9a11307b0ff3b.1617891426.git.ps@pks.im>
        <xmqqczv4vgck.fsf@gitster.g>
        <YG+PLROZbSo32F3k@coredump.intra.peff.net>
Date:   Thu, 08 Apr 2021 16:43:08 -0700
In-Reply-To: <YG+PLROZbSo32F3k@coredump.intra.peff.net> (Jeff King's message
        of "Thu, 8 Apr 2021 19:18:05 -0400")
Message-ID: <xmqq35w0qr5f.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2C626814-98C4-11EB-81C2-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

>>  (3) when set to any other string, it is taken as a filename that
>>      has the global configuration.  Unlike $HOME/.gitconfig or
>>      $XDG_HOME/git/config, it is an error if the named file does not
>>      exist (this is to catch misconfiguration).
>> 
>> And once this is accepted by users and established as a pattern, we
>> could migrate GIT_CONFIG_NOSYSTEM to GIT_CONFIG_SYSTEM=/dev/null
>
> That seems pretty reasonable. I'm on the fence on your (3). Conceivably
> somebody could want to override the baked-in defaults without being sure
> the file is present. But I'm not sure how useful that would be in
> practice.

I was also on the fence.  

If your plan is to create $HOME/.alternate-config and point at it by
setting GIT_CONFIG_GLOBAL=$HOME/.alternate-config, there are two
places you can make typo.  You may write a file with a wrong name.
You may export a variable with a wrong name.

> Some other things to consider:
>
>   - does setting GIT_CONFIG_GLOBAL override both the $HOME and
>     $XDG_CONFIG_HOME? If the plan is to override them, that makes sense.
>     But we do usually read from both of them, so conceivably you might
>     want to override just one? That's probably over-engineering, though.

I viewed this to be working at the more conceptual "here is the file
to read 'system' (or 'per-user') stuff from" level, and not at the
level of the individual file, as I consider that it is a mere
implementation detail that 'per-user' may read from multiple files.

>   - if we have config for "read from this file instead of the system
>     config" and "read from this instead of the user-level config", then
>     I wonder if people will want "read this instead of the repo config".
>     We have resisted having GIT_CONFIG mean that for many years, because
>     I think it gets awkward in some cases (e.g., we'd still want to read
>     it for core.repositoryformatversion, etc). I'm OK with drawing the
>     line there and saying it's not a support feature, but we should be
>     prepared to explain it to users (in the docs or at least in the
>     commit message adding the system/global override variables).

We may have to bite the bullet and make an official catalog of
really "structurely fundamental" configuration variables that must
appear in the per-repository file, and a mechanism to enforce that
by always reading these variables from "$GIT_DIR/config" and always
ignoring appearances of them in any other places.

That alone would probably be a good thing to do regardless of the
GIT_CONFIG_NOGLOBAL issue, as I suspect you may be able to wreak
havoc by adding random configuration like [extension] in
$HOME/.gitconfig ;-)

With that, it would make sense to allow overriding the per-repo
configuration in a similar way, only as a mechanism to override
configuration variables that are about "preferences" (as opposed to
the structurally fundamental ones).
