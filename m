Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AD81C1F461
	for <e@80x24.org>; Fri, 30 Aug 2019 17:06:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728094AbfH3RGM (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Aug 2019 13:06:12 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57111 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727246AbfH3RGM (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Aug 2019 13:06:12 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 0D94C164771;
        Fri, 30 Aug 2019 13:06:10 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=Mex0Q1ncZQtr
        FqM8xC8pg8ih3yw=; b=KuMBOQAjW70uSsUg38HWGTjgFAI4lhc80eeVYqzbhhcQ
        9t3VtFuCjWl8LegAxcAFDJjwj2Khq+9H7MbC45znkLJ5bkKPlCglZH4Dzl3Hk4T7
        wyzuR11oMP6mFgShoN4Sm+z8EAul1IVTN7EF0u7AFie3lywuJvSTQra0C12frVM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=OO4BQA
        S5Th7NEN9I7cWHnF0phE+0bd3NJ1cUvyI10aBDEqZzZY2teXlxht+PqT68A6aXIA
        c74szMNEnXPuCZYv4DP36dQPVpawF/wBGVXwp/7mjZmyfKfxvjp7inygiyw6sfth
        j8C/EjXZ9mD/gxRynP7kXmZ8RlOfWrl316EEQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 048E0164770;
        Fri, 30 Aug 2019 13:06:10 -0400 (EDT)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 6FDB116476F;
        Fri, 30 Aug 2019 13:06:09 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>
Cc:     Thomas Gummerer <t.gummerer@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Joel Teichroeb <joel@teichroeb.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 1/3] factor out refresh_and_write_cache function
References: <20190827101408.76757-1-t.gummerer@gmail.com>
        <20190829182748.43802-1-t.gummerer@gmail.com>
        <20190829182748.43802-2-t.gummerer@gmail.com>
        <CAN0heSqZOG6NMJE4=RReKzG3eD_w1mh8EcYaAQWN6WBY3WuZ1Q@mail.gmail.com>
Date:   Fri, 30 Aug 2019 10:06:08 -0700
In-Reply-To: <CAN0heSqZOG6NMJE4=RReKzG3eD_w1mh8EcYaAQWN6WBY3WuZ1Q@mail.gmail.com>
        ("Martin =?utf-8?Q?=C3=85gren=22's?= message of "Fri, 30 Aug 2019 17:07:29
 +0200")
Message-ID: <xmqq8srazipr.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 7652D09E-CB48-11E9-88A3-46F8B7964D18-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Martin =C3=85gren <martin.agren@gmail.com> writes:

> There's a difference in behavior that I'm not sure about: We used
> to ignore the return value of `refresh_cache()`, i.e. we didn't care
> whether it had any errors. I have no idea whether that's safe to do --
> especially as we go on to write the index. So I don't know whether this
> patch fixes a bug by introducing the early return. Or if it *introduces=
*
> a bug by bailing too aggressively. Do you know more?

One common reason why refresh_cache() fails is because the index is
unmerged (i.e. has one or more higher-stage entries).  After an
attempt to refresh, this would not wrote out the index in such a
case, which might even be more correct thing to do than the original
in the original context of "git am" implementation.  The next thing
that happens after the caller calls this function is to ask
repo_index_has_changes(), and we'd say "the index is dirty" whether
the index is written back or not from such a state.

> The above makes me think that once this new function is in good shape,
> the commit introducing it could sell it as "this is hard to get right -=
-
> let's implement it correctly once and for all". ;-)

Yes, that is a more severe issue.
