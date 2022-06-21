Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C5EAC43334
	for <git@archiver.kernel.org>; Tue, 21 Jun 2022 16:35:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353142AbiFUQfa (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Jun 2022 12:35:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352486AbiFUQf3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Jun 2022 12:35:29 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EADF225284
        for <git@vger.kernel.org>; Tue, 21 Jun 2022 09:35:28 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3430D133829;
        Tue, 21 Jun 2022 12:35:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=lzN9rSgpOqW5gThiy0va5/4UV/aVV41eDoUaPf
        9rMd8=; b=Ei5wzif+1zstN92sQA8OmGDrVu/cAmXKLDLWbP3VwuBHLT+LXtcAYS
        O1Qa9KIdLD7f+lAuAIjR9HMbXSUqlUk79SLFmtapWUtlCeUezONbz2pw3jenI7rQ
        x3izA5wLjOGjwdzEkd5RqR2gCWXbq7VNflQNzh7wpk+5EfSyc9GCE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2A720133828;
        Tue, 21 Jun 2022 12:35:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 8F322133827;
        Tue, 21 Jun 2022 12:35:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Derrick Stolee <derrickstolee@github.com>, rsbecker@nexbridge.com,
        git@vger.kernel.org, avarab@gmail.com
Subject: Re: [PATCH v2] t5510: replace 'origin' with URL more carefully (was
 Re: Test Failure t5510,t5562 - was RE: [ANNOUNCE] Git v2.37.0-rc1)
References: <00a401d884d0$32885890$979909b0$@nexbridge.com>
        <8d2a0a36-1d2f-c723-db1e-8978e5d03d1d@github.com>
        <00b501d884d7$d8ed1200$8ac73600$@nexbridge.com>
        <495bd957-43dc-f252-657d-2969bb7ad5f3@github.com>
        <484a330e-0902-6e1b-8189-63c72dcea494@github.com>
        <YrFwcL2dRS/v7xAw@coredump.intra.peff.net>
Date:   Tue, 21 Jun 2022 09:35:26 -0700
In-Reply-To: <YrFwcL2dRS/v7xAw@coredump.intra.peff.net> (Jeff King's message
        of "Tue, 21 Jun 2022 03:17:04 -0400")
Message-ID: <xmqq1qviht4h.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 284FD84A-F180-11EC-A698-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> And then further changes are easy:
>
>   - you could replace the ad-hoc "I hope single quotes are enough"
>     quoting of $url with a real regex

Yes, this is what I found a bit queasy about in the whole thing.

>   - you can define $sq inside the perl script to avoid the gross '\''
>     quoting (or even avoid it entirely with quotemeta)
>
> So perhaps something like:
>
>   perl -e '
>     my ($cmdline, $url) = @ARGV;
>     $cmdline =~ s[origin(?!/)][quotemeta($url)]ge;
>     print $cmdline;
>   ' -- "$cmdline" "$remote_url"

Yup, a solution along that line was what I expected to see from
those who write Perl when I saw the discussion yesterday.

FWIW, there are a few characters that won't be acceptable in the
pathname for our source tree, including a single quote (I think some
of our build procedures are loose in quoting, unlike parts of the
Makefile that use $(FOO_SQ) for that) and a colon (testing the
version of Git we just built needs the path of the build directory
in GIT_EXEC_PATH, which is prepended to PATH at runtime during the
test, but the colon means that the path is split into two there), so
"I hope single quotes are enough" is not making things worse in
practice, but quotemeta() is so simple---allowing us not having to
worry about quoting is a very good thing.

Thanks.


