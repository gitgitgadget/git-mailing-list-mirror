Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AC20C433E9
	for <git@archiver.kernel.org>; Wed, 20 Jan 2021 06:56:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB4A62332A
	for <git@archiver.kernel.org>; Wed, 20 Jan 2021 06:56:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727740AbhATG4q (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Jan 2021 01:56:46 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:58911 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727672AbhATG4m (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Jan 2021 01:56:42 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 379D0F8BAE;
        Wed, 20 Jan 2021 01:55:53 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=PoqfkkAIkx4QCPH4duIooDCRUcY=; b=F0Ax1g
        YB1UgVBbYL/z3sNF0nBLGP5txbTbAnJboTN4jF0NOZpCZZBAzaOqhAwZrae3iQBG
        dByu84A1LOD3VXJAuCd315Yw1SLTAJtq/feh+SMrc+PCs6bsP3kOmtR2XWnftmmd
        ugX/Q7XwMQABVFLl+MvNA6TPpKhiLNzl0Vlh4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=QxgLQD51d+tILXFrRY7EAT4Ez90Y/DXM
        Z5vqlwBNeFg7ev2m841mxcQQF0Tl8U2y3PznHzGveg/5CqHPXgoX/I5eBskOpsdj
        lOrr2gZvyGq+TPAz8/RiDXZzAS+IROkojlre2+zxjZf0m9EDbGTkkV93tIpzqx/y
        o9tODANQsfQ=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 30443F8BAD;
        Wed, 20 Jan 2021 01:55:53 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.99.68])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 78F8BF8BAC;
        Wed, 20 Jan 2021 01:55:50 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        Simon Ruderich <simon@ruderich.org>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Philip Oakley <philipoakley@iee.email>
Subject: Re: [PATCH v8 5/8] config: store "git -c" variables using more
 robust format
References: <cover.1606214397.git.ps@pks.im> <cover.1610453228.git.ps@pks.im>
        <36c2a51b13e463a4aa8e5316447336927153d99d.1610453228.git.ps@pks.im>
        <YAHqHmGOUl53mfPa@coredump.intra.peff.net> <YAfNrX1KNhHRbHmM@ncase>
Date:   Tue, 19 Jan 2021 22:55:48 -0800
In-Reply-To: <YAfNrX1KNhHRbHmM@ncase> (Patrick Steinhardt's message of "Wed,
        20 Jan 2021 07:29:01 +0100")
Message-ID: <xmqqk0s8gkqz.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 87FBA64C-5AEC-11EB-AB4A-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Patrick Steinhardt <ps@pks.im> writes:

> On Fri, Jan 15, 2021 at 02:16:46PM -0500, Jeff King wrote:
>> On Tue, Jan 12, 2021 at 01:27:01PM +0100, Patrick Steinhardt wrote:
>> 
>> > The previous commit added a new format for $GIT_CONFIG_PARAMETERS which
>> > is able to robustly handle subsections with "=" in them. Let's start
>> 
>> It looks like this commit and 6 got flipped from the original ordering
>> (it's the "previous commit" talked about here). And indeed, running the
>> tests on the individual commits in this series shows that we fail at
>> this step (because we are writing the new format, but the reader is too
>> strict to accept it).
>> 
>> That doesn't matter to the end result, of course, but it hurts later
>> bisecting. Just flipping patches 5 and 6 makes it all work.
>> 
>> -Peff
>
> Oops, yes. That always happens to me when I start using git-am(1). I see
> that the patch series has been applied to "next" already, so does it
> make any sense to resend with patches 5 and 6 flipped?

I recall saying that I'd "rebase -i" before merging it to "next".
Did I forget to do so?

Disecting 4ed03412 (Merge branch 'ps/config-env-pairs' into next,
2021-01-15), we see:

$ git log --oneline --reverse master..4ed03412^2 | cat -n
     1	b0812b6ac0 git: add `--super-prefix` to usage string
     2	ce81b1da23 config: add new way to pass config via `--config-env`
     3	13c44953fb quote: make sq_dequote_step() a public function
     4	b342ae61b3 config: extract function to parse config pairs
     5	f9dbb64fad config: parse more robust format in GIT_CONFIG_PARAMETERS
     6	1ff21c05ba config: store "git -c" variables using more robust format
     7	b9d147fb15 environment: make `getenv_safe()` a public function
     8	d8d77153ea config: allow specifying config entries via envvar pairs

The 5/8 that needs to come after 6/8 has title "store ... using more
rebust format" and that is the 6th patch in the series merged to
'next'.  The 6/8 that needs to come before that one was called
"parse more robust format" and it now appears as the 5th patch.

So it seems all is well?
