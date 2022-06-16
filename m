Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16EBAC43334
	for <git@archiver.kernel.org>; Thu, 16 Jun 2022 05:00:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343750AbiFPFAW (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Jun 2022 01:00:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbiFPFAU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Jun 2022 01:00:20 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 430B111462
        for <git@vger.kernel.org>; Wed, 15 Jun 2022 22:00:19 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id D1CE218A7A1;
        Thu, 16 Jun 2022 01:00:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=7NJ0u7cAZHmyKllwj/VHy+ujg7V3f9xPXULyGZ
        9fXZ0=; b=oLIY0ZPGuRpUHK49njCs1drVncrA1GfH30I3QHlpREIdQHNEUdwpj3
        EcW+XgKXIQtI0+9wTAwEHb+tUAJs2QJ/bBsWdNFyfaIZC38j0R+Wk06OF0DCmSJr
        5PJbUN+phkKC7n+0sbOU4wrx8pbdVWKnsrAKtsNuBfJNe6KW93jsg=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id C9F5018A7A0;
        Thu, 16 Jun 2022 01:00:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 6CE0A18A78C;
        Thu, 16 Jun 2022 01:00:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH 11/11] bug_fl(): add missing `va_end()` call
References: <pull.1264.git.1655336146.gitgitgadget@gmail.com>
        <d674aefa78bdb6d255e40af2f308abf8a87a593a.1655336146.git.gitgitgadget@gmail.com>
        <Yqq3O5hykBecoVKQ@coredump.intra.peff.net>
Date:   Wed, 15 Jun 2022 22:00:14 -0700
In-Reply-To: <Yqq3O5hykBecoVKQ@coredump.intra.peff.net> (Jeff King's message
        of "Thu, 16 Jun 2022 00:53:15 -0400")
Message-ID: <xmqq8rpxw6ch.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 35DEFB60-ED31-11EC-AA7D-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Wed, Jun 15, 2022 at 11:35:45PM +0000, Johannes Schindelin via GitGitGadget wrote:
>
>> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>> 
>> According to the manual:
>> 
>> 	Each invocation of va_copy() must be matched by a corresponding
>> 	invocation of va_end() in the  same function.
>> 
>> Note: There is another instance of `va_copy()` in `usage.c` that is
>> missing a `va_end()` call, in `BUG_vfl()`. It does not matter there,
>> though, because that function either `exit()`s or `abort()`s, anyway.
>> 
>> Reported by Coverity.
>
> This was introduced by the recent 0cc05b044f (usage.c: add a non-fatal
> bug() function to go with BUG(), 2022-06-02). But there's a much worse
> bug in the same function. The code introduced by that patch does:
>
>   va_list ap, cp;
>   [...]
>   va_copy(cp, ap);
>   va_start(ap, fmt);
>
> So "cp" is copied from "ap" before we have actually initialized "ap".
> It's surprising that this works at all. The two lines should be flipped.

Yes, it is surprising.  Perhaps it is not working at all.

Thanks for an extra set of eyeballs.

> IMHO, since we're in the actual varargs function itself, it would be
> simpler to just bracket each use with start/end, rather than copying,
> like:
>
> diff --git a/usage.c b/usage.c
> index 79900d0287..56e29d6cd6 100644
> --- a/usage.c
> +++ b/usage.c
> @@ -334,15 +334,17 @@ NORETURN void BUG_fl(const char *file, int line, const char *fmt, ...)
>  int bug_called_must_BUG;
>  void bug_fl(const char *file, int line, const char *fmt, ...)
>  {
> -	va_list ap, cp;
> +	va_list ap;
>  
>  	bug_called_must_BUG = 1;
>  
> -	va_copy(cp, ap);
>  	va_start(ap, fmt);
>  	BUG_vfl_common(file, line, fmt, ap);
>  	va_end(ap);
> -	trace2_cmd_error_va(fmt, cp);
> +
> +	va_start(ap, fmt);
> +	trace2_cmd_error_va(fmt, ap);
> +	va_end(ap);
>  }
>  
>  #ifdef SUPPRESS_ANNOTATED_LEAKS
>
> but I am happy with any solution that is correct. :)
>
> -Peff
