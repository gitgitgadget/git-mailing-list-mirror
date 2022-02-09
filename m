Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99131C433EF
	for <git@archiver.kernel.org>; Wed,  9 Feb 2022 18:26:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239224AbiBISZ6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Feb 2022 13:25:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239150AbiBISZw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Feb 2022 13:25:52 -0500
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E02AFC0613C9
        for <git@vger.kernel.org>; Wed,  9 Feb 2022 10:25:54 -0800 (PST)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C874210EF6A;
        Wed,  9 Feb 2022 13:25:53 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Y8TsGY59qZY2syHdwBTml7RhXVV3YfXDsxM8z+
        Whevw=; b=lLPgrzSWIsOjkH1oQRUpcrbZ85kKT0VvpxPFW6epJiF7HAzzOEt5aR
        tH7NoNCWHIy491cVPDfCv2M9vu6COPDGCrpmQSCUlF3C/25O9nuV4fHeKYHIXeOn
        NieGmvj8Dfu8xmCrkJwMmGoi5tmSji8ZTX6sOlvRfQSR5OZWaAm+E=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C19FD10EF68;
        Wed,  9 Feb 2022 13:25:53 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.185.212.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 3B30D10EF67;
        Wed,  9 Feb 2022 13:25:53 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Alex Henrie <alexhenrie24@gmail.com>
Cc:     git@vger.kernel.org, paulus@ozlabs.org
Subject: Re: [PATCH 2/3] log: add a config option for --graph
References: <20220209162350.169971-1-alexhenrie24@gmail.com>
        <20220209162350.169971-2-alexhenrie24@gmail.com>
Date:   Wed, 09 Feb 2022 10:25:52 -0800
In-Reply-To: <20220209162350.169971-2-alexhenrie24@gmail.com> (Alex Henrie's
        message of "Wed, 9 Feb 2022 09:23:48 -0700")
Message-ID: <xmqq4k5799sf.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B6FABD16-89D5-11EC-89FC-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Alex Henrie <alexhenrie24@gmail.com> writes:

> +	if (default_graph &&
> +	    !rev->graph &&

This part I can see why we want to check ;-)

> +	    !rev->track_linear &&
> +	    !rev->reverse &&
> +	    !rev->reflog_info &&
> +	    !rev->no_walk) {

But this makes me wonder how we plan to keep this list of "if the
user asked for any of these options, we shouldn't turn graph on by
default" up-to-date.  The scheme looks brittle.

Also, what would happen when a developer wants to add, say
log.reverse, configuration variable in the future?  I can see the
block to do the equivalent of this for .log.reverse begins with

	if (default_reverse &&
	    !rev->reverse &&

but I am not sure what other conditions need to be checked,
especially with 'graph'---should it check for !rev->graph or
default_graph of both?  Are we playing with a potential
combinatorial explosion?

> +		rev->topo_order = 1;
> +		rev->rewrite_parents = 1;
> +		rev->graph = graph_init(rev);

In any case, it probably makes sense to encapsulate these three
lines in a small helper function "when --graph is asked for on a
rev, call this function" in the PREVIOUS step of the series, and
change this patch to read more like

	if (default_graph &&
	    /* check for incompatible options */
	    !rev->track_linear && !rev->reverse && ...)
		rev_add_graph_option(rev);

Most importantly, the helper should be one that handles "wow, we see
that rev->graph is already populated, what should we do?", and not
this caller.  And that helper can be called unconditionally by the
command line parser when it finds !strcmp(arg, "--graph") yields
true.

Thanks.
