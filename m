From: =?UTF-8?Q?Vicent_Mart=C3=AD?= <tanoku@gmail.com>
Subject: Re: What's cooking in git.git (Oct 2013, #06; Fri, 25)
Date: Mon, 28 Oct 2013 22:04:17 +0100
Message-ID: <CAFFjANRaphYdg6VM8cqJY3NmPz+gNE7S9S1jAgPPctUZio7+Tw@mail.gmail.com>
References: <xmqqeh79hr3o.fsf@gitster.dls.corp.google.com> <CACsJy8A3s4TUmUOC+i-k97GxxvBQ7mQmdoPJizfy1yS3rqLEkA@mail.gmail.com>
 <xmqq61shgzvn.fsf@gitster.dls.corp.google.com> <CAFFjANSnuS6_+uAd43AayojJyK-wj2wMxQ6DBD6JyN=A7xh2_A@mail.gmail.com>
 <526EBEE8.7070807@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Cc: Junio C Hamano <gitster@pobox.com>, Duy Nguyen <pclouds@gmail.com>,
	Karsten Blees <blees@dcon.de>,
	Git Mailing List <git@vger.kernel.org>,
	Jeff King <peff@peff.net>
To: Karsten Blees <karsten.blees@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 28 22:04:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VatzT-0002Gd-W1
	for gcvg-git-2@plane.gmane.org; Mon, 28 Oct 2013 22:04:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755615Ab3J1VEj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Oct 2013 17:04:39 -0400
Received: from mail-ve0-f177.google.com ([209.85.128.177]:44357 "EHLO
	mail-ve0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753359Ab3J1VEi convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 28 Oct 2013 17:04:38 -0400
Received: by mail-ve0-f177.google.com with SMTP id oz11so5410812veb.36
        for <git@vger.kernel.org>; Mon, 28 Oct 2013 14:04:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=pRBlnRBuS83gfThmdP0SCryjranWLjGrpRwKN5Qjr8A=;
        b=mozahoTP2/FKxVFFSr6Ro8TV28MWndmzeBmakXU2U//URkr74eToCz87hT8JKbboW4
         FoEcMQrvjiNBmX0nqK6MgL2YuiVmwMyFBeO3B2hPhbmsLoS1NHDnzgmCCvZpzh60fAJO
         /q2k3JvSUNSstJHHWLWkYNpGtfMwQCGl+mtd7r2oyJsmJ3pMCts7Nfkz7+hBeTm91+yy
         Opm9SuF9g5TOkqRC1e+/VxlV+6I9ankFAhX1+JOuLXC+lJDImd91JW85OUmNxLJa+Xyn
         rNgwbEAFKJ4m3+5NJXfIGO3WjGwBATbMboH2iRzcnv8dWRMUhI6FO93lfT+6X8b1nztr
         IXGg==
X-Received: by 10.58.210.39 with SMTP id mr7mr14798801vec.18.1382994277491;
 Mon, 28 Oct 2013 14:04:37 -0700 (PDT)
Received: by 10.221.65.202 with HTTP; Mon, 28 Oct 2013 14:04:17 -0700 (PDT)
In-Reply-To: <526EBEE8.7070807@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236860>

On Mon, Oct 28, 2013 at 8:45 PM, Karsten Blees <karsten.blees@gmail.com> wrote:
>> The new `hashmap.c` covers the first case quite well (albeit slightly
>> more verbosely than I'd like), but in the second case it doesn't quite
>> work. Since the new hash needs to embed the "struct hashmap_entry" on
>> all its values (to allow for separate chaining), having it map to
>> `int` keys requires a struct like this:
>>
>>     struct sha1_position {
>>         struct hashmap_entry {
>>             struct hashmap_entry *next;
>>             unsigned int hash;
>>         };
>>         int position;
>>     }
>>
>
> Hmm...isn't that position rather an index into two separately maintained arrays? So you'd rather have:
>
>     struct sha1_position {
>         struct hashmap_entry {
>             struct hashmap_entry *next;
>             unsigned int hash;
>         };
>         uint32_t pack_name_hash;
>         struct object *object;
>      }

No, this is not quite right. We use the separate arrays because the
normal operation mode is to index by position (e.g. we need the nth
object in the extended index); the hash table is an auxiliary
structure to reverse that indexing (e.g. what position does this SHA1
have on the extended index). The information which is always required
to construct bitmaps is position, so we need to store the indexes in a
map.

>> khash on the other hand is capable of storing the position values as
>> part of the hash table itself (i.e. `int **buckets`), and saves us
>> from thousands of bytes of allocations + indirection.
>>
>
> However, khash keeps separate arrays for flags, keys and values, all of them overallocated by 1 / load factor (so there's lots of unused space). ext_index.objects and ext_index.hashes are also overallocated by the usual alloc_nr() factor 1.5.

FWIW The flags for khash are compacted, so they are stored much more
tightly than pointers, even when overallocated.

>
> Regarding memory consumption, I think both implementations will be pretty similar. Hashmap allocates many small regions while khash re-allocates a few big ones...I really don't know which is better, ideally entries would be allocated in chunks to minimize both heap overhead and memcpy disadvantes.

I agree, both implementations probably have very similar memory
characteristics, probably enough not to matter.

> Regarding performance, khash uses open addressing, which requires more key comparisons (O(1/(1-load_factor))) than chaining (O(1+load_factor)). However, any measurable differences will most likely be dwarfed by IO costs in this particular use case.

I don't think this is true. If you actually run a couple insertion and
lookup benchmarks comparing the two implementations, you'll find khash
to be around ~30% faster for most workloads (venturing a guess from
past experience). I am obviously not the author of khash, but I've
found that the theoretical increase in key comparisons is completely
dwarfed by the benefit of increased cache locality during the probing
fase. I still haven't found a faster C hash table implementation than
khash for the general case, that's why I normally use it despite the
worrisome preprocessor crash-party going on in that header file.

> Btw., pack-objects.c::rehash_objects() in patch 03 unnecessarily checks for duplicates. That's probably the reason for the high hashcmp times you found in the first round of the patch series.

Patch 03 is a refactoring -- the duplicate checking code has been in
pack-objects.c for years. I am not sure duplicate checking is
superfluous at all, there are many cases where you could be
double-inserting objects in a pack-objects run, and you really don't
want to generate packfiles with dupe objects.

Thanks for the feedback!

luv,
vmg
