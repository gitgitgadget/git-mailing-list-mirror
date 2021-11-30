Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C978C433EF
	for <git@archiver.kernel.org>; Tue, 30 Nov 2021 06:32:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233763AbhK3GgD (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Nov 2021 01:36:03 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54222 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238596AbhK3GgD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Nov 2021 01:36:03 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E3248EA61A;
        Tue, 30 Nov 2021 01:32:43 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=UZnLaYjcgcjYegd/rzAofsNIEFlVGcgTODNV0a
        mVoEc=; b=m4PX2HotfwV6R5VW7l7/A7Ir3LcWsKsrH3bZArnHY+ymQLW47SXyef
        CvkCDzXe2DzF0a11vWQf313a7jOwfeTw35rOKQYpNHaEy6IX4h0p4Y2QrxD8p3EX
        CF65JFXSFQ8AbD5U77fmqF66dGPD5zGchsQj53iC0aGJz8n+iiwbk=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D98B0EA619;
        Tue, 30 Nov 2021 01:32:43 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 51676EA618;
        Tue, 30 Nov 2021 01:32:43 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Lessley Dennington <lessleydennington@gmail.com>
Cc:     Lessley Dennington via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, stolee@gmail.com, newren@gmail.com,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v4 1/4] sparse index: enable only for git repos
References: <pull.1050.v3.git.1635802069.gitgitgadget@gmail.com>
        <pull.1050.v4.git.1637620958.gitgitgadget@gmail.com>
        <81e208cf454b61c761fa66e4f43a464ed439ba59.1637620958.git.gitgitgadget@gmail.com>
        <xmqq8rxe787g.fsf@gitster.g>
        <724abbd4-b9ee-3b3d-226c-b7999f138152@gmail.com>
        <xmqqzgpt2z0h.fsf@gitster.g>
        <6db27c92-6ea6-fa5f-8aa7-e1fef7d5ff5a@gmail.com>
Date:   Mon, 29 Nov 2021 22:32:42 -0800
In-Reply-To: <6db27c92-6ea6-fa5f-8aa7-e1fef7d5ff5a@gmail.com> (Lessley
        Dennington's message of "Mon, 29 Nov 2021 15:38:03 -0800")
Message-ID: <xmqqmtlm2lx1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 52E0C4BC-51A7-11EC-B6AA-62A2C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Lessley Dennington <lessleydennington@gmail.com> writes:

> This is cool! I applied it locally, and it seems to be working well. I
> will plan to replace my changes to checkout and pack-objects with this
> for v5.

I didn't write it to replace the changes you were preparing, though.

What the patch is meant to solve is that "git checkout -h" in a
repository, whose .git/config has some custom configuration
variables that affect how the short help text is shown, were
ignoring that per-repository settings by not even checking if we are
in a repository at all.

When "-h" is in effect, and if you are outside a repository, this
would cause the setup_git_directory_gently() function to be called,
and we'd reach checkout_main() without having discovered repository.
I do not think it removes the need for your "only when startup-info
says we have repository, do these" safety.  At least, I didn't write
the patch to remove that need.
