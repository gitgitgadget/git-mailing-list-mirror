Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 148A11F463
	for <e@80x24.org>; Mon, 30 Sep 2019 01:22:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729291AbfI3BWu (ORCPT <rfc822;e@80x24.org>);
        Sun, 29 Sep 2019 21:22:50 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:53550 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726360AbfI3BWt (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 29 Sep 2019 21:22:49 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 58FAE9C98E;
        Sun, 29 Sep 2019 21:22:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=FFTmQYaVM0f+Pidaa77nRt0wHg4=; b=kGz+zr
        H0DCn2q0elehQ5/2CBTueFG4rHr2K3y4vd1XVt7Ihe2GtZaoOazsnAJJcQmOpx7V
        xmLO+pUHZQnaqzquhYswyxg5Jo8BDmyL9yh5LtzVp1CNVMYtiZIbVygZIE1ulBT/
        RogpsfzBXjwSDVPVL49ZXRRW+ybFR+iXAeZAU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=cxZvFsMgOi4UGi66saTvG0y3A0uKot6x
        FQzv0il8rnhN9nBxOhe9NVohM/1Gd0E5/Aj5UWI5yBYtdXCkxb4xAceeGNqNfEaP
        P5QJTyvmOgPSj8dwcFTtbaXdGrlFvYWkVOBWP2Uk2QtEukuNXCInDQiL3swVdtMO
        yNT241AX6sM=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 50B849C98D;
        Sun, 29 Sep 2019 21:22:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 7C0379C98B;
        Sun, 29 Sep 2019 21:22:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Alex Henrie <alexhenrie24@gmail.com>
Cc:     git@vger.kernel.org, dstolee@microsoft.com,
        Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v3] commit-graph: remove a duplicate assignment
References: <20190929005558.733699-1-alexhenrie24@gmail.com>
Date:   Mon, 30 Sep 2019 10:22:44 +0900
In-Reply-To: <20190929005558.733699-1-alexhenrie24@gmail.com> (Alex Henrie's
        message of "Sat, 28 Sep 2019 18:55:58 -0600")
Message-ID: <xmqqimpainmj.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: CF24A8F6-E320-11E9-8212-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Alex Henrie <alexhenrie24@gmail.com> writes:

> The variable g was being set to the same value both at the beginning of
> the function and before the loop. The assignment before the loop was
> kept because it helps clarify what the loop does, and the redundant
> assignment at the beginning of the function was removed.

Writing these mostly in the past tense is misleading to those who
are used to read "git log" from this project.  Give orders to the
codebase to "become like so" instead.  Perhaps like

	Leave the variable 'g' uninitialized before it is set just
	before its first use in front of a loop, which is a lot more
	appropriate place to indicate what it is used for.

>  static void split_graph_merge_strategy(struct write_commit_graph_context *ctx)
>  {
> -	struct commit_graph *g = ctx->r->objects->commit_graph;
> +	struct commit_graph *g;
>  	uint32_t num_commits = ctx->commits.nr;

Stepping back a bit, doesn't the same justification you gave to this
change apply to 'num_commits'?  If you make it uninitialized before
its first use and assign ctx->commits.nr to it near where 'g' is
given its first value, wouldn't it make it even clearer that these
two variables are almost always used together and how they are used
in the loop?

