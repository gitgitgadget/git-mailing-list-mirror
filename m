Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3CF7520FCF
	for <e@80x24.org>; Wed, 29 Jun 2016 20:23:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751537AbcF2UXO (ORCPT <rfc822;e@80x24.org>);
	Wed, 29 Jun 2016 16:23:14 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52223 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751450AbcF2UXN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Jun 2016 16:23:13 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id C920627BD1;
	Wed, 29 Jun 2016 16:21:47 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=5S4DAJtCMzETMYObYHFiKdD7ApY=; b=YQESYm
	6C9UcftuCuYp/pz7yCQIRSAlrhp2BiSCf05cKEVWb3WhfB4Xe/Lu/tQdkkk346Y0
	yRKFHJycJ9A3Dd5F3PXNBHCE+6+UelreDx0Dnpa4eA9ICAgJUHPlgSSXlqGDnkT5
	ofdah+A5AReluIGc24yD/5INqnM2QwtMn3RfY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=HXW56kHJchudJXtkyX9XJN7b5iET0juX
	+sOs5101WyfT0QptwW6TB1pNL2OeDwA621z4bcJ6ZaZElZYtNyi6gYkCDVOrAdEG
	jb5mwGOZN+gEfSNsm4qL0/9v2FXDJir/L7K7NDE1QiUgMnzVS/p42jqAFl1i+miO
	rgtzGyH6Cmo=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id C189327BD0;
	Wed, 29 Jun 2016 16:21:47 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 2E5DF27BCD;
	Wed, 29 Jun 2016 16:21:47 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:	git@vger.kernel.org
Subject: Re: [PATCH 5/9] merge-recursive: avoid returning a wholesale struct
References: <cover.1467199553.git.johannes.schindelin@gmx.de>
	<c33e9cdb1ec6cbebcc3124a62b7b9d52b92cf6c9.1467199553.git.johannes.schindelin@gmx.de>
