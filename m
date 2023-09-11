Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F223ECA0EC3
	for <git@archiver.kernel.org>; Tue, 12 Sep 2023 01:41:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235317AbjILBlU (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 Sep 2023 21:41:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235746AbjILBlG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Sep 2023 21:41:06 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06544A3D7F
        for <git@vger.kernel.org>; Mon, 11 Sep 2023 18:18:15 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id BC77B1AC823;
        Mon, 11 Sep 2023 19:12:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=hduVY2T+jMKQnlaMuDdWSC4AfDXDzGL9QB/8op
        5dhjg=; b=yRppXd00SR3PNVinPOychiempUcXOCURXbqFvpvm5zWDyHjCM8b7OO
        599fhU/d4OxyjSlMOPvLsl4n9Agty7YMJCgS6Y8p8c+kJ31UNx+bZ1mwHwpKRj/5
        uE9PRypXdhqZTGvoDRGMPIUrpjJ4eTv8niwCd+L2ps8SFize1KQhw=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B2BB81AC822;
        Mon, 11 Sep 2023 19:12:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D6B601AC821;
        Mon, 11 Sep 2023 19:12:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Dragan Simic <dsimic@manjaro.org>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] diff --stat: add config option to limit filename width
In-Reply-To: <87badb12f040d1c66cd9b89074d3de5015a45983.1694446743.git.dsimic@manjaro.org>
        (Dragan Simic's message of "Mon, 11 Sep 2023 17:39:44 +0200")
References: <87badb12f040d1c66cd9b89074d3de5015a45983.1694446743.git.dsimic@manjaro.org>
Date:   Mon, 11 Sep 2023 16:12:31 -0700
Message-ID: <xmqqil8gs3s0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: AFF07844-50F8-11EE-9A90-78DCEB2EC81B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dragan Simic <dsimic@manjaro.org> writes:

> Add new configuration option diff.statNameWidth=<width> that is equivalent
> to the command-line option --stat-name-width=<width>, but it is ignored
> by format-patch.  This follows the logic established by the already
> existing configuration option diff.statGraphWidth=<width>.
>
> Limiting the widths of names and graphs in the --stat output makes sense
> for interactive work on wide terminals with many columns, hence the support
> for these configuration options.  They don't affect format-patch because
> it already adheres to the traditional 80-column standard.
>
> Update the documentation and add more tests to cover new configuration
> option diff.statNameWidth=<width>.  While there, perform a few minor code
> and whitespace cleanups here and there, as spotted.
>
> Signed-off-by: Dragan Simic <dsimic@manjaro.org>
> ---

The stat lines have <width> (the entire display width),
<graph-width> (what appears after '|') and <name-width> (what
appears before '|'), so I would worry about letting users specify
all three to contradictory values, if there weren't an existing
command line option already.  But of course there already is a
command line option, so somebody more clever than me must have
thought about how to deal with such an impossible settings, and
adding a configuration variable to specify the same impossible
settings to the system would not make things worse.

>  Documentation/config/diff.txt  |  4 ++++
>  Documentation/diff-options.txt | 17 +++++++-------
>  builtin/diff.c                 |  1 +
>  builtin/log.c                  |  1 +
>  builtin/merge.c                |  1 +
>  builtin/rebase.c               |  1 +

Someday, as a follow-up after the dust from this topic settles, we
would probably want to look at how these rev.diffopt.* members are
initialized and refactor the common code out to a helper.  It would
allow us to instead of doing this ...

>  	/* Set up defaults that will apply to both no-index and regular diffs. */
>  	rev.diffopt.stat_width = -1;
> +	rev.diffopt.stat_name_width = -1;
>  	rev.diffopt.stat_graph_width = -1;
>  	rev.diffopt.flags.allow_external = 1;
>  	rev.diffopt.flags.allow_textconv = 1;

... in many places, do so in a single place in the helper function,
and these places will just call the helper:

	std_graph_options(&rev.diffopt);

I do not know offhand if "stat graph options related members" is a
good line to draw, or there are other things that are common outside
these .stat_foo members.  If the latter and the helper function will
initialize the members other than the stat-graph settings, its name
obviously needs a bit more thought, but you get the idae.

Thanks.
