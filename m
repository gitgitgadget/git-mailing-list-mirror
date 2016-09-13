Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5024120984
	for <e@80x24.org>; Tue, 13 Sep 2016 23:26:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1759540AbcIMXZz (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Sep 2016 19:25:55 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59100 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1754521AbcIMXZw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Sep 2016 19:25:52 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 425933C964;
        Tue, 13 Sep 2016 19:25:51 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=5QvJkbYevcct
        sfXaL8r9VPxebXQ=; b=r7p4TEwbTJnALeTvA5/7T4wTgrtGmpqyX0nb39Y+wOtW
        dm1xHFMw5AiUzJqmO3Dk+ImRsT4fzEeu5mh8XgKG8bix0r6yhxewCzPChmSymmkT
        JXJ8wjn50/yaGQN5vkGErMuTQ89nbYzoQeuJa6UGezXtSrWBohx+NJTBmQE4DHs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=YK7iml
        nAMktkABlOLHXLDbRouwOscQMKmvL3t7C7aqOhIXM3pJVNnzwleBZlqcEVuw87Az
        mJxuBNKwrh0KdFnLHmEVgeXp/XpuBfxeRYe5jLQbJb4uJZSGCOOA3Q45ugypqJep
        dqS4Xy09tTnKWLcm5HDWfZM/lkXDvvVS1LKDY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3B4963C963;
        Tue, 13 Sep 2016 19:25:51 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id A9DCE3C962;
        Tue, 13 Sep 2016 19:25:49 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Git List <git@vger.kernel.org>
Subject: Re: [PATCH] unpack-trees: pass checkout state explicitly to check_updates()
References: <b57982ca-d508-5016-a187-fc3b829f9b0c@web.de>
Date:   Tue, 13 Sep 2016 16:25:47 -0700
In-Reply-To: <b57982ca-d508-5016-a187-fc3b829f9b0c@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
        message of "Tue, 13 Sep 2016 19:37:06 +0200")
Message-ID: <xmqqa8fbtm9w.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 67DB3C7E-7A09-11E6-B372-51057B1B28F4-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ren=C3=A9 Scharfe <l.s.r@web.de> writes:

> Add a parameter for the struct checkout variable to check_updates()
> instead of using a static global variable.  Passing it explicitly makes
> object ownership and usage more easily apparent.  And we get rid of a
> static variable; those can be problematic in library-like code.
> ...
> diff --git a/unpack-trees.c b/unpack-trees.c
> index 11c37fb..74d6dd4 100644
> --- a/unpack-trees.c
> +++ b/unpack-trees.c
> @@ -218,8 +218,8 @@ static void unlink_entry(const struct cache_entry *=
ce)
>  	schedule_dir_for_removal(ce->name, ce_namelen(ce));
>  }
> =20
> -static struct checkout state;

> ...
> @@ -1094,6 +1094,7 @@ int unpack_trees(unsigned len, struct tree_desc *=
t, struct unpack_trees_options
>  	int i, ret;
>  	static struct cache_entry *dfc;
>  	struct exclude_list el;
> +	struct checkout state;

Does the distinction between this thing in BSS implicitly cleared
and the new one on stack that does not seem to have any
initialization matter?

	... goes and looks ...

OK, after this hunk we clear and set up everything in state, so
there is no difference in behaviour.  Just we got rid of an
unnecessary file-scope global.

Nice.  Thanks.
 =20
>  	if (len > MAX_UNPACK_TREES)
>  		die("unpack_trees takes at most %d trees", MAX_UNPACK_TREES);
> @@ -1239,7 +1240,7 @@ int unpack_trees(unsigned len, struct tree_desc *=
t, struct unpack_trees_options
>  	}
> =20
>  	o->src_index =3D NULL;
> -	ret =3D check_updates(o) ? (-2) : 0;
> +	ret =3D check_updates(o, &state) ? (-2) : 0;
>  	if (o->dst_index) {
>  		if (!ret) {
>  			if (!o->result.cache_tree)
