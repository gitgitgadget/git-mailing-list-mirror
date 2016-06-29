Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EA06D20FCF
	for <e@80x24.org>; Wed, 29 Jun 2016 21:06:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751487AbcF2VGj (ORCPT <rfc822;e@80x24.org>);
	Wed, 29 Jun 2016 17:06:39 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60922 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750878AbcF2VGj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Jun 2016 17:06:39 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 0804728984;
	Wed, 29 Jun 2016 17:06:38 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=UdvyqXTd/oj5IY+RJeDNz0rGWvc=; b=TKLvgv
	Nc1GzyJ8L4GDzLGtWN6Oj9h5LNzKg+jp2CxRJDUcxxgvY+gcusJrdugfSGX0pvzG
	0Q4doRi63CSMUmT8SsifO6+kfp+P0Ir7Fd0qKxIFSHQsl9YisqLKdz15Tr53YaKw
	FIZIWYgKmUq/A594/4/rIJR1jyp0jgeXowYbE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=czKBrKNtLhBDUhafHGTbueFcNbns02c+
	HOMr8wj/O86ysuUQ6geVQFSKWeaK28y5ZFaACRfuwp1nTnq39OTK4UNRJ1FS933w
	Idk6w+rU6msJk6OZpeQLp6f0AnFd5reqPVYv6b0Z9ftVR+p5bhpBIhqOkXPtodlE
	naUMsQ32LAY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id EC4F128983;
	Wed, 29 Jun 2016 17:06:37 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 2C7E228982;
	Wed, 29 Jun 2016 17:06:37 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:	git@vger.kernel.org
Subject: Re: [PATCH 7/9] merge-recursive: handle return values indicating errors
References: <cover.1467199553.git.johannes.schindelin@gmx.de>
	<4f2817208cf2f7d4e839ddb6818bf652b0aa633c.1467199553.git.johannes.schindelin@gmx.de>
Date:	Wed, 29 Jun 2016 14:06:35 -0700
In-Reply-To: <4f2817208cf2f7d4e839ddb6818bf652b0aa633c.1467199553.git.johannes.schindelin@gmx.de>
	(Johannes Schindelin's message of "Wed, 29 Jun 2016 13:37:04 +0200
	(CEST)")
Message-ID: <xmqqbn2j3dt0.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5DF9601C-3E3D-11E6-B3BC-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> diff --git a/merge-recursive.c b/merge-recursive.c
> index 6ab7dfc..bb075e3 100644
> --- a/merge-recursive.c
> +++ b/merge-recursive.c
> @@ -266,8 +266,10 @@ struct tree *write_tree_from_memory(struct merge_options *o)
>  		active_cache_tree = cache_tree();
>  
>  	if (!cache_tree_fully_valid(active_cache_tree) &&
> -	    cache_tree_update(&the_index, 0) < 0)
> -		die(_("error building trees"));
> +	    cache_tree_update(&the_index, 0) < 0) {
> +		error(_("error building trees"));
> +		return NULL;
> +	}

This actually is a BUG(), isn't it?  We have already verified that
the cache is merged, so cache_tree_update() ought to be able to come
up with the whole-tree hash.

> @@ -548,19 +550,17 @@ static int update_stages(const char *path, const struct diff_filespec *o,
>  	 */
>  	int clear = 1;
>  	int options = ADD_CACHE_OK_TO_ADD | ADD_CACHE_SKIP_DFCHECK;
> +	int ret = 0;
> +
>  	if (clear)
> -		if (remove_file_from_cache(path))
> -			return -1;
> -	if (o)
> -		if (add_cacheinfo(o->mode, o->sha1, path, 1, 0, options))
> -			return -1;
> -	if (a)
> -		if (add_cacheinfo(a->mode, a->sha1, path, 2, 0, options))
> -			return -1;
> -	if (b)
> -		if (add_cacheinfo(b->mode, b->sha1, path, 3, 0, options))
> -			return -1;
> -	return 0;
> +		ret = remove_file_from_cache(path);
> +	if (!ret && o)
> +		ret = add_cacheinfo(o->mode, o->sha1, path, 1, 0, options);
> +	if (!ret && a)
> +		ret = add_cacheinfo(a->mode, a->sha1, path, 2, 0, options);
> +	if (!ret && b)
> +		ret = add_cacheinfo(b->mode, b->sha1, path, 3, 0, options);
> +	return ret;
>  }

Aren't the preimage and the postimage doing the same thing?  The
only two differences I spot are (1) it is clear in the original that
the returned value is -1 in the error case, even if the error
convention of remove_file_from_cache() and add_cacheinfo() were "0
is good, others are bad"; and (2) the control flow is easier to
follow in the original.

