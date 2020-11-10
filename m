Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33A50C388F7
	for <git@archiver.kernel.org>; Tue, 10 Nov 2020 20:10:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A3876206F1
	for <git@archiver.kernel.org>; Tue, 10 Nov 2020 20:10:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="DCErxPqE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726688AbgKJUJ7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Nov 2020 15:09:59 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:64553 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726428AbgKJUJ6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Nov 2020 15:09:58 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 26D249AA7E;
        Tue, 10 Nov 2020 15:09:56 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=3x/6/2ZeJteq
        d9sq9GFVNMD8hvE=; b=DCErxPqEIWPX2TSh6Q7jpgljIMSn3NUU7xljVoxtzPZM
        fYdVyEnMl6aGKONobeJYz16wssVspckwkzIselyYVCTz1T5PlzlwGFMeajeMbmHX
        ArZaz2uOjKcef3k/7//43lOwGkjJWofl45jWEn3pR4TvkfRJh8O4h5/uN6NAI0c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=dodhzp
        EEArPv9iodU2QC9ouFW0y1L4+V63jKob95fsjoR/zFtmlialFR1QjPZXrsfWDQ03
        7xfqVLaEEYDdRu0EJvS3+HIqt11VRScGV9yo059DYT7NwI9lM6PbfqDhBiwMRzL9
        d8LsdNup9zjmnfXbu4DMUZR57j9abJIMzsW6Y=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1DE259AA7D;
        Tue, 10 Nov 2020 15:09:56 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 9CCEE9AA7A;
        Tue, 10 Nov 2020 15:09:55 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Demi M. Obenour" <athena@invisiblethingslab.com>
Cc:     Git <git@vger.kernel.org>
Subject: Re: check_refname_format allows refs with components that begin
 with -, even though `git tag` does not
References: <c926193b-a328-7562-6d4b-1ab2765c8cca@invisiblethingslab.com>
Date:   Tue, 10 Nov 2020 12:09:55 -0800
In-Reply-To: <c926193b-a328-7562-6d4b-1ab2765c8cca@invisiblethingslab.com>
        (Demi M. Obenour's message of "Tue, 10 Nov 2020 14:32:04 -0500")
Message-ID: <xmqqd00l6kj0.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: B35FC73E-2390-11EB-B6E3-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Demi M. Obenour" <athena@invisiblethingslab.com> writes:

> If I try to create a Git tag with a name beginning with `-`,
> Git complains.  However, Git does not check that a repository does
> not have tags containing `-`.

This is quite deliberate.  The command line parser of "git checkout"
and friends long lacked way to say "switch to THAT BRANCH whose name
begins with a hyphen" etc., and preventing tags and branches whose
name begins with a hyphen from created at the Porcelain level was a
way to stop users from hurting themselves. =20

These funny names are supported at the plumbing level primarily
because we have historically allowed them and suddenly forbidding
their use would break existing repository.  A secondary reason is to
have a way to learn the current value of and then remove them, so
people with these funnily named branches and tags can "rename" them.

> This almost led to a vulnerability in the QubesOS `verify-git-tag`
> script.

Scripts need to be careful about their inputs, period.

> The best idea I had for a fix is to print names beginning with `-`
> using the fully-qualified form, such as "refs/tags/-a".  Also, `--`
> is used as a delimiter in many commands, and can=E2=80=99t be escaped,
> so disallowing it might be a good idea.

I do not think there is anything to fix.

Command line parsers of some commands may have to learn how to
disambiguate such a strangely named tags and branches, though.  Some
commands do not know --end-of-options convention, for example.

Thanks.


[Further reading]

https://lore.kernel.org/git/7v62pjo4km.fsf@alter.siamese.dyndns.org/
https://lore.kernel.org/git/7vsk262vla.fsf@alter.siamese.dyndns.org/
