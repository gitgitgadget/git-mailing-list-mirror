Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1555DC47082
	for <git@archiver.kernel.org>; Thu,  3 Jun 2021 22:06:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DF6FC613F8
	for <git@archiver.kernel.org>; Thu,  3 Jun 2021 22:06:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230212AbhFCWIn (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Jun 2021 18:08:43 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:50897 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbhFCWIm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Jun 2021 18:08:42 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 735DC128EDA;
        Thu,  3 Jun 2021 18:06:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=oQTfDbltk+UFLapzh2/nHeHwgLUtdKbNNWwFVE
        OZeI0=; b=gnfywnc0kSQowpTpWKe5BmOvzmY2JOHBTsp1dA6sPf4g1rB/FdoN4A
        1SqYo832B4zSH4B8dnkBGeh1HhOOXEOeeA7ZpbICVs+R8PBxTMY2UoAFWTV2DYxs
        rQc1VdsgrFH793aNa0UWgOh13GBCoeSLogClTAyIS74FZWZfEM8D8=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 6B3AB128ED9;
        Thu,  3 Jun 2021 18:06:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.172.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id B87EF128ED8;
        Thu,  3 Jun 2021 18:06:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ilias Apostolou <ilias.apostolou.zero@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Request feature: =?utf-8?Q?=E2=80=93no-submodule?=
References: <c5709df6-c357-56b4-f0e0-673bc8b4e668@gmail.com>
        <YLfqiLbpPXWXHlBi@nand.local> <xmqq8s3r7oma.fsf@gitster.g>
        <YLg/dLqYFEqHZJUn@nand.local>
        <9cc98ca3-bdc5-61bf-450a-99bb47673d6c@gmail.com>
Date:   Fri, 04 Jun 2021 07:06:52 +0900
In-Reply-To: <9cc98ca3-bdc5-61bf-450a-99bb47673d6c@gmail.com> (Ilias
        Apostolou's message of "Thu, 3 Jun 2021 13:48:39 +0300")
Message-ID: <xmqqim2u4n7n.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 01C5EAE8-C4B8-11EB-920B-FA9E2DDBB1FC-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ilias Apostolou <ilias.apostolou.zero@gmail.com> writes:

> The reason we need to list all of the true files (except submodules)
> is for code refactoring using the sed unility, for example:
>
> git ls-files | grep -Ev '(png$|ico$)' | xargs sed -i 's/\r\n/\n/'
> ...
> In my opinion, this should be a feature for "ls-files" only, since it
> would be nice to have a clean stream of true files.

Ah, then pathspec is still the right tool to use, I would think.

For example,

    git ls-files -s ':(exclude)*.png' ':(exclude)*.ico' |
    sed -n -e 's/^100[76][54][54] [0-9a-f]* 0       //p' |
    xargs sed -i 's/\r\n/\n/'

that is,

 (1) ls-files -s can be used to learn what kind of path it is.
     Regular files are either 100644 or 100755.  That way, you can
     also exclude symbolic links, which your example use case would
     probably not want to touch.  And you can filter the output to
     have 'a clean stream of true files' fairly easily Depending on
     the details of your needs, it can be tweaked into 'a clean
     stream of executable files' etc., too.

 (2) pathspec magic like ':(exclude)' can be used to lose your "we
     know png and ico are not text files".

Hope this helps.
