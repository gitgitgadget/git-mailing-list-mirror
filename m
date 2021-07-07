Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71269C07E96
	for <git@archiver.kernel.org>; Wed,  7 Jul 2021 01:48:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 471CC61C98
	for <git@archiver.kernel.org>; Wed,  7 Jul 2021 01:48:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229992AbhGGBuw (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Jul 2021 21:50:52 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58945 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229949AbhGGBuv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Jul 2021 21:50:51 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id AF19FD4F19;
        Tue,  6 Jul 2021 21:48:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=LTuwiBgiDIG7IduSGCZ92kbQ+T/0GUjAziabFs
        oD/WA=; b=Amxqc7a1rMPAqZEfXQtsNeKhBLpuMDZPtrd4vmGK7fHPd5oJUcaMRg
        uMzIF9Sa0Q1DFDFC4ETjiJHD98oFGhPDpxi0i4VVRKwcUZU27XScpoG8pT6bsblO
        W+1Qn3xDVrJI9cb+9sD+lr6QYVULipcyHe7+c4I8svmhFDBH06exc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A7E63D4F17;
        Tue,  6 Jul 2021 21:48:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.3.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 3648CD4F16;
        Tue,  6 Jul 2021 21:48:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Aaron Hall <aaronchallmba@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Default ssh command
References: <CADrEZfE+LuDnhWkRHPMwHq7aGYcvDeqken8uZzPgHREtf0iqjA@mail.gmail.com>
Date:   Tue, 06 Jul 2021 18:48:09 -0700
In-Reply-To: <CADrEZfE+LuDnhWkRHPMwHq7aGYcvDeqken8uZzPgHREtf0iqjA@mail.gmail.com>
        (Aaron Hall's message of "Tue, 6 Jul 2021 21:35:30 -0400")
Message-ID: <xmqqczrugahy.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 62335BC8-DEC5-11EB-9A9E-FD8818BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Aaron Hall <aaronchallmba@gmail.com> writes:

> I was trying to push some binary files (PNGs) over ssh and found some
> files inexplicably wouldn't successfully push.
>
> I set, in my .gitconfig file:
>
> [core]
>         sshCommand = ssh -e none
>
> And it works now for all files (that I can tell).
>
> From a close examination of the output where I noted escape codes
> showing up, I believe the problem to be ssh escape codes.
>
> `\n~.` for example closes the ssh client.
>
> Therefore I think the default ssh command should be `ssh -e none`
> instead of `ssh` for the benefit of users who won't recognize the
> problem, unless `git` is expected to make use of ssh escape codes.

Curious.  

When we use ssh to run the receive-pack over the wire while pushing,
we do not ask for pty, and because the "-e" option to set the escape
character is meaningful only when ssh runs with pty allocated, you
shouldn't have to do this, unless you force pty allocation by
e.g. passing "-t" yourself.
