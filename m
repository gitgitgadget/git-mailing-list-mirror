Return-Path: <SRS0=5dtp=C4=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA2E0C43463
	for <git@archiver.kernel.org>; Sat, 19 Sep 2020 18:12:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6996320874
	for <git@archiver.kernel.org>; Sat, 19 Sep 2020 18:12:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="o67407E2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726520AbgISSMw (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 19 Sep 2020 14:12:52 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:55168 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726449AbgISSMw (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 19 Sep 2020 14:12:52 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 4333BE9431;
        Sat, 19 Sep 2020 14:12:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Ra21IbpUAcTnDLR/RL4H4AeJ7z8=; b=o67407
        E2d2HEqByxF/A0dwnU3EPnZuJTWvhJhIzNZnKeLsJxSw2/pXdNIKUjoDp1F5sXUY
        iFlHwlRLGUOqf4YRRI/IyQrSc3c1V9ddXVT/C6MenJIuoHKc15OPMYwsyqwz1u0y
        wweX6tUPGKDC7dEU1UXrN0m/divPQnQzvoG9E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=C+/WcN5rIi3FQjo83ZBDYNA7QzwJutt0
        E0D5LAt6q+U/JCSfxjJY6zromNsxjqCItrdbbEa6wJcUa/nC5F0AdqK3iUbNp16y
        hysu/DpEBwBTqyJVoTRyNL3MIW+3603ca3/gW4P7VmM2q5GwIvBh3yKZemrS8UY5
        hR6A2liufwo=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 3CF30E9430;
        Sat, 19 Sep 2020 14:12:50 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 8811EE942F;
        Sat, 19 Sep 2020 14:12:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Aaron Schrab <aaron@schrab.com>
Cc:     Ash Holland <ash@sorrel.sh>, git@vger.kernel.org
Subject: Re: `git describe --dirty` doesn't consider untracked files to be
 dirty
References: <CAHJUbDg2KA9Xo_CAO=cgrZewOH0zfEhOVydhMN8fLvVDmji4sQ@mail.gmail.com>
        <xmqqh7s8z0qw.fsf@gitster.c.googlers.com>
        <20200908231652.GC1014@pug.qqx.org>
Date:   Sat, 19 Sep 2020 11:12:45 -0700
In-Reply-To: <20200908231652.GC1014@pug.qqx.org> (Aaron Schrab's message of
        "Tue, 8 Sep 2020 19:16:52 -0400")
Message-ID: <xmqqo8m1k542.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B8D3C668-FAA3-11EA-A96D-843F439F7C89-77302942!pb-smtp21.pobox.com
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

In other words, if we do this in the state:

  $ git -C vim/bundle/fugitive describe --dirty

the submodule directory is not reported as dirty.

This is worth fixing.  I am leaning towards saying that `diff` is
wrong in this case, but I am OK to consider unifying the behaviour
the other way and making `describe --dirty` more strict.

Thanks.
