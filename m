Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 330A1C2B9F8
	for <git@archiver.kernel.org>; Tue, 25 May 2021 06:21:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 08EA9613F5
	for <git@archiver.kernel.org>; Tue, 25 May 2021 06:21:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231261AbhEYGWx (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 May 2021 02:22:53 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:55452 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231282AbhEYGWs (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 May 2021 02:22:48 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 2A266135DC7;
        Tue, 25 May 2021 02:21:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=byrDzm81D34m
        5170ZhLBt+NqTQS0KGeI+knYLiP1vU4=; b=FJDQq4BqQmJkdCWQ6USdj32ny//s
        WY3PdnfyYmdoqWaQP0JUvgXI4LxuQG7HGyPT+4+cVQTGIFzJMEuzuqNJYE4HGegs
        XMxsit3yVraZk0/enUqGgm/KhOVnkGvEvcAr8qOuFsPaihr6HToQlYbbRweo3RBc
        bIdPi8iRbzCTJjU=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 23576135DC6;
        Tue, 25 May 2021 02:21:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.73.10.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 6D72C135DC5;
        Tue, 25 May 2021 02:21:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Johannes Sixt <j6t@kdbg.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Robert Foss <robert.foss@linaro.org>
Subject: Re: [PATCH 2/2] send-email: don't needlessly abs_path() the
 core.hooksPath
References: <bb30fe2b-cd75-4782-24a6-08bb002a0367@kdbg.org>
        <cover-0.2-00000000000-20210524T231047Z-avarab@gmail.com>
        <patch-2.2-d097e7b0b81-20210524T231047Z-avarab@gmail.com>
        <xmqqh7iripzg.fsf@gitster.g> <874kerny0e.fsf@evledraar.gmail.com>
Date:   Tue, 25 May 2021 15:21:13 +0900
In-Reply-To: <874kerny0e.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Tue, 25 May 2021 07:57:37 +0200")
Message-ID: <xmqq35ubgwpy.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 68CB6234-BD21-11EB-A1FB-FA9E2DDBB1FC-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> The repo_path() function was introduced in c8243933c74, so it's never
> been in a release, thus I think it's fine to alter its behavior.
>
> The code here doesn't need to concern itself with what needs to be
> relative to what, you run send-email in some working tree directory (or
> top-level), and depending on core.hooksPath we'll either return a
> relative path to the .git/hooks or an absolute one, the system()
> invocation will accept either.

All of that are convincing, but I'd rather not risk it.  I'll take
your 1/2 with J6t's fix, both of which are obvious and no brainer,
but I am willing to take this 2/2 as a post-release clean-up next
monght, though ;-)

Thanks.
