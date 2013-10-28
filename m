From: Karsten Blees <karsten.blees@gmail.com>
Subject: Re: What's cooking in git.git (Oct 2013, #06; Fri, 25)
Date: Mon, 28 Oct 2013 20:45:44 +0100
Message-ID: <526EBEE8.7070807@gmail.com>
References: <xmqqeh79hr3o.fsf@gitster.dls.corp.google.com> <CACsJy8A3s4TUmUOC+i-k97GxxvBQ7mQmdoPJizfy1yS3rqLEkA@mail.gmail.com> <xmqq61shgzvn.fsf@gitster.dls.corp.google.com> <CAFFjANSnuS6_+uAd43AayojJyK-wj2wMxQ6DBD6JyN=A7xh2_A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Duy Nguyen <pclouds@gmail.com>, Karsten Blees <blees@dcon.de>,
	Git Mailing List <git@vger.kernel.org>,
	Jeff King <peff@peff.net>
To: =?UTF-8?B?VmljZW50IE1hcnTDrQ==?= <tanoku@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Oct 28 20:45:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vasl4-0003zh-LF
	for gcvg-git-2@plane.gmane.org; Mon, 28 Oct 2013 20:45:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756148Ab3J1Tpq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 28 Oct 2013 15:45:46 -0400
Received: from mail-ee0-f49.google.com ([74.125.83.49]:48046 "EHLO
	mail-ee0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755323Ab3J1Tpp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Oct 2013 15:45:45 -0400
Received: by mail-ee0-f49.google.com with SMTP id e52so1902278eek.36
        for <git@vger.kernel.org>; Mon, 28 Oct 2013 12:45:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=51hY5FDKzTTMi8KvmCzb8E6ttkf9fbdVBz0DSwgYJ5Y=;
        b=kpSbo8BGNbfABu4HMkAaXWDVYLro2r937+VyJv7zoguePww19xHBy54rgYeYhkEtML
         odbEA8Hveaztg1fKKHwq0sKiChNtSDCHJ/V21NsOJcshI+AzVsPOmmNclYPfEzupnDod
         wZ7ih6VTWJKvQvah4h4bsXiLHuRRIpkxpfkY/QpJDstIpl5XbHFvdJL1PsLyxeSUoFDh
         XdGluOx6YF+miyKZpdfK6HQ90JWi7vV23nvvr3/rQ6/4/SNgcKoKor3Ooivp4tXzX36Q
         BrbcAUEcNtHmo84vDAVhe5ehwnJfi6jaEGbLROcfajtqYTvA3VeWNXvVp0SBqr6l5IFl
         vs5A==
X-Received: by 10.14.32.196 with SMTP id o44mr23954712eea.43.1382989544534;
        Mon, 28 Oct 2013 12:45:44 -0700 (PDT)
Received: from [10.1.100.51] (ns.dcon.de. [77.244.111.149])
        by mx.google.com with ESMTPSA id a6sm60940720eei.10.2013.10.28.12.45.43
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 28 Oct 2013 12:45:43 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.0.1
In-Reply-To: <CAFFjANSnuS6_+uAd43AayojJyK-wj2wMxQ6DBD6JyN=A7xh2_A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236853>

Am 28.10.2013 17:16, schrieb Vicent Mart=C3=AD:
> On Mon, Oct 28, 2013 at 4:48 PM, Junio C Hamano <gitster@pobox.com> w=
rote:
>>> jk/pack-bitmap adds khash.h, which from a first glance looks like y=
et
>>> another hash table implementation. I was just wondering if kb's new
>>> hash tables can cover the need of pack-bitmap.c too so we can remov=
e
>>> khash.h later..
>>
>> Good thinking ;-).
>=20
> We use the khash tables to map:
>=20
>     - sha1 (const char *) to (void *)
>     - sha1 (const char *) to int
>=20
> The new `hashmap.c` covers the first case quite well (albeit slightly
> more verbosely than I'd like), but in the second case it doesn't quit=
e
> work. Since the new hash needs to embed the "struct hashmap_entry" on
> all its values (to allow for separate chaining), having it map to
> `int` keys requires a struct like this:
>=20
>     struct sha1_position {
>         struct hashmap_entry {
>             struct hashmap_entry *next;
>             unsigned int hash;
>         };
>         int position;
>     }
>=20

Hmm...isn't that position rather an index into two separately maintaine=
d arrays? So you'd rather have:

    struct sha1_position {
        struct hashmap_entry {
            struct hashmap_entry *next;
            unsigned int hash;
        };
        uint32_t pack_name_hash;
        struct object *object;
     }

> khash on the other hand is capable of storing the position values as
> part of the hash table itself (i.e. `int **buckets`), and saves us
> from thousands of bytes of allocations + indirection.
>=20

However, khash keeps separate arrays for flags, keys and values, all of=
 them overallocated by 1 / load factor (so there's lots of unused space=
). ext_index.objects and ext_index.hashes are also overallocated by the=
 usual alloc_nr() factor 1.5.

Regarding memory consumption, I think both implementations will be pret=
ty similar. Hashmap allocates many small regions while khash re-allocat=
es a few big ones...I really don't know which is better, ideally entrie=
s would be allocated in chunks to minimize both heap overhead and memcp=
y disadvantes.

Regarding performance, khash uses open addressing, which requires more =
key comparisons (O(1/(1-load_factor))) than chaining (O(1+load_factor))=
=2E However, any measurable differences will most likely be dwarfed by =
IO costs in this particular use case.


Btw., pack-objects.c::rehash_objects() in patch 03 unnecessarily checks=
 for duplicates. That's probably the reason for the high hashcmp times =
you found in the first round of the patch series.

Cheers,
Karsten
