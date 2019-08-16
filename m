Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CA07F1F45A
	for <e@80x24.org>; Fri, 16 Aug 2019 19:52:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727569AbfHPTwL (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Aug 2019 15:52:11 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52050 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726527AbfHPTwL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Aug 2019 15:52:11 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4BA7A176EF9;
        Fri, 16 Aug 2019 15:52:09 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=eeIxSVoWPeVEfKrQShP2YDMpi94=; b=hlUyFl
        oZljejPJXllKOyeH70u/qX/D/aR31UGJHVuRSRDfkLdnc9Fr71WmA7qLdj2iZQjd
        NhjLpVSz8adYIndfJJHahX24Ma6NwFVHbLqvVlEKxxz+Lp/ytXdc9J3KWN/OVJra
        2Y9/VZ3pv9OBF9ZkQCRNbvOqbOVLS+E207+Ew=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=s46pbRTBFXLof+DBR8KgZ5KpT3aHdevF
        bP4+wZFjmvQkVVvjdByR4qHF3Ir5Q5v7YYCRToVvbDAD2q8s6nAIzlxo+EYBBCY9
        h6iOUNDHxEb90KJ2Spz4yAJw3fFcXo+DQxYmZzNIjMvBK91AaQgc028D5D/fLeZq
        AyMEfIFXT78=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4294A176EF8;
        Fri, 16 Aug 2019 15:52:09 -0400 (EDT)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A8581176EF7;
        Fri, 16 Aug 2019 15:52:08 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v3 23/24] merge-recursive: add sanity checks for relevant merge_options
References: <20190726155258.28561-1-newren@gmail.com>
        <20190815214053.16594-1-newren@gmail.com>
        <20190815214053.16594-24-newren@gmail.com>
Date:   Fri, 16 Aug 2019 12:52:07 -0700
In-Reply-To: <20190815214053.16594-24-newren@gmail.com> (Elijah Newren's
        message of "Thu, 15 Aug 2019 14:40:52 -0700")
Message-ID: <xmqqd0h428ig.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 54B4B8A6-C05F-11E9-9729-46F8B7964D18-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> There are lots of options that callers can set, yet most have a limited
> range of valid values, some options are meant for output (e.g.
> opt->obuf, which is expected to start empty), and callers are expected
> to not set opt->priv.  Add several sanity checks to ensure callers
> provide sane values.
> ...

The change to the struct does not seem to have much with the above
rationale.

> diff --git a/merge-recursive.h b/merge-recursive.h
> index 978847e672..d201ee80fb 100644
> --- a/merge-recursive.h
> +++ b/merge-recursive.h
> @@ -27,7 +27,7 @@ struct merge_options {
>  	} detect_directory_renames;
>  	int rename_limit;
>  	int rename_score;
> -	int show_rename_progress;
> +	int show_rename_progress : 1;

And a one-bit wide bitfield that is signed is always an iffy idea.

>  
>  	/* xdiff-related options (patience, ignore whitespace, ours/theirs) */
>  	long xdl_opts;
