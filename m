Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F5B2C433F5
	for <git@archiver.kernel.org>; Thu, 16 Dec 2021 22:32:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234141AbhLPWcH (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Dec 2021 17:32:07 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:57924 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230462AbhLPWcH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Dec 2021 17:32:07 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id BCB0E178802;
        Thu, 16 Dec 2021 17:32:06 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=jn4Z2KZXhGwyFtmgFsEPywzMrkb7ghUu3Mrdpn
        hTBRA=; b=xxcVa/vOvSWszuor2tVGHpL48diAggDm9yJNRMRaQtXOkkZY33Mleq
        n/Wf4N6j6f0o/NX00bA9AWEymp+KRgkZbXP3rLVj2b2hoYq2D8mzZW9hvNkNSFI+
        eGWmHAZ3o3+JDjEB6HMRCB3lfg9yLex4POyafcy8jZiYdMiwte5s0=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id B512B178801;
        Thu, 16 Dec 2021 17:32:06 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 1C79E178800;
        Thu, 16 Dec 2021 17:32:03 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Andriy Makukha via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Andriy Makukha <andriy.makukha@gmail.com>
Subject: Re: [PATCH] strlcpy(): safer and faster version
References: <pull.1097.git.1639675881065.gitgitgadget@gmail.com>
        <YbuB8xeHLNSYnv/a@coredump.intra.peff.net>
Date:   Thu, 16 Dec 2021 14:32:01 -0800
In-Reply-To: <YbuB8xeHLNSYnv/a@coredump.intra.peff.net> (Jeff King's message
        of "Thu, 16 Dec 2021 13:14:11 -0500")
Message-ID: <xmqqy24k6v1a.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: FDCA79D4-5EBF-11EC-8D74-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Thu, Dec 16, 2021 at 05:31:20PM +0000, Andriy Makukha via GitGitGadget wrote:
>
>> Original strlcpy() has a significant disadvantage of being both unsafe
>> and inefficient. It unnecessarily calculates length of `src` which may
>> result in a segmentation fault if `src` is not terminated with a
>> NUL-character.
>
> I think any code that passes such a "src" is still broken after your
> code. If the length of "src" is less than "size", then the result in
> "dest" will contain garbage we read from the memory after "src".
>
> Likewise in that case using strnlen() isn't any faster, since it has to
> look at the same number of bytes either way (it may even be slower since
> its loop has two conditions to check).
>
>> In this fix, if `src` is too long, strlcpy() returns `size`. This
>> allows to still detect an error while fixing the mentioned
>> vulnerabilities. It deviates from original strlcpy(), but for a good
>> reason.
>
> This could potentially break callers of strlcpy(), though, because it's
> changing the semantics of the return value. For example, if they use the
> return value to expand a buffer to hold the result.
>
> I do think the proposed semantics are better (I have actually fixed a
> real overflow bug where somebody assumed strlcpy() returned the number
> of bytes written). But we probably should not call it strlcpy(), because
> that's has well-known behavior that we're not meeting.
>
> I don't think any of the current code would be broken by this (most does
> not even look at the return value at all). It just seems like an
> accident waiting to happen.
>
> Personally, I don't love strlcpy() in the first place. Avoiding heap
> overflows is good, but unexpected truncation can also be buggy. That's
> why try to either size buffers automatically (strbuf, xstrfmt,
> FLEX_ALLOC, etc) or assert that we didn't truncate (xsnprintf).
>
> Some cases could probably be converted away from strlcpy(). For
> instance, the color stuff in add-interactive.c should be using
> xsnprintf(), since the point of COLOR_MAXLEN is to hold the
> longest-possible color. The ones in difftool.c probably ought to be
> strbufs. There are definitely some that want the truncation semantics
> (e.g., usernames in archive-tar.c). We might be better off providing a
> function whose name makes it clear that truncation is OK.
>
>>  size_t gitstrlcpy(char *dest, const char *src, size_t size)
>>  {
>> -	size_t ret = strlen(src);
>> +	/*
>> +	 * NOTE: original strlcpy returns full length of src, but this is
>> +	 * unsafe. This implementation returns `size` if src is too long.
>> +	 * This behaviour is faster and still allows to detect an issue.
>> +	 */
>> +	size_t ret = strnlen(src, size);
>
> Also, strnlen() isn't portable, so we'd need a solution there (open
> coding or yet another compat wrapper).

Thanks for saying everything I wanted to say ;-)
