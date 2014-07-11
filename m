From: Karsten Blees <karsten.blees@gmail.com>
Subject: Re: [PATCH v1 3/4] hashmap: add simplified hashmap_get_from_hash()
 API
Date: Fri, 11 Jul 2014 21:11:51 +0200
Message-ID: <53C036F7.5070104@gmail.com>
References: <53B48540.5070600@gmail.com> <53B48613.60509@gmail.com> <xmqqk37pdpzb.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jul 11 21:11:57 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X5gEf-00058D-1W
	for gcvg-git-2@plane.gmane.org; Fri, 11 Jul 2014 21:11:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932364AbaGKTLv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jul 2014 15:11:51 -0400
Received: from mail-we0-f170.google.com ([74.125.82.170]:51237 "EHLO
	mail-we0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932335AbaGKTLt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jul 2014 15:11:49 -0400
Received: by mail-we0-f170.google.com with SMTP id w62so1243925wes.15
        for <git@vger.kernel.org>; Fri, 11 Jul 2014 12:11:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=dlJu4uOHtXvIsxs5ZCPNPwc/NACxDpgnDgJusJjtX9E=;
        b=cVXsqr9lNj32nCb/3E8Uztohe1p+hzU4v3V8G3FdBN2pbD5SObocwv7UZVKcFwSQcQ
         jxbUnrDkZIW4iIqqNEUyCOOKZbyoPRQv1TY3d9KugH581a5kYJ/QZnvz39ALinI6MZIe
         05E+RgdDZqev75PO/6ov/vTZC8pHl8eHvKbJSLDxlYmzHynlEAo2iurKk1RvzdEGUd1p
         h6gahxJR7DH+649l9G2ka+s+utl853IeKW1K83rkzrPOwEUXR13HabDlwSbmQUIzCcK0
         JbWMQVTxAlK21gb9Kqxx863JT69+Ug2rsvA0hkC7apBnM4I6NevSYGp3EA4eaz0W12+Q
         ebwg==
X-Received: by 10.194.173.7 with SMTP id bg7mr968147wjc.3.1405105908091;
        Fri, 11 Jul 2014 12:11:48 -0700 (PDT)
Received: from [10.1.116.52] (ns.dcon.de. [77.244.111.149])
        by mx.google.com with ESMTPSA id pc4sm10436005wic.16.2014.07.11.12.11.47
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 11 Jul 2014 12:11:47 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <xmqqk37pdpzb.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253318>

Am 07.07.2014 19:43, schrieb Junio C Hamano:
> Karsten Blees <karsten.blees@gmail.com> writes:
> 
>> Hashmap entries are typically looked up by just a key. The hashmap_get()
>> API expects an initialized entry structure instead, to support compound
>> keys. This flexibility is currently only needed by find_dir_entry() in
>> name-hash.c (and compat/win32/fscache.c in the msysgit fork). All other
>> (currently five) call sites of hashmap_get() have to set up a near emtpy
> 
> s/emtpy/empty/;
> 
>> entry structure, resulting in duplicate code like this:
>>
>>   struct hashmap_entry keyentry;
>>   hashmap_entry_init(&keyentry, hash(key));
>>   return hashmap_get(map, &keyentry, key);
>>
>> Add a hashmap_get_from_hash() API that allows hashmap lookups by just
>> specifying the key and its hash code, i.e.:
>>
>>   return hashmap_get_from_hash(map, hash(key), key);
> 
> While I think the *_get_from_hash() is an improvement over the
> three-line sequence, I find it somewhat strange that callers of it
> still must compute the hash code themselves, instead of letting the
> hashmap itself to apply the user supplied hash function to the key
> to derive it.  After all, the map must know how to compare two
> entries via a user-supplied cmpfn given at the map initialization
> time, and the algorithm to derive the hash code falls into the same
> category, in the sense that both must stay the same during the
> lifetime of a hashmap, no?  Unless there is a situation where you
> need to be able to initialize a hashmap_entry without knowing which
> hashmap the entry will eventually be stored, it feels dubious API
> that exposes to the outside callers hashmap_entry_init() that takes
> the hash code without taking the hashmap itself.
> 
> In other words, why isn't hashmap_get() more like this:
> 
>         void *hashmap_get(const struct hashmap *map, const void *key)
>         {
>                 struct hashmap_entry keyentry;
>                 hashmap_entry_init(&keyentry, map->hash(key));
>                 return *find_entry_ptr(map, &keyentry, key);
>         }
> 
> with hashmap_entry_init() purely a static helper in hashmap.c?
> 

1. Performance

Calculating hash codes is the most expensive operation when working with
hash tables (unless you already have a good hash such as sha1). And using
hash tables as a cache of some sort is probably the most common use case.
So you'll often have code like this:

1  unsigned int h = hash(key);
2  struct my_entry *e = hashmap_get_from_hash(&map, hash, key);
3  if (!e) {
4    e = malloc(sizeof(*e));
5    hashmap_entry_init(e, h);
6    e->key = key;
6    hashmap_add(&map, e);
7  }

Note that the hash code from line 1 can be reused in line 5. You cannot do
that if calculating the hash code is buried in the implementation.

Callbacks cannot be inlined either...


2. Simplicity

Most APIs take a user defined hashmap_entry structure, so you'd either need
two hash functions, or a hash function that can distinguish between the
'entry' and 'key-only' case, e.g.

  unsigned int my_hash(const struct my_entry *entry, const void *keydata)
  {
    if (keydata)
      return strhash(keydata);
    else
      return strhash(entry->key);
  }

Hashmap clients will typically provide small, type safe wrappers around the
hashmap API. That's perfect for calculating the hash code without breaking
encapsulation. IMO there's no need to make things more complex by requiring
another callback.


3. Compound keys

The key doesn't always consist of just a single word. E.g. for struct
dir_entry, the key is [char *name, int len]. So an API like this:

  void *hashmap_get(const struct hashmap *map, const void *key)

won't do in the general case (unless you require clients to define their
own key structure in addition to the entry structure...).
