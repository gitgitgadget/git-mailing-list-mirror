Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87D97C433F5
	for <git@archiver.kernel.org>; Fri, 29 Oct 2021 20:35:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D4CD61038
	for <git@archiver.kernel.org>; Fri, 29 Oct 2021 20:35:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230509AbhJ2Uhp (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Oct 2021 16:37:45 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:63187 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229968AbhJ2Uhn (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Oct 2021 16:37:43 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id AB71B15E23D;
        Fri, 29 Oct 2021 16:35:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=tF2/8cNNwE2C3XS5UBZBpQ7f4uWJFRWWlO1x5u
        q4KVk=; b=tBzpZesVaMXCyInRXb8B6sN7cEB9aRSFbujKlj6guSuLaKVQ36T8Tx
        XOTKGYFY4WwWWL5z4M0nIEin363GNvQXxb3hBefTMtWhr6D9T4aRNsaz8eocqSe8
        bz69YCNzQmIsyscHZJjkCi073/gaKPunTBnqgYX/flKKjyU6yl9ZQ=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id A27E015E23C;
        Fri, 29 Oct 2021 16:35:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 429B715E23B;
        Fri, 29 Oct 2021 16:35:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     <rsbecker@nexbridge.com>
Cc:     <git@vger.kernel.org>
Subject: Re: [Bug] wrapper.c uses unportable unsetenv
References: <012301d7cd01$90428960$b0c79c20$@nexbridge.com>
Date:   Fri, 29 Oct 2021 13:35:08 -0700
In-Reply-To: <012301d7cd01$90428960$b0c79c20$@nexbridge.com>
        (rsbecker@nexbridge.com's message of "Fri, 29 Oct 2021 16:14:17
        -0400")
Message-ID: <xmqqsfwjk1s3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B5FB6840-38F7-11EC-ABAA-98D80D944F46-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

<rsbecker@nexbridge.com> writes:

> The unsetenv()/setenv(overwrite) calls are not 100% portable - as in not on
> all POSIX implementations. It breaks the build on some of the NonStop
> platforms. This will change in a year or two but I really don't want to fall
> behind on git releases.
>
> This was introduced at 3540c71 but I was on vacation when it happened so did
> not catch it during reviews - my apologies for that.

I do not quite understand.  xsetenv() does use the three-arg
setenv(), but that is not anything new.  It merely replaced a call
to the same three-arg setenv() in environment.c that have already
been there, introduced by d7ac12b2 (Add set_git_dir() function,
2007-08-01).

You may argue that 3540c71 has done a shoddy job by introducing
xunsetenv() without adding any caller, and to this day, we do not
have a single caller to the wrapper, but we already have a few calls
to unsetenv() that is compiled unconditionally.

So if you built any version of Git, you must have had these somehow
"available" in your build (e.g. your system headers may have made
them a no-op), and I'd expect you'd keep doing the same to locally
work it around on the platform side, without ...

> Is it critical that this be called or can we #ifdef it away if it isn't
> supported for a build? The #if is exactly this:

... doing something like this in the generic part of the code.
Please don't do this.

> wrapper.c@150
> + #if (_TANDEM_ARCH_ > 3 || (_TANDEM_ARCH_ == 3 && __L_Series_RVU >= 2010))
> 	if (setenv(name, value, overwrite))
> 		die_errno(_("could not setenv '%s'"), name ? name :
> "(null)");
> + #endif
>
> wrapper.c@154
> + #if (_TANDEM_ARCH_ > 3 || (_TANDEM_ARCH_ == 3 && __L_Series_RVU >= 2010))
> 	if (!unsetenv(name))
> 		die_errno(_("could not unsetenv '%s'"), name ? name :
> "(null)");
> + #endif


There are compat/setenv.c and compat/unsetenv.c to be used when
NO_SETENV and NO_UNSETENV are defined.  Is that how you built your
Git earlier since 2007, perhaps?


