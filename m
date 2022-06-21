Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32002C433EF
	for <git@archiver.kernel.org>; Tue, 21 Jun 2022 21:33:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237681AbiFUVdR (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Jun 2022 17:33:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232216AbiFUVdQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Jun 2022 17:33:16 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6383116D
        for <git@vger.kernel.org>; Tue, 21 Jun 2022 14:33:15 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id D3E51196F28;
        Tue, 21 Jun 2022 17:33:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=9EuQPGOq1PP6vkp/Uhk65gZ7VnERzSk3oIzCKw
        hB4wI=; b=AgRYYMzFqnpkU4y42EGv5EndJ+VxFUhFCdHJvntBWnNFe33/Vgzyid
        3KoOzUZL8035l2XMSSkXh39drx/hC0tF5qYIADOhOrfCa57IimgYN/xovQgrjJiM
        /SsH8pY6ND7mwV0YfaJLgrKn3qujpAaeCvP9C2wSEzSpAYvx6YtEY=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id CC854196F26;
        Tue, 21 Jun 2022 17:33:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 6D5F8196F24;
        Tue, 21 Jun 2022 17:33:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, me@ttaylorr.com, newren@gmail.com,
        avarab@gmail.com, dyroneteng@gmail.com, Johannes.Schindelin@gmx.de
Subject: Re: [PATCH 1/6] docs: document bundle URI standard
References: <pull.1248.git.1654545325.gitgitgadget@gmail.com>
        <e771b2971d092af5ea8a47eb708d03e34b284a0f.1654545325.git.gitgitgadget@gmail.com>
        <xmqqtu8x1fd4.fsf@gitster.g>
        <48e722dc-f860-f7a6-36d0-b0106087aef4@github.com>
        <d4427adf-e3ef-a5cd-3016-687004dc5ae3@github.com>
        <xmqq8rpphiwn.fsf@gitster.g>
        <17349136-2d99-92fc-a73a-507684f32baa@github.com>
Date:   Tue, 21 Jun 2022 14:33:10 -0700
In-Reply-To: <17349136-2d99-92fc-a73a-507684f32baa@github.com> (Derrick
        Stolee's message of "Tue, 21 Jun 2022 17:10:04 -0400")
Message-ID: <xmqqedzhg0rt.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C0006DB6-F1A9-11EC-BE94-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <derrickstolee@github.com> writes:

>> FWIW, I wasn't thinking about GC and expiration.  If bundle URI
>> thing can say "you need this, that and that other bundle" and cause
>> you to fetch three bundles, I thought that there needs a way for you
>> to record the tips of these three bundles---these three bundles
>> should not have to compete for refs/bundles/master, for example.
>  
> Not wanting to compete makes sense, but also we should usually
> expect the "most recent" bundle to be the most recent version of the
> branch. However, that ordering only makes sense when we have the
> creationToken (nee timestamp) heuristic, so having distinct ref
> spaces makes sense to avoid collisions.

I still do not see how keeping track of bundle tips in the longer
term with refs fits in the larger picture.  It's not like we are
keeping the bundle files (we are instead exploding them into the
object store, at which point the contents are mixed with all other
objects), and if we do so as part of a boot-strapping, we'd fetch
more history on top of what came from bundles, at which point we
no longer need these refs for protecting objects from collection.
And if the project rewinds and force pushes history, some objects
that originally came from these bundles can and should go stale and
be collected.

Also, if I am not mistaken, the table of contents does not record
the tip commits of each bundle, so keeping track of the bundle tips
we have seen does not help us optimizing download upon seeing a
toc---we'd need to look at the bundle data (at least the header part
that lists the tips) anyway.

Not complaining against the existence of refs/bundles/ hierarchy.
Just stating that I do not think I got the use of it documented in
the proposed design (perhaps it was described but I didn't
understand it, or perhaps it was under-described and needs
clarification).

Thanks.
