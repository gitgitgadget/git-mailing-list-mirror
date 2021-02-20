Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E35EC433DB
	for <git@archiver.kernel.org>; Sat, 20 Feb 2021 03:26:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3C0CF64E4B
	for <git@archiver.kernel.org>; Sat, 20 Feb 2021 03:26:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229767AbhBTDZz (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Feb 2021 22:25:55 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61793 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229745AbhBTDZy (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Feb 2021 22:25:54 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D36469D591;
        Fri, 19 Feb 2021 22:25:11 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=R3VNEHqEneekapD+ghsdj5z03V4=; b=DmoWJk
        4rfoN6G5uG8hOX44eYxixx0zlsNFf42cjD+rpi6Fg7Mc2tasK3ABkMAX5KT7NXG7
        T1OElvOIuSgLwr4ggQa8eoyLJH3Qqt7DtztmB0w7nAoMzCIj+6bBrD283iMMLBdo
        LQ/SNysOK4L/jZd8Kr9JLR3HWd7GfoULGKJBQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ZHXpBmU5WEU5+ve2qQrTXxMYOEjdwNO1
        WyAGv3LJfpy2Hp6EjoGdELXxJc32orDv8Q94yOd2XCGrpj07yoP2cvwMPgJTbc2i
        IYHuqh92s7mxgb1vdVUCL1GPrVUdYvebd5bVeJIquND4nHhodmhxbYOqFExMOLOn
        9Y7sbk2bcZM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id CC00E9D590;
        Fri, 19 Feb 2021 22:25:11 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 541BB9D58E;
        Fri, 19 Feb 2021 22:25:11 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [RFC PATCH] push: perform negotiation before sending packfile
References: <xmqqy2fldsy4.fsf@gitster.g>
        <20210219004242.1179999-1-jonathantanmy@google.com>
Date:   Fri, 19 Feb 2021 19:25:10 -0800
In-Reply-To: <20210219004242.1179999-1-jonathantanmy@google.com> (Jonathan
        Tan's message of "Thu, 18 Feb 2021 16:42:42 -0800")
Message-ID: <xmqqzgzza0a1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3D4518D4-732B-11EB-8C9A-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

>> For a real implementation, I think we'd want to do the negotiation
>> inside the conversation between send-pack and receive-pack, so that
>> what is agreed to be common between two parties will not shift in
>> the middle (in the same spirit that upload-pack grabs all the
>> relevant refs first, advertises them, negotiates what is common and
>> creates a pack, all using the same worldview of where the tips of
>> refs are throughout the process, even if some refs change in the
>> meantime).
>
> Upload-pack does that for protocol v0 ssh:// and git:// but not
> http(s)://, and does not do that for protocol v2, I believe.
>
> If we were to do that, I don't think it would work for the transports
> that have are stateless (e.g. HTTP).

Yeah, I consider it a bug in the "stateless" hack, though, and v2
somehow chose to take the common denominator to propagate the same
bug to protocols that are otherwise capable of being stateful.

In any case, I think I heard in another response from you that you
plan to do only v2, and I think that is OK.  Perhaps we can have a
separate service (like 'ls-refs' is a service that can be used
independent of the 'fetch' service in v2, and can be used by
somebody trying to 'push') 'negotiate' that can become a separate
thing, so that "fetch<->upload-pack" conversation would become
ls-refs plus negotiate plus fetch, while "push<->receive-pack"
conversation would become ls-refs plus negotiate plus push?

Thanks.
