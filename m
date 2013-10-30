From: Vicent Marti <vicent@github.com>
Subject: Re: [PATCH 11/19] pack-objects: use bitmaps when packing objects
Date: Wed, 30 Oct 2013 17:01:17 +0100
Message-ID: <CAFFjANQYsULx+Cr68_xrA-jB2WvJqw-KRa2hbHsA7WaLKFowEg@mail.gmail.com>
References: <20131024175915.GA23398@sigill.intra.peff.net> <20131024180419.GK24180@sigill.intra.peff.net>
 <CAJo=hJuDx=3AOoz2oEORVOzeBYBwvOWO_ye8D5d8PcDc3Zm+Ew@mail.gmail.com>
 <20131030082143.GM11317@sigill.intra.peff.net> <CAJo=hJs0uUdDfdo9g-FeUmed5Z4+S+spPb+4OL8NipN-GXxuxQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>, git <git@vger.kernel.org>
To: Shawn Pearce <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Oct 30 17:01:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VbYDI-0004Jy-HT
	for gcvg-git-2@plane.gmane.org; Wed, 30 Oct 2013 17:01:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752204Ab3J3QBk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Oct 2013 12:01:40 -0400
Received: from mail-vb0-f52.google.com ([209.85.212.52]:54002 "EHLO
	mail-vb0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750766Ab3J3QBj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Oct 2013 12:01:39 -0400
Received: by mail-vb0-f52.google.com with SMTP id f13so1188502vbg.11
        for <git@vger.kernel.org>; Wed, 30 Oct 2013 09:01:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=IW66f5YMW5Tigvdxf0+PFz5cZgH9w0Y1POBj0o4zEhM=;
        b=0KIcQNvR0zzPqcBWzgoxb82A/GpHeFeQwFssS/3eObilsgYkm0jSUJ2Z1yUReK2pcS
         oGwezNHtvQAUzvi5iUE3uV1YLObYbmX2oh8Vl819i9VuCftbQSt/TT8p6qMGFNz8vPU/
         ZkXDv3wAT5nLIcTFmnpzzIWQw+jCCcorkQcncGaFVnPvCdTThbUmTtcxqIxOTe0dRzV0
         laQM0McT5rRaAh2triS2sujLE89G13ZdAOz6pJOpGrRM0lLGg3fd52uMdsoRYzNtbJlM
         jVjfLwBXDp6CgNhi3434G+6+gI2GkHsr2DRyLHCLiVIOBa2r2xzknusJBuTYKGjhEV58
         LaKg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=IW66f5YMW5Tigvdxf0+PFz5cZgH9w0Y1POBj0o4zEhM=;
        b=hGS8h7f2WnwsoBcpKAeGBgrSwRwzl7rzgkh3CzmZf1cbDi0HL9pBiWWoVcGvofXYrF
         T0jvxoNcwzjgW83r7nUTz86tVlXmL6qKww+gVgmu4VytnSR2VGbRAI+VjNGScRdP1elD
         drGiq1LlWi4ZB1g+ez3fZBsU+8BPXnzotWOQY=
X-Received: by 10.52.122.71 with SMTP id lq7mr15468vdb.65.1383148899026; Wed,
 30 Oct 2013 09:01:39 -0700 (PDT)
Received: by 10.221.65.202 with HTTP; Wed, 30 Oct 2013 09:01:17 -0700 (PDT)
In-Reply-To: <CAJo=hJs0uUdDfdo9g-FeUmed5Z4+S+spPb+4OL8NipN-GXxuxQ@mail.gmail.com>
X-Google-Sender-Auth: uMreuky_SYgH3M_AVeIX-VAS7lc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237028>

On Wed, Oct 30, 2013 at 11:38 AM, Shawn Pearce <spearce@spearce.org> wrote:
>> Since (1) is relatively rare, I think we are using this as a proxy for
>> (2), so that we can do a regular walk rather than looking around for
>> bitmaps that don't exist. But I may be misremembering the reasoning.
>> Vicent?
>
> Ah. I am not sure if we do this in JGit. I think JGit's approach is to
> look if the have appears in a pack with bitmaps, this is a simple
> lookup in the .idx file and does not require expanding any data from
> the .bitmap file.

No, you don't do this in JGit right now. This is a small optimization
we implemented to prevent *loading* the bitmap file (and hence
building the reverse index, which can be expensive) unless we're sure
we can at least *attempt* a bitmap walk.

> But it wasn't my question. :-)
>
> Client sends "want B ; have E". What if E appears in the bitmapped
> pack, but does not itself have a bitmap? Do you walk backwards from B
> and switch to the bitmap algorithm when you find a commit that has a
> bitmap and that bitmap contains E?

This is correct, we use the same heuristics as JGit. Once we have
loaded a bitmap file we know we can attempt a bitmap walk; if E is on
the bitmapped pack, we'll build a temporary bitmap using an extended
index (with bits for commits that are not in the packfile) as we walk
backwards until E. Once we find a commit with a bitmap, we'll OR that
with the temporary bitmap to skip the full walk.

>>> In JGit we write the to_pack list first, then the reuse pack. Our
>>> rationale was the to_pack list is recent objects that are newer and
>>> would appear first in a traditional traversal, so they should go at
>>> the front of the stream. This does mean if they delta compress against
>>> an object in that reuse_packfile slice they have to use REF_DELTA
>>> instead of OFS_DELTA.
>>
>> That's a good point. In our case I think we do not delta against the
>> reused packfile objects at all, as we simply send out the whole slice of
>> packfile without making an entry for each object.
>
> JGit also doesn't use the reused packfile as delta bases, because
> there are no object entries to shove through the delta window. So
> there is never any risk of a reference to a base later in the file. It
> also means that "thin pack" at the front of the stream is less
> optimally compressed. At Google we side step that by doing GC at the
> server very often, to try and keep the number of objects in that pack
> low.
>
> It might make sense to use a commit that covers the majority of the
> reused pack as the edge base candidate case during delta compression
> here, as though the client had sent us a "have" for that commit. I
> don't think we have tried this in JGit. It would make deltas use
> REF_DELTA, but the delta size has to be smaller than the REF_DELTA
> header to be used in the stream so its still a smaller overall
> transfer.
>
>>> Is this series running on github.com/torvalds/linux? Last Saturday I
>>> ran a live demo clone comparing github.com/torvalds/linux to a JGit
>>> bitmap clone and some guy heckled me because GitHub was only a few
>>> seconds slower. :-)
>>
>> It is. Use kernel.org if you want to make fun of someone. :)
>
> Hah. OK, so GitHub was only a few seconds slower only because my
> desktop is better connected to our data centers than to yours. Nicely
> done, this patch series really works. :)

Thanks Shawn, your feedback was very helpful.

Re. cloning speeds: we are actually bottlenecked by our routing layer.
The CPUs in our new fileservers can clone `torvalds/linux` to
/dev/null in 20s, but we're slowing down when routing the actual
traffic back to the client. We're in the process of rewriting our Git
reverse proxys so let's see what the future looks like.

Love,
vmg
