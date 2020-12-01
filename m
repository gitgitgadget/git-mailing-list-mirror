Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2F8AC64E7B
	for <git@archiver.kernel.org>; Tue,  1 Dec 2020 17:59:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 721B420870
	for <git@archiver.kernel.org>; Tue,  1 Dec 2020 17:59:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="RGmR+7WS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404202AbgLAR7S (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Dec 2020 12:59:18 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55422 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404199AbgLAR7S (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Dec 2020 12:59:18 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C25C59F5F2;
        Tue,  1 Dec 2020 12:58:35 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=0NJZN0AaPLbeOE9L5MkjJ3HGGDs=; b=RGmR+7
        WSuI6kQSCl5XIimKt5m0SjnZNpHY4AdqN4k+H528RPc5IzIxG8q/ZZSaSO9O00CE
        WV78ja4iUal5J16K6csl2tHP+SASCd9Rj7VMvQitEXePrWR+503hmAlR/4x1DWbr
        9OTP8j+9669mnZ5qNuxbhRTsS3LRaoWsx3nlQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=LGegjENvCIrJnvHG5otwE+Krxbl5dKfG
        nSAPl1vKm58+RD4hiCiMy0KtNeSbZyimng+JCH6XHdt+ByAqCZfH4yX3Vss7DCGJ
        jCiHKtSV4/2L9EgrgOAqZH+aM4bvMMmK54Zrhy8psRhjgE0g3AVPz0etITQeYtwT
        A4YtH0YKl/0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id BAB999F5F1;
        Tue,  1 Dec 2020 12:58:35 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id F3F659F5F0;
        Tue,  1 Dec 2020 12:58:33 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Cc:     git <git@vger.kernel.org>
Subject: Re: Is git-am expected to honor core.sharedRepository?
References: <CAHd-oW4yHSTYr0Gwn60tu2c7VY=PJbSbg23Z5Bd_11Do-+juGA@mail.gmail.com>
Date:   Tue, 01 Dec 2020 09:58:33 -0800
In-Reply-To: <CAHd-oW4yHSTYr0Gwn60tu2c7VY=PJbSbg23Z5Bd_11Do-+juGA@mail.gmail.com>
        (Matheus Tavares Bernardino's message of "Tue, 1 Dec 2020 12:23:55
        -0300")
Message-ID: <xmqqpn3tqugm.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D439242C-33FE-11EB-8DA1-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Matheus Tavares Bernardino <matheus.bernardino@usp.br> writes:

> If not, the place to be changed is probably the
> safe_create_leading_directories() call in apply.c.

https://lore.kernel.org/git/xmqqziglaxj4.fsf@gitster.mtv.corp.google.com/

Calling adjust_shared_perm() on a path outside .git/ is a potential
bug, as you found out, and definitely a bug if used on working tree
files.  We may want to share with only selected users in a group the
contents of the repository (e.g. allow local cloning from us), while
allowing daemon-ish tools to scan what is in the working tree files
without letting them touch what is in the repository, for example;
adjust_shared_perm() is meant for .git/ repository files and
tightening working tree files' permissions using it would break such
arrangement.

I think bugreport uses scld, but it may be used to drop cruft inside
the working tree, but the files created are *not* to be "git add"ed,
so the use case does not count as "if used on working tree files".

> $ git commit -m d
> $ ls -l
> drwxr-xr-x 2 matheus matheus 60 dez  1 11:29 d
> ...
> Then we create a patch and use am to apply it:
> The setting was honored by am:
> $ ls -l
> drwx--S--- 2 matheus matheus 60 dez  1 11:30 d

Having said that, I know it can be argued both ways.  If we want to
protect .git/ contents in a certain way, it may be worth protecting
the files in the working tree in the same way as well.  But at least
that is not the current rule is (even though as you found out we do
have bugs).

Thanks.


