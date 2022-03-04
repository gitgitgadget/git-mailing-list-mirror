Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B09AC433F5
	for <git@archiver.kernel.org>; Fri,  4 Mar 2022 00:16:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237353AbiCDARR (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Mar 2022 19:17:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231175AbiCDARP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Mar 2022 19:17:15 -0500
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B35B2177D0E
        for <git@vger.kernel.org>; Thu,  3 Mar 2022 16:16:28 -0800 (PST)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id C759A1871CA;
        Thu,  3 Mar 2022 19:16:27 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=orBR7/cCnjQe
        LIhOObGfwqyjc7jw+ULSN4xdaO4DPak=; b=PTm7QtQXDBfK9B2iGeTpn1hLWPIE
        NNCsruiDQ0YUNDuMnLcs4zZKsXag+xIrGfI89Zu2t8IdokOcAOna1KHF901EuptR
        2tGJOc83nPtgNBNs6hPqkMsM+yqXXzpK6QpREeg0eMhd3iTj3BcMX/ztJpHTWcvs
        FV/eDD1U4dyMxus=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id BEA5B1871C9;
        Thu,  3 Mar 2022 19:16:27 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.230.65.123])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 3A25A1871C8;
        Thu,  3 Mar 2022 19:16:25 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, tytso@mit.edu, derrickstolee@github.com,
        larsxschneider@gmail.com
Subject: Re: [PATCH v3 04/17] chunk-format.h: extract oid_version()
References: <cover.1638224692.git.me@ttaylorr.com>
        <cover.1646266835.git.me@ttaylorr.com>
        <135a07276b0a40b04f2c28d4f48c26b1af76c12c.1646266835.git.me@ttaylorr.com>
        <220303.86ilsv2dke.gmgdl@evledraar.gmail.com>
        <YiFQBobcLT2m/KMx@nand.local>
Date:   Thu, 03 Mar 2022 16:16:24 -0800
In-Reply-To: <YiFQBobcLT2m/KMx@nand.local> (Taylor Blau's message of "Thu, 3
        Mar 2022 18:32:22 -0500")
Message-ID: <xmqq4k4e7esn.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 541D6D2E-9B50-11EC-9EC2-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> On Thu, Mar 03, 2022 at 05:30:44PM +0100, =C3=86var Arnfj=C3=B6r=C3=B0 =
Bjarmason wrote:
>>
>> On Wed, Mar 02 2022, Taylor Blau wrote:
>>
>> > Consolidate these into a single definition in chunk-format.h. It's n=
ot
>> > clear that this is the best header to define this function in, but i=
t
>> > should do for now.
>> > [...]
>> > +
>> > +uint8_t oid_version(const struct git_hash_algo *algop)
>> > +{
>> > +	switch (hash_algo_by_ptr(algop)) {
>> > +	case GIT_HASH_SHA1:
>> > +		return 1;
>> > +	case GIT_HASH_SHA256:
>> > +		return 2;
>>
>> Not a new issue, but I wonder why these don't return hash_algo_by_ptr
>> aka GIT_HASH_WHATEVER here. I.e. this is the same as this more
>> straightforward & obvious code that avoids re-hardcoding the magic
>> constants:
>
> Hmm. Certainly the value returned by hash_algo_by_ptr() works for SHA-1
> and SHA-256, but writes may want to use a different value for future
> hashes. Not that this couldn't be changed then, but my feeling is that
> the existing code is clearer since it avoids the reader having to jump
> to hash_algo_by_ptr()'s implementation to figure out what it returns.

If we promise that everywhere in file formats where we identify what
hash is used, we write "1" for SHA1 and "2" for SHA256, it would be
natural to define GIT_HASH_SHA1 to "1" and GIT_HASH_SHA256 to "2".

And readers do not have to "figure out", if that is a clearly
written guideline to represent the hash used in file formats.  As
written, the readers who -assumes- such a guideline is there must
figure out from hash.h that GIT_HASH_SHA1 is 1 and GIT_HASH_SHA256
is 2 to be convinced that the above code is correct.

Now, hash.h says GIT_HASH_SHA1 is 1 and GIT_HASH_SHA256 is 2.  So

	int oidv =3D hash_algo_by_ptr(algop)
	switch (oidv) {
	case GIT_HASH_SHA1:
	case GIT_HASH_SHA256:
		return oidv;
	default:
		die();
	}

should work already.  To put it differently, if this didn't work, we
should renumber GIT_HASH_SHA1 and GIT_HASH_SHA256 to make it work, I
would think.  If not, we have a huge mess on our hands, as constants
used in on-disk file formats is hard (almost impossible) to change.

An overly generic function name oid_version() cannot be justified
unless the same constants are used everywhere.  I see hits from 'git
grep oid_version' in

    chunk-format.c (obviously)
    commit-graph.c
    midx.c
    pack-write.c

so presumably these types of files are using the "canonical"
numbering.

And when we introduce GIT_HASH_SHA3 or whatever, we should give it a
number that this function can return (i.e. from the range 3..255).
