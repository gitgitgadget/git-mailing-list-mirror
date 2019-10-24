Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CC9781F4C0
	for <e@80x24.org>; Thu, 24 Oct 2019 03:52:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390377AbfJXDwF (ORCPT <rfc822;e@80x24.org>);
        Wed, 23 Oct 2019 23:52:05 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:50862 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392449AbfJXDwF (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Oct 2019 23:52:05 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 95B759647B;
        Wed, 23 Oct 2019 23:52:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=/PwaorfXU1e9C7g2ZBfcE1Czrdo=; b=sdvWIc
        YT7JudVxdPmOdGZEb9kPKpREa1ZG9//v7Cd/t/+7IOz3459rJOulVQQioGOZQ9St
        E5G3e4ETFmCDQh0x5wlUFGdRAF175x9l+3Eyd4l9SrtMWFHMOr6m+1wbOUafVuZY
        ARqiMI9BXL+oOqTVuTGpj5/tP7akE5h354Uhs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=tK8VQj6vktteDrBWPQor0MwCJpotvQUH
        KlBsESSxrzX+MiSLjfrDMGE+ra/zpXi/b1izWF3wuq9VsxHnJNDdA9C4jBiVFyU+
        ajOCxXcz8N+Hvut97JKxjyjVw8Rwquwm/s5UY5cPVQZxEuDoRiXM5PFAKDxnKZa8
        qnRJV/Nn7Cg=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 8E9189647A;
        Wed, 23 Oct 2019 23:52:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id B6C2396477;
        Wed, 23 Oct 2019 23:52:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 04/23] remember commit/tag parse failures
References: <20191018044103.GA17625@sigill.intra.peff.net>
        <20191018044721.GD17879@sigill.intra.peff.net>
Date:   Thu, 24 Oct 2019 12:51:58 +0900
In-Reply-To: <20191018044721.GD17879@sigill.intra.peff.net> (Jeff King's
        message of "Fri, 18 Oct 2019 00:47:21 -0400")
Message-ID: <xmqqwocug5r5.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A232C414-F611-11E9-89AB-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> ...
> a separate check for a NULL tree. In fact, we can now ditch that
> explicit tree check entirely, as we're covered robustly by this change
> (and the previous recent change to treat a NULL tree as a parse error).
> ...
> @@ -855,9 +855,6 @@ static void write_graph_chunk_data(struct hashfile *f, int hash_len,
>  			die(_("unable to parse commit %s"),
>  				oid_to_hex(&(*list)->object.oid));
>  		tree = get_commit_tree_oid(*list);
> -		if (!tree)
> -			die(_("unable to get tree for %s"),
> -				oid_to_hex(&(*list)->object.oid));

The context before this hunk is to die when parse_commit(*list)
fails, and because a successful parse_commit() will always set a
non-NULL tree now, the null-ness check on its tree becomes unneeded,
which makes sense.

