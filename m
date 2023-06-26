Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4191EB64D7
	for <git@archiver.kernel.org>; Mon, 26 Jun 2023 23:06:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229848AbjFZXGR (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Jun 2023 19:06:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229750AbjFZXGH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Jun 2023 19:06:07 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FECA10DB
        for <git@vger.kernel.org>; Mon, 26 Jun 2023 16:06:02 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4BE4D1ABEB8;
        Mon, 26 Jun 2023 19:06:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=zB86Ii1H2jaHOHrojzcZPvF2KXnkgfFRPF9Dtl
        0nBvg=; b=Bm6ynYmG8vippKbxjh19U6nLxcn7rkKeSk1xL7qxxvCHAfJtiv6YED
        dXIbvGplJ5QAHuTFfvh8SGM7xEN+gmih9I70Rw3M9fUDETZkeY3fYV2DuZdapFzl
        uZejnLpgfVyUN7xDyEt6uYO0jqD6Zvm2unfA/jhksF9y3CNtzKus8=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3D0B21ABEB7;
        Mon, 26 Jun 2023 19:06:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.105.62.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 0B3881ABEB6;
        Mon, 26 Jun 2023 19:05:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Glen Choo <chooglen@google.com>
Cc:     Glen Choo via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jesse Kasky <jkasky@slack-corp.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH] config: don't BUG when both kvi and source are set
References: <pull.1535.git.git.1687801297404.gitgitgadget@gmail.com>
        <xmqq352e59h9.fsf@gitster.g>
        <kl6l7crpsuhs.fsf@chooglen-macbookpro.roam.corp.google.com>
Date:   Mon, 26 Jun 2023 16:05:58 -0700
In-Reply-To: <kl6l7crpsuhs.fsf@chooglen-macbookpro.roam.corp.google.com> (Glen
        Choo's message of "Mon, 26 Jun 2023 15:56:31 -0700")
Message-ID: <xmqqh6qt4yeh.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 03FBFB3A-1476-11EE-B086-C65BE52EC81B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Glen Choo <chooglen@google.com> writes:

> Ah, I meant that this bug occurred because most users of config use
> git_config()/repo_config() (a wrapper around config sets), so it's very
> easy to accidentally read repo config, e.g. in the middle of parsing
> config (config file -> config set). I'd imagine it might also be quite
> easy to read repo config while reading repo config (config set -> config
> set), which would make current_config_* return the wrong thing, but at
> least it doesn't BUG().

I think BUG() is better than silently computing a wrong result, but
it would probably be much rare than the problem at hand, and with
the getting rid of global dependencies, it won't be an issue anymore,
hopefull?  So it is good.

> The "reverse" case (config set -> config file) is very _unlikely_
> because very few places need to know about config files, so it's
> unlikely that we'd have an explicit call to parse a config file,
> especially in the middle of reading repo config.

As long as existing codepaths do not do that, it would be OK ;-)

Thanks.
