Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CCDDC433B4
	for <git@archiver.kernel.org>; Sun, 16 May 2021 21:59:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 11A5E61019
	for <git@archiver.kernel.org>; Sun, 16 May 2021 21:59:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230156AbhEPWAg (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 16 May 2021 18:00:36 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50258 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229942AbhEPWAf (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 16 May 2021 18:00:35 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 673A3BE40B;
        Sun, 16 May 2021 17:59:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=ny6AxyEquALr
        5B8gpPg1J/Hn0+dM9lSyFpkdXTd2hGM=; b=El2dmywrBh/obTJ80t9UpaBBbr9z
        KbBbgaE3bQkrNC95anbvfqiGwSNNuuwkwFGwce9r/cyOYTKvAImuH/r54ooXHtKe
        eLfmYtpPQvimK0WDjPNh3QRmeD767E/9s9eE+Gu13m812e1NUVFPdkTzCz3ENc8c
        aDmzu6ZuxkenVh4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 5F46ABE40A;
        Sun, 16 May 2021 17:59:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id D8DF1BE409;
        Sun, 16 May 2021 17:59:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Wolfgang =?utf-8?Q?M=C3=BCller?= <wolf@oriole.systems>
Cc:     git@vger.kernel.org
Subject: Re: [RFC PATCH] rev-parse: fix segfault with missing --path-format
 argument
References: <20210516120449.661636-1-wolf@oriole.systems>
        <xmqqsg2m6dsi.fsf@gitster.g>
        <20210516143156.mauc2ukryx5j2e2r@nabokov.fritz.box>
Date:   Mon, 17 May 2021 06:59:18 +0900
In-Reply-To: <20210516143156.mauc2ukryx5j2e2r@nabokov.fritz.box> ("Wolfgang
        =?utf-8?Q?M=C3=BCller=22's?= message of "Sun, 16 May 2021 16:31:56 +0200")
Message-ID: <xmqqk0ny5oi1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: F69F2BC2-B691-11EB-945C-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Wolfgang M=C3=BCller <wolf@oriole.systems> writes:

> On 2021-05-16 21:53, Junio C Hamano wrote:
>
>> As die() is end-user facing, you'd probably want
>>=20
>> 	die(_("--path-format requires an argument"));
>>=20
>> We do have untranslated die() nearby for the same option, which may
>> want to be cleaned up either in a preliminary patch, or in this same
>> patch as an unrelated fix "while we are at it".
>
> I would not mind preparing a preliminary patch that cleans up all
> untranslated user-facing calls to die(). My editor finds 15 of those in
> rev-parse.c, and I think they all qualify.
>
> If you'd rather not touch unrelated code paths I'll instead include it
> in v2 as an unrelated fix in the same commit.

I am puzzled by the last paragraph.  Somebody who does not want to
see "unrelated" codepaths touched would appreciate if a commit that
fixes this segfault does not touch them at the same time.

In any case, I now counted existing die() messages in this file, and
among 15 of them, only 1 is marked with _(...).  I think that it
is the best to apply the patch as-is (without _(...)), adding one
untranslated message to the file.

Then, on top of this change, the 15 untranslated messages can be
marked with _(...) a separate commit (and it does not even have to
be done by you).

> I think I initially went for "--path-format --show-toplevel" because I
> was under the assumption that --path-format needs another option it can
> modify. It seems that this is not the case, so wouldn't it be simpler
> here to do the following instead:
>
> 	test_must_fail git rev-parse --path-format
>
> That way we do not have to worry about subsequent changes to other,
> unrelated, options.

That's good, too.  Simple.

Thanks.

