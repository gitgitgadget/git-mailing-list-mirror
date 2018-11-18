Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5FC641F87F
	for <e@80x24.org>; Sun, 18 Nov 2018 23:20:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727288AbeKSJmY (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Nov 2018 04:42:24 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64619 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726073AbeKSJmY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Nov 2018 04:42:24 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 294F312122A;
        Sun, 18 Nov 2018 18:20:40 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=z8Nn39awzvQthr5l0q3Uas+3shI=; b=pEL6kL
        /nTy2TseBtsCsE86BNbKZ/qhMAkY3RvxQM4xaq2CJhJYrngWED1xszuSJXMcshQ/
        WDSZBokB7PhDZNu6C/wrxK8gGSeX9YHIT+dgC2jYduOVC9JcAXQ+D0Z1+tC9jKO3
        X7yLswMVeHIDx3cofGqte9mb+YOI5WEmd+Bko=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=FO7P9ycJMkV5m4EmXcSiGSNzCoATlNru
        8zplYML4doIeUupBETUib3qcYV8r3x/TTkWTVTsoCJLHbk4cJ3OHap9GH8+EChl+
        U1/Isq8jNcQhFpqCt/kyaL4orobV6fjurJrEwdw7EAJ40tz7rMctEuw3bHynHYK7
        U/CzIWKFybo=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1FD77121229;
        Sun, 18 Nov 2018 18:20:40 -0500 (EST)
Received: from pobox.com (unknown [35.187.50.168])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 918E0121228;
        Sun, 18 Nov 2018 18:20:39 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Xenos <sxenos@google.com>
Cc:     pclouds@gmail.com, git@vger.kernel.org,
        Stefan Beller <sbeller@google.com>,
        Jonathan Nieder <jrn@google.com>,
        Junio C Hamano <jch@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Derrick Stolee <stolee@gmail.com>,
        Carl Baldwin <carl@ecbaldwin.net>,
        Dave Borowitz <dborowitz@google.com>
Subject: Re: [PATCH] technical doc: add a design doc for the evolve command
References: <20181115005546.212538-1-sxenos@google.com>
        <CACsJy8Dk=Z4z5BD-XD_uTJg9Aysd5A--BUjnZR4i5=PfoabAPg@mail.gmail.com>
        <CAPL8ZismWQ7CCZXZJAqtu7v2CD0SyN5kncgXnXb7sL9mmqwhcQ@mail.gmail.com>
Date:   Mon, 19 Nov 2018 08:20:38 +0900
In-Reply-To: <CAPL8ZismWQ7CCZXZJAqtu7v2CD0SyN5kncgXnXb7sL9mmqwhcQ@mail.gmail.com>
        (Stefan Xenos's message of "Sun, 18 Nov 2018 14:27:18 -0800")
Message-ID: <xmqq1s7iezw9.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8FD6FBF8-EB88-11E8-A2F6-063AD72159A7-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Xenos <sxenos@google.com> writes:

>> I don't think this counts as a typical modification and is probably hard to detect automatically.
>
> Clever use of commands! (side: wouldn't it just be easier to just use
> git commit --amend, though?)

When an original commit is mostly an early part of a feature, mixed
with a small but an urgent bugfix, it is not unusual to start your
work from "reset HEAD^" (or "reset --soft HEAD^") and recreate a
commit that has the main part of the change from the original,
leaving the remainder in the working tree to be worked into another
bugfix commit, most likely to be on a new branch forked from an
earlier point in the history, i.e.

	git reset HEAD^
	git add -p
	git commit -c @{1}
	git checkout -m -b a-small-bugfix-split-out master
	edit
	git commit -a

I agree with both of you that we want to have a way to mark that the
first commit we made by partially committing what was in the
original came from the original one, and also that the second one
has contents from the same original one.

It is unclear, without human involvement, if we can mechanically
infer that anything that used to be built on top of the original
commit would want to be rebuilt on top of the first half of the
split commit (i.e. the early part of the feature with the bugfix
separated out) but not on the other half (i.e. the bugfix alone).
