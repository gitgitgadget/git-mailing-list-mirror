Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00355C433EF
	for <git@archiver.kernel.org>; Wed, 22 Jun 2022 15:12:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359306AbiFVPMW (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Jun 2022 11:12:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359301AbiFVPMV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Jun 2022 11:12:21 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76AF83EA99
        for <git@vger.kernel.org>; Wed, 22 Jun 2022 08:12:20 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 85F9812A0D6;
        Wed, 22 Jun 2022 11:12:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=9Rso0DwfR9GvmdQIQCa8gbcgtoO+ODVBPDEcjO
        +5PTk=; b=kKBb8DcvNMyn78h1FmQraPQonBCUL8SmQODI/45w4NJBbY3vRBXQhE
        3hZ9dzon/42FOF5baX/3Wf/6+Yha62w35v7dJ0abstLr8mCgzCeTq0Vr/tRKg1pI
        bQjkhrzcriVDO7yzjZsHh7i+mztZF6BwIAdjFeuo/4FmPYEox5eqo=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7CF5212A0D5;
        Wed, 22 Jun 2022 11:12:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id DDE1112A0D4;
        Wed, 22 Jun 2022 11:12:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     Teng Long <dyroneteng@gmail.com>, avarab@gmail.com,
        derrickstolee@github.com, git@vger.kernel.org, me@ttaylorr.com,
        tenglong.tl@alibaba-inc.com
Subject: Re: [PATCH v3 5/5] bitmap: add trace2 outputs during open "bitmap"
 file
References: <cover.1655817253.git.dyroneteng@gmail.com>
        <8735ae99798a43650acb9a1df7ba2072c7758476.1655817253.git.dyroneteng@gmail.com>
        <4176c5af-43fd-b7a1-346c-4d4aa9dbd4ae@jeffhostetler.com>
Date:   Wed, 22 Jun 2022 08:12:17 -0700
In-Reply-To: <4176c5af-43fd-b7a1-346c-4d4aa9dbd4ae@jeffhostetler.com> (Jeff
        Hostetler's message of "Wed, 22 Jun 2022 09:04:32 -0400")
Message-ID: <xmqqfsjw7mwe.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B53D53FA-F23D-11EC-89AD-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff Hostetler <git@jeffhostetler.com> writes:

> (I just sent a response to your V2 before I saw your V3, so I'll
> my response here so that it doesn't get lost.)
>
>
> We should not be doing this.  This would dump every repo-related
> boolean value on every command.  I see that in V3 that you have
> a "trace" flag to control this.  But again, this seems wrong here.

I noticed that "flag" while merging this with another topic to
"seen" and found it strange, too.  It "allows" the caller to choose
which one gets logged per variable, but in a very hard-coded way; we
probably would have been much better off to have a table of what
gets logged and have repo_cfg_*() calls consult it.  Even without
configurability, at least it would move the hard-coded choice of
what gets logged from code to data.

But ...

> I already have a GIT_TRACE2_CONFIG_PARAMS and trace2.configparams
> that will dump "interesting" config values to the trace2 log.
> Just set one of them to a list of regex's.  Look at the comment above
> trace2_cmd_list_config() in trace2.h for details.

... that does sound like the right way to go.

> ...
> So if I'm reading this right, this will only print the value of
> "core.multipackindex".
>
> You can get this without the changes here using
>
> GIT_TRACE2_CONFIG_PARAMS="core.multipackindex,...any_other_values_of_interest..."
> before running the command (or use the config setting) before running
> your commandss.

Thanks.
