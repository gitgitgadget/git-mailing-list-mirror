Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19853C433F5
	for <git@archiver.kernel.org>; Fri,  4 Feb 2022 21:56:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243748AbiBDV4A (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Feb 2022 16:56:00 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:50801 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230180AbiBDVz7 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Feb 2022 16:55:59 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 4004F175347;
        Fri,  4 Feb 2022 16:55:59 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=J84C+KwBk172
        F6ClJQ1QTy2/7I7p+D+RM8yK/CjRZm0=; b=Jj80dkAPqjrMELHPtEZBpFpNICQS
        eTHLl6rRrPqV+583OfKNJpnhw91aUD/2wO2N1nybV4QP2a/+Eo66BpEDi5TprPSm
        /Lg7Octmo2zg0Sfqjz6YwJoJPgSwSYAAmwVT8DlAvUoZX8MTVhtHPtQ/jVLzO3Tq
        W972z2ihUGWRPR8=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 37899175346;
        Fri,  4 Feb 2022 16:55:59 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 90A2F175345;
        Fri,  4 Feb 2022 16:55:56 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Lessley Dennington via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, stolee@gmail.com,
        johannes.schindelin@gmail.com, Elijah Newren <newren@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Lessley Dennington <lessleydennington@gmail.com>
Subject: Re: [PATCH v5 3/3] completion: handle unusual characters for
 sparse-checkout
References: <pull.1108.v4.git.1643318514.gitgitgadget@gmail.com>
        <pull.1108.v5.git.1643921091.gitgitgadget@gmail.com>
        <ddf5e583dd71a729d6fb0513aed9fc4eb6ebbdd7.1643921091.git.gitgitgadget@gmail.com>
Date:   Fri, 04 Feb 2022 13:55:54 -0800
In-Reply-To: <ddf5e583dd71a729d6fb0513aed9fc4eb6ebbdd7.1643921091.git.gitgitgadget@gmail.com>
        (Lessley Dennington via GitGitGadget's message of "Thu, 03 Feb 2022
        20:44:51 +0000")
Message-ID: <xmqqr18ijnyt.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 3B19082A-8605-11EC-A9CC-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Lessley Dennington via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> +test_expect_success FUNNYNAMES 'cone mode sparse-checkout completes di=
rectory names with special characters' '
> +	# reset sparse-checkout
> +	git -C sparse-checkout sparse-checkout disable &&
> +	(
> +		cd sparse-checkout &&
> +		mkdir "directory with spaces" &&
> +		mkdir "$(printf "directory\twith\ttabs")" &&
> +		mkdir "directory\with\backslashes" &&
> +		mkdir "directory-with-=C3=A1ccent" &&
> +		>"directory with spaces/randomfile" &&
> +		>"$(printf "directory\twith\ttabs")/randomfile" &&
> +		>"directory\with\backslashes/randomfile" &&
> +		>"directory-with-=C3=A1ccent/randomfile" &&
> +		git add . &&
> +		git commit -m "Add directories containing unusual characters" &&
> +		git sparse-checkout set --cone "directory with spaces" \
> +			"$(printf "directory\twith\ttabs")" "directory\with\backslashes" \
> +			"directory-with-=C3=A1ccent" &&
> +		test_completion "git sparse-checkout add dir" <<-\EOF
> +		directory with spaces/
> +		directory	with	tabs/
> +		directory\with\backslashes/
> +		directory-with-=C3=A1ccent/
> +		EOF
> +	)
> +'

I wonder if we care about the repetition, which can burden anybody
who will later have to change this script.  "directory with spaces"
appears three times in the above (i.e. mkdir uses it, then redirection
to create a file under it uses it, and "sparse-checkout set" uses it,
and then finally the expected output has it.

An obvious way to reduce repetition is to add variables for them,
and because this is in a subshell, we do not have to worry about the
use of extra variables contaminating the namespace for later tests.

	D1=3D"directory with spaces" &&
	D2=3D$(printf "directory\t\with\ttabs") &&
	D3=3D"directory\with\backslashes" &&
        D4=3D"directory-with-=C3=A1ccent" &&
	for D in "$D1" "$D2" "$D3" "$D4"
	do
		>"$D/samplefile" || return 1
	done &&
	git add . &&
	git commit -m "add many" &&
	git sparse-checkout set --cone "$D1" "$D2" "$D3" "$D4" &&
	test_completion "git sparse-checkout add dir" <<-EOF
	$D1/
	$D2/
	$D3/
	$D4/
	EOF

Having written it, I am undecided.  It does reduce repetition, and
it does reduce the chance to make typo, but did I make it easier to
follow?  I am not sure about the last part.

Thanks.
