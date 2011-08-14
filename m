From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/6] Access reference caches only through new function
 get_cached_refs().
Date: Sun, 14 Aug 2011 15:12:05 -0700
Message-ID: <7vzkjblk22.fsf@alter.siamese.dyndns.org>
References: <1313188589-2330-1-git-send-email-mhagger@alum.mit.edu>
 <1313188589-2330-3-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	Drew Northup <drew.northup@maine.edu>,
	Jakub Narebski <jnareb@gmail.com>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Mon Aug 15 00:12:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qsiuy-0004e6-4G
	for gcvg-git-2@lo.gmane.org; Mon, 15 Aug 2011 00:12:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754761Ab1HNWMJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Aug 2011 18:12:09 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:49499 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754546Ab1HNWMI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Aug 2011 18:12:08 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3451B3042;
	Sun, 14 Aug 2011 18:12:07 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=DkBLA4uu7lJScQG6YRcJSsjlDv8=; b=fht3yc
	Wl0/dtySi+yfoKKzQPkxbS10rtlCJBwev1F5A6TIHPZpHURPLzAxT22H00FyzCTO
	RlywmM+NZDgZwkm4xw36VZql5f00/8sMGTiR51stMp0obsqcafOQa9PMFC72UokM
	4ywjw3HsUgQ+4quSETXrMCj0elg5iC0gRh3xU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=U/LyuK/x0Q1XmcQON413rRGFt6BimZHe
	9fgdUJgpes4M8Bz5A7mxVHax/tA9odw4nURAYfxVrfFuhAJh254UC/ADHCdPdmbM
	+lzBQ8wovU707LvFnQD2ZHsSFHAgV7e/Gp3TQK6DpLUvtrgHk+VBKPAQV8H7mPJR
	K5xOiFq9VkM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2BE963041;
	Sun, 14 Aug 2011 18:12:07 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8E9253040; Sun, 14 Aug 2011
 18:12:06 -0400 (EDT)
In-Reply-To: <1313188589-2330-3-git-send-email-mhagger@alum.mit.edu> (Michael
 Haggerty's message of "Sat, 13 Aug 2011 00:36:25 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 725FDFC4-C6C2-11E0-8257-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179350>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
> ---
>  refs.c |   54 +++++++++++++++++++++++++++++++-----------------------
>  1 files changed, 31 insertions(+), 23 deletions(-)
>
> diff --git a/refs.c b/refs.c
> index b0c8308..89840d7 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -181,9 +181,26 @@ static void clear_cached_refs(struct cached_refs *ca)
>  	ca->did_loose = ca->did_packed = 0;
>  }
>  
> +/*
> + * Return a pointer to a cached_refs for the specified submodule. For
> + * the main repository, use submodule==NULL. The returned structure
> + * will be allocated and initialized but not necessarily populated; it
> + * should not be freed.
> + */
> +static struct cached_refs *get_cached_refs(const char *submodule)
> +{
> +	if (! submodule)

(style) lose the SP before "submodule".

> +		return &cached_refs;
> +	else {
> +		/* For now, don't reuse the refs cache for submodules. */
> +		clear_cached_refs(&submodule_refs);
> +		return &submodule_refs;
> +	}
> +}
> +
>  static void invalidate_cached_refs(void)
>  {
> -	clear_cached_refs(&cached_refs);
> +	clear_cached_refs(get_cached_refs(NULL));
>  }
>  
>  static void read_packed_refs(FILE *f, struct cached_refs *cached_refs)
> @@ -234,19 +251,14 @@ void clear_extra_refs(void)
>  
>  static struct ref_list *get_packed_refs(const char *submodule)
>  {
> -	const char *packed_refs_file;
> -	struct cached_refs *refs;
> +	struct cached_refs *refs = get_cached_refs(submodule);
>  
> -	if (submodule) {
> -		packed_refs_file = git_path_submodule(submodule, "packed-refs");
> -		refs = &submodule_refs;
> -		free_ref_list(refs->packed);
> -	} else {
> -		packed_refs_file = git_path("packed-refs");
> -		refs = &cached_refs;
> -	}
> -
> -	if (!refs->did_packed || submodule) {
> +	if (!refs->did_packed) {
> +		const char *packed_refs_file;
> +		if (submodule)
> +			packed_refs_file = git_path_submodule(submodule, "packed-refs");
> +		else
> +			packed_refs_file = git_path("packed-refs");
>  		FILE *f = fopen(packed_refs_file, "r");

decl-after-statement.

>  		refs->packed = NULL;
>  		if (f) {
> @@ -361,17 +373,13 @@ void warn_dangling_symref(FILE *fp, const char *msg_fmt, const char *refname)
>  
>  static struct ref_list *get_loose_refs(const char *submodule)
>  {
> -	if (submodule) {
> -		free_ref_list(submodule_refs.loose);
> -		submodule_refs.loose = get_ref_dir(submodule, "refs", NULL);
> -		return submodule_refs.loose;
> -	}
> +	struct cached_refs *refs = get_cached_refs(submodule);
>  
> -	if (!cached_refs.did_loose) {
> -		cached_refs.loose = get_ref_dir(NULL, "refs", NULL);
> -		cached_refs.did_loose = 1;
> +	if (!refs->did_loose) {
> +		refs->loose = get_ref_dir(submodule, "refs", NULL);
> +		refs->did_loose = 1;
>  	}
> -	return cached_refs.loose;
> +	return refs->loose;
>  }
>  
>  /* We allow "recursive" symbolic refs. Only within reason, though */
