Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EBB5620899
	for <e@80x24.org>; Tue,  8 Aug 2017 20:19:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752264AbdHHUT0 (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 Aug 2017 16:19:26 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61895 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752222AbdHHUTZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Aug 2017 16:19:25 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D50639563C;
        Tue,  8 Aug 2017 16:19:24 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ea+U8+KDZrjWp63bNt3/wq1ERs0=; b=AkNIyx
        yNYf3CfG6tS98ScoQNrv9LENWS95sfiTf/zjKKrM73rL7ZSAEArJF+WYZB63bV92
        z0xdDRAn7Wo61pc8OHSaj5Jo6guPrLoJHbcYrjhbM/QXYBAT+F05FnAjFVPHBV77
        9SxGMMnrll7RiPkfJk6f6+AUgvCcaCTyWFt14=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ol81ZXkxJ2gAJfVgT82oHcP4kidS4obd
        e3ZHjyroW7F4bGY63bBHzAHc8gxhY+GQeit3kiXaSAbS0ZFWddvBEMNJFMNWUBYv
        etavhKLT+4766SIMk6MLRAd5qw3SfQt/cirUWRvL8PX7ii40MQCfgt6PuaIp6xa5
        kd/Ko1ORRbM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id CB0309563B;
        Tue,  8 Aug 2017 16:19:24 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 31A7F9563A;
        Tue,  8 Aug 2017 16:19:24 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [RFC PATCH 04/10] pack: move open_pack_index(), parse_pack_index()
References: <cover.1502220307.git.jonathantanmy@google.com>
        <cover.1502220307.git.jonathantanmy@google.com>
        <02e77a90110bdd6dad13c60aa08107b6345a60b9.1502220307.git.jonathantanmy@google.com>
Date:   Tue, 08 Aug 2017 13:19:23 -0700
In-Reply-To: <02e77a90110bdd6dad13c60aa08107b6345a60b9.1502220307.git.jonathantanmy@google.com>
        (Jonathan Tan's message of "Tue, 8 Aug 2017 12:32:34 -0700")
Message-ID: <xmqq8titbyno.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: DEB02A24-7C76-11E7-A22B-9D2B0D78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
> ---
>  builtin/count-objects.c |   1 +
>  cache.h                 |   8 ---
>  pack.c                  | 149 ++++++++++++++++++++++++++++++++++++++++++++++++
>  pack.h                  |   8 +++
>  sha1_file.c             | 140 ---------------------------------------------
>  sha1_name.c             |   1 +
>  6 files changed, 159 insertions(+), 148 deletions(-)

This patch is a bit strange...

> diff --git a/pack.c b/pack.c
> index 60d9fc3b0..6edc43228 100644
> --- a/pack.c
> +++ b/pack.c
> ...
> +static struct packed_git *alloc_packed_git(int extra)
> +{
> +	struct packed_git *p = xmalloc(st_add(sizeof(*p), extra));
> +	memset(p, 0, sizeof(*p));
> +	p->pack_fd = -1;
> +	return p;
> +}
> +
> +struct packed_git *parse_pack_index(unsigned char *sha1, const char *idx_path)
> +{
> +	const char *path = sha1_pack_name(sha1);
> +	size_t alloc = st_add(strlen(path), 1);
> +	struct packed_git *p = alloc_packed_git(alloc);
> +
> +	memcpy(p->pack_name, path, alloc); /* includes NUL */
> +	hashcpy(p->sha1, sha1);
> +	if (check_packed_git_idx(idx_path, p)) {
> +		free(p);
> +		return NULL;
> +	}
> +
> +	return p;
> +}

We see these two functions appear in pack.c

> diff --git a/sha1_file.c b/sha1_file.c
> index 0de39f480..2e414f5f5 100644
> --- a/sha1_file.c
> +++ b/sha1_file.c
> ...
> @@ -1300,22 +1176,6 @@ struct packed_git *add_packed_git(const char *path, size_t path_len, int local)
>  	return p;
>  }
>  
> -struct packed_git *parse_pack_index(unsigned char *sha1, const char *idx_path)
> -{
> -	const char *path = sha1_pack_name(sha1);
> -	size_t alloc = st_add(strlen(path), 1);
> -	struct packed_git *p = alloc_packed_git(alloc);
> -
> -	memcpy(p->pack_name, path, alloc); /* includes NUL */
> -	hashcpy(p->sha1, sha1);
> -	if (check_packed_git_idx(idx_path, p)) {
> -		free(p);
> -		return NULL;
> -	}
> -
> -	return p;
> -}
> -

And we see parse_pack_index() came from sha1_file.c

But where did alloc_packed_git() come from?  Was the patch split
incorrectly or something?

When I applied the whole series and did

    git blame -s -w -M -C -C master.. pack.c

expecting that pretty much everything has come from sha1_file.c but
noticed that some lines were actually blamed to a version of pack.c
and these functions were among them.
