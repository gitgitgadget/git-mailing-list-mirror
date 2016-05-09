From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v9 1/6] read-cache: factor out get_sha1_from_index() helper
Date: Mon, 09 May 2016 12:54:37 -0700
Message-ID: <xmqqy47jt3b6.fsf@gitster.mtv.corp.google.com>
References: <xmqqegblor2l.fsf@gitster.mtv.corp.google.com>
	<1462601458-23498-1-git-send-email-tboegi@web.de>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: tboegi@web.de
X-From: git-owner@vger.kernel.org Mon May 09 21:54:46 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1azrGP-00017Y-CO
	for gcvg-git-2@plane.gmane.org; Mon, 09 May 2016 21:54:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751256AbcEITyl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 May 2016 15:54:41 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59977 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751069AbcEITyl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 May 2016 15:54:41 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 9EC561A845;
	Mon,  9 May 2016 15:54:39 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=sDP/C/vIWuhHxIdTQL5LOnoAmYQ=; b=aSopRW
	SHBcs01tJNa21O5NNsxBVgU9l+BhJ2i1MD9iNYu3CQsfEJPiaRIahAgJwkBu7AzN
	O4m0rWz5+7kVICgbZATfwZY1vEIq3e4obbOo/2mEImO/sHmjfkCEGE97oYhHRaCz
	iFHIXueslQbwxUtQpDM/p9vPZT+LoQgUc6TCI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=YbavzbgF3NxSBonFYjBQSfCmH3okZRYM
	gRBU8RpJT1Ev2hSkgd4M+T+X1doAKMCoRXY0/x6iNsNKEdhukuzvG07ij6ZExRfn
	TZxewNycOf4DPnvM/MkesBH7mgwDM2kCAQFEtEW5U8mBChQbz9O9BqXehS2SGALd
	DI3990Lw1Y4=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 96C9F1A844;
	Mon,  9 May 2016 15:54:39 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E4BCA1A843;
	Mon,  9 May 2016 15:54:38 -0400 (EDT)
In-Reply-To: <1462601458-23498-1-git-send-email-tboegi@web.de>
	(tboegi@web.de's message of "Sat, 7 May 2016 08:10:58 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: DD08AF7A-161F-11E6-8F07-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294044>

tboegi@web.de writes:

> +#define get_sha1_from_cache(path)  get_sha1_from_index (&the_index, (path))
>  #endif

Micronit: lose the extra SP; i.e. "get_sha1_from_index(&the_index, (path))".

> diff --git a/read-cache.c b/read-cache.c
> index d9fb78b..a3ef967 100644
> --- a/read-cache.c
> +++ b/read-cache.c
> @@ -2263,13 +2263,27 @@ int index_name_is_other(const struct index_state *istate, const char *name,
>  
>  void *read_blob_data_from_index(struct index_state *istate, const char *path, unsigned long *size)
>  {
> -	int pos, len;
> +	const unsigned char *sha1;
>  	unsigned long sz;
>  	enum object_type type;
>  	void *data;
>  
> -	len = strlen(path);
> -	pos = index_name_pos(istate, path, len);
> +	sha1 = get_sha1_from_index(istate, path);
> +	if (!sha1)
> +		return NULL;
> +	data = read_sha1_file(sha1, &type, &sz);
> +	if (!data || type != OBJ_BLOB) {
> +		free(data);
> +		return NULL;
> +	}
> +	if (size)
> +		*size = sz;
> +	return data;
> +}
> +
> +const unsigned char *get_sha1_from_index(struct index_state *istate, const char *path)
> +{
> +	int pos = index_name_pos(istate, path, strlen(path));
>  	if (pos < 0) {
>  		/*
>  		 * We might be in the middle of a merge, in which
> @@ -2285,14 +2299,7 @@ void *read_blob_data_from_index(struct index_state *istate, const char *path, un
>  	}
>  	if (pos < 0)
>  		return NULL;
> +	return (istate->cache[pos]->sha1);

Micronit: lose the extra () pair around what is returned.

I wondered if we can share more code with this helper and
get_sha1_with_context_1(), which is the canonical copy of this logic
used to parse ":$path" and get the object name at $path in the
index, but this is sufficiently low-level and such a refactoring
of small code would not be of great benefit, so this patch is OK.

Thanks.

>  }
>  
>  void stat_validity_clear(struct stat_validity *sv)
