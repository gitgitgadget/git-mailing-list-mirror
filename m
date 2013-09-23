From: Karsten Blees <karsten.blees@gmail.com>
Subject: Re: [PATCH/RFC 1/5] add a hashtable implementation that supports
 O(1) removal
Date: Mon, 23 Sep 2013 11:16:45 +0200
Message-ID: <524006FD.2010604@gmail.com>
References: <522FAAC4.2080601@gmail.com> <522FAB19.3080704@gmail.com> <xmqqtxhqrjzf.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Sep 23 11:16:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VO2GC-0006CN-1C
	for gcvg-git-2@plane.gmane.org; Mon, 23 Sep 2013 11:16:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753512Ab3IWJQr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Sep 2013 05:16:47 -0400
Received: from mail-wg0-f45.google.com ([74.125.82.45]:35895 "EHLO
	mail-wg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753020Ab3IWJQq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Sep 2013 05:16:46 -0400
Received: by mail-wg0-f45.google.com with SMTP id y10so2838010wgg.0
        for <git@vger.kernel.org>; Mon, 23 Sep 2013 02:16:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=dVWjPE8A5jFklJatTLWOYY10bnz/AfOXWT+XAhsRH2Q=;
        b=HPsiXmJNLmBT/1Ytw+81JVj2sywdGVz2S2K6rkb6Zz9bmGdn9/ZFFh1Ar4QgL5hNDt
         Kn7ZrJ4rGEU2I5nd8HxSK0aANaIx74qXew3m0MPAtXwfYaq2F+VcAlKz5gan2cf44SS/
         8ZjNbGfp0B8eHX3SCxcH5cvv8H0vrSEt5XR7E3A7cU6CxTgJmmf5pYGSa/8BbB/FJORA
         /ihH1OHEIa+2b8QGTRe2fjL66VzGxBK8pLS4Snz9OtuMg5afYKrng+QkhWqO8LRmbxUo
         Wgla3DvBHuiJOdfnEtJaIVVmDLTQG37y3oZ+X8JwkTic67LtnqyrSvC1Rgv4w3I6yK1z
         zPcQ==
X-Received: by 10.180.20.77 with SMTP id l13mr12641641wie.40.1379927805715;
        Mon, 23 Sep 2013 02:16:45 -0700 (PDT)
Received: from [10.1.100.51] (ns.dcon.de. [77.244.111.149])
        by mx.google.com with ESMTPSA id jf2sm24179598wic.2.1969.12.31.16.00.00
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 23 Sep 2013 02:16:45 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:17.0) Gecko/20130801 Thunderbird/17.0.8
In-Reply-To: <xmqqtxhqrjzf.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235203>

Sorry for the delay, I've been on vacation...

Am 12.09.2013 01:56, schrieb Junio C Hamano:
> Karsten Blees <karsten.blees@gmail.com> writes:
> 
>> +#define FNV32_BASE ((unsigned int) 0x811c9dc5)
>> +#define FNV32_PRIME ((unsigned int) 0x01000193)
>> + ...
>> +static inline unsigned int bucket(const hashmap *map, const hashmap_entry *key)
>> +{
>> +	return key->hash & (map->tablesize - 1);
>> +}
> 
> As tablesize would hopefully be reasonably small, not worrying about
> platforms' "unsigned int" being 64-bit (in which case it would be
> more appropriate to compute with FNV64_PRIME) should be fine.
> 
>> +static inline hashmap_entry **find_entry(const hashmap *map,
>> +		const hashmap_entry *key)
>> +{
>> +	hashmap_entry **e = &map->table[bucket(map, key)];
>> +	while (*e && !entry_equals(map, *e, key))
>> +		e = &(*e)->next;
>> +	return e;
>> +}
> 
> (mental note) This finds the location the pointer to the entry is
> stored, not the entry itself.
> 

Will rename to find_entry_ptr to make this clear

>> +void *hashmap_get(const hashmap *map, const void *key)
>> +{
>> +	return *find_entry(map, key);
>> +}
> 
> ... which is consistent with this, and more importantly, it is
> crucial for hashmap_remove()'s implementation, because...
> 
>> +void *hashmap_remove(hashmap *map, const void *key)
>> +{
>> +	hashmap_entry *old;
>> +	hashmap_entry **e = find_entry(map, key);
>> +	if (!*e)
>> +		return NULL;
>> +
>> +	/* remove existing entry */
>> +	old = *e;
>> +	*e = old->next;
> 
> ... this wants to update the linked list in place.
> 
> Looking good.
> 
> I however wonder if the singly linked linear chain is a really good
> alternative for the access pattern of the hashes we use, though.

I don't think it will make a big difference in lookup performance, especially with good hash codes (such as the first bytes of a sha1). In theory, chaining should be slightly faster, because entries are strictly confined to their buckets (i.e. no extraneous entries need to be traversed when looking up an entry). With uniform hash distribution, chaining should require (1 + loadfactor) comparisons to find an entry, while open addressing requires (1/(1 - loadfactor)) [1]. I'll add a performance test for lookups, though.

[1] http://en.wikipedia.org/wiki/Hash_table#Performance_analysis

> Do we really want to trigger growth on the bucket load factor, not the
> length of the longest chain, for example?
> 

With good hashes and a load factor < 1, the longest 'chain' is 1. We only get chains in case of collisions, which however cannot necessarily be resolved by resizing. E.g. in the worst case, all entries have the same hash code, which deforms the hash table into a long linked list in a single bucket. Resizing won't change that.

An alternative would be to resize on the number of used buckets instead of total entries. I.e. with exceptionally bad hash codes and lots of collisions, we at least don't waste memory by making the table unnecessarily large. However, I don't think this is worth the extra effort.

>> +	old->next = NULL;
>> +
>> +	/* fix size and rehash if appropriate */
>> +	map->size--;
>> +	if (map->tablesize > HASHMAP_INITIAL_SIZE &&
>> +		map->size * HASHMAP_SHRINK_AT < map->tablesize)
>> +		rehash(map, map->tablesize >> HASHMAP_GROW);
> 
> Please align the first two lines so that the first non-whitespace on
> the second line of the condition part of the "if" statement
> (i.e. 'm') aligns with the first non-whitespace inside the '(' open
> parenthesis (i.e. 'm').
> 

Will do.
