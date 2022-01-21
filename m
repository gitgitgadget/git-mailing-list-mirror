Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4410C433EF
	for <git@archiver.kernel.org>; Fri, 21 Jan 2022 20:49:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231492AbiAUUtZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Jan 2022 15:49:25 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61977 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbiAUUtZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Jan 2022 15:49:25 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1521010AD5F;
        Fri, 21 Jan 2022 15:49:24 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=HyrjPR6obYjSI44XRj5dmos+LhtP4zDTEf8c1F
        rHCqo=; b=ULGx/RgDR5s8f+RQOWpUFR/SH3Hj7bSz7mevYUuiCMu9tx6MGZxRD9
        8ye/zKvUXFGRXtQAhQGVAXJEkrefPqq2LZdgHAaTUTYQWsLoeR66enfNji8lPQkr
        0ec7tOY9XWHwPh5pvkt/0KotspX4j6/9ZWX/bG1VNlK+SP8hxJUnk=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 0A56B10AD5E;
        Fri, 21 Jan 2022 15:49:24 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 69EE710AD5D;
        Fri, 21 Jan 2022 15:49:23 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>, git@vger.kernel.org
Subject: Re: [GSoC] [PATCH 1/1] t0001: replace "test [-d|-f]" with
 test_path_is_* functions
References: <20220121102109.433457-1-shaoxuan.yuan02@gmail.com>
        <20220121102109.433457-2-shaoxuan.yuan02@gmail.com>
        <Yer/oEZK6TBFSsde@nand.local>
Date:   Fri, 21 Jan 2022 12:49:22 -0800
In-Reply-To: <Yer/oEZK6TBFSsde@nand.local> (Taylor Blau's message of "Fri, 21
        Jan 2022 13:46:56 -0500")
Message-ID: <xmqqr190g6gd.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9D34B352-7AFB-11EC-97A1-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

>> -	if test -d "$1" && test -f "$1/config" && test -d "$1/refs"
>> +	if test_path_is_dir "$1" && test_path_is_file "$1/config" && test_path_is_dir "$1/refs"
>>  	then
>>  		: happy
>>  	else
>
> Looks very reasonable to me. Indeed, this line comes from 6adcca3fe8
> (Fix initialization of a bare repository, 2007-08-27) which predates
> 2caf20c52b (test-lib: user-friendly alternatives to test [-d|-f|-e],
> 2010-08-10) when these helpers were originally introduced.
>
> I thought that we could probably just shorten this to calling
> "test_path_is_file" twice: once for "$1/config" and a second time for
> "$1/refs", but that assumes "$1" is non-empty. And to ensure that you'd
> need another check, which amounts to the same amount of code overall.

I had the same thought.

Since the first "$GIT_DIR must be a directory" matters only when the
caller is crazy enough to have a bare repository at the root of the
filesystem and to think that it is a good idea to say "" is the
"$GIT_DIR" (in which case, "test -d ''" would fail, even though the
tests for /config and /refs are checking the right thing), I do not
see much downside from omitting the first one, but I think that is
something we need to do _outside_ the topic of this change, which is
purely "modernize, using the helpers we already have, without
changing what we do".


