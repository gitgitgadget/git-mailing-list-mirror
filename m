Return-Path: <SRS0=3/hf=DT=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33F72C433E7
	for <git@archiver.kernel.org>; Mon, 12 Oct 2020 19:27:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CBEE620776
	for <git@archiver.kernel.org>; Mon, 12 Oct 2020 19:27:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="rHQKVpdT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390979AbgJLT1J (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Oct 2020 15:27:09 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64741 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388652AbgJLT1I (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Oct 2020 15:27:08 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 30DD08D550;
        Mon, 12 Oct 2020 15:27:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=BZXme2JXpiYxCC16xQOJEWw/AB0=; b=rHQKVp
        dTqRhY8w+aCilmCYtJ+eb9Q5YWlCy1eF/QiE1Mq4FFBRHMAZX3Il8EnxJiQqJaD/
        s58i864bwzaE+OSCZibW9AhVUo6GiS1T2Jrnmhf9kE44w7euc2pKoIF0WECcAfqo
        gKemfsecfZBkv9GKuixrV86biKUda6vlOczSw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Tz77i7TKUX8dNs46WaS+sKsaZcAusKt9
        NQg27qRRZNfhid4v+tlPiVhoXrgllGq6E9NkvtWR9VLikUhrNEskBepfiBlom4S9
        BGBc5nD12+7fdvC8iQcgFAj3avMp6/nFk28vEizm8xHVqV30wot529O0vhgWhHTg
        pWrBQr3iAC8=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 244D88D54F;
        Mon, 12 Oct 2020 15:27:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 881958D54E;
        Mon, 12 Oct 2020 15:27:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 0/2] ci: make the new GitHub workflow logic more defensive
References: <pull.748.git.1602451631.gitgitgadget@gmail.com>
Date:   Mon, 12 Oct 2020 12:27:06 -0700
In-Reply-To: <pull.748.git.1602451631.gitgitgadget@gmail.com> (Johannes
        Schindelin via GitGitGadget's message of "Sun, 11 Oct 2020 21:27:09
        +0000")
Message-ID: <xmqqblh7p7n9.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: EAB2D212-0CC0-11EB-8D6F-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> Phil just reported that the check I added failed miserably
> [https://github.com/phil-blain/git/runs/1238660958] in their fork, and the 
> entire run would be abandoned. That's totally unintended, and was caused by
> a different metadata format for older recorded runs.

Thanks for a quick response to breakage.

> Let's work around this particular issue, and then make the entire check a
> lot more robust.
>
> This patch series is based on js/ci-ghwf-dedup-tests.

Will queue.