Date:	Wed, 29 Jun 2016 13:21:44 -0700
In-Reply-To: <c33e9cdb1ec6cbebcc3124a62b7b9d52b92cf6c9.1467199553.git.johannes.schindelin@gmx.de>
	(Johannes Schindelin's message of "Wed, 29 Jun 2016 13:36:54 +0200
	(CEST)")
Message-ID: <xmqqr3bf3fvr.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1A9CF8FC-3E37-11E6-A36C-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> It is technically allowed, as per C89, for functions' return type to
> be complete structs (i.e. *not* just pointers to structs), but it is
> bad practice.

Not necessarily.

> This is a very late attempt to contain the damage done by this developer
> in 6d297f8 (Status update on merge-recursive in C, 2006-07-08) which
> introduced such a return type.
>
> It will also help the current effort to libify merge-recursive.c, as
> it will allow us to return proper error codes later.

But this part of the motivation does make sense.  Having to pass an
extra int &error_code field, only because the return value is
already used for something else, is a lot more weird.

> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  merge-recursive.c | 93 ++++++++++++++++++++++++++++++-------------------------
>  1 file changed, 50 insertions(+), 43 deletions(-)
>
> diff --git a/merge-recursive.c b/merge-recursive.c
> index c4ece96..d56651c9 100644
> --- a/merge-recursive.c
> +++ b/merge-recursive.c
> @@ -888,47 +888,47 @@ static int merge_3way(struct merge_options *o,
>  	return merge_status;
>  }
>  
> -static struct merge_file_info merge_file_1(struct merge_options *o,
> +static int merge_file_1(struct merge_options *o,
>  					   const struct diff_filespec *one,
>  					   const struct diff_filespec *a,
>  					   const struct diff_filespec *b,
>  					   const char *branch1,
> -					   const char *branch2)
> +					   const char *branch2,
> +					   struct merge_file_info *result)
>  {
> -	struct merge_file_info result;
> -	result.merge = 0;
> -	result.clean = 1;
> +	result->merge = 0;
> +	result->clean = 1;
>  
>  	if ((S_IFMT & a->mode) != (S_IFMT & b->mode)) {
> -		result.clean = 0;
> +		result->clean = 0;
>  		if (S_ISREG(a->mode)) {
> -			result.mode = a->mode;
> -			hashcpy(result.sha, a->sha1);
> +			result->mode = a->mode;
> +			hashcpy(result->sha, a->sha1);
>  		} else {
> -			result.mode = b->mode;
> -			hashcpy(result.sha, b->sha1);
> +			result->mode = b->mode;
> +			hashcpy(result->sha, b->sha1);
>  		}
>  	} else {
>  		if (!sha_eq(a->sha1, one->sha1) && !sha_eq(b->sha1, one->sha1))
> -			result.merge = 1;
> +			result->merge = 1;
>  
>  		/*
>  		 * Merge modes
>  		 */
>  		if (a->mode == b->mode || a->mode == one->mode)
> -			result.mode = b->mode;
> +			result->mode = b->mode;
>  		else {
> -			result.mode = a->mode;
> +			result->mode = a->mode;
>  			if (b->mode != one->mode) {
> -				result.clean = 0;
> -				result.merge = 1;
> +				result->clean = 0;
> +				result->merge = 1;
>  			}
>  		}
>  
>  		if (sha_eq(a->sha1, b->sha1) || sha_eq(a->sha1, one->sha1))
> -			hashcpy(result.sha, b->sha1);
> +			hashcpy(result->sha, b->sha1);
>  		else if (sha_eq(b->sha1, one->sha1))
> -			hashcpy(result.sha, a->sha1);
> +			hashcpy(result->sha, a->sha1);
>  		else if (S_ISREG(a->mode)) {
>  			mmbuffer_t result_buf;
>  			int merge_status;
> @@ -940,62 +940,63 @@ static struct merge_file_info merge_file_1(struct merge_options *o,
>  				die(_("Failed to execute internal merge"));
>  
>  			if (write_sha1_file(result_buf.ptr, result_buf.size,
> -					    blob_type, result.sha))
> +					    blob_type, result->sha))
>  				die(_("Unable to add %s to database"),
>  				    a->path);
>  
>  			free(result_buf.ptr);
> -			result.clean = (merge_status == 0);
> +			result->clean = (merge_status == 0);
>  		} else if (S_ISGITLINK(a->mode)) {
> -			result.clean = merge_submodule(result.sha,
> +			result->clean = merge_submodule(result->sha,
>  						       one->path, one->sha1,
>  						       a->sha1, b->sha1,
>  						       !o->call_depth);
>  		} else if (S_ISLNK(a->mode)) {
> -			hashcpy(result.sha, a->sha1);
> +			hashcpy(result->sha, a->sha1);
>  
>  			if (!sha_eq(a->sha1, b->sha1))
> -				result.clean = 0;
> +				result->clean = 0;
>  		} else
>  			die(_("BUG: unsupported object type in the tree"));
>  	}
>  
> -	return result;
> +	return 0;
>  }
>  
> -static struct merge_file_info
> -merge_file_special_markers(struct merge_options *o,
> +static int merge_file_special_markers(struct merge_options *o,
>  			   const struct diff_filespec *one,
>  			   const struct diff_filespec *a,
>  			   const struct diff_filespec *b,
>  			   const char *branch1,
>  			   const char *filename1,
>  			   const char *branch2,
> -			   const char *filename2)
> +			   const char *filename2,
> +			   struct merge_file_info *mfi)
>  {
>  	char *side1 = NULL;
>  	char *side2 = NULL;
> -	struct merge_file_info mfi;
> +	int ret;
>  
>  	if (filename1)
>  		side1 = xstrfmt("%s:%s", branch1, filename1);
>  	if (filename2)
>  		side2 = xstrfmt("%s:%s", branch2, filename2);
>  
> -	mfi = merge_file_1(o, one, a, b,
> -			   side1 ? side1 : branch1, side2 ? side2 : branch2);
> +	ret = merge_file_1(o, one, a, b,
> +		side1 ? side1 : branch1, side2 ? side2 : branch2, mfi);
>  	free(side1);
>  	free(side2);
> -	return mfi;
> +	return ret;
>  }
>  
> -static struct merge_file_info merge_file_one(struct merge_options *o,
> +static int merge_file_one(struct merge_options *o,
>  					 const char *path,
>  					 const unsigned char *o_sha, int o_mode,
>  					 const unsigned char *a_sha, int a_mode,
>  					 const unsigned char *b_sha, int b_mode,
>  					 const char *branch1,
> -					 const char *branch2)
> +					 const char *branch2,
> +					 struct merge_file_info *mfi)
>  {
>  	struct diff_filespec one, a, b;
>  
> @@ -1006,7 +1007,7 @@ static struct merge_file_info merge_file_one(struct merge_options *o,
>  	a.mode = a_mode;
>  	hashcpy(b.sha1, b_sha);
>  	b.mode = b_mode;
> -	return merge_file_1(o, &one, &a, &b, branch1, branch2);
> +	return merge_file_1(o, &one, &a, &b, branch1, branch2, mfi);
>  }
>  
>  static void handle_change_delete(struct merge_options *o,
> @@ -1179,11 +1180,14 @@ static void conflict_rename_rename_1to2(struct merge_options *o,
>  		struct merge_file_info mfi;
>  		struct diff_filespec other;
>  		struct diff_filespec *add;
> -		mfi = merge_file_one(o, one->path,
> +
> +		if (merge_file_one(o, one->path,
>  				 one->sha1, one->mode,
>  				 a->sha1, a->mode,
>  				 b->sha1, b->mode,
> -				 ci->branch1, ci->branch2);
> +				 ci->branch1, ci->branch2, &mfi) < 0)
> +			return;
> +
>  		/*
>  		 * FIXME: For rename/add-source conflicts (if we could detect
>  		 * such), this is wrong.  We should instead find a unique
> @@ -1237,12 +1241,13 @@ static void conflict_rename_rename_2to1(struct merge_options *o,
>  	remove_file(o, 1, a->path, o->call_depth || would_lose_untracked(a->path));
>  	remove_file(o, 1, b->path, o->call_depth || would_lose_untracked(b->path));
>  
> -	mfi_c1 = merge_file_special_markers(o, a, c1, &ci->ren1_other,
> +	if (merge_file_special_markers(o, a, c1, &ci->ren1_other,
>  					    o->branch1, c1->path,
> -					    o->branch2, ci->ren1_other.path);
> -	mfi_c2 = merge_file_special_markers(o, b, &ci->ren2_other, c2,
> +					    o->branch2, ci->ren1_other.path, &mfi_c1) < 0 ||
> +	    merge_file_special_markers(o, b, &ci->ren2_other, c2,
>  					    o->branch1, ci->ren2_other.path,
> -					    o->branch2, c2->path);
> +					    o->branch2, c2->path, &mfi_c2) < 0)
> +		return;
>  
>  	if (o->call_depth) {
>  		/*
> @@ -1463,10 +1468,11 @@ static int process_renames(struct merge_options *o,
>  				       ren1_dst, branch2);
>  				if (o->call_depth) {
>  					struct merge_file_info mfi;
> -					mfi = merge_file_one(o, ren1_dst, null_sha1, 0,
> +					if (merge_file_one(o, ren1_dst, null_sha1, 0,
>  							 ren1->pair->two->sha1, ren1->pair->two->mode,
>  							 dst_other.sha1, dst_other.mode,
> -							 branch1, branch2);
> +							 branch1, branch2, &mfi) < 0)
> +						return -1;
>  					output(o, 1, _("Adding merged %s"), ren1_dst);
>  					update_file(o, 0, mfi.sha, mfi.mode, ren1_dst);
>  					try_merge = 0;
> @@ -1622,9 +1628,10 @@ static int merge_content(struct merge_options *o,
>  		if (dir_in_way(path, !o->call_depth))
>  			df_conflict_remains = 1;
>  	}
> -	mfi = merge_file_special_markers(o, &one, &a, &b,
> +	if (merge_file_special_markers(o, &one, &a, &b,
>  					 o->branch1, path1,
> -					 o->branch2, path2);
> +					 o->branch2, path2, &mfi) < 0)
> +		return -1;
>  
>  	if (mfi.clean && !df_conflict_remains &&
>  	    sha_eq(mfi.sha, a_sha) && mfi.mode == a_mode) {
