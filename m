Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 62C1120958
	for <e@80x24.org>; Mon, 27 Mar 2017 00:42:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751743AbdC0AmF (ORCPT <rfc822;e@80x24.org>);
        Sun, 26 Mar 2017 20:42:05 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51858 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751663AbdC0AmD (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 26 Mar 2017 20:42:03 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7FA006F085;
        Sun, 26 Mar 2017 20:40:48 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=S1mOKcuIy6O/
        pUubJDc7nZJVwOI=; b=QBJpqwicYaEi9frsCkNDKCwqnPLHmSpalcbh94hxTz1r
        Eoy2TtZ8b9Q1xHVXG53EslJnnYRIwU5qSl21xuBVheRwvFZj5yy2jIJuwIscjxet
        fc0BGsiX3pZgPwdGAQCWZQ7xbfI9YfOu5CbVUiIrG4kg9Hr+OWkiUSi64nSaKsc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=u5gJQy
        +xYrt+4/wIWKCYdOgCR+4MjXJk4mIYjtTdAPgS4cPsgB4bi5oueP5NDaTIlx7xy4
        /YEG/XzHQ0E8zrnwYPCqaX3ozYQuW3U/J9rwzhhwl6KWPf+JcZKamJoXF+4j2za+
        iEvZZP8ZdfgK8GnwkFsmmn+ASkj6XRyVYdaEo=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 773E06F084;
        Sun, 26 Mar 2017 20:40:48 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D550E6F083;
        Sun, 26 Mar 2017 20:40:47 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Git List <git@vger.kernel.org>,
        Zenobiusz Kunegunda <zenobiusz.kunegunda@interia.pl>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH] strbuf: support long paths w/o read rights in strbuf_getcwd() on FreeBSD
References: <4026bc3b-2999-9daf-d6ab-10c6d007b1e7@web.de>
Date:   Sun, 26 Mar 2017 17:40:46 -0700
In-Reply-To: <4026bc3b-2999-9daf-d6ab-10c6d007b1e7@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
        message of "Sun, 26 Mar 2017 15:43:50 +0200")
Message-ID: <xmqq1stj4kmp.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 051DF5F2-1286-11E7-A13A-97B1B46B9B0B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ren=C3=A9 Scharfe <l.s.r@web.de> writes:

> FreeBSD implements getcwd(3) as a syscall, but falls back to a version
> based on readdir(3) if it fails for some reason.  The latter requires
> permissions to read and execute path components, while the former does
> not.  That means that if our buffer is too small and we're missing
> rights we could get EACCES, but we may succeed with a bigger buffer.

WOW.  Just WOW.  Looking at the debugging exchange from the
sideline, I didn't expect this end result.

> Keep retrying if getcwd(3) indicates lack of permissions until our
> buffer can fit PATH_MAX bytes, as that's the maximum supported by the
> syscall on FreeBSD anyway.  This way we do what we can to be able to
> benefit from the syscall, but we also won't loop forever if there is a
> real permission issue.
>
> This fixes a regression introduced with 7333ed17 (setup: convert
> setup_git_directory_gently_1 et al. to strbuf, 2014-07-28) for paths
> longer than 127 bytes with components that miss read or execute
> permissions (e.g. 0711 on /home for privacy reasons); we used a fixed
> PATH_MAX-sized buffer before.
>
> Reported-by: Zenobiusz Kunegunda <zenobiusz.kunegunda@interia.pl>
> Signed-off-by: Rene Scharfe <l.s.r@web.de>
> ---


Nicely analysed and fixed (or is the right word "worked around"?)

Thanks, will queue.
