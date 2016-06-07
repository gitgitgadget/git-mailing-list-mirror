From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 21/38] refs: make pack_refs() virtual
Date: Tue, 07 Jun 2016 10:35:06 -0700
Message-ID: <xmqqy46grjg5.fsf@gitster.mtv.corp.google.com>
References: <cover.1464983301.git.mhagger@alum.mit.edu>
	<22e49ca0f50831538d07d115d56b4af4e457a80c.1464983301.git.mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain
Cc: David Turner <dturner@twopensource.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Tue Jun 07 19:35:28 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bAKuP-0005We-17
	for gcvg-git-2@plane.gmane.org; Tue, 07 Jun 2016 19:35:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755685AbcFGRfM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jun 2016 13:35:12 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64279 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753993AbcFGRfK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jun 2016 13:35:10 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 731F323650;
	Tue,  7 Jun 2016 13:35:08 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=azNHfcFPjw5JoCdZOdmh2uVjhWA=; b=btrMCM
	A0EfgGsaLeYgVE793A9HYdg9lc4L5v7oUT4zunAaN5luet2aDxLTi2AQTqzX1skB
	YIAZXDE33YeKJ0J1m2uX6mic9sD2CyxbtA+aCU/lzZ+K7Lvx8Yk0CoS2S8KVz94C
	TUoN9OJq8RjRm3hNzaipMG7uiYhJ1BypQvW8w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=qghD8OPe7Lz1pGbDvEHXnsIBLVUIoUIX
	ASZSmOLZXJGtaNQkalBhjY/Vksi3axTxeaebTqTOgQLZ48EkKWBGXaahjbQJpSIS
	4YYt3E1fAaqlLXm9lZ2QB4rj1SpCpKi3BUIszM1x2ZpXnP6pJl85X9rL+9LTzaix
	T90gkHu9TF4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 6CC1E2364E;
	Tue,  7 Jun 2016 13:35:08 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E845E2364D;
	Tue,  7 Jun 2016 13:35:07 -0400 (EDT)
In-Reply-To: <22e49ca0f50831538d07d115d56b4af4e457a80c.1464983301.git.mhagger@alum.mit.edu>
	(Michael Haggerty's message of "Fri, 3 Jun 2016 23:03:56 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 2D8D9CFE-2CD6-11E6-ACF6-89D312518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296701>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
> ---
>  refs.c               | 7 +++++++
>  refs/files-backend.c | 6 ++++--
>  refs/refs-internal.h | 4 ++++
>  3 files changed, 15 insertions(+), 2 deletions(-)
>
> diff --git a/refs.c b/refs.c
> index 79ef443..f4f5f32 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -1418,6 +1418,13 @@ void assert_main_repository(struct ref_store *refs, const char *caller)
>  }
>  
>  /* backend functions */
> +int pack_refs(unsigned int flags)
> +{
> +	struct ref_store *refs = get_ref_store(NULL);
> +
> +	return refs->be->pack_refs(refs, flags);
> +}
> +

Makes me wonder what it even means to "pack_refs" in the context of
other possible backends (e.g. lmdb), but higher level API users
(e.g. "gc") needs something to call to give the backend "here is a
chance for you to optimize yourself" cue, so perhaps it is OK.

>  int ref_transaction_commit(struct ref_transaction *transaction,
>  			   struct strbuf *err)
>  {
> diff --git a/refs/files-backend.c b/refs/files-backend.c
> index af8de85..e5a8799 100644
> --- a/refs/files-backend.c
> +++ b/refs/files-backend.c
> @@ -2358,10 +2358,10 @@ static void prune_refs(struct ref_to_prune *r)
>  	}
>  }
>  
> -int pack_refs(unsigned int flags)
> +static int files_pack_refs(struct ref_store *ref_store, unsigned int flags)
>  {
>  	struct files_ref_store *refs =
> -		get_files_ref_store(NULL, "pack_refs");
> +		files_downcast(ref_store, 0, "pack_refs");
>  	struct pack_refs_cb_data cbdata;
>  
>  	memset(&cbdata, 0, sizeof(cbdata));
> @@ -4026,6 +4026,8 @@ struct ref_storage_be refs_be_files = {
>  	files_ref_store_create,
>  	files_transaction_commit,
>  
> +	files_pack_refs,
> +
>  	files_read_raw_ref,
>  	files_verify_refname_available
>  };
> diff --git a/refs/refs-internal.h b/refs/refs-internal.h
> index 18e01d0..578c125 100644
> --- a/refs/refs-internal.h
> +++ b/refs/refs-internal.h
> @@ -495,6 +495,8 @@ typedef int ref_transaction_commit_fn(struct ref_store *refs,
>  				      struct ref_transaction *transaction,
>  				      struct strbuf *err);
>  
> +typedef int pack_refs_fn(struct ref_store *ref_store, unsigned int flags);
> +
>  /*
>   * Read a reference from the specified reference store, non-recursively.
>   * Set type to describe the reference, and:
> @@ -549,6 +551,8 @@ struct ref_storage_be {
>  	ref_store_init_fn *init;
>  	ref_transaction_commit_fn *transaction_commit;
>  
> +	pack_refs_fn *pack_refs;
> +
>  	read_raw_ref_fn *read_raw_ref;
>  	verify_refname_available_fn *verify_refname_available;
>  };
