Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94BD1C433DB
	for <git@archiver.kernel.org>; Tue,  9 Feb 2021 23:13:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4028164E76
	for <git@archiver.kernel.org>; Tue,  9 Feb 2021 23:13:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234840AbhBIXMn (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Feb 2021 18:12:43 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:55586 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234119AbhBIWO4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Feb 2021 17:14:56 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 73006124F81;
        Tue,  9 Feb 2021 16:27:24 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=42RzuTWc668FRiG4yIVQIds/11U=; b=FLBDBm
        rXU7Osy4mtFsheyDSfM0h4E/4pS62BxbvaRLJUtOAUVfBOCehx8PBBXEtPNFe5z8
        XM7u15a3nPHk7vTP60kmfigDp2yqsgD6WJMWJUgl9JmBsYN5MRUPy+kPLVUspF8r
        d1XRtrYVRVp9CQZCkLTu7mVpkJRmFdBKkqQmw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=BluMLyl3gCzZX8Hxzbmh5SoWOmHkiieG
        940ie6LiZ6t7cbRlTnili8D89ogqbZSE6rxAA4CCjNZAFt038Zbs8SIHC9iJn1Nh
        00xa01VUERbwsYNbG9SVniCSlDDDW0Yuj6V3jtqkRZ1qAhjp7KBlAFNHNoUIH27t
        +wN+VhczeqM=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 6DA13124F80;
        Tue,  9 Feb 2021 16:27:24 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id AB77A124F7E;
        Tue,  9 Feb 2021 16:27:21 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Matheus Tavares <matheus.bernardino@usp.br>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/2] write_entry(): fix misuses of `path` in error messages
References: <cover.1612812581.git.matheus.bernardino@usp.br>
        <d52bcad326ece6be2fcf87ca6b72e4ce8212e31f.1612812581.git.matheus.bernardino@usp.br>
Date:   Tue, 09 Feb 2021 13:27:19 -0800
In-Reply-To: <d52bcad326ece6be2fcf87ca6b72e4ce8212e31f.1612812581.git.matheus.bernardino@usp.br>
        (Matheus Tavares's message of "Mon, 8 Feb 2021 16:36:31 -0300")
Message-ID: <xmqqr1lpyls8.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 983B6628-6B1D-11EB-9B4A-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Matheus Tavares <matheus.bernardino@usp.br> writes:

> The variables `path` and `ce->name`, at write_entry(), usually have the
> same contents, but that's not the case when using a checkout prefix or
> writing to a tempfile. (In fact, `path` will be either empty or dirty
> when writing to a tempfile.) Therefore, these variables cannot be used
> interchangeably. In this sense, fix wrong uses of `path` in error
> messages where it should really be `ce->name`. (There doesn't seem to be
> any misuse in the other way around.)

Sounds reasonable.  Don't we want to protect this fix with tests?

> Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
> ---
>  entry.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/entry.c b/entry.c
> index a0532f1f00..7b9f43716f 100644
> --- a/entry.c
> +++ b/entry.c
> @@ -282,7 +282,7 @@ static int write_entry(struct cache_entry *ce,
>  		new_blob = read_blob_entry(ce, &size);
>  		if (!new_blob)
>  			return error("unable to read sha1 file of %s (%s)",
> -				     path, oid_to_hex(&ce->oid));
> +				     ce->name, oid_to_hex(&ce->oid));
>  
>  		/*
>  		 * We can't make a real symlink; write out a regular file entry
> @@ -309,7 +309,7 @@ static int write_entry(struct cache_entry *ce,
>  			new_blob = read_blob_entry(ce, &size);
>  			if (!new_blob)
>  				return error("unable to read sha1 file of %s (%s)",
> -					     path, oid_to_hex(&ce->oid));
> +					     ce->name, oid_to_hex(&ce->oid));
>  		}
>  
>  		/*
> @@ -354,7 +354,7 @@ static int write_entry(struct cache_entry *ce,
>  
>  	case S_IFGITLINK:
>  		if (to_tempfile)
> -			return error("cannot create temporary submodule %s", path);
> +			return error("cannot create temporary submodule %s", ce->name);
>  		if (mkdir(path, 0777) < 0)
>  			return error("cannot create submodule directory %s", path);
>  		sub = submodule_from_ce(ce);
> @@ -365,7 +365,7 @@ static int write_entry(struct cache_entry *ce,
>  		break;
>  
>  	default:
> -		return error("unknown file mode for %s in index", path);
> +		return error("unknown file mode for %s in index", ce->name);
>  	}
>  
>  finish:
