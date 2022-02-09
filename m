Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C65C5C433F5
	for <git@archiver.kernel.org>; Wed,  9 Feb 2022 18:19:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239442AbiBISS5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Feb 2022 13:18:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239222AbiBISSr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Feb 2022 13:18:47 -0500
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E441C02B666
        for <git@vger.kernel.org>; Wed,  9 Feb 2022 10:17:08 -0800 (PST)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 99B0EFCB49;
        Wed,  9 Feb 2022 13:16:06 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Bmjx9ZtNeO47+xsNzW9EOSmsPzGeAUvaI3Bsv6
        Z6V0A=; b=LnxK69xJ4bOiTVTRRylyygIfuTs10toj//iiaEEw3fXn5DSR2ZhvG8
        KseCWkVt3uwufWvaXGGC3ACwpJds1IYMPi3djX6zMidHjKA1Ib377vAXW50hsXYJ
        OLkq5m2/ECGaymvlWQkw6/BDkAZplK+882OKgvucakWXZtlssHzN0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8D48CFCB47;
        Wed,  9 Feb 2022 13:16:06 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.185.212.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id D0FFBFCB3E;
        Wed,  9 Feb 2022 13:16:05 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Alex Henrie <alexhenrie24@gmail.com>
Cc:     git@vger.kernel.org, paulus@ozlabs.org
Subject: Re: [PATCH 1/3] log: fix memory leak if --graph is passed multiple
 times
References: <20220209162350.169971-1-alexhenrie24@gmail.com>
Date:   Wed, 09 Feb 2022 10:16:04 -0800
In-Reply-To: <20220209162350.169971-1-alexhenrie24@gmail.com> (Alex Henrie's
        message of "Wed, 9 Feb 2022 09:23:47 -0700")
Message-ID: <xmqqh7979a8r.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 58E2006E-89D4-11EC-9462-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Alex Henrie <alexhenrie24@gmail.com> writes:

> Signed-off-by: Alex Henrie <alexhenrie24@gmail.com>
> ---
>  revision.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/revision.c b/revision.c
> index ad4286fbdd..c03c387edd 100644
> --- a/revision.c
> +++ b/revision.c
> @@ -2424,9 +2424,11 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
>  		revs->pretty_given = 1;
>  		revs->abbrev_commit = 1;
>  	} else if (!strcmp(arg, "--graph")) {
> -		revs->topo_order = 1;
> -		revs->rewrite_parents = 1;
> -		revs->graph = graph_init(revs);
> +		if (!revs->graph) {
> +			revs->topo_order = 1;
> +			revs->rewrite_parents = 1;
> +			revs->graph = graph_init(revs);
> +		}

I understand the refs->graph part but are there ways to turn off
topo_order or rewrite_parents with _other_ options?  I.e.

    git log --graph --another-option --graph

if --another-option flips either bits off, would make the graph
code misbehave because it requires both of these bits set.

I think this is safe in the corrent code, simply because there do
not seem to be a way to unset these bits once they are set, but
I am not sure if that is something we want to rely on.

I think an ideal endgame should look more like

	} else if (!strcmp(arg, "--graph")) {
		revs->topo_order = 1;
		revs->rewrite_parents = 1;
+		graph_clear(revs->graph);
		revs->graph = graph_init(revs);

where graph_clear() is to release the resource held by the git_graph
struct that was previously prepared (and possibly used), and becomes
a no-op when given NULL (just like free(NULL) is OK).

But if we want to punt on introducing graph_clear(), perhaps

	} else if (!strcmp(arg, "--graph")) {
		revs->topo_order = 1;
		revs->rewrite_parents = 1;
		if (!revs->graph)
			revs->graph = graph_init(revs);

would be closer to the ideal endgame (and have an in-code comment to
hint future developers that (1) we are aware that this is not ideal,
and that (2) the right way is to clear the previously allocated one
before doing another init).

Thanks.

>  	} else if (!strcmp(arg, "--encode-email-headers")) {
>  		revs->encode_email_headers = 1;
>  	} else if (!strcmp(arg, "--no-encode-email-headers")) {