> @@ -736,7 +736,7 @@ static int make_room_for_path(struct merge_options *o, const char *path)
>  	return error(msg, path, _(": perhaps a D/F conflict?"));
>  }
>  
> -static void update_file_flags(struct merge_options *o,
> +static int update_file_flags(struct merge_options *o,
>  			      const unsigned char *sha,
>  			      unsigned mode,
>  			      const char *path,
> @@ -777,8 +777,7 @@ static void update_file_flags(struct merge_options *o,
>  
>  		if (make_room_for_path(o, path) < 0) {
>  			update_wd = 0;
> -			free(buf);
> -			goto update_index;
> +			goto free_buf;
>  		}
>  		if (S_ISREG(mode) || (!has_symlinks && S_ISLNK(mode))) {
>  			int fd;
> @@ -801,20 +800,22 @@ static void update_file_flags(struct merge_options *o,
>  		} else
>  			die(_("do not know what to do with %06o %s '%s'"),
>  			    mode, sha1_to_hex(sha), path);
> +free_buf:
>  		free(buf);

I somehow find the above change harder to follow than the original.

>  	}
>   update_index:
>  	if (update_cache)
>  		add_cacheinfo(mode, sha, path, 0, update_wd, ADD_CACHE_OK_TO_ADD);
> +	return 0;
>  }
>  

This one is in line with the stated goal of the patch.

> @@ -1028,21 +1030,23 @@ static void handle_change_delete(struct merge_options *o,
>  		 * correct; since there is no true "middle point" between
>  		 * them, simply reuse the base version for virtual merge base.
>  		 */
> -		remove_file_from_cache(path);
> -		update_file(o, 0, o_sha, o_mode, renamed ? renamed : path);
> +		ret = remove_file_from_cache(path);
> +		if (!ret)
> +			ret = update_file(o, 0, o_sha, o_mode,
> +					  renamed ? renamed : path);

As you noted in the log message, this does change the behaviour.  If
remove returns non-zero for whatever reason, we still did update()
in the original, but we no longer do.  Does this have negative
effect to the overall codeflow?

Or, assuming that everybody returns -1 for errors, perhaps

	ret = remove();
        ret |= update();

may be a more faithful and safe conversion?

> @@ -1087,21 +1094,22 @@ static void conflict_rename_delete(struct merge_options *o,
>  		b_mode = dest->mode;
>  	}
>  
> -	handle_change_delete(o,
> +	ret = handle_change_delete(o,
>  			     o->call_depth ? orig->path : dest->path,
>  			     orig->sha1, orig->mode,
>  			     a_sha, a_mode,
>  			     b_sha, b_mode,
>  			     _("rename"), _("renamed"));
> -
> -	if (o->call_depth) {
> -		remove_file_from_cache(dest->path);
> -	} else {
> -		update_stages(dest->path, NULL,
> +	if (ret < 0)
> +		return ret;
> +	if (o->call_depth)
> +		ret = remove_file_from_cache(dest->path);
> +	else
> +		ret = update_stages(dest->path, NULL,
>  			      rename_branch == o->branch1 ? dest : NULL,
>  			      rename_branch == o->branch1 ? NULL : dest);
> -	}

Similarly, if handle_change_delete() returns non-zero, we no longer
call remove() or update().  Is that a good behaviour change?

> -static void handle_file(struct merge_options *o,
> +static int handle_file(struct merge_options *o,
>  			struct diff_filespec *rename,
>  			int stage,
>  			struct rename_conflict_info *ci)

Likewise.

> -static void conflict_rename_rename_1to2(struct merge_options *o,
> +static int conflict_rename_rename_1to2(struct merge_options *o,
>  					struct rename_conflict_info *ci)
>  {
> ...
> -		if (merge_file_one(o, one->path,
> +		if ((ret = merge_file_one(o, one->path,
>  				 one->sha1, one->mode,
>  				 a->sha1, a->mode,
>  				 b->sha1, b->mode,
> -				 ci->branch1, ci->branch2, &mfi) < 0)
> -			return;
> +				 ci->branch1, ci->branch2, &mfi)))
> +			return ret;

This does not change behaviour.

> @@ -1194,7 +1208,8 @@ static void conflict_rename_rename_1to2(struct merge_options *o,
>  		 * pathname and then either rename the add-source file to that
>  		 * unique path, or use that unique path instead of src here.
>  		 */
> -		update_file(o, 0, mfi.sha, mfi.mode, one->path);
> +		if ((ret = update_file(o, 0, mfi.sha, mfi.mode, one->path)))
> +			return ret;

But this does.

> @@ -1205,22 +1220,31 @@ static void conflict_rename_rename_1to2(struct merge_options *o,
>  		 * resolving the conflict at that path in its favor.
>  		 */
>  		add = filespec_from_entry(&other, ci->dst_entry1, 2 ^ 1);
> -		if (add)
> -			update_file(o, 0, add->sha1, add->mode, a->path);
> +		if (add) {
> +			if ((ret = update_file(o, 0, add->sha1, add->mode,
> +					a->path)))
> +				return ret;
> +		}

So does this.


>  		else
>  			remove_file_from_cache(a->path);
>  		add = filespec_from_entry(&other, ci->dst_entry2, 3 ^ 1);
> -		if (add)
> -			update_file(o, 0, add->sha1, add->mode, b->path);
> +		if (add) {
> +			if ((ret = update_file(o, 0, add->sha1, add->mode,
> +					b->path)))
> +				return ret;
> +		}

And this.

>  	} else {
> -		handle_file(o, a, 2, ci);
> -		handle_file(o, b, 3, ci);
> +		if ((ret = handle_file(o, a, 2, ci)) ||
> +		    (ret = handle_file(o, b, 3, ci)))
> +			return ret;

And this.
