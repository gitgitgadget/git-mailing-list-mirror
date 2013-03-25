From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/3] Refactor parts of
 in_delta_base_cache/cache_or_unpack_entry
Date: Mon, 25 Mar 2013 16:15:41 -0700
Message-ID: <7vtxnzul42.fsf@alter.siamese.dyndns.org>
References: <cover.1364234154.git.trast@student.ethz.ch>
 <987ab8138000d0aaa7d1bb6242cced1344e4d339.1364234154.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>, Stefan Zager <szager@google.com>,
	Jeff King <peff@peff.net>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	"Nicolas Pitre" <nico@fluxnic.net>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Tue Mar 26 00:16:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UKGcf-0007xZ-8Z
	for gcvg-git-2@plane.gmane.org; Tue, 26 Mar 2013 00:16:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759055Ab3CYXPp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Mar 2013 19:15:45 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:49316 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754873Ab3CYXPo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Mar 2013 19:15:44 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4A6D9BAE1;
	Mon, 25 Mar 2013 19:15:43 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=+T9ro4/4d5E1ZU0G0ITmtYjcn2M=; b=AB1SnU
	BPzjLTgXqJ6roAJziTwPbqKY74u55SYSlNjYcl8fFbwbi01sL2qLlHkc6AgpCLth
	KV4rEOgS1dLGyoXEohmClNwrzzxL2/g///okpcecEwF5QCsC2IHC3ojSxNRhRRXg
	I8Odt3dbhD3uFDJdcJGdpFJdpNl2s14OU6j3M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=E8GDV88L4hVbGO9i6JpXR2E3sbTyMjEV
	2d9lfVkMRcemB2tH6bvfzay2BG5hZ3P1pS2ZQoF4HZlEyNhllJqoOvHrwL/nhwxe
	lNwnOOPFSDKjaKYK7zSahH4B86wYC7jLTnZ0CcAOoVA4AzvHffwGVqe1p+a0NbkJ
	rxsgxdcj8QQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3D98EBAE0;
	Mon, 25 Mar 2013 19:15:43 -0400 (EDT)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 84B8BBADF; Mon, 25 Mar 2013
 19:15:42 -0400 (EDT)
In-Reply-To: <987ab8138000d0aaa7d1bb6242cced1344e4d339.1364234154.git.trast@student.ethz.ch> (Thomas Rast's message of "Mon, 25 Mar 2013 19:07:40 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: EA2FB542-95A1-11E2-A429-EA7A2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219116>

Thomas Rast <trast@student.ethz.ch> writes:

> The delta base cache lookup and test were shared.  Refactor them;
> we'll need both parts again.  Also, we'll use the clearing routine
> later.
>
> Signed-off-by: Thomas Rast <trast@student.ethz.ch>
> ---

Looks like a very straight-forward rewrite.

The only little concern I may have is this cmp_* function tells us
"I found it!" by returning true, which is counter-intuitive to the
readers of the caller (not the callee).

I think it makes sense to compare delta-base-cache entries only for
equality, so eq-delta-base-cache-entry might be a better name for
it, perhaps?

>  sha1_file.c | 45 ++++++++++++++++++++++++++++++++-------------
>  1 file changed, 32 insertions(+), 13 deletions(-)
>
> diff --git a/sha1_file.c b/sha1_file.c
> index 71877a7..bd054d1 100644
> --- a/sha1_file.c
> +++ b/sha1_file.c
> @@ -1756,32 +1756,51 @@ static unsigned long pack_entry_hash(struct packed_git *p, off_t base_offset)
>  	return hash % MAX_DELTA_CACHE;
>  }
>  
> -static int in_delta_base_cache(struct packed_git *p, off_t base_offset)
> +static struct delta_base_cache_entry *
> +get_delta_base_cache_entry(struct packed_git *p, off_t base_offset)
>  {
>  	unsigned long hash = pack_entry_hash(p, base_offset);
> -	struct delta_base_cache_entry *ent = delta_base_cache + hash;
> +	return delta_base_cache + hash;
> +}
> +
> +static int cmp_delta_base_cache_entry(struct delta_base_cache_entry *ent,
> +				      struct packed_git *p, off_t base_offset)
> +{
>  	return (ent->data && ent->p == p && ent->base_offset == base_offset);
>  }
>  
> +static int in_delta_base_cache(struct packed_git *p, off_t base_offset)
> +{
> +	struct delta_base_cache_entry *ent;
> +	ent = get_delta_base_cache_entry(p, base_offset);
> +	return cmp_delta_base_cache_entry(ent, p, base_offset);
> +}
> +
> +static void clear_delta_base_cache_entry(struct delta_base_cache_entry *ent)
> +{
> +	ent->data = NULL;
> +	ent->lru.next->prev = ent->lru.prev;
> +	ent->lru.prev->next = ent->lru.next;
> +	delta_base_cached -= ent->size;
> +}
> +
>  static void *cache_or_unpack_entry(struct packed_git *p, off_t base_offset,
>  	unsigned long *base_size, enum object_type *type, int keep_cache)
>  {
> +	struct delta_base_cache_entry *ent;
>  	void *ret;
> -	unsigned long hash = pack_entry_hash(p, base_offset);
> -	struct delta_base_cache_entry *ent = delta_base_cache + hash;
>  
> -	ret = ent->data;
> -	if (!ret || ent->p != p || ent->base_offset != base_offset)
> +	ent = get_delta_base_cache_entry(p, base_offset);
> +
> +	if (!cmp_delta_base_cache_entry(ent, p, base_offset))
>  		return unpack_entry(p, base_offset, type, base_size);
>  
> -	if (!keep_cache) {
> -		ent->data = NULL;
> -		ent->lru.next->prev = ent->lru.prev;
> -		ent->lru.prev->next = ent->lru.next;
> -		delta_base_cached -= ent->size;
> -	} else {
> +	ret = ent->data;
> +
> +	if (!keep_cache)
> +		clear_delta_base_cache_entry(ent);
> +	else
>  		ret = xmemdupz(ent->data, ent->size);
> -	}
>  	*type = ent->type;
>  	*base_size = ent->size;
>  	return ret;
