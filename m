From: Karsten Blees <karsten.blees@gmail.com>
Subject: Re: [PATCH] name-hash.c: fix endless loop with core.ignorecase=true
Date: Wed, 27 Feb 2013 22:52:20 +0100
Message-ID: <512E8014.3090107@gmail.com>
References: <CACsJy8CEHzqH1X=v4yau0SyZwrZp1r6hNp=yXD+eZh1q_BS-0g@mail.gmail.com> <CALkWK0=6_n4rf6AWci6J+uhGHpjTUmK7YFdVHuSJedN2zLWtMA@mail.gmail.com> <CACsJy8DeM5--WVXg3b65RxLBS7Jho-7KmcGwWk7B5uAx77yOEw@mail.gmail.com> <20130210111732.GA24377@lanh> <CABPQNSZ282Lre=sy-+ZQdJA9JnGqQguq2bQDOwvjb0fP+1-w8Q@mail.gmail.com> <CACsJy8AWyJ=dW5f44huWyPPe4X62xyi+R9CNM5Tg6u6TYf+thQ@mail.gmail.com> <511AAA92.4030508@gmail.com> <CACsJy8C=2xKcsby048WWCFNhgKObGwrzeCOJPVVqgj88AfSHQw@mail.gmail.com> <20130213181851.GA5603@sigill.intra.peff.net> <511BF6D7.3030404@gmail.com> <20130213225529.GA25353@sigill.intra.peff.net> <511C3454.6080204@gmail.com> <512E1C0F.3050506@gmail.com> <7v621dk8aa.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, Duy Nguyen <pclouds@gmail.com>,
	kusmabite@gmail.com, Ramkumar Ramachandra <artagnon@gmail.com>,
	Robert Zeh <robert.allan.zeh@gmail.com>,
	Git List <git@vger.kernel.org>, finnag@pvv.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 27 22:52:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UAove-0005iT-Sm
	for gcvg-git-2@plane.gmane.org; Wed, 27 Feb 2013 22:52:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757085Ab3B0VwV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Feb 2013 16:52:21 -0500
Received: from mail-ee0-f47.google.com ([74.125.83.47]:36682 "EHLO
	mail-ee0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756950Ab3B0VwU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Feb 2013 16:52:20 -0500
Received: by mail-ee0-f47.google.com with SMTP id e52so908038eek.6
        for <git@vger.kernel.org>; Wed, 27 Feb 2013 13:52:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:message-id:date:from:user-agent:mime-version:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=VcC/fghIuhUjJkVLOL9+w7i6xlg7Q9tnBuJfpxDOMP0=;
        b=qpS/qriDxtGO4ZlgrQYHRO5b6AjWq6nHEFwQ+C5NL+rSnAo/E/PNKHJnh0tdy1ZO6I
         8oePWOSP7hCP7fSHO3a/qeTl0VkCkGmD/MbPJRS33DGJ0XfdXhQknE4itsbzry3k9Ot/
         pLxqYlDN37Klfa800oEnbtNZjwItUL6YSzpW63NzxMEodJvb5UX4jUFyiO3DaHqpbNLz
         4LROjQfdnqFKwbklZWQCXyWsl7L9nj0UIURuDd1jsA2H7USGjh6xaxvgzSQS99jByUx+
         6aps2UMLYxLrciuY/I+PL0afXEFiTRcpKe4CRbLhmBtTpfvUyq959SW+OKjiO142JZBs
         8hyQ==
X-Received: by 10.15.23.193 with SMTP id h41mr10083447eeu.17.1362001938177;
        Wed, 27 Feb 2013 13:52:18 -0800 (PST)
Received: from [10.1.100.50] (ns.dcon.de. [77.244.111.149])
        by mx.google.com with ESMTPS id 3sm8496237eej.6.2013.02.27.13.52.16
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 27 Feb 2013 13:52:17 -0800 (PST)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:17.0) Gecko/20130215 Thunderbird/17.0.3
In-Reply-To: <7v621dk8aa.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217224>

