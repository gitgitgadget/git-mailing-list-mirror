Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C63DC00144
	for <git@archiver.kernel.org>; Tue,  2 Aug 2022 00:57:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234389AbiHBA5k (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Aug 2022 20:57:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbiHBA5i (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Aug 2022 20:57:38 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6EA745041
        for <git@vger.kernel.org>; Mon,  1 Aug 2022 17:57:35 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 620721957C0;
        Mon,  1 Aug 2022 20:57:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=E4hms5VZIRLWGz4KFHnLL2XZJJhXUtT/7zumJp
        MwD3Q=; b=krGwsisvMX3a78tNah9QjuyBXccu8Qm9Lb/VTs0aIwdGMu+LZY3kVe
        5rEvAM2vx4ad90rwkxv0a3wuwHQTgTV7SNtzkF/Qw24w1GHMaPxyg+Go/65gsIYz
        hjcVdoOykT7BeH8NR/g2TLjTnc3xeo1vuX4PwG5N81gmHeQGe6ORo=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 595E51957BE;
        Mon,  1 Aug 2022 20:57:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.145.39.32])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id EC2FA1957BD;
        Mon,  1 Aug 2022 20:57:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Git List Mailing <git@vger.kernel.org>
Subject: Re: "git symbolic-ref" doesn't do a very good job
References: <CAHk-=wh9f0EmsNFgoxUa8BzVej06+7MbLr-MLBjDjtj_=Pf90A@mail.gmail.com>
        <CAHk-=wg9LaHeg0UmZ90gLOaBpO-5fhoaH22iNNm=1eror95pFg@mail.gmail.com>
        <YuXKaLXhnR3mVlWk@coredump.intra.peff.net>
        <YuXLtIBXYG+JBKdV@coredump.intra.peff.net>
        <CAHk-=wi5pfUcuaAUz=rifon9d51mshE7k6bkpMXddog0On9jow@mail.gmail.com>
        <YugQqp4oN26OFOpt@coredump.intra.peff.net>
        <YugYNzQYWqDCmOqN@coredump.intra.peff.net>
        <xmqqfsifyetv.fsf@gitster.g>
        <Yuhz0VAX77qv4P5Z@coredump.intra.peff.net>
Date:   Mon, 01 Aug 2022 17:57:30 -0700
In-Reply-To: <Yuhz0VAX77qv4P5Z@coredump.intra.peff.net> (Jeff King's message
        of "Mon, 1 Aug 2022 20:46:09 -0400")
Message-ID: <xmqqilnbjwcl.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 16C69714-11FE-11ED-9ACE-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Mon, Aug 01, 2022 at 11:54:36AM -0700, Junio C Hamano wrote:
>
>> > +test_expect_success 'symbolic-ref allows top-level target for non-HEAD' '
>> > +	git symbolic-ref refs/heads/top-level FETCH_HEAD &&
>> > +	git update-ref FETCH_HEAD HEAD &&
>> > +	test_cmp_rev top-level HEAD
>> > +'
>> >  test_done
>> 
>> Strange, but OK.
>
> I'd be OK to drop this if you hate it too much, btw. Mostly I wanted to
> make sure that the various iterations behaved as I expected. But there
> is a test in t3200 (the one Linus found earlier) that incidentally does
> check that something like this works.

Oh, no, I do not hate it (or like it) at all.

The "strange" was mostly referring to the order of the symbolic
thing that refers to another thing that is being pointed at, which
looked backwards, i.e. "git symbolic-ref HEAD refs/heads/main" is
what we usually expect (i.e. "we use this short name HEAD to refer
to the longer refs/heads/main ref"), but after staring the one in
the test "git symbolic-ref refs/heads/top-level FETCH_HEAD" too
long, your eyes trick your brain into thinking we use the short name
FETCH_HEAD to refer to the top-level branch, which is the other way
around.

We've been allowing the one-level thing and I think the discussion
has established that we need to keep it supported.  There is nothing
to hate or like about it X-<.

Thanks.

