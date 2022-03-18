Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC9D0C433EF
	for <git@archiver.kernel.org>; Fri, 18 Mar 2022 17:18:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238896AbiCRRTZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Mar 2022 13:19:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236629AbiCRRTX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Mar 2022 13:19:23 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F41EA3
        for <git@vger.kernel.org>; Fri, 18 Mar 2022 10:18:03 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id CCA4118D049;
        Fri, 18 Mar 2022 13:18:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=D25xSIU7IxlTDk85vg5QqKCqtEG0jLxcuNs8PT
        HOLyE=; b=H+oNmIDQ1aL3Z3ZXQ+1Xu21T7brN4lzAHswEk2gNCMBCFe3COmxSLU
        36eQha1BDnH84Qy0cNzsBTw4ewNnnPb9Z5SiwzXT6NUSm570OE+0bE4/lhnaQ+/a
        F0Hn1eFXGSA2k7KX5jyZRS7ZUlxobVApXoKqLblzONsyX9FSu5mrc=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id C4C2118D048;
        Fri, 18 Mar 2022 13:18:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 3431318D045;
        Fri, 18 Mar 2022 13:18:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood123@gmail.com>
Cc:     Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, derrickstolee@github.com,
        Victoria Dye <vdye@github.com>
Subject: Re: [PATCH v3 2/5] reset: introduce --[no-]refresh option to --mixed
References: <pull.1170.v2.git.1647274230.gitgitgadget@gmail.com>
        <pull.1170.v3.git.1647308982.gitgitgadget@gmail.com>
        <101cee42dd6d5a4e5f12da647eafab9334d69a2d.1647308982.git.gitgitgadget@gmail.com>
        <80a5f411-2ddb-177f-4139-1dfff436deda@gmail.com>
Date:   Fri, 18 Mar 2022 10:17:59 -0700
In-Reply-To: <80a5f411-2ddb-177f-4139-1dfff436deda@gmail.com> (Phillip Wood's
        message of "Fri, 18 Mar 2022 11:08:31 +0000")
Message-ID: <xmqqy2179o3c.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5C8CE2CE-A6DF-11EC-91AB-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood123@gmail.com> writes:

> This keeps the current behavior of not refreshing when --quiet is
> given. I wonder how disruptive it would be to take the opportunity to
> get rid of that hack and go back the the original behavior of
> refreshing when --quiet is given. There are a couple of assumptions
> that make me think it might be acceptable
>
> 1 - anyone using a sparse index wont notice as refreshing the index
>     should be fast for them
>
> 2 - the large repositories that are affected exist in managed
>     environments where an admin who reads the release notes could set
>     reset.refresh in a central config so individual users are not
>     inconvenienced.

I would very much prefer to see "--quiet" not making contribution to
the decision to refresh or not in the longer term.  Many plumbing
commands expect that the calling scripts refresh the index with an
explicit use of "update-index --refresh" and leave the index not
refreshed, but working on unrefreshed index is a trade-off between
performance and correctness.

 * Turning "--quiet" not to refresh may incur performance regression
   for shorter term.  It will not hurt correctness.

 * Introducing "--no-refresh" to mark "reset --quiet" invocations,
   where the freshness of the index does not matter for correctness,
   would help regain performance without breaking scripts.  All
   "reset --quiet" invocations in scripts written before this series
   are supposed to be safe (as they lived with their "reset --quiet"
   that does not refresh), but newly written scripts may start
   expecting that "reset --quiet" would refresh for correctness.

 * If we allow reset.refresh to be set to "no", however, that would
   affect _all_ uses of "reset --quiet", including the ones in newly
   written scripts that expect "reset --quiet" to refresh.  They
   would be forced to say "reset --quiet --refresh", just in case
   the user has such a configuration; otherwise these scripts will
   be declared "buggy" for not explicitly saying "--refresh".

I do not think reset.refresh is a good idea, but I very much like
the idea to making "reset" (regardless of "--quiet") to refresh by
default.

Thanks.