Am 27.02.2013 17:53, schrieb Junio C Hamano:
> Karsten Blees <karsten.blees@gmail.com> writes:
> 
>> With core.ignorecase=true, name-hash.c builds a case insensitive index of
>> all tracked directories. Currently, the existing cache entry structures are
>> added multiple times to the same hashtable (with different name lengths and
>> hash codes). However, there's only one dir_next pointer, which gets
>> completely messed up in case of hash collisions. In the worst case, this
>> causes an endless loop if ce == ce->dir_next:
>>
>> ---8<---
>> # "V/", "V/XQANY/" and "WURZAUP/" all have the same hash_name
>> mkdir V
>> mkdir V/XQANY
>> mkdir WURZAUP
>> touch V/XQANY/test
>> git init
>> git config core.ignorecase true
>> git add .
>> git status
>> ---8<---
> 
> Instead of using the scissors mark to confuse "am -c", indenting
> this block would have been easier to later readers.
> 
> Also it is somewhat a shame that we do not use the above sample
> collisions in a new test case.
> 

Duly noted.

Is there a way to run 'git status' with timeout? A test that doesn't complete (instead of failing) isn't nice...

>> +static struct dir_entry *hash_dir_entry(struct index_state *istate,
>> +		struct cache_entry *ce, int namelen, int add)
>>  {
>>  	/*
>>  	 * Throw each directory component in the hash for quick lookup
>>  	 * during a git status. Directory components are stored with their
>> -	 * closing slash.  Despite submodules being a directory, they never
>> -	 * reach this point, because they are stored without a closing slash
>> -	 * in the cache.
> 
> Is the description of submodule no longer relevant?
> 
>> -	 * Note that the cache_entry stored with the directory does not
>> -	 * represent the directory itself.  It is a pointer to an existing
>> -	 * filename, and its only purpose is to represent existence of the
>> -	 * directory in the cache.  It is very possible multiple directory
>> -	 * hash entries may point to the same cache_entry.
> 
> Is this paragraph no longer relevant?  It seems to me that it still
> holds true, given the way how dir->ce points at the given ce.
> 

I interpreted this as an explanation why it was safe to add the same cache_entry to the same name_hash multiple times...now that we have separate dir_entries and index_state.dir_hash, that's no longer a problem. But rereading that paragraph again, it is still mostly true (except for the 'existance' part, which is solved by reference counting).

>> +	 * closing slash.
>>  	 */
>> +	struct dir_entry *dir, *p;
>> +
>> +	/* get length of parent directory */
>> +	while (namelen > 0 && !is_dir_sep(ce->name[namelen - 1]))
>> +		namelen--;
>> +	if (namelen <= 0)
>> +		return NULL;
>> +
>> +	/* lookup existing entry for that directory */
>> +	dir = find_dir_entry(istate, ce->name, namelen);
>> +	if (add && !dir) {
>> ...
>>  	}
>> +
>> +	/* add or release reference to this entry (and parents if 0) */
>> +	p = dir;
>> +	if (add) {
>> +		while (p && !(p->nr++))
>> +			p = p->parent;
>> +	} else {
>> +		while (p && p->nr && !(--p->nr))
>> +			p = p->parent;
>> +	}
> 
> Can we free the entry when its refcnt goes down to zero?  If yes, is
> it worth doing so?
> 

There's no remove_hash in hash.[ch], and dir_entry.next may point to another dir_entry with the same hash code, so we must not free the memory (same problem as CE_UNHASHED).

>> +
>> +	return dir;
>>  }
>>  
>>  static void hash_index_entry(struct index_state *istate, struct cache_entry *ce)
>> @@ -74,7 +111,7 @@ static void hash_index_entry(struct index_state *istate, struct cache_entry *ce)
>>  	if (ce->ce_flags & CE_HASHED)
>>  		return;
>>  	ce->ce_flags |= CE_HASHED;
>> -	ce->next = ce->dir_next = NULL;
>> +	ce->next = NULL;
>>  	hash = hash_name(ce->name, ce_namelen(ce));
>>  	pos = insert_hash(hash, ce, &istate->name_hash);
>>  	if (pos) {
>> @@ -82,8 +119,8 @@ static void hash_index_entry(struct index_state *istate, struct cache_entry *ce)
>>  		*pos = ce;
>>  	}
>>  
>> -	if (ignore_case)
>> -		hash_index_entry_directories(istate, ce);
>> +	if (ignore_case && !(ce->ce_flags & CE_UNHASHED))
>> +		hash_dir_entry(istate, ce, ce_namelen(ce), 1);
>>  }
>>  
>>  static void lazy_init_name_hash(struct index_state *istate)
>> @@ -99,11 +136,33 @@ static void lazy_init_name_hash(struct index_state *istate)
>>  
>>  void add_name_hash(struct index_state *istate, struct cache_entry *ce)
>>  {
>> +	/* if already hashed, add reference to directory entries */
>> +	if (ignore_case && (ce->ce_flags & CE_STATE_MASK) == CE_STATE_MASK)
>> +		hash_dir_entry(istate, ce, ce_namelen(ce), 1);
> 
> Instead of a single function with "are we adding or removing?"
> parameter, it would be a lot easier to read the callers if they are
> wrapped in two helpers, add_dir_entry() and del_dir_entry() or
> something, especially when the add=[0|1] parameter is constant for
> each and every callsite (i.e. the codeflow determines it, not the
> data).
> 

OK

>>  	ce->ce_flags &= ~CE_UNHASHED;
>>  	if (istate->name_hash_initialized)
>>  		hash_index_entry(istate, ce);
>>  }
>>  
>> +/*
>> + * We don't actually *remove* it, we can just mark it invalid so that
>> + * we won't find it in lookups.
>> + *
>> + * Not only would we have to search the lists (simple enough), but
>> + * we'd also have to rehash other hash buckets in case this makes the
>> + * hash bucket empty (common). So it's much better to just mark
>> + * it.
>> + */
>> +void remove_name_hash(struct index_state *istate, struct cache_entry *ce)
>> +{
>> +	/* if already hashed, release reference to directory entries */
>> +	if (ignore_case && (ce->ce_flags & CE_STATE_MASK) == CE_HASHED)
>> +		hash_dir_entry(istate, ce, ce_namelen(ce), 0);
> 
> And here as well.
> 
>> +
>> +	ce->ce_flags |= CE_UNHASHED;
>> +}
>> +
>>  static int slow_same_name(const char *name1, int len1, const char *name2, int len2)
>>  {
>>  	if (len1 != len2)
>> @@ -137,18 +196,7 @@ static int same_name(const struct cache_entry *ce, const char *name, int namelen
>>  	if (!icase)
>>  		return 0;
>>  
>> -	/*
>> -	 * If the entry we're comparing is a filename (no trailing slash), then compare
>> -	 * the lengths exactly.
>> -	 */
>> -	if (name[namelen - 1] != '/')
>> -		return slow_same_name(name, namelen, ce->name, len);
>> -
>> -	/*
>> -	 * For a directory, we point to an arbitrary cache_entry filename.  Just
>> -	 * make sure the directory portion matches.
>> -	 */
>> -	return slow_same_name(name, namelen, ce->name, namelen < len ? namelen : len);
>> +	return slow_same_name(name, namelen, ce->name, len);
> 
> Hmph, what is this change about?  Nobody calls same_name() with a
> directory name anymore or something?
> 

dir_entries (with trailing /) are in index_state.dir_hash, so we wouldn't expect to find anything in index_state.name_hash, especially not a cache_entry. find_dir_entry simply uses strncasecmp, as we only do directory indexing with core.ignorecase=true.

> Thanks.
> 
