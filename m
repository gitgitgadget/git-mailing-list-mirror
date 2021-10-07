Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6B59C4332F
	for <git@archiver.kernel.org>; Thu,  7 Oct 2021 20:56:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D065E6103C
	for <git@archiver.kernel.org>; Thu,  7 Oct 2021 20:56:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233552AbhJGU6c (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Oct 2021 16:58:32 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54237 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241424AbhJGU6X (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Oct 2021 16:58:23 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 536CBE73D9;
        Thu,  7 Oct 2021 16:56:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=fpPCn5OPZWDXZzfWRXHVLNbFn5nf4iKhcdWfFa
        fCWow=; b=l80eGhIOBCoOUf2iGTRMEizNk8MGeIgqT7uwcb5lBNcV+PU0WPKoXT
        BuIGb/aG5E/tVVWcopY/92vRF0gDaffCW/LkibqtzwQZli0fHanXrxDM+BszJtKs
        qk++BCqPcyP6qstcVD69NWAlzgDwDQdZpAtujSPflwr7lSldha2bU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3A182E73D7;
        Thu,  7 Oct 2021 16:56:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 8FB1EE73D5;
        Thu,  7 Oct 2021 16:56:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 5/5] cat-file: use packed_object_info() for
 --batch-all-objects
References: <YVy1sx8Xb1xMLFQT@coredump.intra.peff.net>
        <YVy3rPuUal0+9iJs@coredump.intra.peff.net>
Date:   Thu, 07 Oct 2021 13:56:26 -0700
In-Reply-To: <YVy3rPuUal0+9iJs@coredump.intra.peff.net> (Jeff King's message
        of "Tue, 5 Oct 2021 16:38:04 -0400")
Message-ID: <xmqqily8pn9h.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0A3C136C-27B1-11EC-8DEC-62A2C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> diff --git a/builtin/cat-file.c b/builtin/cat-file.c
> index b533935d5c..219ff5628d 100644
> --- a/builtin/cat-file.c
> +++ b/builtin/cat-file.c
> @@ -358,15 +358,26 @@ static void print_object_or_die(struct batch_options *opt, struct expand_data *d

The two new parameters might deserve a comment in front of the
function as to the calling convention (namely, offset can be any
garbage when the caller signals "unknown" with pack==NULL). 

>  static void batch_object_write(const char *obj_name,
>  			       struct strbuf *scratch,
>  			       struct batch_options *opt,
> -			       struct expand_data *data)
> +			       struct expand_data *data,
> +			       struct packed_git *pack,
> +			       off_t offset)
>  {
> -	if (!data->skip_object_info &&
> -	    oid_object_info_extended(the_repository, &data->oid, &data->info,
> -				     OBJECT_INFO_LOOKUP_REPLACE) < 0) {
> -		printf("%s missing\n",
> -		       obj_name ? obj_name : oid_to_hex(&data->oid));
> -		fflush(stdout);
> -		return;
> +	if (!data->skip_object_info) {
> +		int ret;
> +
> +		if (pack)
> +			ret = packed_object_info(the_repository, pack, offset,
> +						 &data->info);
> +		else
> +			ret = oid_object_info_extended(the_repository,
> +						       &data->oid, &data->info,
> +						       OBJECT_INFO_LOOKUP_REPLACE);
> +		if (ret < 0) {
> +			printf("%s missing\n",
> +			       obj_name ? obj_name : oid_to_hex(&data->oid));
> +			fflush(stdout);
> +			return;
> +		}
>  	}

The implementation is quite straight-forward.

> @@ -463,31 +475,36 @@ static int collect_packed_object(const struct object_id *oid,
>  	return 0;
>  }
>  
> -static int batch_unordered_object(const struct object_id *oid, void *vdata)
> +static int batch_unordered_object(const struct object_id *oid,
> +				  struct packed_git *pack, off_t offset,
> +				  void *vdata)
>  {
>  	struct object_cb_data *data = vdata;
>  
>  	if (oidset_insert(data->seen, oid))
>  		return 0;
>  
>  	oidcpy(&data->expand->oid, oid);
> -	batch_object_write(NULL, data->scratch, data->opt, data->expand);
> +	batch_object_write(NULL, data->scratch, data->opt, data->expand,
> +			   pack, offset);
>  	return 0;
>  }
> ...
>  static int batch_unordered_packed(const struct object_id *oid,
>  				  struct packed_git *pack,
>  				  uint32_t pos,
>  				  void *data)
>  {
> -	return batch_unordered_object(oid, data);
> +	return batch_unordered_object(oid, pack,
> +				      nth_packed_object_offset(pack, pos),
> +				      data);
>  }

We used to discard a good piece of info (i.e.  which pack we found
the object in), but we can make good use of it.

Nice.
