Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D104AC433EF
	for <git@archiver.kernel.org>; Wed,  6 Apr 2022 14:04:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234421AbiDFOGi (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Apr 2022 10:06:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234331AbiDFOGS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Apr 2022 10:06:18 -0400
Received: from lucy.dinwoodie.org (b.8.0.0.8.9.b.0.2.f.0.9.2.a.d.b.d.a.0.2.5.1.e.d.0.b.8.0.1.0.0.2.ip6.arpa [IPv6:2001:8b0:de15:20ad:bda2:90f2:b98:8b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8497BB7F
        for <git@vger.kernel.org>; Wed,  6 Apr 2022 02:42:15 -0700 (PDT)
Received: from adam by lucy.dinwoodie.org with local (Exim 4.94.2)
        (envelope-from <adam@dinwoodie.org>)
        id 1nc2Ax-000x47-RD; Wed, 06 Apr 2022 10:42:07 +0100
Date:   Wed, 6 Apr 2022 10:42:07 +0100
From:   Adam Dinwoodie <adam@dinwoodie.org>
To:     Lessley Dennington via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, stolee@gmail.com, gitster@pobox.com,
        johannes.schindelin@gmail.com, Elijah Newren <newren@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Lessley Dennington <lessleydennington@gmail.com>
Subject: Re: [PATCH v7 3/3] completion: handle unusual characters for
 sparse-checkout
Message-ID: <20220406094207.h7ru4xdiimywelqg@lucy.dinwoodie.org>
References: <pull.1108.v6.git.1643945198.gitgitgadget@gmail.com>
 <pull.1108.v7.git.1644255105.gitgitgadget@gmail.com>
 <996cbe7dfb73c211eae012813b352b0d0de3954c.1644255105.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <996cbe7dfb73c211eae012813b352b0d0de3954c.1644255105.git.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 07, 2022 at 05:31:45PM +0000, Lessley Dennington via GitGitGadget wrote:
> <snip>
> 
> Note there are two tests for this new functionality - one for spaces and
> accents and one for backslashes and tabs. The backslashes and tabs test
> uses FUNNYNAMES to avoid running on Windows. This is because:
> 
> 1. Backslashes are explicitly not allowed in Windows file paths.
> 2. Although tabs appear to be allowed when creating a file in a Windows
> bash shell, they actually are not renderable (and appear as empty boxes
> in the shell).
> 
> <snip>
> diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
> index b38a7302249..da6c86c64b3 100755
> --- a/t/t9902-completion.sh
> +++ b/t/t9902-completion.sh
> @@ -1508,6 +1508,55 @@ test_expect_success 'cone mode sparse-checkout completes directory names' '
> <snip>
> +# use FUNNYNAMES to avoid running on Windows, which doesn't permit backslashes or tabs in paths
> +test_expect_success FUNNYNAMES 'cone mode sparse-checkout completes directory names with backslashes and tabs' '
> +	# reset sparse-checkout
> +	git -C sparse-checkout sparse-checkout disable &&
> +	(
> +		cd sparse-checkout &&
> +		mkdir "directory\with\backslashes" &&
> +		mkdir "$(printf "directory\twith\ttabs")" &&
> +		>"directory\with\backslashes/randomfile" &&
> +		>"$(printf "directory\twith\ttabs")/randomfile" &&
> +		git add . &&
> +		git commit -m "Add directory with backslashes and directory with tabs" &&
> +		git sparse-checkout set --cone "directory\with\backslashes" \
> +			"$(printf "directory\twith\ttabs")" &&
> +		test_completion "git sparse-checkout add dir" <<-\EOF &&
> +		directory\with\backslashes/
> +		directory	with	tabs/
> +		EOF
> +		rm -rf "directory\with\backslashes" &&
> +		rm -rf "$(printf "directory\twith\ttabs")" &&
> +		git add . &&
> +		git commit -m "Remove directory with backslashes and directory with tabs"
> +	)
> +'
> +
>  test_expect_success 'non-cone mode sparse-checkout uses bash completion' '
>  	# reset sparse-checkout repo to non-cone mode
>  	git -C sparse-checkout sparse-checkout disable &&

On Cygwin this test is failing: `FUNNYNAMES` checks (a) the system isn't
MinGW, and (b) the filesystem supports tabs, quotes and newlines.
Cygwin isn't MinGW, and its interface to the file system supports all
those characters, but doesn't support backslashes.

I think the ideal solution here would be to split this test into two:
one part to cover the tab part, which will work on Cygwin, and a
separate part that has another prereq (which might be a new variant of
FUN*NAMES, or might be something more explicit like
SLASHALLOWEDINPATHCOMPONENTS, or might just be FUNNYNAMES,!CYGWIN).  But
it might be easier to just gate this test on FUNNYNAMES,!CYGWIN and not
worry about not being able to test the tab handling on Cygwin systems,
as the chances of a Cygwin-specific regression that'd only be caught by
this test seems pretty low to me.
