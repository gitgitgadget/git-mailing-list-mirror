Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72F9AC433EF
	for <git@archiver.kernel.org>; Fri,  4 Mar 2022 22:15:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229876AbiCDWQ2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Mar 2022 17:16:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbiCDWQ1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Mar 2022 17:16:27 -0500
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C378F65FC
        for <git@vger.kernel.org>; Fri,  4 Mar 2022 14:15:38 -0800 (PST)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7384B11243B;
        Fri,  4 Mar 2022 17:15:37 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=BksDZWkwP3fCFj4tE7DeZxX65ZE6PRWq5rZiIA
        dbke4=; b=vUrNvnCqErWFD5zDzH0T7RZVxNRtHLghyhpC3PQVt21iKn9vQUY0AX
        R+Mc7yvwqsuecU3qMud5Bvt9VDBfnXxPY7xvcSnHkY8VKZ1ze01N7emcGTSSkHlI
        IT2ofc8I/9gLx2l8+RB2hnQzKjTmS82xXqaSwjvts+LTDvva9ofNU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6B0DD11243A;
        Fri,  4 Mar 2022 17:15:37 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.230.65.123])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id D0977112439;
        Fri,  4 Mar 2022 17:15:36 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, stolee@gmail.com, avarab@gmail.com,
        zhiyou.jx@alibaba-inc.com, jonathantanmy@google.com,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH 02/11] revision: put object filter into struct rev_info
References: <pull.1159.git.1645638911.gitgitgadget@gmail.com>
        <3a88c99d9bc765bf4728fe0f0df1eed86adace0e.1645638911.git.gitgitgadget@gmail.com>
Date:   Fri, 04 Mar 2022 14:15:35 -0800
In-Reply-To: <3a88c99d9bc765bf4728fe0f0df1eed86adace0e.1645638911.git.gitgitgadget@gmail.com>
        (Derrick Stolee via GitGitGadget's message of "Wed, 23 Feb 2022
        17:55:02 +0000")
Message-ID: <xmqqk0d9z7nc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9E278F36-9C08-11EC-9E92-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

>  static int try_bitmap_count(struct rev_info *revs,
> -			    struct list_objects_filter_options *filter,
>  			    int filter_provided_objects)

This makes quite a lot of sense as filter is now available as
revs->filter.

>  {
>  	uint32_t commit_count = 0,
> @@ -436,7 +434,8 @@ static int try_bitmap_count(struct rev_info *revs,
>  	 */
>  	max_count = revs->max_count;
>  
> -	bitmap_git = prepare_bitmap_walk(revs, filter, filter_provided_objects);
> +	bitmap_git = prepare_bitmap_walk(revs, revs->filter,
> +					 filter_provided_objects);

And we should be able to do the same to prepare_bitmap_walk().  It
is OK if such a change comes later and not as part of this commit.

Perhaps it is deliberate.  Unlike the helpers this step touches,
namely, try_bitmap_count(), try_bitmap_traversal(), and
try_bitmap_disk_usage(), prepare_bitmap_walk() is not a file-scope
static helper and updating it will need touching many more places.

> @@ -597,13 +595,17 @@ int cmd_rev_list(int argc, const char **argv, const char *prefix)
>  		}
>  
>  		if (skip_prefix(arg, ("--" CL_ARG__FILTER "="), &arg)) {

#leftoverbit.  We need to remember to clean this up, now "--filter"
is well established (I am assuming this literal-string pasting is
because we didn't know what the right and final word to be used as
the option name back when this code was originally written), when
the code around here is quiescent.

> -			parse_list_objects_filter(&filter_options, arg);
> -			if (filter_options.choice && !revs.blob_objects)
> +			if (!revs.filter)
> +				CALLOC_ARRAY(revs.filter, 1);
> +			parse_list_objects_filter(revs.filter, arg);
> +			if (revs.filter->choice && !revs.blob_objects)
>  				die(_("object filtering requires --objects"));
>  			continue;

OK.  The original "filter_options" was a structure and not a pointer
to a structure; now we have a pointer to a structure in revs as a
member so we need an on-demand allocation.  CALLOC_ARRAY() instead
of xcalloc(), when we know we are creating one element and not an
array of elements whose size happens to be one, is not wrong but it
does look strange.  Was there a reason why we avoid xcalloc()?

Makes me also wonder how big the filter_options structure is;
because we will not use unbounded many revs structure, it may have
been a simpler conversion to turn a static struct into an embedded
struct member in a struct (instead of a member of a struct that is a
pointer to a struct).  That way, we did not have to ...

>  		}
>  		if (!strcmp(arg, ("--no-" CL_ARG__FILTER))) {
> -			list_objects_filter_set_no_filter(&filter_options);
> +			if (!revs.filter)
> +				CALLOC_ARRAY(revs.filter, 1);

... repeat the on-demand allocation.  If some code used to pass
&filter_options in a parameter to helper functions, and such calling
sites get rewritten to pass the value in the revs.filter pointer,
and if revs hasn't gone through this codepath, these helper functions
will start receiving NULL in their filter_options parameter, which
they may or may not be prepared to take.  This "we get rid of a
global struct and replace it with an on-demand allocated structure,
pointer to which is stored in the revs structure" rewrite somehow
makes me nervous.

> diff --git a/revision.h b/revision.h
> index 3c58c18c63a..1ddb73ab82e 100644
> --- a/revision.h
> +++ b/revision.h
> @@ -81,6 +81,7 @@ struct rev_cmdline_info {
>  
>  struct oidset;
>  struct topo_walk_info;
> +struct list_objects_filter_options;

Is the forward-declaration the only reason why we needed to have a
pointer to a(n opaque) struct, not an embedded struct, as a member?

>  struct rev_info {
>  	/* Starting list */
> @@ -94,6 +95,9 @@ struct rev_info {
>  	/* The end-points specified by the end user */
>  	struct rev_cmdline_info cmdline;
>  
> +	/* Object filter options. NULL for no filtering. */
> +	struct list_objects_filter_options *filter;
> +
>  	/* excluding from --branches, --refs, etc. expansion */
>  	struct string_list *ref_excludes;
