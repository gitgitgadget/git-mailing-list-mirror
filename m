Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E18E5C433F5
	for <git@archiver.kernel.org>; Tue,  1 Mar 2022 02:27:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230488AbiCAC15 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Feb 2022 21:27:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230192AbiCAC15 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Feb 2022 21:27:57 -0500
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77811E61
        for <git@vger.kernel.org>; Mon, 28 Feb 2022 18:27:17 -0800 (PST)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 78675108502;
        Mon, 28 Feb 2022 21:27:16 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=bOtfTkLEKC7d0FK0voGWfGhEy5yfOpoHhPYrqj
        vWYkY=; b=OlAOaNR/ThrXwYvmHdRwer5GsVR33Iy34335q+VqrZHGJgpHWvgTQ/
        SdHFtLqRQAMLljmsRHkOPnKTxweDWncNnmQ92szQzTTpqHIb/MO5ZqUdj37tZlIk
        9k/J4ATMoZLQoZsWRH1ENlYAhjXoXmEvD0ASiCW862f0sI7Gbfp1c=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6F3A2108501;
        Mon, 28 Feb 2022 21:27:16 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D6F9D108500;
        Mon, 28 Feb 2022 21:27:15 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Elia Pinto <gitter.spiros@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH] test-lib.sh: Use GLIBC_TUNABLES instead of
 MALLOC_CHECK_ on glibc >= 2.34
References: <20220228160827.465488-1-gitter.spiros@gmail.com>
        <xmqq7d9e249n.fsf@gitster.g>
        <Yh12FNTGuJkRlqBE@camp.crustytoothpaste.net>
Date:   Mon, 28 Feb 2022 18:27:14 -0800
In-Reply-To: <Yh12FNTGuJkRlqBE@camp.crustytoothpaste.net> (brian m. carlson's
        message of "Tue, 1 Mar 2022 01:25:40 +0000")
Message-ID: <xmqqtuciwgot.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1C3934A6-9907-11EC-8375-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

>> > +	if type -p getconf >/dev/null 2>&1; then
>> > +		_GLIBC_VERSION="$(getconf GNU_LIBC_VERSION 2>/dev/null | awk '{ print $2 }')"
>> > +		if [ -n "$_GLIBC_VERSION" -a $(expr "$_GLIBC_VERSION" \>= "2.34") ]; then
>> > +			_HAVE_GLIBC_234="yes"
>> > +		fi
>> > +	fi
>> 
>> Style.  We prefer "test ..." over "[ ... ]" and more importantly we
>> don't use "test X -a Y".
>> 
>> Do we absolutely need "test -p getconf" with an extra indentation?
>> I suspect we don't.
>
> getconf is specified by POSIX, but that doesn't mean it's in the default
> install or in PATH on all systems.  However, we should write "command -v
> getconf" instead if we need to check, since that's the POSIX way to
> write it, and "type" is not guaranteed to be present on all systems.

My point was that the code relies on having getconf on PATH anyway,
so it is sufficient to attempt running getconf and using its output
after checking it begins with "glibc".  Missing getconf or getconf
that is different from what we expect it to be would be rejected by
the same code, without needing the above nested if .. if .. fi .. fi
