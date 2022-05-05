Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 436ADC433EF
	for <git@archiver.kernel.org>; Thu,  5 May 2022 18:42:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382966AbiEESpt (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 5 May 2022 14:45:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385063AbiEESoU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 May 2022 14:44:20 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E4C16A401
        for <git@vger.kernel.org>; Thu,  5 May 2022 11:33:16 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 924AE17A616;
        Thu,  5 May 2022 14:33:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=7r9OXPF//ZjyQ3iPppyJKrtoa3+VhriZkeTbvw
        VPHSE=; b=SoPrjdh2wVnG3X+MBEeLpGf2KIzWhyaCvBEr3IfAW3AMpzaV2YuxU1
        xhOYckK8o7J6EHRSYWFTVNH2xoaQ0eTTgZ8Q6lBJkYfW5KN8QCAvXgkQYktoUv0g
        AphLW6M/vlXpYFSN5Y0YhaziHW7Q3dmitDCU2+r5nV+EqBM+1Fj3Q=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 8A65A17A615;
        Thu,  5 May 2022 14:33:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.65.128])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 1216D17A613;
        Thu,  5 May 2022 14:33:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= <carenas@gmail.com>,
        git@vger.kernel.org, bagasdotme@gmail.com,
        phillip.wood123@gmail.com,
        SZEDER =?utf-8?Q?G?= =?utf-8?Q?=C3=A1bor?= 
        <szeder.dev@gmail.com>
Subject: Re: [PATCH v3 1/3] t: document regression git safe.directory when
 using sudo
References: <20220428105852.94449-1-carenas@gmail.com>
        <20220503065442.95699-1-carenas@gmail.com>
        <20220503065442.95699-2-carenas@gmail.com>
        <nycvar.QRO.7.76.6.2205051439290.355@tvgsbejvaqbjf.bet>
Date:   Thu, 05 May 2022 11:33:09 -0700
In-Reply-To: <nycvar.QRO.7.76.6.2205051439290.355@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Thu, 5 May 2022 15:44:34 +0200 (CEST)")
Message-ID: <xmqqlevfesnu.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D10F9C6C-CCA1-11EC-AAC4-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hmm. I would like to suggest that we can side-step all of these issues
> (and the ones I outline below) by considering a similar approach to the
> one Stolee took in t0033: use one or more `GIT_TEST_*` environment
> variables to pretend the exact scenario we want to test for.

I like the GIT_TEST_ASSUME_DIFFERENT_OWNER because it is fairly
clear that it cannot be used as a new attack vector, even with
social engineering.

It would be nice if we can do something similar, but I am coming up
empty while trying to think of "we are testing; pretend that ..."
that is good for testing this SUDO_UID special case *and* clearly
cannot be used as an attack target.

So I very much like the suggestion in principle, but I am not sure
how useful the suggestion would be to make the resulting code better
in practice.

Perhaps this may be a way to pretend we are running a command under
'sudo'?

	test_pretend_sudo () {	
            GIT_TEST_PRETEND_GETEUID_RETURNING_ROOT=1 \
	    GIT_TEST_PRETEND_LSTAT_RETURNING_ROOT=root/p \
                SUDO_UID=0 "$@"
	}

	test_expect_success 'access root-owned repository as root' '
		mkdir root/p &&
		git init root/p &&
		test_pretend_sudo git status
	'

That way we can avoid having to run "chown" while preparing for the
test fixture, and running "git status" under root, but I am not sure
if we want our shipped production binaries to have these "pretend"
knobs.

Thanks.
