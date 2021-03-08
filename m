Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC024C433E6
	for <git@archiver.kernel.org>; Mon,  8 Mar 2021 17:21:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A2756522C
	for <git@archiver.kernel.org>; Mon,  8 Mar 2021 17:21:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229690AbhCHRVN (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Mar 2021 12:21:13 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:54325 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230211AbhCHRVM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Mar 2021 12:21:12 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 2B26B10F9F4;
        Mon,  8 Mar 2021 12:21:12 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=05CiAXtGdkYP
        9eKo3hBl+3qrgaQ=; b=OR9aOr3nU8XwxmsR0FYczGu/gQrmL2D3Wu1IXHR+Mhqs
        pM9hCkd5Yx6Qy4m4o+e0JQSCUsovFpye8Oofh7h/5dTV9cUTpiE48tIwjA2X0gqI
        JUDpuWuAsrOwl/WY32d2tvbqQJ4RSgbd9u+rwFmRad6ECc1zMReJKQMZaQ9maOo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=IThbIu
        ah1ag8Dg/5VpdqMKlDHn2VXrhjP9K93DAHa0lqQW8UPOmVUDuhqSLSohVyNr9pq6
        ljaYBPq2cikWw6xlCQTC7wq0nFjnOe6FaWIOX9Y+W65G+1D4gfEJeKf57WHYrfhb
        /VSqpI+iG4pFMxfM7sW9qgG1bak5mwmBGMgEU=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 255B110F9F2;
        Mon,  8 Mar 2021 12:21:12 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 654FE10F9EF;
        Mon,  8 Mar 2021 12:21:09 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Makefile: generate 'git' as 'cc [...] -o git+ && mv
 git+ git'
References: <20210307132001.7485-1-avarab@gmail.com>
        <xmqq35x68zob.fsf@gitster.c.googlers.com>
        <87ft15kegn.fsf@evledraar.gmail.com>
Date:   Mon, 08 Mar 2021 09:21:07 -0800
In-Reply-To: <87ft15kegn.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Mon, 08 Mar 2021 13:38:32 +0100")
Message-ID: <xmqqpn097e9o.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: AC6A356E-8032-11EB-9DA7-D609E328BF65-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> We have a lot of existing rules in the Makefile that are of the form:
>
>     make thing >thing+ &&
>     mv thing+ thing
>
> Where we're not doing the rename dance to avoid clobbering the file
> we're reading.

I am afraid that you are totally misreading the intent of that age
old convention, which is spelled:

	thing:
		rm -f thing thing+
		prepare contents for thing >thing+
		mv thing+ thing

It protects us from a failure mode where "prepare contents for
thing" step is broken and leaves a "thing" that does not work, but
confuses make that make does not need to rebuild it, if you wrote it
as such:

	thing:
		prepare contents for thing >thing

I think more recent make actually has some knob you can tweak to
tell "if the rule failed, remove it", but the convention predates
it.

In any case, it is not "we are trying to make thing available while
it is being rewritten" at all.
