Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64AAD182D25
	for <git@vger.kernel.org>; Thu, 30 May 2024 15:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717083393; cv=none; b=OBqKRqC43nH0xck/hI/k1T4+9+0bxqStM2t3cZ1nIdcpGm0EfTHkK+I91d+LarOGiuxwQpnGgj7EyPfLd8iWd8v9RZacEqu+cCPjjFxU31LF0Ejjr6qi8lVgrGCB7CrVmWyIFEHanvwrPM6uQ/aM943sZRSZRG40y+ABwQrgw3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717083393; c=relaxed/simple;
	bh=TvQ8K/v4dimnComXORIArto3y4kugQZ1CHV4vQV7524=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dPJJfDiSxYapMCWAD9FXm8yJGaeUPsHvr/JmaYBwyCXidhVHnW+hzJTnMavD2w/KkR8JR1rzLl613mNBManugurfg/13iy7hrfwPjiLVI0wXi5d6CRwoiKvru9nxV7E4QE/pQgMtUvYU7VDztXUegnXv+S7wi7kDFVhtZwe7jeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=DhQh2FxZ; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="DhQh2FxZ"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id BB13E3A162;
	Thu, 30 May 2024 11:36:30 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=TvQ8K/v4dimnComXORIArto3y4kugQZ1CHV4vQ
	V7524=; b=DhQh2FxZKt9MKJXWbZoXTP04y5VRzed/ctDICN4Afa3viUYX98Ivtf
	1Qb6SBicMJrqy2HbXDEPqgDNo+o84NvmQ0F0v4WcNRS7HsehL/vAj3gTPaywa/uc
	hZwEfjy4PSdouba1gbcma09aR5fS8BVeqOHi5WpxpWd4FXkREPLQ8=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id B36C03A161;
	Thu, 30 May 2024 11:36:30 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.173.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 59FDE3A160;
	Thu, 30 May 2024 11:36:27 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Patrick Steinhardt <ps@pks.im>,  git@vger.kernel.org,  Eric Sunshine
 <sunshine@sunshineco.com>,  Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH 5/5] mv: replace src_dir with a strvec
In-Reply-To: <20240530064638.GE1949704@coredump.intra.peff.net> (Jeff King's
	message of "Thu, 30 May 2024 02:46:38 -0400")
References: <20240530063857.GA1942535@coredump.intra.peff.net>
	<20240530064638.GE1949704@coredump.intra.peff.net>
Date: Thu, 30 May 2024 08:36:25 -0700
Message-ID: <xmqqo78nqpl2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 610CDDD8-1E9A-11EF-89C9-8F8B087618E4-77302942!pb-smtp21.pobox.com

Jeff King <peff@peff.net> writes:

> We manually manage the src_dir array with ALLOC_GROW. Using a strvec is
> a little more ergonomic, and makes the memory ownership more clear. It
> does mean that we copy the strings (which were otherwise just pointers
> into the "sources" strvec), but using the same rationale as 9fcd9e4e72
> (builtin/mv duplicate string list memory, 2024-05-27), it's just not
> enough to be worth worrying about here.

Hmph, the rationale given by 9fcd9e4e (builtin/mv duplicate string
list memory, 2024-05-27) essentially is "the number of elements are
the same as the number of command line parameters", but I do not
think that is quite correct.

When you do "mv srcA srcB ... dst", you'd inspect the command line
arguments from left to right, notice that srcA is a directory, find
the cache entries for paths that are inside srcA, append the paths
in that directory to source[] and destination[] array, and extend
argc.  "for (i = 0; i < argc; i++)" loop that appends one element to
src_for_dst per iteration ends up running the number of paths being
moved, which can be order of magnitude more than the command line
parameters.

Of course, if we needed to make copies for correctness reasons (or
to clarify memory ownership semantics), that alone may be a good
justification and we do not need an excuse "it's just a handful of
elements anyway" to begin with.

Anyway, that is about somebody else's patch, not this one ;-).

The rationale *does* apply to this change; src_dir is a list of
directories we found on the command line, so the number of elements
in it is reasonably bounded.

> As a bonus, this gets rid of some "int"s used for allocation management
> (though in practice these were limited to command-line sizes and thus
> not overflowable).

Again, correct.

> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  builtin/mv.c | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
>
> diff --git a/builtin/mv.c b/builtin/mv.c
> index 01725e4a20..6c69033c5f 100644
> --- a/builtin/mv.c
> +++ b/builtin/mv.c
> @@ -197,8 +197,7 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
>  	struct strvec submodule_gitfiles_to_free = STRVEC_INIT;
>  	const char **submodule_gitfiles;
>  	char *dst_w_slash = NULL;
> -	const char **src_dir = NULL;
> -	int src_dir_nr = 0, src_dir_alloc = 0;
> +	struct strvec src_dir = STRVEC_INIT;
>  	enum update_mode *modes, dst_mode = 0;
>  	struct stat st, dest_st;
>  	struct string_list src_for_dst = STRING_LIST_INIT_DUP;
> @@ -344,8 +343,7 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
>  			/* last - first >= 1 */
>  			modes[i] |= WORKING_DIRECTORY;
>  
> -			ALLOC_GROW(src_dir, src_dir_nr + 1, src_dir_alloc);
> -			src_dir[src_dir_nr++] = src;
> +			strvec_push(&src_dir, src);
>  
>  			n = argc + last - first;
>  			REALLOC_ARRAY(modes, n);
> @@ -559,7 +557,7 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
>  		}
>  	}
>  
> -	remove_empty_src_dirs(src_dir, src_dir_nr);
> +	remove_empty_src_dirs(src_dir.v, src_dir.nr);
>  
>  	if (dirty_paths.nr)
>  		advise_on_moving_dirty_path(&dirty_paths);
> @@ -574,7 +572,7 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
>  	ret = 0;
>  
>  out:
> -	free(src_dir);
> +	strvec_clear(&src_dir);
>  	free(dst_w_slash);
>  	string_list_clear(&src_for_dst, 0);
>  	string_list_clear(&dirty_paths, 0);
