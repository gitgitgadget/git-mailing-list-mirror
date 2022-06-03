Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B3E1C433EF
	for <git@archiver.kernel.org>; Fri,  3 Jun 2022 17:39:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344607AbiFCRj5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Jun 2022 13:39:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344561AbiFCRj4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Jun 2022 13:39:56 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75BBA532EB
        for <git@vger.kernel.org>; Fri,  3 Jun 2022 10:39:54 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D165112E91D;
        Fri,  3 Jun 2022 13:39:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=yhrxLbOEA0hw1onCWpYdTvHIt1kof1iTpefBKu
        dGcPo=; b=mrJigp6HNVIvLnCmpyiQlbPJoe7XnDPlzrRAO1lCJ3mIKrtiudQSDN
        ZvMp60Xv+NiJx+9v9R0vNzY04+TXIp8vpTXeFQYAt1I0AmqdksJKSq3xNch3+uOO
        KA7L+Q5fx/b/KtYjbTnqHv6sVKz+N9vRs6N5ioGkSG55wNn7Tb/Oo=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C313112E91C;
        Fri,  3 Jun 2022 13:39:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 31FE412E91B;
        Fri,  3 Jun 2022 13:39:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, johannes.schindelin@gmx.de, me@ttaylorr.com,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH 1/4] log-tree: create for_each_decoration()
References: <pull.1247.git.1654263472.gitgitgadget@gmail.com>
        <4f9f34876413927d819313a70fcdefcad5b35689.1654263472.git.gitgitgadget@gmail.com>
Date:   Fri, 03 Jun 2022 10:39:52 -0700
In-Reply-To: <4f9f34876413927d819313a70fcdefcad5b35689.1654263472.git.gitgitgadget@gmail.com>
        (Derrick Stolee via GitGitGadget's message of "Fri, 03 Jun 2022
        13:37:49 +0000")
Message-ID: <xmqqa6athcif.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2CF66C80-E364-11EC-9E64-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

>  	const struct name_decoration *decoration;
> +	struct format_decorations_context ctx = {
> +		.sb = sb,
> +		.use_color = use_color,
> +		.prefix = prefix,
> +		.separator = separator,
> +		.suffix = suffix,
> +		.color_commit =	diff_get_color(use_color, DIFF_COMMIT),
> +		.color_reset = decorate_get_color(use_color, DECORATION_NONE),
> +	};
>  
>  	decoration = get_name_decoration(&commit->object);
>  	if (!decoration)
>  		return;
>  
> +	ctx.current_and_HEAD = current_pointed_by_HEAD(decoration);
>  
> +	for_each_decoration(commit, append_decoration, &ctx);

The function for_each_decoration() that does not take decoration but
a commit felt iffy, especially because we already have called
get_name_decoration() to obtain one for commit, and the API forces
us to do that again at the beginning of for_each_decoration().

> +	strbuf_addstr(sb, ctx.color_commit);
> +	strbuf_addstr(sb, ctx.suffix);
> +	strbuf_addstr(sb, ctx.color_reset);
> +}
> +
> +int for_each_decoration(const struct commit *c, decoration_fn fn, void *data)
> +{
> +	const struct name_decoration *decoration;
> +
> +	decoration = get_name_decoration(&c->object);
> +	while (decoration) {
> +		int res;
> +		if ((res = fn(decoration, data)))
> +			return res;
>  		decoration = decoration->next;
>  	}
> +
> +	return 0;
>  }

We'll know if this small waste is worth it when we see the new
caller(s), I guess, but even if they start from commit, allowing
them the same early return trick would require this piece of code:

	decoration = get_name_decoration(&commit->object);
	if (!decoration)
		return;

in them, and even if they do not need it, it would be trivial for
them to say

	for_each_decoration(get_name_decoration(&commit->object),
        		    do_whatever_they_need_to_do, &ctx);

so, we may want to revisit this after we finish reading the series
through.  Making the iterator take name_decoration does not look
too bad.

>  void show_decorations(struct rev_info *opt, struct commit *commit)
> diff --git a/log-tree.h b/log-tree.h
> index e7e4641cf83..ea07da2625b 100644
> --- a/log-tree.h
> +++ b/log-tree.h
> @@ -35,4 +35,8 @@ void fmt_output_commit(struct strbuf *, struct commit *, struct rev_info *);
>  void fmt_output_subject(struct strbuf *, const char *subject, struct rev_info *);
>  void fmt_output_email_subject(struct strbuf *, struct rev_info *);
>  
> +typedef int decoration_fn(const struct name_decoration *d,
> +			  void *data);
> +int for_each_decoration(const struct commit *c, decoration_fn fn, void *data);
> +
>  #endif
