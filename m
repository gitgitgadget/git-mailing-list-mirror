From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 02/14] add a hashtable implementation that supports O(1) removal
Date: Fri, 08 Nov 2013 09:08:13 -0800
Message-ID: <xmqqtxfmom82.fsf@gitster.dls.corp.google.com>
References: <527BA483.6040803@gmail.com> <527BA4F3.3040806@gmail.com>
	<xmqq4n7nriuj.fsf@gitster.dls.corp.google.com>
	<527CBC8E.6050507@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>, Thomas Rast <tr@thomasrast.ch>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: Karsten Blees <karsten.blees@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 08 18:08:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VepXi-0007Mn-QK
	for gcvg-git-2@plane.gmane.org; Fri, 08 Nov 2013 18:08:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757642Ab3KHRIS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Nov 2013 12:08:18 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50286 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757506Ab3KHRIS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Nov 2013 12:08:18 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 153C94EF0C;
	Fri,  8 Nov 2013 12:08:17 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=R25ejGWlitSZTj0yqwRzc6hF1BA=; b=AvLCbV
	7dzX1aUNyy+eHfZHTkLKKI8CppyBEBBy7GCGm3+froZ7dmRfHaLDYmtPA2LRvt/J
	/ha8ZP9Z1Tt7kLLhOE1Q7lYl+4sbRsz+JNMddzs40U2g+wj8pO8yVPloj7EmyI9j
	mmOZl7BbOrEGeYGAxataO5RGDRA14Lx7c5+W4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=iDoIVZkgRuvvGpRwdWyXoiqPEY5bASlt
	jSeVGJNIj77ZZ8tmFoBCiLjP0V7iyxLHt78erTzWTcSKHmJVSsZB7Vs67VB5I3UV
	atl0fWZP8BOxSeFplBSrx8yk+1Y///RAu5DZcwMubkiIVwFJs3Sm2tQFGIfITRHK
	10/s9GyUK6Q=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 009604EF0B;
	Fri,  8 Nov 2013 12:08:17 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4652F4EF09;
	Fri,  8 Nov 2013 12:08:15 -0500 (EST)
In-Reply-To: <527CBC8E.6050507@gmail.com> (Karsten Blees's message of "Fri, 08
	Nov 2013 11:27:26 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 5B2A2904-4898-11E3-AA10-1FFB7F2839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237456>

Karsten Blees <karsten.blees@gmail.com> writes:

> What about this:
>
> #define HASHMAP_GROW_AT 80
> #define HASHMAP_SHRINK_AT 16

I am not too enthused for three reasons. The fact that these are
100-based numbers is not written down anywhere other than the place
they are used, the places that use these need to consistently divide
by 100, which invites unnecessary bugs, and compared to the
original, you now require 16/100 but you didn't even want the exact
16% in the first plae (i.e. a simple 1/6 was good enough, and it
still is).

>> Perhaps
>> 
>> #define HASHMAP_GROW_AT(current) ((current) + (current) >> 2)
>> #define HASHMAP_SHRINK_AT(current) ((current) * 6)
>> #define HASHMAP_GROW(current) ((current) << 2)
>> #define HASHMAP_SHRINK(current) ((current) >> 2)
>> 
>> may alleviate my worries; I dunno.

>>> +
>>> +void hashmap_free(struct hashmap *map, hashmap_free_fn free_function)
>>> +{
>> 
>> Why is free_function not part of the constants defiend at
>> hashmap_init() time?  Your API allows the same hashmap, depending on
>> the way it has been used, to be cleaned up with different
>> free_function, but I am not sure if that "flexibility" is intended
>> (and in what application it would be useful).
>> 
>
> The free_function is a convenience so you don't have to loop over
> the entries yourself. ...
> ...a simple 'to free or not to free' boolean would suffice.

That is not the "flexibility" I was talking about. Your API allows
omne to write a single program that does this:

	struct hashmap map;

	hashmap_init(&map, compare_fn);
        add/put/remove on map;

	if (phase_of_moon())
        	hashmap_free(&map, free_them_in_one_way);
	else
        	hashmap_free(&map, free_them_in_another_way);

Just like your _init takes a comparison function to make it clear
that all entries will be compared using the same function throughout
the life of the map, if it takes a free function (and you can use
NULL to mean "do not free, I am managing elements myself"), I would
think that it will make it clear that the elements in that map will
be freed the same way.

And it will allow your _put to call that free function when you
replace an existing entry with a new one, if that becomes necessary.
The API in the posted version seems to make it responsibility of the
caller of _put to do whatever necessary clean-up to the returned
value (which is the entry that was replaced and no longer in the
hashmap), but within the context of a patch series whose later patch
changes the API to replace or remove an entry from the index in such
a way to shift the responsibility of freeing it from the caller to
the callee, such a change to this API to make _put and _remove
responsible for calling per-element free is a possiblity you may
want to consider, no?

>>> +	if (map->tablesize > HASHMAP_INITIAL_SIZE &&
>>> +	    map->size * HASHMAP_SHRINK_AT < map->tablesize)
>>> +		rehash(map, map->tablesize >> HASHMAP_GROW);
>> 
>> This "we shrink by the same amount" looks inconsistent with the use
>> of separate grow-at and shrink-at constants (see above for four
>> suggested #define's).
>> 
>
> These values account for a small hysteresis so that there is no size at which a sequence of add, remove, add, remove (or put, put, put, put) results in permanent resizes.

I was commenting on the two bottom lines of the above three line
quote from the patch.  You use SHIRNK_AT to decide if you want to
shrink, and you use >>GROW to do the actual shrinking.  Why isn't it
like this instead?

	if (map->tablesize > HASHMAP_INITIAL_SIZE &&
	    HASHMAP_SHIRNK_AT(map->size) < map->tablesize)
		rehash(map, map->tablesize >> HASHMAP_SHRINK);

The fact that constant used for shrinking was not called SHRINK but
GROW was what caught my attention.
