From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: No progress from push when using bitmaps
Date: Sat, 15 Mar 2014 06:53:37 +0700
Message-ID: <CACsJy8BrdN5sbuMEp+G-gUBDcSwFscX_4pYe-U5bOkuq6=J4gw@mail.gmail.com>
References: <CAJo=hJth1YB+u2Y9S0X3xk7s2-HcPP4_k03qprHBU4A9721i8g@mail.gmail.com>
 <20140313212626.GA23618@sigill.intra.peff.net> <CAJo=hJu1WscibwectWzrUcoOV4-9xk4hBm1JA+RjONmgvZTXwQ@mail.gmail.com>
 <20140313220754.GA20173@sigill.intra.peff.net> <5322CF58.6060506@alum.mit.edu>
 <CACsJy8BZd0uL2M8NHO+sFcWfkmoyuVnU1Mh2eKZ2OXm=Y-Ge5g@mail.gmail.com> <20140314152939.GA6186@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Shawn Pearce <spearce@spearce.org>, git <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Mar 15 00:54:18 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WObva-0004jH-Gc
	for gcvg-git-2@plane.gmane.org; Sat, 15 Mar 2014 00:54:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756490AbaCNXyK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Mar 2014 19:54:10 -0400
Received: from mail-qa0-f51.google.com ([209.85.216.51]:41540 "EHLO
	mail-qa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756475AbaCNXyI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Mar 2014 19:54:08 -0400
Received: by mail-qa0-f51.google.com with SMTP id j7so3205720qaq.38
        for <git@vger.kernel.org>; Fri, 14 Mar 2014 16:54:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=CggBSysZIwU6/w2aKlNDRkm8kb06bWLVXQs7wkGJm1A=;
        b=Jc5EJ0+3RS/lEEb0c6jAtKWLVNyN7Weqy+t851i0uPS+1tkzLgDWbbM006qsv2zeTF
         dcqQAZzz5WrM2HyRocOKNqEeeSJdV2R/RG+kPn3Xum0dJK8REzo5k6MwRgyfbbdDnZfG
         dZFvEbCbhYEW+9BDL1QhHjPT0N0YvLAhOa9rN8mIAOQitrDgGc3Pyekge6suhlzY2/QC
         jK9rvBLEqZirFYMz+metT6+++/ORh6v0jy6I7PRQJ6NLqLmg/diFGUcUiAzxYdPdfpYV
         KiMXdCBZGCNb7JUAtB34KXc8W0uzYDMHSnafJiJ57DJxhVFPvUSQUK8RopIUhVZYxStw
         YPKw==
X-Received: by 10.140.51.109 with SMTP id t100mr12424606qga.50.1394841247125;
 Fri, 14 Mar 2014 16:54:07 -0700 (PDT)
Received: by 10.96.146.102 with HTTP; Fri, 14 Mar 2014 16:53:37 -0700 (PDT)
In-Reply-To: <20140314152939.GA6186@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244124>

On Fri, Mar 14, 2014 at 10:29 PM, Jeff King <peff@peff.net> wrote:
>> If an object is reused, we already know its compressed size. If it's
>> not reused and is a loose object, we could use on-disk size. It's a
>> lot harder to estimate an not-reused, deltified object. All we have is
>> the uncompressed size, and the size of each delta in the delta chain..
>> Neither gives a good hint of what the compressed size would be.
>
> Hmm. I think we do have the compressed delta size after having run the
> compression phase (because that is ultimately what we compare to find
> the best delta).

There are cases when we try not to find deltas (large blobs, file too
small, or -delta attribute). The large blob case is especially
interesting because progress bar crawls slowly when they write these
objects.

> Loose objects are probably the hardest here, as we
> actually recompress them (IIRC, because packfiles encode the type/size
> info outside of the compressed bit, whereas it is inside for loose
> objects; the "experimental loose" format harmonized this, but it never
> caught on).
>
> Without doing that recompression, any value you came up with would be an
> estimate, though it would be pretty close (not off by more than a few
> bytes per object).

That's my hope. Although if they tweak compression level then the
estimation could be off (gzip -9 and gzip -1 produce big difference in
size)

> However, you can't just run through the packing list
> and add up the object sizes; you'd need to do a real "dry-run" through
> the writing phase. There are probably more I'm missing, but you need at
> least to figure out:
>
>   1. The actual compressed size of a full loose object, as described
>      above.
>
>   2. The variable-length headers for each object based on its type and
>      size.

We could run through a "typical" repo, calculate the average header
length then use it for all objects?

>
>   3. The final form that the object will take based on what has come
>      before. For example, if there is a max pack size, we may split an
>      object from its delta base, in which case we have to throw away the
>      delta. We don't know where those breaks will be until we walk
>      through the whole list.

Ah this could probably be avoided. max pack size does not apply to
streaming pack-objects, where progress bar is most shown. Falling back
to object number in this case does not sound too bad.

>
>   4. If an object we attempt to reuse turns out to be corrupted, we
>      fall back to the non-reuse code path, which will have a different
>      size. So you'd need to actually check the reused object CRCs during
>      the dry-run (and for local repacks, not transfers, we actually
>      inflate and check the zlib, too, for safety).

Ugh..

>
> So I think it's _possible_. But it's definitely not trivial. For now, I
> think it makes sense to go with something like the patch I posted
> earlier (which I'll re-roll in a few minutes). That fixes what is IMHO a
> regression in the bitmaps case. And it does not make it any harder for
> somebody to later convert us to a true byte-counter (i.e., it is the
> easy half already).

Agreed.
-- 
Duy
