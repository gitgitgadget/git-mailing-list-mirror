From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 34/38] refs: add method for delete_refs
Date: Tue, 07 Jun 2016 10:43:34 -0700
Message-ID: <xmqqporsrj21.fsf@gitster.mtv.corp.google.com>
References: <cover.1464983301.git.mhagger@alum.mit.edu>
	<17da5760ac671c98811cc5a3ec46a61f8261d8d9.1464983301.git.mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain
Cc: David Turner <dturner@twopensource.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Tue Jun 07 19:43:44 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bAL2U-00030p-R4
	for gcvg-git-2@plane.gmane.org; Tue, 07 Jun 2016 19:43:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756053AbcFGRni (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jun 2016 13:43:38 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58301 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752515AbcFGRni (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jun 2016 13:43:38 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id D325D237CD;
	Tue,  7 Jun 2016 13:43:36 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=bLTlYTIQwnBUVBTKpmOA0TW9ITA=; b=N9GCpI
	2uo0iBh1kh5BJzutJXJt5o41D+HNnFdy7Ke/jceHLiBg95UNnd2f2J/7EC6vyqFg
	oyWa5UtRdxRlZtx5YwcxFT8WEzd2irXZT0Qxe/4MZvRW3vXSTUTpU6zLP49mk9aV
	D+EcuTSI/eRMsK9XahQvuzmAh3Q4LYyEikmgw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=wX7xXU406hNc/DeGA+YxccFMzVPxFBtA
	FmpWAQK/3GDzfg3MhEZ80xzJC0HUgleHpnc1fj8s8h+IfDul/5yjh/O8vq2xQsFA
	VrctzckGU6NoGEVV52DnV0/L4w21hJuntblR4nPhyKDVlRfRJUjW2NxFBN1BiBXW
	0kwrBxKkNqA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id CB34B237CB;
	Tue,  7 Jun 2016 13:43:36 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 517A3237CA;
	Tue,  7 Jun 2016 13:43:36 -0400 (EDT)
In-Reply-To: <17da5760ac671c98811cc5a3ec46a61f8261d8d9.1464983301.git.mhagger@alum.mit.edu>
	(Michael Haggerty's message of "Fri, 3 Jun 2016 23:04:09 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 5C9299A4-2CD7-11E6-88E4-89D312518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296703>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> From: David Turner <dturner@twopensource.com>
>
> In the file-based backend, delete_refs has some special optimization
> to deal with packed refs.  In other backends, we might be able to make
> ref deletion faster by putting all deletions into a single
> transaction.  So we need a special backend function for this.
>
> Signed-off-by: David Turner <dturner@twopensource.com>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
> ---
> I think that we could get away without this method if we make
> ref_transactions a bit smarter (for example, by supporting best-effort
> updates that can fail without causing the entire transaction to be
> aborted). But that would be a significant detour, so let's leave it
> here for now.

Hmm, I actually was wondering why 'pack without' was there while
reading 24/38; IIUC, that is one of the "special optimization" that
is very much tied to the files backend, and it may make sense to
hide it behind delete_refs() as its implementation detail.

Which is exactly what this step is about, so I am happy ;-)

Unlike other changes like the ones that did read_raw_ref(),
verify_refname_available(), etc., the title does not follow the
pattern "refs: make X() virtual", even though as far as I can see
the intent is the same as others.  Perhaps a minor retitle is in
order?

>  refs.c               | 7 +++++++
>  refs/files-backend.c | 6 ++++--
>  refs/refs-internal.h | 3 +++
>  3 files changed, 14 insertions(+), 2 deletions(-)
>
> diff --git a/refs.c b/refs.c
> index 6c1e899..8ab9862 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -1529,3 +1529,10 @@ int initial_ref_transaction_commit(struct ref_transaction *transaction,
>  
>  	return refs->be->initial_transaction_commit(refs, transaction, err);
>  }
> +
> +int delete_refs(struct string_list *refnames, unsigned int flags)
> +{
> +	struct ref_store *refs = get_ref_store(NULL);
> +
> +	return refs->be->delete_refs(refs, refnames, flags);
> +}
> diff --git a/refs/files-backend.c b/refs/files-backend.c
> index 253899f..5681141 100644
> --- a/refs/files-backend.c
> +++ b/refs/files-backend.c
> @@ -2455,10 +2455,11 @@ static int delete_ref_loose(struct ref_lock *lock, int flag, struct strbuf *err)
>  	return 0;
>  }
>  
> -int delete_refs(struct string_list *refnames, unsigned int flags)
> +static int files_delete_refs(struct ref_store *ref_store,
> +			     struct string_list *refnames, unsigned int flags)
>  {
>  	struct files_ref_store *refs =
> -		get_files_ref_store(NULL, "delete_refs");
> +		files_downcast(ref_store, 0, "delete_refs");
>  	struct strbuf err = STRBUF_INIT;
>  	int i, result = 0;
>  
> @@ -4070,6 +4071,7 @@ struct ref_storage_be refs_be_files = {
>  	files_pack_refs,
>  	files_peel_ref,
>  	files_create_symref,
> +	files_delete_refs,
>  
>  	files_ref_iterator_begin,
>  	files_read_raw_ref,
> diff --git a/refs/refs-internal.h b/refs/refs-internal.h
> index e462b54..f944b7a 100644
> --- a/refs/refs-internal.h
> +++ b/refs/refs-internal.h
> @@ -485,6 +485,8 @@ typedef int create_symref_fn(struct ref_store *ref_store,
>  			     const char *ref_target,
>  			     const char *refs_heads_master,
>  			     const char *logmsg);
> +typedef int delete_refs_fn(struct ref_store *ref_store,
> +			   struct string_list *refnames, unsigned int flags);
>  
>  /*
>   * Iterate over the references in the specified ref_store that are
> @@ -582,6 +584,7 @@ struct ref_storage_be {
>  	pack_refs_fn *pack_refs;
>  	peel_ref_fn *peel_ref;
>  	create_symref_fn *create_symref;
> +	delete_refs_fn *delete_refs;
>  
>  	ref_iterator_begin_fn *iterator_begin;
>  	read_raw_ref_fn *read_raw_ref;
