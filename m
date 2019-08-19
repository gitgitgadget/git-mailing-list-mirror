Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0ED8D1F461
	for <e@80x24.org>; Mon, 19 Aug 2019 18:21:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728302AbfHSSVU (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Aug 2019 14:21:20 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58035 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727808AbfHSSVT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Aug 2019 14:21:19 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A5FC116AE99;
        Mon, 19 Aug 2019 14:21:17 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=CwAXuvJLIdYk8dyMFgwA+PNSu0k=; b=J2TtId
        ZcCWYfHDmUog2rUa0sKarqm/VF4yWGrcePoN9Sb0lmlbKBvkBZBpRNNIr593WvzX
        NQwifUGBqn/Ut9gDR2YpMKZlZUjzK2QgZUGTKkPh24f2ZDCBjwxb844bVUxMOnPs
        L2TxYKtBBjQ4wr1X5neC/rbR6co3Wy91hE9RQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=o/jYPRIFQ8CAtpg+liZPI61chiCXw7zQ
        5DT/ijJ8XPTbg60Asa1o9QBYGCycBsYjmKo3j9Q7S/0t81fLisfgk8f4iyjIujSY
        ZUOjVx6pre6zlH3B2JBwfXP9qITFu2uDPzcdObYW/DejOlfc+Klzt/IbGPKillPI
        vM9Os/45mXA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9C3BA16AE97;
        Mon, 19 Aug 2019 14:21:17 -0400 (EDT)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 0AD7316AE96;
        Mon, 19 Aug 2019 14:21:16 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ben <ben@wijen.net>
Cc:     phillip.wood@dunelm.org.uk, git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Pratik Karki <predatoramigo@gmail.com>
Subject: Re: [PATCH 0/2] git rebase: Make sure upstream branch is left alone.
References: <20190818095349.3218-1-ben@wijen.net>
        <0bef598c-6c89-c699-5290-ee2003db5979@gmail.com>
        <81b244b9-8b26-e638-56ae-827bbc522dc2@wijen.net>
Date:   Mon, 19 Aug 2019 11:21:15 -0700
In-Reply-To: <81b244b9-8b26-e638-56ae-827bbc522dc2@wijen.net> (ben@wijen.net's
        message of "Mon, 19 Aug 2019 17:33:15 +0200")
Message-ID: <xmqqef1hxbhg.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2282E3D4-C2AE-11E9-BC64-46F8B7964D18-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ben <ben@wijen.net> writes:

> Hi Phillip,
>
> The expected behavior: (as per v2.21.0:/git-legacy-rebase.sh:679)
>     AUTOSTASH=$(git stash create autostash)
>     git reset --hard
>     git checkout master
>     git rebase upstream
>     git stash apply $AUTOSTASH 
>
>
> The actual behavior:
>     AUTOSTASH=$(git stash create autostash)
>     git reset --hard master
>     git checkout master
>     git rebase upstream
>     git stash apply $AUTOSTASH 
>
> So, the problem with the actual behavior is the move of the currently active branch with 'git reset --hard master'

Your expected and actual behaviour are described above, but it is
not mentioned out of what command (and in what settings) you expect
the above behaviour.

I am guessing that the setup and the command is something along this
line?

    git checkout not-the-master
    work work work
    git rebase --autostash upstream master

That is, you have checked out a branch that is not the 'master'
branch, you have accumulated some work in the working tree, and then
you ask "please stash away the work in progress and then rebase the
'master' branch on top of the upstream branch"?

If so, my expectation for the third step (i.e. the actual "rebase")
aligns with yours.  After stashing away the local change, we want to
get a clean working tree, checkout the master branch and rebase it
on top of the upstream.  With the command sequence you wrote in the
"actual" section, after stashing away the local change, the current
branch that is *not* the master is reset to the tip of 'master',
which would not be what we want.

