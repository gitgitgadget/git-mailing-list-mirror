Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 480A8C433EF
	for <git@archiver.kernel.org>; Thu, 16 Jun 2022 04:36:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348870AbiFPEgt (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Jun 2022 00:36:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242923AbiFPEgs (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Jun 2022 00:36:48 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 799D35AA40
        for <git@vger.kernel.org>; Wed, 15 Jun 2022 21:36:47 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C7C95124411;
        Thu, 16 Jun 2022 00:36:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=yzZ+TcsLMgvYpzgcPOywodhfkh0MFFITQCWAZF
        gnlbQ=; b=iQwyWcA6DuOaddQls4t7xJNiND5muKq2UXrVrw62iVAZ8/vZo6iPgC
        xo4TJnGWIY7OztJMfbMc3zRLHsR6I3/EQ68tnbObzAgSML2gHCD5JpAjCPtUzNEa
        sLJ42Bdm99N46viCydaZMpXj+98uxqC7U/ZZ+bq4DPpZyOnssBsj8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id BED47124410;
        Thu, 16 Jun 2022 00:36:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 34D4312440F;
        Thu, 16 Jun 2022 00:36:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 05/11] submodule-config: avoid memory leak
References: <pull.1264.git.1655336146.gitgitgadget@gmail.com>
        <591166e07d87fdb5efc2769d3e2963e3f0412720.1655336146.git.gitgitgadget@gmail.com>
Date:   Wed, 15 Jun 2022 21:36:45 -0700
In-Reply-To: <591166e07d87fdb5efc2769d3e2963e3f0412720.1655336146.git.gitgitgadget@gmail.com>
        (Johannes Schindelin via GitGitGadget's message of "Wed, 15 Jun 2022
        23:35:39 +0000")
Message-ID: <xmqqmtedw7fm.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: EDE7FB84-ED2D-11EC-8796-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> In 961b130d20c9 (branch: add --recurse-submodules option for branch
> creation, 2022-01-28), a funny pattern was introduced where first some
> struct is `xmalloc()`ed, then we resize an array whose element type is
> the same struct, and then the first struct's contents are copied into
> the last element of that array.

Sigh.  The original is butt ugly, with this strange pattern and
structure assignments etc.  I wonder how something like this slipped
through our reviews.

I wonder if it would help for me to stop trusting reviews by less
experienced reviewers too much, and instead give sanity checks to
more patches myself from now on, but I certainly cannot afford the
time and my mental health to do so for all the patches X-<.

Will queue.

>  		if (S_ISGITLINK(name_entry->mode) &&
>  		    is_tree_submodule_active(r, root_tree, tree_path)) {
> -			st_entry = xmalloc(sizeof(*st_entry));
> +			ALLOC_GROW(out->entries, out->entry_nr + 1,
> +				   out->entry_alloc);
> +			st_entry = &out->entries[out->entry_nr++];
> +
>  			st_entry->name_entry = xmalloc(sizeof(*st_entry->name_entry));
>  			*st_entry->name_entry = *name_entry;
>  			st_entry->submodule =
> @@ -766,9 +769,6 @@ static void traverse_tree_submodules(struct repository *r,
>  						root_tree))
>  				FREE_AND_NULL(st_entry->repo);
>  
> -			ALLOC_GROW(out->entries, out->entry_nr + 1,
> -				   out->entry_alloc);
> -			out->entries[out->entry_nr++] = *st_entry;
>  		} else if (S_ISDIR(name_entry->mode))
>  			traverse_tree_submodules(r, root_tree, tree_path,
>  						 &name_entry->oid, out);
