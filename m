Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 379DDC432BE
	for <git@archiver.kernel.org>; Thu, 26 Aug 2021 06:25:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1131860F14
	for <git@archiver.kernel.org>; Thu, 26 Aug 2021 06:25:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238938AbhHZG0G (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 Aug 2021 02:26:06 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55968 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238082AbhHZG0F (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Aug 2021 02:26:05 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 74F69CF73C;
        Thu, 26 Aug 2021 02:25:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=3UZCWi7Q9JRKZwpSDf1mwRKQpJ/zdjG6tIVtGr
        2n9ss=; b=m79rQEEEeRJBqxq22Pl35fvdUH4Umy70ekP4IbLCqUKmnEwaHx/5ct
        zmolAvHIbDUSIzvs5kaCuXcebY1GP5bL4Ab47+DdgB/p075euVylI1F9VyqhFFfF
        0FAGLjG30TEbC6gkTIp/6Ff9eDobOZO86vySR2YmStcQfRqAqIXuc=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6AB14CF73B;
        Thu, 26 Aug 2021 02:25:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.116.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E3E07CF73A;
        Thu, 26 Aug 2021 02:25:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= <carenas@gmail.com>,
        git@vger.kernel.org, Jens.Lehmann@web.de
Subject: Re: [PATCH] test-lib-functions: avoid non POSIX ERE in
 test_dir_is_empty()
References: <20210826031710.32980-1-carenas@gmail.com>
        <YScXboC0M1IPNFon@nand.local>
Date:   Wed, 25 Aug 2021 23:25:16 -0700
In-Reply-To: <YScXboC0M1IPNFon@nand.local> (Taylor Blau's message of "Thu, 26
        Aug 2021 00:24:14 -0400")
Message-ID: <xmqqlf4ohgdv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 61BE45DE-0636-11EC-9764-D601C7D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

>> -	if test -n "$(ls -a1 "$1" | egrep -v '^\.\.?$')"
>> +	if test -n "$(ls -a1 "$1" | grep -v '^\.$' | grep -v '^\.\.$')"
>
> This replacement is correct, but I'm not sure that I necessarily find it
> simpler. If we really are concerned about egrep usage, then
>
>     if test -n "$(find "$1" | grep -v '^\.$')"
>
> would suffice. But it looks like we are fairly OK with egrep in t (`git
> grep 'egrep' -- t | wc -l` turns up 19 matches), so I'm not sure the
> change is necessary in the first place.

It is true that we have been OK with egrep.

"grep -E" is in POSIX (so is "grep -F") and that you might be able
to make an argument to use them instead of "egrep" and "fgrep", but
at least at one point in the past, 87539416 (tests: grep portability
fixes, 2008-09-30) favoured "fgrep" over "grep -F", claiming that
the former was more widely available than the latter.

The world may have changed since then, though.  IIRC, the 2008's
topic was mostly about portability to Solaris and AIX, and their
peculiarity (or their relevance) may have waned.

