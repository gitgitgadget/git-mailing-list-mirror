Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD15FECAAA1
	for <git@archiver.kernel.org>; Thu, 15 Sep 2022 20:41:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229561AbiIOUl2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Sep 2022 16:41:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbiIOUl0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Sep 2022 16:41:26 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94031901BE
        for <git@vger.kernel.org>; Thu, 15 Sep 2022 13:41:24 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 6F6181BA256;
        Thu, 15 Sep 2022 16:41:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=IozVWiuzC8J8FrLC6ErFbZmziPexo8H++QaxlF
        yuAKk=; b=Hn+2SdMMoly/t9T88KLKAHYMcjrAnYaLOjCJt7uMAzdtQo1DSuSY6y
        MlWY84aF4X17MeeJB+qOyQYd4y+M6kMuJldYvFeP8TZuXiaJov32ByPpHigmy+93
        w+VX8V3f4rOkYMxxl9IM8CECP9CU18mfOUJKcqMqJgEdnFsDt3zJE=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 64A9B1BA255;
        Thu, 15 Sep 2022 16:41:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id DF7EE1BA254;
        Thu, 15 Sep 2022 16:41:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Sergey Organov <sorganov@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 2/3] diff-merges: cleanup set_diff_merges()
References: <20220914193102.5275-1-sorganov@gmail.com>
        <20220914193102.5275-3-sorganov@gmail.com>
Date:   Thu, 15 Sep 2022 13:41:17 -0700
In-Reply-To: <20220914193102.5275-3-sorganov@gmail.com> (Sergey Organov's
        message of "Wed, 14 Sep 2022 22:31:01 +0300")
Message-ID: <xmqq35csmkuq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C04F8E8E-3536-11ED-B895-C2DA088D43B2-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sergey Organov <sorganov@gmail.com> writes:

> Get rid of special-casing of 'suppress' in set_diff_merges(). Instead
> set 'merges_need_diff' flag correctly in every option handling
> function.
>
> Signed-off-by: Sergey Organov <sorganov@gmail.com>
> ---
>  diff-merges.c | 30 +++++++++++++++++++-----------
>  1 file changed, 19 insertions(+), 11 deletions(-)

Looks OK to me.

Everybody else says set_X() but set_none() has nothing to do ther
than calling suppress(), so the change does not really make a
functional difference (as you said in the cover letter).

Is the idea that the original value in .merges_need_diff member does
not matter because in every case it is set to either 0 or 1?  Most
cases call common_setup() to set it to 1 like this here...

> +static void common_setup(struct rev_info *revs)
> +{
> +	suppress(revs);
> +	revs->merges_need_diff = 1;
> +}

... but this does not touch (in other words, it does not explicitly
clear) it, ...

> +static void set_none(struct rev_info *revs)
> +{
> +	suppress(revs);
> +}

 ... so we still rely on somebody to set the .merges_need_diff
to 0 initially, right?

> -
> -	/* NOTE: the merges_need_diff flag is cleared by func() call */
> -	if (func != suppress)
> -		revs->merges_need_diff = 1;
>  }

It is very good to see this one go.

>  /*
> @@ -115,6 +122,7 @@ int diff_merges_parse_opts(struct rev_info *revs, const char **argv)
>  
>  	if (!suppress_m_parsing && !strcmp(arg, "-m")) {
>  		set_to_default(revs);
> +		revs->merges_need_diff = 0;

I am wondering how this becomes necessary?  Is it because
set_to_default() would flip the member to 1 unconditionally, or
something?  If it weren't for this hunk, the lossage of the previous
hunk is a very good clean-up, but if we need to do this, I cannot
shake the feeling that we mostly shifted the dirt around, without
really cleaning it?  I dunno.

> @@ -125,7 +133,7 @@ int diff_merges_parse_opts(struct rev_info *revs, const char **argv)
>  		set_remerge_diff(revs);
>  		revs->merges_imply_patch = 1;
>  	} else if (!strcmp(arg, "--no-diff-merges")) {
> -		suppress(revs);
> +		set_none(revs);

We do not need to explicitly set .merges_need_diff to 0 here,
presumably because it is initialized to 0 and nobody touched it,
right?

>  	} else if (!strcmp(arg, "--combined-all-paths")) {
>  		revs->combined_all_paths = 1;
>  	} else if ((argcount = parse_long_opt("diff-merges", argv, &optarg))) {
> @@ -139,7 +147,7 @@ int diff_merges_parse_opts(struct rev_info *revs, const char **argv)
>  
>  void diff_merges_suppress(struct rev_info *revs)
>  {
> -	suppress(revs);
> +	set_none(revs);
>  }
>  
>  void diff_merges_default_to_first_parent(struct rev_info *revs)
