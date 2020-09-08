Return-Path: <SRS0=ga/5=CR=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37313C433E2
	for <git@archiver.kernel.org>; Tue,  8 Sep 2020 23:59:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C817320757
	for <git@archiver.kernel.org>; Tue,  8 Sep 2020 23:59:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="p4An7m4q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728442AbgIHX7Y (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Sep 2020 19:59:24 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64955 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726605AbgIHX7X (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Sep 2020 19:59:23 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 5E0C483FC0;
        Tue,  8 Sep 2020 19:59:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=oe8RDV5u4Cuqx/TZND9gf8qC7Pw=; b=p4An7m
        4q3M4FpDZFWo+bvv43gEwgOpjPmKN/mUovJ0nXUQtmIUib6WWCsNXgm5rKWFhGn8
        LCXYYkmbqicIDs2l09xWZhD4weFncEEQgvemxRS2/9zy+OP/O6asW9Q2QAyRS9qq
        9W50uPBq/rDfFdvIJ4SwxP0Fg7eduvkcBNa1M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=UGRRdG3e9a2hW15jZgZaUD7HCAcNv8An
        6/1l7NtjSiNm62jzPuYXIUXo1XrAB9ZUyHICFDhdNk6VDvPpQVM403KaXNRaNhp/
        TDE6ALzhM+GPj/9qcQ28/Wb7gqQQIh8Mo1QNXtDRrxV8aL5V4QLsBln7Rwt+yB9Z
        Q9zi92RsBtM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 5426F83FBF;
        Tue,  8 Sep 2020 19:59:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D2C6B83FBE;
        Tue,  8 Sep 2020 19:59:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Aaron Schrab <aaron@schrab.com>
Cc:     Ash Holland <ash@sorrel.sh>, git@vger.kernel.org
Subject: Re: `git describe --dirty` doesn't consider untracked files to be dirty
References: <CAHJUbDg2KA9Xo_CAO=cgrZewOH0zfEhOVydhMN8fLvVDmji4sQ@mail.gmail.com>
        <xmqqh7s8z0qw.fsf@gitster.c.googlers.com>
        <20200908231652.GC1014@pug.qqx.org>
Date:   Tue, 08 Sep 2020 16:59:20 -0700
In-Reply-To: <20200908231652.GC1014@pug.qqx.org> (Aaron Schrab's message of
        "Tue, 8 Sep 2020 19:16:52 -0400")
Message-ID: <xmqqft7rx1k7.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 500FA934-F22F-11EA-B4F4-01D9BED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Aaron Schrab <aaron@schrab.com> writes:

> It's perhaps worth noting that submodules are already considered dirty
> when untracked files are added:
>
> $ git diff vim/bundle/fugitive
>
> $ echo foo >vim/bundle/fugitive/foo
>
> $ git diff vim/bundle/fugitive
> diff --git i/vim/bundle/fugitive w/vim/bundle/fugitive
> --- i/vim/bundle/fugitive
> +++ w/vim/bundle/fugitive
> @@ -1 +1 @@
> -Subproject commit caf3b1d5696e8d39a905e48f1e89d8c0c565168c
> +Subproject commit caf3b1d5696e8d39a905e48f1e89d8c0c565168c-dirty

It gives one vote for (1) to the part you did not quote from the
message you are responding to, which was:

>> I do not think this is something we want to hide behind a
>> configuration knob, but I am undecided between (1) declare that this
>> is a bug and change the behaviour of "--dirty" and (2) declare that
>> we discovered another useful behaviour and add a new option next to
>> "--dirty".

I tend to agree the consistency with that behaviour would be more
useful.  The discrepanthy shows the relative age of features and how
our thinking has changed over time ;-)
