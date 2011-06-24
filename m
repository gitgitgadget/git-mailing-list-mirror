From: David Barr <davidbarr@google.com>
Subject: Re: [RFC/PATCH 2/3] small-alloc: add allocator for small objects
Date: Fri, 24 Jun 2011 07:38:51 -0700
Message-ID: <BANLkTi=34cQvU9oE0gPe=5PFDYfhxoYF+A@mail.gmail.com>
References: <1308728011-14136-1-git-send-email-davidbarr@google.com>
	<1308728011-14136-3-git-send-email-davidbarr@google.com>
	<7vk4cd617u.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: GIT Mailing-list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 24 16:39:01 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qa7XB-0006A7-E8
	for gcvg-git-2@lo.gmane.org; Fri, 24 Jun 2011 16:39:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759515Ab1FXOiz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Jun 2011 10:38:55 -0400
Received: from smtp-out.google.com ([74.125.121.67]:34043 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759400Ab1FXOiy (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Jun 2011 10:38:54 -0400
Received: from hpaq6.eem.corp.google.com (hpaq6.eem.corp.google.com [172.25.149.6])
	by smtp-out.google.com with ESMTP id p5OEcrDC008212
	for <git@vger.kernel.org>; Fri, 24 Jun 2011 07:38:53 -0700
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=google.com; s=beta;
	t=1308926333; bh=p5S/LTEUOJ0gFFrL7fR9y43vdv0=;
	h=MIME-Version:In-Reply-To:References:Date:Message-ID:Subject:From:
	 To:Cc:Content-Type;
	b=XI4JHS7m/cd8TsxQhH229wlUANdaB1tERngVzEEPmnUW/Y7jnoKLaNyciPZttkEk4
	 m1gc6gSTssjJSYiEYwbuQ==
Received: from gyg13 (gyg13.prod.google.com [10.243.50.141])
	by hpaq6.eem.corp.google.com with ESMTP id p5OEcpn8018086
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=NOT)
	for <git@vger.kernel.org>; Fri, 24 Jun 2011 07:38:52 -0700
Received: by gyg13 with SMTP id 13so1523417gyg.0
        for <git@vger.kernel.org>; Fri, 24 Jun 2011 07:38:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=beta;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=GHSC7WWXlpg8GVTZrQvODFn5/64vANonKxmAY02Rv9U=;
        b=Zc5l6mn4gnLsFsk9fnQ2K3ujdxvepYFxUHvztaWY0T7hPvWeNCN97HUYKOZHvZ9Y2t
         6k2tZL1hxHipO0vf3DwA==
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=google.com; s=beta;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=fctj7OcW5413JxxoCL0WgKfwGRkP4QVjTWJcnrbmLZ1/exkMZAivIfiTQLjxFZ2f+i
         HyOTiSqwkNCZNBoVedLA==
Received: by 10.101.153.6 with SMTP id f6mr3750474ano.3.1308926331342; Fri, 24
 Jun 2011 07:38:51 -0700 (PDT)
Received: by 10.101.29.2 with HTTP; Fri, 24 Jun 2011 07:38:51 -0700 (PDT)
In-Reply-To: <7vk4cd617u.fsf@alter.siamese.dyndns.org>
X-System-Of-Record: true
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176306>

Junio,

Sorry for the repeat, accidentally sent as HTML, rejected by the list.

On Wednesday, June 22, 2011, Junio C Hamano wrote:
David Barr <davidbarr@google.com> writes:

> +void *pool_alloc(struct mem_pool *pool, size_t len, size_t *id_out)
> +{
> +     static size_t id = 1;

Does this mean that even though you can have more than one mem_pool object
active in the system, you won't have id collision throughout the system?
That is a nice property (e.g. given an ID that does not belong to a pool,
you won't risk returning a wrong chunk of <mem,len> pair from pool_ptr()),
but is there a downside using function-scope static like this, I wonder?

This is an artifact that I missed in refactoring my experimental code.
This ought to be a field in struct mem_pool.
My intent was for id's to be unique and contiguous within a pool.

For example, if I have two pools A and B, and call pool_alloc on A and
then on B and then on A again, A's space[0] will have the first and the
third object, with id=1 and id=3. How does this interact with your
implementation of pool_ptr() which seems to assume that id's are
consecutive within a single pool->space[]?

It would interact very poorly.

> +     size_t n;

> +     void *r;
> +
> +     if ((pool->end - pool->next_free >= len) &&
> +         (pool->len_free >= sizeof_varint(len)))
> +             n = pool->nr - 1;

Help me make sure I understand what is going on here.

A mem-pool has pool->nr chunks (and it can grow as more memory is asked
from this pool). A new memory request is satisfied by carving out of
pool->space[n] (where n is the "newest chunk" in the pool).
pool->len[n] is a fixed sized byte array and stores the length of each
memory block carved out of pool->space[n] as a sequence of varint.
If pool->space[n] has enough space to fit "len" bytes, and if pool->len[n]
still has enough space to record the length, you use the current chunk,
otherwise (i.e. the else clause) you add a new chunk.

Am I with you so far?

Absolutely.

With the chunk_size of 2MB, you would fit roughly 16k allocation requests
for 128-byte memory, and you would need 2-bytes to express the length of
one piece of memory in your varint encoding, i.e. you would need to size
an element of pool->len[] to 32kB if you wanted to store 16k allocation of
128-byte for a chunk.

This would all depend on what the expected distribution of request size,
but it somehow feels wasteful to be limited by both space[] and len[]. If
you chose sizeof(*pool->len) that is too small for the workload, wouldn't
you end up allocating many 2MB space[], only to use potentially very
initial parts of them before len[] fills up?

Yes, this is a weakness of this iteration of the design.

> +     if (id_out)

> +             *id_out = id;
> +     id++;
> +
> +     char *t = &pool->len[n][sizeof(*pool->len) - pool->len_free];

Please avoid decl_after_statement.

Thanks for the reminder, will clean up some more.

> +     size_t n = pool->nr * id / pool->first_id[pool->nr - 1];

> +     if (n >= pool->nr - 1)
> +             n = pool->nr - 1;
> +     while (n && pool->first_id[n] > id)
> +             n--;
> +     while (n + 1 < pool->nr && pool->first_id[n + 1] <= id)
> +             n++;

I was about to say "bsearch?", but perhaps it is not worth it.

A linear guesstimate is typically off by a small amount, so linear
search is fine.
Also, the index of id's is contiguous, so linear search has good cache locality.
If I address the next concern in this review, this search will no
longer be necessary.

> +struct mem_pool {
> +     size_t *first_id;
> +     char **space;
> +     char (*len)[sizeof(size_t) + sizeof(char*)];

Each element of pool->len[] is just a byte-array that stores varint, no?
It is very misleading to specify its size as sizeof(size_t)+sizeof(char*)
as if you would store a "struct { size_t some; char *thing; }" here.

Instead of having two independently depleted byte-buffer (space[] and
len[]), I wonder if it would be more space efficient (without being less
processing efficient) to use a single buffer space.  Your pool_ptr() would
start at the beginning of pool->space[n], decode a varint and take it as a
length, if that is not the object you are looking for, skip that many
bytes (i.e. payload immediately follows the length) to the next object,
and so on.

I have already investigated this arrangement, it has very poor
locality of access.
For objects <32 bytes long, its not too bad since typically 2 bytes of a 64 byte
cache line would be read consecutively. For larger objects this is pathological
cache behavior. On the other hand, the current design means that the entire
sequence of lengths will fit on a single >=16 byte cache line.

Also what kind of alignment guarantee would we _want_ to give the callers?
As far as I can tell, this implementation does not guarantee any alignment.

No alignment guarantee provided. An interesting possibility is to provide a
guarantee and use the padding bytes for metadata.

Although on second reading I think I must have mis-read, I've been investigating
fixing the number of objects per chunk rather than fixing the space for lengths.
I have an inkling that I already considered this and found that it introduced a
nasty corner case. This investigation is ongoing.

--
David Barr.
