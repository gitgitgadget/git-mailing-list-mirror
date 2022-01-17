Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA6BFC433F5
	for <git@archiver.kernel.org>; Mon, 17 Jan 2022 02:19:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236801AbiAQCTg (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 16 Jan 2022 21:19:36 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60904 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233990AbiAQCTf (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 16 Jan 2022 21:19:35 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D63EE10929D;
        Sun, 16 Jan 2022 21:19:34 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ClrELDZ9BAfZJdSbJy0+SSClui/H7SGmp+R/X3
        GAQQA=; b=uqXLS3P1yiML7BnU50T/o5bYd0xzsFvPZ0SF/Hv4LI9d/tejkR8+H6
        q7zFMNgJdc2vRcTSZU6tDVyTdK69zSc+vgGn4L5JrNzyKw2h2OmBwZdJeu4tItQU
        lZ8zD7ZXSapmohsGtNN+H257WNZnsuMciIywtHA+EVbI1kMaNMk0M=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id CAB3910929C;
        Sun, 16 Jan 2022 21:19:34 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 2CF3E10929B;
        Sun, 16 Jan 2022 21:19:34 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Joel Holdsworth <jholdsworth@nvidia.com>
Cc:     git@vger.kernel.org, Luke Diamand <luke@diamand.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Tzadik Vanderhoof <tzadik.vanderhoof@gmail.com>,
        Dorgon Chang <dorgonman@hotmail.com>,
        Joachim Kuebart <joachim.kuebart@gmail.com>,
        Daniel Levin <dendy.ua@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Ben Keene <seraphire@gmail.com>,
        Andrew Oakley <andrew@adoakley.name>
Subject: Re: [PATCH v3 02/21] git-p4: remove unneeded semicolons from
 statements
References: <20220116160550.514637-1-jholdsworth@nvidia.com>
        <20220116160550.514637-3-jholdsworth@nvidia.com>
Date:   Sun, 16 Jan 2022 18:19:32 -0800
In-Reply-To: <20220116160550.514637-3-jholdsworth@nvidia.com> (Joel
        Holdsworth's message of "Sun, 16 Jan 2022 16:05:31 +0000")
Message-ID: <xmqqczkrxfwr.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E945BAB6-773B-11EC-A165-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Joel Holdsworth <jholdsworth@nvidia.com> writes:

> @@ -4119,9 +4119,9 @@ def run(self, args):
>  
>      def rebase(self):
>          if os.system("git update-index --refresh") != 0:
> -            die("Some files in your working directory are modified and different than what is in your index. You can use git update-index <filename> to bring the index up to date or stash away all your changes with git stash.");
> -        if len(read_pipe(["git", "diff-index", "HEAD", "--"])) > 0:
> -            die("You have uncommitted changes. Please commit them before rebasing or stash them away with git stash.");
> +            die("Some files in your working directory are modified and different than what is in your index. You can use git update-index <filename> to bring the index up to date or stash away all your changes with git stash.")
> +        if len(read_pipe("git diff-index HEAD --")) > 0:
> +            die("You have uncommitted changes. Please commit them before rebasing or stash them away with git stash.")
>  
>          [upstream, settings] = findUpstreamBranchPoint()
>          if len(upstream) == 0:

I think this is the most likely culprit behind the CI breakage at
https://github.com/git/git/runs/4834693517?check_suite_focus=true#step:5:1643

You made read_pipe() to refuse to take string-form of command in
another topic in 'next', and this series are built on what is in
'next', but apparently this hunk does MUCH MORE than "remove
unneeded semicolons"---at least here it reverts the "read_pipe() no
longer takes a string-form of external command".


