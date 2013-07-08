From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [PATCH 4/4] pack-revindex: radix-sort the revindex
Date: Mon, 8 Jul 2013 08:38:44 -0700
Message-ID: <CAJo=hJt0R43TtGaSEegkC+aZvUJ7FAPFYzZ8fq-Tx1Pzp6Zi-A@mail.gmail.com>
References: <20130707100133.GA18717@sigill.intra.peff.net> <20130707101438.GD19143@sigill.intra.peff.net>
 <CAJo=hJugvqBEQwPYcttNH+R8xUKxy1uDm5EjiWaye-wEuTxk-w@mail.gmail.com> <20130708075712.GC25072@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Jul 08 17:39:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UwDWx-00057n-Ux
	for gcvg-git-2@plane.gmane.org; Mon, 08 Jul 2013 17:39:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751653Ab3GHPjG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Jul 2013 11:39:06 -0400
Received: from mail-ie0-f181.google.com ([209.85.223.181]:57903 "EHLO
	mail-ie0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751549Ab3GHPjE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Jul 2013 11:39:04 -0400
Received: by mail-ie0-f181.google.com with SMTP id x12so10161561ief.40
        for <git@vger.kernel.org>; Mon, 08 Jul 2013 08:39:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spearce.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=KUUIWwgupcr/vACKGYTh1yoxqOGnRm/sqYDH25FFEcQ=;
        b=Lv0hyVBzq8OSK/W6eKUo9FCSaM/imZAWPueH9yh+1LtwU0tUKSdZNQR88LTm+IGxRt
         wuZfwrpbPop/PVjSvthsmvl9vpiKZX7dAbdh06zYHCaswlC0D0NAzMgxUQpCaSCKlfFl
         X4Cq6OSawH/pwvZZ8e85+I6+ryt7XBGZYd0HU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:x-gm-message-state;
        bh=KUUIWwgupcr/vACKGYTh1yoxqOGnRm/sqYDH25FFEcQ=;
        b=HWdcFDPuOFmY1z8Aw9TeUctwhAaFbsccHWDumtRTNd1V3wgIWfBzPJ1OTWgOxsDC/e
         LclY3V8yUSWoUiyO0IXOrgYITx0O9uIlGaTOFt/2hChnaWKYI8Xtw+EEuIqmmppvkpIR
         WbVk5o603v+7Egw6WGGL7WAMWMwHzMI/ILOZ8QpotNPhhNmabB+LZnNHVrpLGGKhRy8J
         8QwMY0urkMdlaDmes4sDjY3/T5IOIokU+tePnzL7vqUAp4GXxh/i7HUtVEg2L+F2RuUS
         f6LdEQHczmW2uL7Mxx8F4yovi9twHXvDyix46UGgG1OtKYh5xbo2CJ0q57Cd+yOuySh2
         ybvg==
X-Received: by 10.50.72.40 with SMTP id a8mr8865255igv.15.1373297944145; Mon,
 08 Jul 2013 08:39:04 -0700 (PDT)
Received: by 10.64.143.200 with HTTP; Mon, 8 Jul 2013 08:38:44 -0700 (PDT)
In-Reply-To: <20130708075712.GC25072@sigill.intra.peff.net>
X-Gm-Message-State: ALoCoQkIRqzHXtKnCB9G+oM10XWmIljGVBQiA8vk6TKf2aN1kXPjr+gEAOgK2FTs/74MC0PoxpCV
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229868>

On Mon, Jul 8, 2013 at 12:57 AM, Jeff King <peff@peff.net> wrote:
> On Sun, Jul 07, 2013 at 04:52:23PM -0700, Shawn O. Pearce wrote:
>
>> On Sun, Jul 7, 2013 at 3:14 AM, Jeff King <peff@peff.net> wrote:
>> > The pack revindex stores the offsets of the objects in the
>> > pack in sorted order, allowing us to easily find the on-disk
>> > size of each object. To compute it, we populate an array
>> > with the offsets from the sha1-sorted idx file, and then use
>> > qsort to order it by offsets.
>> >
>> > That does O(n log n) offset comparisons, and profiling shows
>> > that we spend most of our time in cmp_offset. However, since
>> > we are sorting on a simple off_t, we can use numeric sorts
>> > that perform better. A radix sort can run in O(k*n), where k
>> > is the number of "digits" in our number. For a 64-bit off_t,
>> > using 16-bit "digits" gives us k=4.
>>
>> Did you try the simple bucket sort Colby now uses in JGit?
>>
>> The sort is pretty simple:
>>
>>   bucket_size = pack_length / object_count;
>>   buckets[] = malloc(object_count * sizeof(int));
>>
>>   foreach obj in idx:
>>     push_chain(buckets[obj.offset / bucket_size], obj.idx_nth);
>>
>>   foreach bucket:
>>     insertion sort by offset
>
> I did do something similar (though I flattened my buckets into a single
> list afterwards), but I ended up closer to 700ms (down from 830ms, but
> with the radix sort around 200ms). It's entirely possible I screwed up
> something in the implementation (the bucket insertion can be done in a
> lot of different ways, many of which are terrible), but I didn't keep a
> copy of that attempt. If you try it and have better numbers, I'd be
> happy to see them.

Colby's sort in Java is coming in around 450ms for linux.git, so
sounds like your implementation was doing something suboptimal.

But as I thought about it this morning, a radix sort for most pack
files should run with k=2 and take only O(2*N) time. It is a very
efficient sort for the data. Colby and I didn't even try a radix sort,
and I suspect it would out-perform the bucket sort we do now.

>> We observed on linux.git that most buckets have an average number of
>> objects. IIRC the bucket_size was ~201 bytes and most buckets had very
>> few objects each. For lookups we keep the bucket_size parameter and a
>> bucket index table. This arrangement uses 8 bytes per object in the
>> reverse index, making it very memory efficient. Searches are typically
>> below O(log N) time because each bucket has <log N entries.
>
> I didn't measure lookups at all; I was focused on time to build the
> index. So if there were benefits there that make up for a longer setup
> time, I wouldn't have measured them (of course, we also care about the
> case with few lookups, so it would be a tradeoff).

We didn't measure lookup times either. Colby did compute a histogram
of bucket sizes and showed nearly all buckets were significantly
smaller than log N, so lookups are <log N time even though they are a
simple iteration through the elements. Colby considered doing binary
search within a bucket but didn't bother given how small the buckets
are.

So our lookup time benefit is theoretical. The way JGit implements
clones we tend not to perform N lookups in revidx, its usually sub
1000 lookups in revidx. That makes it harder to have any noticeable
benefit from decreased lookup time.

> You could also leave
> each bucket unsorted and only lazily sort it when a lookup hits the
> bucket, which might help that case (I didn't look to see if you do that
> in JGit).

We didn't do that in JGit, the sort is done at initialization. But
given the remark I just made about clones doing only a few lookups we
may want to defer the sort. IIRC the sort is about half of our
initialization cost.
