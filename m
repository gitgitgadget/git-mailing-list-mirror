Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD245C433EF
	for <git@archiver.kernel.org>; Fri, 25 Feb 2022 19:13:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234308AbiBYTNc (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Feb 2022 14:13:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234296AbiBYTN3 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Feb 2022 14:13:29 -0500
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EE011B84D6
        for <git@vger.kernel.org>; Fri, 25 Feb 2022 11:12:57 -0800 (PST)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 69B8E116D63;
        Fri, 25 Feb 2022 14:12:56 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Xx4Qjl7RsnPBQ8E5pfUJlcnjTrnUMpXSv/HsVx
        PyBPE=; b=N1BlhRAn5mRrcHGfeS25MRlvyWRkOhMVpp3xfsf7JnM7gpJvfOi8iB
        Beb90rPk4mhb+AcLIg3nx+7gZ7VB/m551Ws0bzHkqiJY+UoFf3vmA5gp+qzXLRNl
        jaK3rqpU2ZiDKwJTGYWe2tTerqOZkLASzG9iOCklJW7iWw6RmoGNk=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 60A4D116D62;
        Fri, 25 Feb 2022 14:12:56 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id BF821116D61;
        Fri, 25 Feb 2022 14:12:55 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Tao Klerks via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Tao Klerks <tao@klerks.biz>
Subject: Re: [PATCH v2 3/3] untracked-cache: write index when populating
 empty untracked cache
References: <pull.986.git.1624559401.gitgitgadget@gmail.com>
        <pull.986.v2.git.1645809015.gitgitgadget@gmail.com>
        <190b27e518a22e2253b318e8087446d761e918b2.1645809015.git.gitgitgadget@gmail.com>
Date:   Fri, 25 Feb 2022 11:12:54 -0800
In-Reply-To: <190b27e518a22e2253b318e8087446d761e918b2.1645809015.git.gitgitgadget@gmail.com>
        (Tao Klerks via GitGitGadget's message of "Fri, 25 Feb 2022 17:10:14
        +0000")
Message-ID: <xmqqmtiebw09.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: EFF4ECCC-966E-11EC-8AE9-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Tao Klerks via GitGitGadget" <gitgitgadget@gmail.com> writes:

> diff --git a/dir.c b/dir.c
> index d91295f2bcd..4eee45dec91 100644
> --- a/dir.c
> +++ b/dir.c
> @@ -2781,7 +2781,8 @@ void remove_untracked_cache(struct index_state *istate)
>  
>  static struct untracked_cache_dir *validate_untracked_cache(struct dir_struct *dir,
>  						      int base_len,
> -						      const struct pathspec *pathspec)
> +						      const struct pathspec *pathspec,
> +						      struct index_state *istate)
>  {
>  	struct untracked_cache_dir *root;
>  	static int untracked_cache_disabled = -1;
> @@ -2845,8 +2846,11 @@ static struct untracked_cache_dir *validate_untracked_cache(struct dir_struct *d
>  		return NULL;
>  	}
>  
> -	if (!dir->untracked->root)
> +	if (!dir->untracked->root) {
> +		/* Untracked cache existed but is not initialized; fix that */
>  		FLEX_ALLOC_STR(dir->untracked->root, name, "");
> +		istate->cache_changed |= UNTRACKED_CHANGED;
> +	}
>  
>  	/* Validate $GIT_DIR/info/exclude and core.excludesfile */
>  	root = dir->untracked->root;
> @@ -2916,7 +2920,7 @@ int read_directory(struct dir_struct *dir, struct index_state *istate,
>  		return dir->nr;
>  	}
>  
> -	untracked = validate_untracked_cache(dir, len, pathspec);
> +	untracked = validate_untracked_cache(dir, len, pathspec, istate);
>  	if (!untracked)
>  		/*
>  		 * make sure untracked cache code path is disabled,

Makes sense.  Will queue.  Thanks.
