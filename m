Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A36CDC19F2A
	for <git@archiver.kernel.org>; Thu,  4 Aug 2022 18:20:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234862AbiHDSUJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Aug 2022 14:20:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbiHDSUI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Aug 2022 14:20:08 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED335655D
        for <git@vger.kernel.org>; Thu,  4 Aug 2022 11:20:06 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 84F1613E767;
        Thu,  4 Aug 2022 14:20:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=4PZyXOawDBMELGtyik1RgApFHWZczCv9cH8qEj
        vd0nU=; b=nUntt+kHPCp+UCPhI/MDqYbPRSI/DawO9jyXoX9UX3ANy4z/4efKex
        2WBsbvO7IKx1+kXbMp9gtZF1CSJ8IgsS4H3CW9NBVtH7SGjwm44+ycladWA6A79f
        PJE/p1qXzs/YbRz5zXwS/Vj4sVCyrTq8j7mHG7OcJmEIvCqZ8H9Ck=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 76A0813E766;
        Thu,  4 Aug 2022 14:20:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.145.39.32])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 2DEF713E758;
        Thu,  4 Aug 2022 14:20:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, me@ttaylorr.com, newren@gmail.com,
        avarab@gmail.com, dyroneteng@gmail.com, Johannes.Schindelin@gmx.de,
        szeder.dev@gmail.com, mjcheetham@outlook.com, steadmon@google.com
Subject: Re: [PATCH v2 4/5] bundle-uri: add support for http(s):// and file://
References: <pull.1300.git.1658781277.gitgitgadget@gmail.com>
        <pull.1300.v2.git.1659443384.gitgitgadget@gmail.com>
        <e4f2dcc7a45388663aeac786e5abdcf2164cfe62.1659443384.git.gitgitgadget@gmail.com>
        <xmqq8ro6fi1j.fsf@gitster.g>
        <9afd5eb2-44a0-6342-6006-5dbdefba9947@github.com>
Date:   Thu, 04 Aug 2022 11:19:59 -0700
In-Reply-To: <9afd5eb2-44a0-6342-6006-5dbdefba9947@github.com> (Derrick
        Stolee's message of "Thu, 4 Aug 2022 11:34:36 -0400")
Message-ID: <xmqqsfmb50s0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0E817486-1422-11ED-9975-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <derrickstolee@github.com> writes:

>>> +	if (istarts_with(uri, "https:") ||
>>> +	    istarts_with(uri, "http:"))
>> 
>> Let's be a bit more strict to avoid mistakes and make the code
>> immediately obvious, e.g.
>> 
>> 	if (istarts_with(uri, "https://") ||
>> 	    istarts_with(uri, "http://"))

This part (i.e. check for "<scheme>://", not "<scheme>:") still
stands, as the latter could be an scp style Git URL that goes to the
host whose name is <scheme>.  As mentioned later, s/istarts/starts/
is probably a good thing to do here.

>> Does "git-remote-https" talk to a "http://" URL just fine when uri
>> parameter starts with "http://"?  Would it be the same if the uri
>> parameter begins with say "Http://"?
>
> I did a quick check of our HTTPS tests modifying the HTTPD_PROTO
> variable in lib-httpd.sh to "HtTP" and we get this fun error:
>
> + git clone --filter=blob:limit=0 HtTP://127.0.0.1:5601/smart/server client
> Cloning into 'client'...
> git: 'remote-HtTP' is not a git command. See 'git --help'.
>
> So I guess I can keep case-sensitive comparisons here.

Guarding them to lowercase-only may sound like a cop-out to purists,
but I think it is reasonable thing to do.  The only folks that would
be offended by are protocol lawyers, and as your check shows, we are
treating <scheme> case sensitively already.

An obvious alternative is to downcase the "<scheme>://" part but I
do not think it is worth it; we have to do that everywhere and we
need to be confident that we covered all the code paths---the latter
is expensive.

There do exist skip_iprefix() that are used in many places, like
convert, http, mailinfo, etc. by the way.  That is a moot point as
we are not doing case insensitive comparison anymore.

Thanks.
