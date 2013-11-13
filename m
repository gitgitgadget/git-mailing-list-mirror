From: Karsten Blees <karsten.blees@gmail.com>
Subject: Re: [PATCH v4 02/14] add a hashtable implementation that supports
 O(1) removal
Date: Wed, 13 Nov 2013 17:37:14 +0100
Message-ID: <5283AABA.1070807@gmail.com>
References: <527BA483.6040803@gmail.com> <527BA4F3.3040806@gmail.com>	<xmqq4n7nriuj.fsf@gitster.dls.corp.google.com>	<527CBC8E.6050507@gmail.com> <xmqqtxfmom82.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git List <git@vger.kernel.org>, Thomas Rast <tr@thomasrast.ch>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Nov 13 17:37:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VgdRR-0002yV-13
	for gcvg-git-2@plane.gmane.org; Wed, 13 Nov 2013 17:37:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757443Ab3KMQhR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Nov 2013 11:37:17 -0500
Received: from mail-wg0-f50.google.com ([74.125.82.50]:41147 "EHLO
	mail-wg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755654Ab3KMQhP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Nov 2013 11:37:15 -0500
Received: by mail-wg0-f50.google.com with SMTP id k14so680722wgh.29
        for <git@vger.kernel.org>; Wed, 13 Nov 2013 08:37:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=SrVXxEALeNm0s4nXBTPn0e24PPiqwZ3e2E6YbuutxIM=;
        b=FUukU7KEuY7F2aveM0UfFUDOUuT7K6D7laPD0OYTG2djFZ37gc0mErAC7EDzn0pZ1/
         VwEp5qR0whhkAA269dYmSOKG13ROb3bxujYyR6sgNqRvvOcmoPyWZerVufOhNhYLkmtR
         2ez8P5zwLQKpO9DqR+03gp7gr9p/yV9N47dZm7qe2uQV8CxkqFPLLmrk2X5g6g9ZeRY9
         Xt9K1lsC1Xo+LiWknMLatQbOS1Yryi/3T9p05ROvgZTKv2fejfqsxMZHYFR9itxjRYLv
         hW+ubDjumTGzOjV8BfolLycKAoi6YrCr4MZ/IRN9GZe0R26izJ2Tq5A52PRHG/1WWe15
         DyJQ==
X-Received: by 10.180.11.37 with SMTP id n5mr21303712wib.25.1384360634467;
        Wed, 13 Nov 2013 08:37:14 -0800 (PST)
Received: from [10.1.100.52] (ns.dcon.de. [77.244.111.149])
        by mx.google.com with ESMTPSA id ll10sm57095762wic.9.2013.11.13.08.37.13
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 13 Nov 2013 08:37:13 -0800 (PST)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.1.0
In-Reply-To: <xmqqtxfmom82.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237792>

Am 08.11.2013 18:08, schrieb Junio C Hamano:
> Karsten Blees <karsten.blees@gmail.com> writes:
> 
>> What about this:
>>
>> #define HASHMAP_GROW_AT 80
>> #define HASHMAP_SHRINK_AT 16
> 
> I am not too enthused for three reasons. The fact that these are
> 100-based numbers is not written down anywhere other than the place
> they are used, 

Please forgive me that I didn't properly comment those lines when I tried to express my ideas in a mail :-)

> the places that use these need to consistently divide
> by 100, which invites unnecessary bugs, and compared to the
> original, you now require 16/100 but you didn't even want the exact
> 16% in the first plae (i.e. a simple 1/6 was good enough, and it
> still is).
> 

Actually, we're looking for a value slightly smaller than load-factor / resize-factor (i.e. 0.8 / 4 = 0.2), and 1/6 just happens to be close. However, if we modify the load-factor or resize-factor, we also need to adjust the shrink threshold in some non-obvious way. E.g. with load-factor 0.6, shrink-at must be 1/7. If we grow / shrink by 3 bits, shrink-at must be 1/11...

My current work-in-process version eliminates the _SHRINK_AT constant completely by basing the calculation on load-factor and resize-factor alone (i.e. it works for all values of load-factor and resize-factor without danger of introducing bugs):

/* grow / shrink by 2^2 */
#define HASHMAP_RESIZE_BITS 2
/* load factor in percent */
#define HASHMAP_LOAD_FACTOR 80

static void alloc_table(struct hashmap *map, unsigned int size)
{
	map->tablesize = size;
	map->table = xcalloc(size, sizeof(struct hashmap_entry *));

	/* calculate resize thresholds for new size */
	map->grow_at = (unsigned int) ((uint64_t) size * HASHMAP_LOAD_FACTOR / 100);
	if (size <= HASHMAP_INITIAL_SIZE)
		map->shrink_at = 0;
	else
		/*
		 * The shrink-threshold must be slightly smaller than
		 * (grow-threshold / resize-factor) to prevent erratic resizing,
		 * thus we divide by (resize-factor + 1).
		 */
		map->shrink_at = map->grow_at / ((1 << HASHMAP_RESIZE_BITS) + 1);
}


>>> Perhaps
>>>
>>> #define HASHMAP_GROW_AT(current) ((current) + (current) >> 2)
>>> #define HASHMAP_SHRINK_AT(current) ((current) * 6)
>>> #define HASHMAP_GROW(current) ((current) << 2)
>>> #define HASHMAP_SHRINK(current) ((current) >> 2)
>>>
>>> may alleviate my worries; I dunno.
> 
>>>> +
>>>> +void hashmap_free(struct hashmap *map, hashmap_free_fn free_function)
>>>> +{
>>>
>>> Why is free_function not part of the constants defiend at
>>> hashmap_init() time?  Your API allows the same hashmap, depending on
>>> the way it has been used, to be cleaned up with different
>>> free_function, but I am not sure if that "flexibility" is intended
>>> (and in what application it would be useful).
>>>
>>
>> The free_function is a convenience so you don't have to loop over
>> the entries yourself. ...
>> ...a simple 'to free or not to free' boolean would suffice.
> 
> That is not the "flexibility" I was talking about. Your API allows
> omne to write a single program that does this:
> 
> 	struct hashmap map;
> 
> 	hashmap_init(&map, compare_fn);
>         add/put/remove on map;
> 
> 	if (phase_of_moon())
>         	hashmap_free(&map, free_them_in_one_way);
> 	else
>         	hashmap_free(&map, free_them_in_another_way);
> 
> Just like your _init takes a comparison function to make it clear
> that all entries will be compared using the same function throughout
> the life of the map, if it takes a free function (and you can use
> NULL to mean "do not free, I am managing elements myself"), I would
> think that it will make it clear that the elements in that map will
> be freed the same way.
> 
> And it will allow your _put to call that free function when you
> replace an existing entry with a new one, if that becomes necessary.
> The API in the posted version seems to make it responsibility of the
> caller of _put to do whatever necessary clean-up to the returned
> value (which is the entry that was replaced and no longer in the
> hashmap), but within the context of a patch series whose later patch
> changes the API to replace or remove an entry from the index in such
> a way to shift the responsibility of freeing it from the caller to
> the callee, such a change to this API to make _put and _remove
> responsible for calling per-element free is a possiblity you may
> want to consider, no?
> 

Using an entry after it has been removed is a pretty common use case. E.g. a multi threaded application might want to remove the entry within a mutex and postpone any more expensive cleanup (e.g. updating a file, or even freeing the entry) until after leaving the mutex; A merge algorithm might want to move entries from source maps to a target map. If _remove/_put were also responsible for freeing the entry, you'd have to _get + copy + _remove/_put instead, which is rather complicated and certainly doesn't improve performance.

>From looking through some Java sources (with similar Map.remove API), I get the impression that use-after-remove would also have to be a per-call rather than a per-map decision.

With the current API, removing _and_ freeing an entry is as simple as:

  free(hashmap_remove(...));

So I don't see the need for additional hashmap_remove_and_free() or hashmap_remove(..., int free_entry) APIs.

It's different for hashmap_free, though: no matter how your algorithm worked during the lifetime of the map, you still might want to free remaining entries when cleaning up memory. We could of course remove this feature from hashmap_free to make it absolutely clear that memory management is the responsibility of the caller. Then we'd need additional code whenever freeing entries is necessary:

  struct hashmap_iter iter;
  struct hashmap_entry *e;
  for (e = hashmap_iter_first(map, &iter); e; e = hashmap_iter_next(&iter))
	  free(e);

>>>> +	if (map->tablesize > HASHMAP_INITIAL_SIZE &&
>>>> +	    map->size * HASHMAP_SHRINK_AT < map->tablesize)
>>>> +		rehash(map, map->tablesize >> HASHMAP_GROW);
>>>
>>> This "we shrink by the same amount" looks inconsistent with the use
>>> of separate grow-at and shrink-at constants (see above for four
>>> suggested #define's).
>>>
>>
>> These values account for a small hysteresis so that there is no size at which a sequence of add, remove, add, remove (or put, put, put, put) results in permanent resizes.
> 
> I was commenting on the two bottom lines of the above three line
> quote from the patch.  You use SHIRNK_AT to decide if you want to
> shrink, and you use >>GROW to do the actual shrinking.  Why isn't it
> like this instead?
> 
> 	if (map->tablesize > HASHMAP_INITIAL_SIZE &&
> 	    HASHMAP_SHIRNK_AT(map->size) < map->tablesize)
> 		rehash(map, map->tablesize >> HASHMAP_SHRINK);
> 
> The fact that constant used for shrinking was not called SHRINK but
> GROW was what caught my attention.
> 

Renamed to HASHMAP_RESIZE_BITS.
