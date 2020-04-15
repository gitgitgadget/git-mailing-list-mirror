Return-Path: <SRS0=MaRY=57=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F4AEC3815B
	for <git@archiver.kernel.org>; Wed, 15 Apr 2020 19:17:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 44C1120771
	for <git@archiver.kernel.org>; Wed, 15 Apr 2020 19:17:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="eFBVORhm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406357AbgDOTHW (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Apr 2020 15:07:22 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61131 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1416841AbgDOSjw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Apr 2020 14:39:52 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C4FB062EE3;
        Wed, 15 Apr 2020 14:39:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=k/KhqBD8a/qI9sHwIPSmFesONxg=; b=eFBVOR
        hmSLrY4pWEnFT9UWAM6MRTYpmjXyh0KSS/LpVi+kewuvww7wDgWPy7aDKZn10U5+
        cyjsJ5sGbgBgX7z28SyqMGBMXLvuMEUajpWGbk37E/mElcPq27rZ9Jll6FgmY20s
        sQsp6Zl3IAcXkAAOBZk1AHNEC3Nl/3pj8Q9Tg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=SP+qvqChdnWqJEs+Bu5W9ngsy+ohhOTr
        CAJ8nwjmN+0KcGQO/FMe98LL5SEcXgU1FEyAy6wWwL+DqWpV255czQViYGZMpmnM
        E2JJEjMTYXw+ASDKxW+ZHRvQD3XN9qmtyvSEm2w2aPw7yn3BR23GJJZ7snsUKQdt
        lJcz6x7ocEk=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id BDE7062EE2;
        Wed, 15 Apr 2020 14:39:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 3E47062EE1;
        Wed, 15 Apr 2020 14:39:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] credential: treat "?" and "#" in URLs as end of host
References: <20200414214304.GA1887601@coredump.intra.peff.net>
Date:   Wed, 15 Apr 2020 11:39:48 -0700
In-Reply-To: <20200414214304.GA1887601@coredump.intra.peff.net> (Jeff King's
        message of "Tue, 14 Apr 2020 17:43:04 -0400")
Message-ID: <xmqqv9m061aj.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7C9527EA-7F48-11EA-BC13-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> -	slash = strchrnul(cp, '/');
> +
> +	/*
> +	 * A query or fragment marker before the slash ends the host portion.
> +	 * We'll just continue to call this "slash" for simplicity. Notably our
> +	 * "trim leading slashes" part won't skip over this part of the path,
> +	 * but that's what we'd want.
> +	 */
> +	slash = cp + strcspn(cp, "/?#");

Whatever happened when the original did not find any slash should
happen in the new code when none of these three terminating bytes
is found.  The original made slash point at the end of the string,
and the new code does the same.

So, by definition, the code is correct ;-)

> diff --git a/t/t0300-credentials.sh b/t/t0300-credentials.sh
> index 5b78ebbc3f..b6ec676989 100755
> --- a/t/t0300-credentials.sh
> +++ b/t/t0300-credentials.sh
> @@ -443,11 +443,45 @@ test_expect_success 'url parser ignores embedded newlines' '
>  	username=askpass-username
>  	password=askpass-password
>  	--
> -	warning: url contains a newline in its host component: https://one.example.com?%0ahost=two.example.com/
> +	warning: url contains a newline in its path component: https://one.example.com?%0ahost=two.example.com/

Nice demonstration ;-).

