From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 03/25] object_array: factor out slopbuf-freeing logic
Date: Thu, 16 Oct 2014 10:39:54 -0700
Message-ID: <xmqqr3y7ud5h.fsf@gitster.dls.corp.google.com>
References: <20141015223244.GA25368@peff.net>
	<20141015223419.GC25630@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Oct 16 19:40:11 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xep22-0004wx-OE
	for gcvg-git-2@plane.gmane.org; Thu, 16 Oct 2014 19:40:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751604AbaJPRkE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Oct 2014 13:40:04 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:63420 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751433AbaJPRkD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Oct 2014 13:40:03 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id EA86213FD9;
	Thu, 16 Oct 2014 13:39:56 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=fPSvdT5T0P+O/8osDEYINmCOXHs=; b=AMqihF
	r6EILZIMp/x3f34xekllSLPprn+z0+0vD2tOjJyu1c6m5pvoJG+eIT6TnMOweOYg
	SsN3bNEI8SWPrpinCIFO+qh/aCcS4mkgW+fWRsoS2HXNNexMOP3SmDhfxTvHVVUK
	2C3ZEx+Kr24gAnX4YFN/AJ6uq0KTxCdZkV88A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=eLbH7d2Cnd2G6HZUd0lAzUEJh5of7Uxy
	xxDItW6zAB1dO5+iouoA0AJqlksbUPkLVp9rzPUuigUOIIuNdfVXBMrWGLDJ6JCq
	BJ2zBtYCEutJEM/3iE43STvZOo97uDIbgVXErjwlsyiGjERkRcxfk79InS7G3+Fk
	UajGbzRY9vM=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E25E813FD8;
	Thu, 16 Oct 2014 13:39:56 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 6B70213FD5;
	Thu, 16 Oct 2014 13:39:56 -0400 (EDT)
In-Reply-To: <20141015223419.GC25630@peff.net> (Jeff King's message of "Wed,
	15 Oct 2014 18:34:19 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 719D510E-555B-11E4-B436-855A93717476-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> This is not a lot of code, but it's a logical construct that
> should not need to be repeated (and we are about to add a
> third repetition).

Good, but I have two and a half tangential comments about the
context that appears in this patch ;-)

>  void object_array_filter(struct object_array *array,
>  			 object_array_each_func_t want, void *cb_data)
>  {
> @@ -367,8 +377,7 @@ void object_array_filter(struct object_array *array,
>  				objects[dst] = objects[src];
>  			dst++;
>  		} else {
> -			if (objects[src].name != object_array_slopbuf)
> -				free(objects[src].name);
> +			object_array_release_entry(&objects[src]);
>  		}
>  	}
>  	array->nr = dst;
> @@ -400,8 +409,7 @@ void object_array_remove_duplicates(struct object_array *array)
>  				objects[array->nr] = objects[src];
>  			array->nr++;
>  		} else {
> -			if (objects[src].name != object_array_slopbuf)
> -				free(objects[src].name);
> +			object_array_release_entry(&objects[src]);
>  		}
>  	}
>  }

 1.  These two functions both remove elements from a given array
     in-place, the former being in a more generic form that takes a
     caller-specified criterion while the latter uses a hardcoded
     condition to decide what to filter.  aeb4a51e (object_array:
     add function object_array_filter(), 2013-05-25) and later
     1506510c (object_array_remove_duplicates(): rewrite to reduce
     copying, 2013-05-25) should have refactored the latter further
     to implement it in terms of the former, perhaps?

 1.5 I would have expected a function to "remove duplicates from an
     array" to remove duplicates from the array by comparing the objects
     contained in the array, not entries that may (or may not) point at
     different objects but happens to share the same name; I think this
     function is misnamed.

 2.  We use object_array_remove_duplicates() to de-dup "git bundle
     create x master master", which came from b2a6d1c6 (bundle:
     allow the same ref to be given more than once, 2009-01-17),
     which is still the sole caller of the function, and I think
     this is bogus.  Comparing .name would not de-dup "git bundle
     create x master refs/heads/master".

I think the right way to fix these two and a half problems is to do
the following:

 - object_array_remove_duplicates() (and contains_name() helper it
   uses) should be removed from object.c;

 - create_bundle() in bundle.c should implement a helper that is
   similar to contains_name() but knows about ref dwimming and use
   it to call object_array_filter() to replace its call to
   object_array_remove_duplicates().

I am not doing this myself, and I do not expect either you or
Michael to do so, either.  I am just writing this down to point out
a low hanging fruit to aspiring new contributors (hint, hint).

Thanks.
