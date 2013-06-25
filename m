From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 03/16] pack-objects: use a faster hash table
Date: Tue, 25 Jun 2013 15:48:37 -0700
Message-ID: <7vk3lhzu0q.fsf@alter.siamese.dyndns.org>
References: <1372116193-32762-1-git-send-email-tanoku@gmail.com>
	<1372116193-32762-4-git-send-email-tanoku@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Vicent Marti <tanoku@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 26 00:48:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Urc2X-0004dW-48
	for gcvg-git-2@plane.gmane.org; Wed, 26 Jun 2013 00:48:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751466Ab3FYWsl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Jun 2013 18:48:41 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43057 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751263Ab3FYWsk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Jun 2013 18:48:40 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A98A92BB7E;
	Tue, 25 Jun 2013 22:48:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=yckbLvu6tYtZ8odCxi0+KiwC9+U=; b=oBtn6W
	uxrSat+YMTl9oHJX41D/j1Vcu9LzBH895ENSEj9l0y7X5hSG2rWXkLL+B8a4iipp
	p1f9tKPxZij8iXicMGSwu2iTQ7LqeYlP7yIpdq5WppRN33atDRTEBLseOdhHkofV
	t/I2/+R9ilypCCUzyWEpxGm2/GyAmP8eLcl2w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=GRQe/BhJizgK5fiaJJOfWQMTyUasO8+v
	QDfJ+Cml60jwQCIMU3v5r7l849bdvihckKEIgguYP6De4Az0+gzTjG/p46CStnDe
	R2YVyrCHyPEnarMeMbWMavJjzsIT1nrFclp1RIbhk1GbWPVcx1jSBLA/JlzwEIRH
	U0Cat8fiPTw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9EEB42BB7D;
	Tue, 25 Jun 2013 22:48:39 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E58BE2BB79;
	Tue, 25 Jun 2013 22:48:38 +0000 (UTC)
In-Reply-To: <1372116193-32762-4-git-send-email-tanoku@gmail.com> (Vicent
	Marti's message of "Tue, 25 Jun 2013 01:23:00 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 606E59CC-DDE9-11E2-925C-9B86C9BC06FA-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229010>

Vicent Marti <tanoku@gmail.com> writes:

> @@ -901,19 +896,19 @@ static int no_try_delta(const char *path)
>  	return 0;
>  }
>  
> -static int add_object_entry(const unsigned char *sha1, enum object_type type,
> -			    const char *name, int exclude)
> +static int add_object_entry_1(const unsigned char *sha1, enum object_type type,
> +			    uint32_t hash, int exclude, struct packed_git *found_pack,
> +				off_t found_offset)
>  {
>  	struct object_entry *entry;
> -	struct packed_git *p, *found_pack = NULL;
> -	off_t found_offset = 0;
> -	int ix;
> -	unsigned hash = name_hash(name);
> +	struct packed_git *p;
> +	khiter_t ix;
> +	int hash_ret;
>  
> -	ix = nr_objects ? locate_object_entry_hash(sha1) : -1;
> -	if (ix >= 0) {
> +	ix = kh_put_sha1(packed_objects, sha1, &hash_ret);
> +	if (hash_ret == 0) {
>  		if (exclude) {
> -			entry = objects + object_ix[ix] - 1;
> +			entry = kh_value(packed_objects, ix);
>  			if (!entry->preferred_base)
>  				nr_result--;
>  			entry->preferred_base = 1;

After this, the function returns.  The original did not add to the
table the object name we are looking at, but the new code first adds
it to the table with the unconditional kh_put_sha1() above.  Is a
call to kh_del_sha1() missing here ...

> @@ -921,38 +916,42 @@ static int add_object_entry(const unsigned char *sha1, enum object_type type,
>  		return 0;
>  	}
>  
> -	if (!exclude && local && has_loose_object_nonlocal(sha1))
> +	if (!exclude && local && has_loose_object_nonlocal(sha1)) {
> +		kh_del_sha1(packed_objects, ix);
>  		return 0;

... like this one, which seems to compensate for "ahh, after all we
realize we do not want to add this one to the table"?

> @@ -966,19 +965,30 @@ static int add_object_entry(const unsigned char *sha1, enum object_type type,
>  		entry->in_pack_offset = found_offset;
>  	}
>  
> -	if (object_ix_hashsz * 3 <= nr_objects * 4)
> -		rehash_objects();
> -	else
> -		object_ix[-1 - ix] = nr_objects;
> +	kh_value(packed_objects, ix) = entry;
> +	kh_key(packed_objects, ix) = entry->idx.sha1;
> +	objects[nr_objects++] = entry;
>  
>  	display_progress(progress_state, nr_objects);
>  
> -	if (name && no_try_delta(name))
> -		entry->no_try_delta = 1;
> -
>  	return 1;
>  }
>  
> +static int add_object_entry(const unsigned char *sha1, enum object_type type,
> +			    const char *name, int exclude)
> +{
> +	if (add_object_entry_1(sha1, type, name_hash(name), exclude, NULL, 0)) {
> +		struct object_entry *entry = objects[nr_objects - 1];
> +
> +		if (name && no_try_delta(name))
> +			entry->no_try_delta = 1;
> +
> +		return 1;
> +	}
> +
> +	return 0;
> +}

It is somewhat unclear what we are getting from the split of the
main part of this function into *_1(), other than the *_1() function
now has a very deep indentation inside "if (!found_pack)", which is
always true because the caller always passes NULL to found_pack.
Perhaps this is an unrelated refactoring that is needed for later
steps and does not have anything to do with the use of new hash
function?
