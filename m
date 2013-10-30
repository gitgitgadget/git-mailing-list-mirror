From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [PATCH 11/19] pack-objects: use bitmaps when packing objects
Date: Wed, 30 Oct 2013 10:38:57 +0000
Message-ID: <CAJo=hJs0uUdDfdo9g-FeUmed5Z4+S+spPb+4OL8NipN-GXxuxQ@mail.gmail.com>
References: <20131024175915.GA23398@sigill.intra.peff.net> <20131024180419.GK24180@sigill.intra.peff.net>
 <CAJo=hJuDx=3AOoz2oEORVOzeBYBwvOWO_ye8D5d8PcDc3Zm+Ew@mail.gmail.com> <20131030082143.GM11317@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git <git@vger.kernel.org>, Vicent Marti <vicent@github.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Oct 30 11:39:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VbTBL-0003Tl-P5
	for gcvg-git-2@plane.gmane.org; Wed, 30 Oct 2013 11:39:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753422Ab3J3KjU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Oct 2013 06:39:20 -0400
Received: from mail-wi0-f169.google.com ([209.85.212.169]:51578 "EHLO
	mail-wi0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752881Ab3J3KjT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Oct 2013 06:39:19 -0400
Received: by mail-wi0-f169.google.com with SMTP id cb5so6179992wib.4
        for <git@vger.kernel.org>; Wed, 30 Oct 2013 03:39:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spearce.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=v25QwyQyZzysWdbyICEtWEeoYjJarskEBsf+tBA1LTI=;
        b=VySqZBm6h/fqfPDOdhF+S0gtxE/kZoumHfsvdvd/NJi4tF93xEMt0L+8namNsl1pTb
         uQSmXRlekbyroyGkMQMx4iXQI/xYCjt8CASSoLhLWrTFo6LsMn7axgaiiuhWFQfl/hZD
         waZTU56uv+KMxHJeQq8kCGrFr50BJU0WOmN58=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=v25QwyQyZzysWdbyICEtWEeoYjJarskEBsf+tBA1LTI=;
        b=B+GIjztZQtha4SNnNPL+bZQX0UpwrlZ9FmuktlHoeC0oBjoQE+zT1ZqCKdOBKVcGrr
         QMNVq113xPZl45xE4GsyN/Y2zYynulBfrGa2BgiBE2eY7GNLua2NM23nnpwjWbPfQs08
         nl2yMCOfqj/GC29HhpOA5iqNJymA9dDs9G4TOoOL5U4xH4WHiHjrongpPuXK3b+16ky9
         MiHja4kEOHC9NZLr4WpvZ4qppkvuHgtWKOxZZE2KvShxjTOhSlpYXQrzrJwzVzPEwBI/
         2tz3TDp48eqDAz4uKi3atVZtoMcxivyoCBFJrc7u0EaMRSNTIipvhqsAor1xy15WmJle
         Wr5w==
X-Gm-Message-State: ALoCoQnKISg3GgG0qMpR7AMTX5CoOR9Y9CyFJylWDh67aCP2hg1HDD1OkI6/oymoCA4/gt9VXzMX
X-Received: by 10.180.94.100 with SMTP id db4mr2157575wib.14.1383129557726;
 Wed, 30 Oct 2013 03:39:17 -0700 (PDT)
Received: by 10.227.62.140 with HTTP; Wed, 30 Oct 2013 03:38:57 -0700 (PDT)
In-Reply-To: <20131030082143.GM11317@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237010>

On Wed, Oct 30, 2013 at 8:21 AM, Jeff King <peff@peff.net> wrote:
> On Fri, Oct 25, 2013 at 02:14:11PM +0000, Shawn O. Pearce wrote:
>> On Thu, Oct 24, 2013 at 6:04 PM, Jeff King <peff@peff.net> wrote:
>> > For bitmaps to be used, the following must be true:
>> >
>> >   1. We must be packing to stdout (as a normal `pack-objects` from
>> >      `upload-pack` would do).
>> >
>> >   2. There must be a .bitmap index containing at least one of the
>> >      "have" objects that the client is asking for.
>>
>> The client must explicitly "have" a commit that has a bitmap? In JGit
>> we allow the client to have anything, and walk backwards using
>> traditional graph traversal until a bitmap is found.
>
> If the bitmaps contain the full set of reachable objects and the client
> does not have any "haves" that are bitmapped , then we know that either:
>
>   1. Their "haves" are not reachable from the "wants"
>
>      or
>
>   2. Their "wants" are not bitmapped, and so the slice of "haves..wants"
>      has no bitmaps
>
> Since (1) is relatively rare, I think we are using this as a proxy for
> (2), so that we can do a regular walk rather than looking around for
> bitmaps that don't exist. But I may be misremembering the reasoning.
> Vicent?

Ah. I am not sure if we do this in JGit. I think JGit's approach is to
look if the have appears in a pack with bitmaps, this is a simple
lookup in the .idx file and does not require expanding any data from
the .bitmap file.


But it wasn't my question. :-)

Client sends "want B ; have E". What if E appears in the bitmapped
pack, but does not itself have a bitmap? Do you walk backwards from B
and switch to the bitmap algorithm when you find a commit that has a
bitmap and that bitmap contains E?

>> In JGit we write the to_pack list first, then the reuse pack. Our
>> rationale was the to_pack list is recent objects that are newer and
>> would appear first in a traditional traversal, so they should go at
>> the front of the stream. This does mean if they delta compress against
>> an object in that reuse_packfile slice they have to use REF_DELTA
>> instead of OFS_DELTA.
>
> That's a good point. In our case I think we do not delta against the
> reused packfile objects at all, as we simply send out the whole slice of
> packfile without making an entry for each object.

JGit also doesn't use the reused packfile as delta bases, because
there are no object entries to shove through the delta window. So
there is never any risk of a reference to a base later in the file. It
also means that "thin pack" at the front of the stream is less
optimally compressed. At Google we side step that by doing GC at the
server very often, to try and keep the number of objects in that pack
low.

It might make sense to use a commit that covers the majority of the
reused pack as the edge base candidate case during delta compression
here, as though the client had sent us a "have" for that commit. I
don't think we have tried this in JGit. It would make deltas use
REF_DELTA, but the delta size has to be smaller than the REF_DELTA
header to be used in the stream so its still a smaller overall
transfer.

>> Is this series running on github.com/torvalds/linux? Last Saturday I
>> ran a live demo clone comparing github.com/torvalds/linux to a JGit
>> bitmap clone and some guy heckled me because GitHub was only a few
>> seconds slower. :-)
>
> It is. Use kernel.org if you want to make fun of someone. :)

Hah. OK, so GitHub was only a few seconds slower only because my
desktop is better connected to our data centers than to yours. Nicely
done, this patch series really works. :)
