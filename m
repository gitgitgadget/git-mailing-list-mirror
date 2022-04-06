Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B49A8C433FE
	for <git@archiver.kernel.org>; Wed,  6 Apr 2022 21:23:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235711AbiDFVZo (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Apr 2022 17:25:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235730AbiDFVZD (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Apr 2022 17:25:03 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 404B7232D0E
        for <git@vger.kernel.org>; Wed,  6 Apr 2022 13:20:13 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 92BB7131CE4;
        Wed,  6 Apr 2022 16:20:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=da/fnOz8t6sN6SsSJQx9vU/8fiZ8HD+03Ug2bV
        y1nf8=; b=XOC0Pnn7MxO4mWtf8XEcGfb/SdIh7TA/guPxQjBfaOy1utL16q2EFm
        RsW7zcLMx4RcW3e3d89OKuBJ7nevhB2cL2ir2sjSpH9/jp5zALO8TzjlSZHz/0I1
        BBHOiQySEn9v2E0JiY1cXeD8YAQ1i7Ej75vyqafOGKxoTmgHkAQB8=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8A032131CE3;
        Wed,  6 Apr 2022 16:20:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.230.65.123])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E16D0131CE0;
        Wed,  6 Apr 2022 16:20:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Theodore Ts'o" <tytso@mit.edu>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Markus Vervier <markus.vervier@x41-dsec.de>,
        git@vger.kernel.org
Subject: Re: Covierty Integration / Improvement
References: <10fd679a-eb94-5380-2070-699f1b56a7b1@x41-dsec.de>
        <nycvar.QRO.7.76.6.2204052352030.379@tvgsbejvaqbjf.bet>
        <nycvar.QRO.7.76.6.2204061620110.379@tvgsbejvaqbjf.bet>
        <Yk3UAz3sn9KhMnyf@mit.edu>
Date:   Wed, 06 Apr 2022 13:20:10 -0700
In-Reply-To: <Yk3UAz3sn9KhMnyf@mit.edu> (Theodore Ts'o's message of "Wed, 6
        Apr 2022 13:55:15 -0400")
Message-ID: <xmqqfsmqx8ud.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F6349A50-B5E6-11EC-8E5B-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Theodore Ts'o" <tytso@mit.edu> writes:

> On Wed, Apr 06, 2022 at 05:08:37PM +0200, Johannes Schindelin wrote:
>> I have fixed Git for Windows' Coverity build and started to sift through
>> the 154 new defects reported as of v2.36.0-rc0.
>> 
>> Sadly, there is now a new class of overwhelming false positives: Coverity
>> claims that "strbuf_addstr does not [NUL-]terminate", which is of course
>> false.
>
> It should be possible to suppress this by uploading a Coverity model
> file.  See[1] for more details:
>
> [1] https://community.synopsys.com/s/article/practical-example-of-coverity-function-model
>
> I've suppressed a similar issue by using the attribute __nonstring,
> but I don't think that will work for git, because strbuf->buf really
> *is* a NUL-terminated string, where as in ext4 we have some fields
> which are designed to be NUL padded, but it is *not* guaranteed to be
> NUL-terminated:

That is very much expected from filesystem code, for which strncmp()
and friends were invented for ;-)

> (This is needed to suppress warnings by Clang as well.)
>
> Using __nonstring will result in attempts to use s_volume_name in "C"
> string context to give a warning, which is why this isn't right for
> strbuf->buf.

Indeed.  We do aim to make reading .buf member as NUL-terminated
string safe, so it would make it very inconvenient to warn against
such uses.

Thanks.


