Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 803ABECAAA1
	for <git@archiver.kernel.org>; Fri, 16 Sep 2022 22:35:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229586AbiIPWfX (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Sep 2022 18:35:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbiIPWfV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Sep 2022 18:35:21 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F04C448C81
        for <git@vger.kernel.org>; Fri, 16 Sep 2022 15:35:19 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B8910149FE7;
        Fri, 16 Sep 2022 18:35:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=C2OnunZbuZwYhCVzc13895EMiwb7rYEFYG6h27
        Pzkag=; b=xwfTIcO002X9NWs2bH0r48KeSj7I86zpJ7DaEBzzvpOsjVVF0Wzlnc
        bWuQcwgEqV8hxZjXu33f/1fjvH5pQNgXROtQ4fJ99X7vbCaK7+JHN3tvjhaey45T
        OqWEqF52SNhPx/0hc88PYF3/za9OHl6Ki8qIajwfnctwjyVJW+Fa4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id AFCBE149FE6;
        Fri, 16 Sep 2022 18:35:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 0D3E9149FE4;
        Fri, 16 Sep 2022 18:35:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Siddharth Asthana <siddharthasthana31@gmail.com>
Cc:     git@vger.kernel.org, christian.couder@gmail.com,
        johncai86@gmail.com
Subject: Re: [PATCH 3/3] cat-file: add mailmap support to --batch-check option
References: <20220916205946.178925-1-siddharthasthana31@gmail.com>
        <20220916205946.178925-4-siddharthasthana31@gmail.com>
Date:   Fri, 16 Sep 2022 15:35:16 -0700
In-Reply-To: <20220916205946.178925-4-siddharthasthana31@gmail.com> (Siddharth
        Asthana's message of "Sat, 17 Sep 2022 02:29:46 +0530")
Message-ID: <xmqq35creymz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D72B5546-360F-11ED-BF49-307A8E0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Siddharth Asthana <siddharthasthana31@gmail.com> writes:

> Using `git cat-file --use-mailmap` with --batch-check option, like the
> following is allowed:
>
>  git cat-file --use-mailmap -batch-check
>
> The current implementation will return the same object size irrespective
> of the mailmap option, which is not as useful as it could be. When we
> use the mailmap mechanism to replace the idents, the size of the object
> can change and --batch-check option would be more useful if it shows the
> size of the changed object. This patch implements that.

Almost the same comment on the proposed log message as [2/3].

> diff --git a/builtin/cat-file.c b/builtin/cat-file.c
> index 9942b93867..93d127d687 100644
> --- a/builtin/cat-file.c
> +++ b/builtin/cat-file.c
> @@ -424,6 +424,12 @@ static void print_object_or_die(struct batch_options *opt, struct expand_data *d
>  
>  static void print_default_format(struct strbuf *scratch, struct expand_data *data)
>  {
> +	if (use_mailmap && (data->type == OBJ_COMMIT || data->type == OBJ_TAG)) {
> +		size_t s = data->size;
> +		*data->info.contentp = replace_idents_using_mailmap((char*)*data->info.contentp, &s);
> +		data->size = cast_size_t_to_ulong(s);
> +	}
> +
>  	strbuf_addf(scratch, "%s %s %"PRIuMAX"\n", oid_to_hex(&data->oid),
>  		    type_name(data->type),
>  		    (uintmax_t)data->size);
> @@ -441,9 +447,14 @@ static void batch_object_write(const char *obj_name,
>  			       struct packed_git *pack,
>  			       off_t offset)
>  {
> +	void *buf = NULL;
> +
>  	if (!data->skip_object_info) {
>  		int ret;
>  
> +		if (use_mailmap)
> +			data->info.contentp = &buf;
> +
>  		if (pack)
>  			ret = packed_object_info(the_repository, pack, offset,
>  						 &data->info);
> @@ -474,6 +485,8 @@ static void batch_object_write(const char *obj_name,
>  		print_object_or_die(opt, data);
>  		batch_write(opt, "\n", 1);
>  	}
> +
> +	free(buf);

OK.  Do we have _any_ idea what kind of object this is upon entry to
this function so that we can avoid populating .contentp for say a
huge blob object?  Of course, we could probe for type without
loading the contents, something like the attached sketch.  Usually
the blobs and trees are far larger than commits and tags and more
expensive to materialize in core (especially because trees delta so
well), so avoiding the cost to do so may worth it.  I dunno.

diff --git i/builtin/cat-file.c w/builtin/cat-file.c
index 989eee0bb4..562691eb1e 100644
--- i/builtin/cat-file.c
+++ w/builtin/cat-file.c
@@ -431,6 +431,9 @@ static void batch_object_write(const char *obj_name,
 	if (!data->skip_object_info) {
 		int ret;
 
+		if (use_mailmap && !data->info.typep)
+			data->info.typep = &data.type;
+
 		if (pack)
 			ret = packed_object_info(the_repository, pack, offset,
 						 &data->info);
@@ -444,8 +447,14 @@ static void batch_object_write(const char *obj_name,
 			fflush(stdout);
 			return;
 		}
-	}
 
+		if (use_mailmap && 
+		    (*(data->info.typep) == OBJ_COMMIT ||
+		    (*data->info.typep) == OBJ_TAG)) {
+			... load the contents here ...;
+			... replace idents with mailmap ...;
+		}
+	}
 	strbuf_reset(scratch);
 
 	if (!opt->format) {

