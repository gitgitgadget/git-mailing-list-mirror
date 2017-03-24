Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9BB5F1FC19
	for <e@80x24.org>; Fri, 24 Mar 2017 22:56:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966720AbdCXW4v (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 Mar 2017 18:56:51 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58585 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S966019AbdCXW4r (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Mar 2017 18:56:47 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3BABB7908C;
        Fri, 24 Mar 2017 18:56:30 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=WgeEUFms5NpGHukqKy29IuiUYEs=; b=E6PIQH
        r3SAoHcHXqaw3gNzfgXAyCJgDSW22waXjBWse7Ayvv20bVXMn0f+ZqSdvk+r6wM2
        VAIE+QZ+i+uSoSEf6nxj1/AjaLs9ZFnSYQls8auSqFZ8OJy/cjIV4wuLaAKL8U1N
        WWYtbp9JOmZv82Yq68z0nzSIkFpNXa7lMXPZM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ApQWVY9sRQCjqB0DkIStDcL2KcfHkhqP
        IvYq4WLkIb59HlFtG8A78bS8DZWHDWI+u7h6NKX7jLzOAVOnnRkjKVtx7N2hPwFx
        IMcVjHt0LpiAwSKv2ApaA3yntTv0nH5uZEFXktULLw29LLo1+P8okEWx5BdW4uvD
        ptg1HKiVCVc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 346A17908B;
        Fri, 24 Mar 2017 18:56:30 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id A2BB379089;
        Fri, 24 Mar 2017 18:56:29 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Dennis Kaarsemaker <dennis@kaarsemaker.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v4 1/2] diff --no-index: optionally follow symlinks
References: <20170324213110.4331-1-dennis@kaarsemaker.net>
        <20170324213110.4331-2-dennis@kaarsemaker.net>
Date:   Fri, 24 Mar 2017 15:56:28 -0700
In-Reply-To: <20170324213110.4331-2-dennis@kaarsemaker.net> (Dennis
        Kaarsemaker's message of "Fri, 24 Mar 2017 22:31:09 +0100")
Message-ID: <xmqqziga5lnn.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1E1BCBEE-10E5-11E7-AEF4-FC50AE2156B6-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dennis Kaarsemaker <dennis@kaarsemaker.net> writes:

> @@ -52,7 +52,7 @@ static int get_mode(const char *path, int *mode)
>  #endif
>  	else if (path == file_from_standard_input)
>  		*mode = create_ce_mode(0666);
> -	else if (lstat(path, &st))
> +	else if (dereference ? stat(path, &st) : lstat(path, &st))
>  		return error("Could not access '%s'", path);
>  	else
>  		*mode = st.st_mode;

This part makes sense---when the caller tells us to stat() we
stat(), otherwise, we lstat().

> diff --git a/diff.c b/diff.c
> index be11e4ef2b..2afecfb939 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -2815,7 +2815,7 @@ int diff_populate_filespec(struct diff_filespec *s, unsigned int flags)
>  		s->size = xsize_t(st.st_size);
>  		if (!s->size)
>  			goto empty;
> -		if (S_ISLNK(st.st_mode)) {
> +		if (S_ISLNK(s->mode)) {

This change is conceptually wrong.  s->mode (often) comes from the
index but in this codepath, after finding that s->oid is not valid
or we want to read from the working tree instead (several lines
before this part), we are committed to read from the working tree
and check things with st.st_* fields, not s->mode, when we decide
what to do with the thing we find on the filesystem, no?

> @@ -2825,6 +2825,10 @@ int diff_populate_filespec(struct diff_filespec *s, unsigned int flags)
>  			s->should_free = 1;
>  			return 0;
>  		}
> +		if (S_ISLNK(st.st_mode)) {
> +			stat(s->path, &st);
> +			s->size = xsize_t(st.st_size);
> +		}
>  		if (size_only)
>  			return 0;
>  		if ((flags & CHECK_BINARY) &&

I suspect that this would conflict with a recent topic.  

But more importantly, this inserted code feels doubly wrong.

 - what allows us to unconditionally do "ah, symbolic link on the
   disk--find the target of the link, not the symbolic link itself"?
   We do not seem to be checking '--dereference' around here.

 - does this code do a reasonable thing when the path is a symbolic
   link that points at a directory?  what does it mean to grab
   st.st_size for such a thing (and then go on to open() and xmmap()
   it)?

Puzzled.

Thanks.


   
