Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37924C07E99
	for <git@archiver.kernel.org>; Fri,  9 Jul 2021 15:44:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 14FA261378
	for <git@archiver.kernel.org>; Fri,  9 Jul 2021 15:44:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232424AbhGIPrG (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Jul 2021 11:47:06 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50353 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232269AbhGIPrF (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Jul 2021 11:47:05 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 86CE3D2758;
        Fri,  9 Jul 2021 11:44:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=VqxRG68ZG0DWPBAIxwMssLBsY4Kx4qq+AFwyMq
        9HXH8=; b=TK5GVaQFkpFsCjX0KmfyOkLNUiFnrLMmtyQiQRlDtvllp4/TMfSzVH
        IRP9fRChZvFXOAA2Cl1q0s9VG7J9uT0amoGHy09h25blFoJv6FKpvarEst3pQ1QN
        OPRy56PdxEBkd2nLzhQ0wCbUfeME/N2g5jiwcIItQX62JATH8DSoo=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7EBCFD2757;
        Fri,  9 Jul 2021 11:44:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.3.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id F3652D2755;
        Fri,  9 Jul 2021 11:44:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH] rev-list: add option for --pretty without header
References: <20210706224321.14371-1-sandals@crustytoothpaste.net>
        <CAP8UFD0t0=us1MWHTtEvVhNhWB1P6Q5gp-6v5XVGLBVeZ5RYKg@mail.gmail.com>
Date:   Fri, 09 Jul 2021 08:44:20 -0700
In-Reply-To: <CAP8UFD0t0=us1MWHTtEvVhNhWB1P6Q5gp-6v5XVGLBVeZ5RYKg@mail.gmail.com>
        (Christian Couder's message of "Fri, 9 Jul 2021 10:01:46 +0200")
Message-ID: <xmqq8s2f8pbf.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 87238DAA-E0CC-11EB-A57F-FD8818BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christian Couder <christian.couder@gmail.com> writes:

> On Wed, Jul 7, 2021 at 12:47 AM brian m. carlson
> <sandals@crustytoothpaste.net> wrote:
>>
>> In general, we encourage users to use plumbing commands, like git
>> rev-list, over porcelain commands, like git log, when scripting.
>> However, git rev-list has one glaring problem that prevents it from
>> being used in certain cases: when --pretty is used, it always prints out
>> a line containing "commit" and the object ID.
>
> You say always, but it looks like it doesn't do it when
> --pretty=oneline is used.

I've understood that he meant "when --pretty=format is used",
though, as it is the only format whose intent was to allow
generation of output stream that does not have to be preprocessed
with "grep -v '^[0-9a-f]{40}'" etc.

> It looks like the tests only check what happens in case
> --pretty=format:'...' is used, but I wonder what the code does if a
> builtin format is used.

Good point.

I also think the handling of --abbrev-commit may need to be
rethought with this change.  See here:

    diff --git a/builtin/rev-list.c b/builtin/rev-list.c
    index 7677b1af5a..f571cc9598 100644
    --- a/builtin/rev-list.c
    +++ b/builtin/rev-list.c
    @@ -132,7 +132,7 @@ static void show_commit(struct commit *commit, void *data)
            if (revs->abbrev_commit && revs->abbrev)
                    fputs(find_unique_abbrev(&commit->object.oid, revs->abbrev),
                          stdout);
    -	else
    +	else if (revs->include_header)
                    fputs(oid_to_hex(&commit->object.oid), stdout);
            if (revs->print_parents) {
                    struct commit_list *parents = commit->parents;

The original says that if --abbrev-commit is set and --abbrev is set
to non-zero, we'd show unique abbreviation and if not, specifically,
even when --abbrev-commit is set but --abbrev is set to 0, we didn't
do the find_unique_abbrev() of full hexdigits but left the output to
the else clause.  This was because the original code KNOWS that the
else clause unconditionally emits the full commit object name.

That assumption, which made the original code's handling of
"--abbrev-commit --abbrev=0" correct, no longer holds with the
updated code.  What happens is with --no-commit-header, if we give
"--abbrev-commit --abbrev=4", we still see the unique abbreviation
that is not shorter than 4 hexdigits (i.e. "--no-commit-header" is
ignored), but if we say "--abbrev-commit --abbrev=0", we do not see
any commit header.

My hunch is that this "if / else", which determines if the commit
header should give shortened or full length, should be skipped when
the .include_header is false.
