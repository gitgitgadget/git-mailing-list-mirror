From: Shawn Pearce <spearce@spearce.org>
Subject: Re: Pack v4 again..
Date: Mon, 16 Feb 2015 20:12:33 -0800
Message-ID: <CAJo=hJvR-3o3U3YWhvq4D-A6YomFbjwEyKxjT93EoNMRrW1PtQ@mail.gmail.com>
References: <CACsJy8CMCTirggRhD28xvv4tM8b4+NL_ruF4LgW293dHAmLYdA@mail.gmail.com>
 <alpine.LFD.2.11.1502152221480.22104@knanqh.ubzr> <20150216064537.GF32381@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Nicolas Pitre <nico@fluxnic.net>, Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Feb 17 05:13:01 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YNZWt-0007sv-F5
	for gcvg-git-2@plane.gmane.org; Tue, 17 Feb 2015 05:12:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752571AbbBQEMz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Feb 2015 23:12:55 -0500
Received: from mail-yh0-f48.google.com ([209.85.213.48]:55154 "EHLO
	mail-yh0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751330AbbBQEMy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Feb 2015 23:12:54 -0500
Received: by mail-yh0-f48.google.com with SMTP id t59so15762374yho.7
        for <git@vger.kernel.org>; Mon, 16 Feb 2015 20:12:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spearce.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=1n8c5sMKC+LV6oSfcaWKeXDhEiIuF9VOUejRIRgs6iA=;
        b=N/HbExZ4v1+bKJnc21US6ULpy0Sd3yRe+n8J8epoONawy/9jPw1O5+R7b5ILE7VECh
         GHIqWz9znO9R0kFFNmop7yu8wxjhVq6zES/3htYGFxD65NJSoTnclP3ycswZJbFnAmWi
         x6qyJDHi3myI8VYFy+1PJ2NnQpTOwAZorYM5o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=1n8c5sMKC+LV6oSfcaWKeXDhEiIuF9VOUejRIRgs6iA=;
        b=Ai6DPGVGWdUWT3QpcBlcR0dEO9TfJ1OV6i4bygZUi5qDfXGAA7k96PjxXnDe/4XhmY
         8CLNXF/rZMMubUWIPYUTu8r5IeL0uqkLEXGOul8Kpp0OE7qO3m0kNA/At33apA8lVFEt
         k0VJLm6/CBMdvEoWlgFnJETTswHTk0ztTmvbhuoophiiMgjgqEdP+j+DpxFbsDfrTtM2
         vLm3kIHyghboUi9lVBbXfNX+IASkaWXytAxQNNqrhkED0Q1NRsT0qq3pRt2NV5BtrPkV
         0soDsoKF5gK33JMJD1WKr2oVRoxWBdK/TxFGiwQgpnMlTKprPrLHblXicXenzoO4SqdQ
         WrsQ==
X-Gm-Message-State: ALoCoQmV2qYSyoxkPI94wVU9GbKOtT1wlCf+ucTTkcX6aWhXDTHKEeAVxgxvs68sr/ltbynt2shs
X-Received: by 10.170.60.16 with SMTP id c16mr216454ykc.128.1424146373442;
 Mon, 16 Feb 2015 20:12:53 -0800 (PST)
Received: by 10.170.39.19 with HTTP; Mon, 16 Feb 2015 20:12:33 -0800 (PST)
In-Reply-To: <20150216064537.GF32381@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263930>

On Sun, Feb 15, 2015 at 10:45 PM, Jeff King <peff@peff.net> wrote:
> On Sun, Feb 15, 2015 at 11:59:02PM -0500, Nicolas Pitre wrote:
>
>> Yet, I think the biggest problem with pack v4 at the moment is the
>> packing algorithm for tree objects.  We are piggy-backing on the pack v2
>> object delta compression sorting and that produces suboptimal results
>> due to deep recursions.  And it is the recursion that kills us. The pack
>> v4 requires a new packing algorithm for its tree objects.
>>
>> What I imagined is something like this:
>>
>> - Each canonical tree entry is made of a SHA1, mode and path.  Let's
>>   assume this is hashed into a 24-bit value.
>>
>> - Each tree object can therefore be represented as a string of 24-bit
>>   "characters".
>>
>> - Delta-compressing a tree object becomes a substring search where we
>>   try to replace a sequence of "characters" with the longest "string"
>>   possible from another object.  Repeat with the remaining sequences.
>
> Somewhat related to this, I was playing this weekend with the idea of
> generating fast tree diffs from our on-disk deltas. That is, given a
> base tree and a binary delta against it, could I reliably reproduce a
> diff (one way or the other) in O(size of diff), rather than O(size of
> tree)?

Yes, if you always make the tree diff *search* on entry boundaries.

> The conclusion I came to was "no, you cannot do it in the general case
> of byte-wise binary diffs"[2].

This is also why you cannot binary search inside of the canonical tree
format. :(

> If we knew that our deltas were always produced on entry-boundaries (a
> "character" in your description above), this would be much simpler.

Eons ago Nico and I were of the opinion that pack v4 trees could use
the existing byte based delta format on disk, but the delta
search/encoder would always align to fixed width entry boundaries.
That gives you deltas that are understandable by the current decoder,
but are also trivially processed in delta format as insertions and
copy runs always cover complete entries and are never a partial entry.

It was all theory; we never actually wrote a prototype of that.

> [1] Of course there are other reachability checks besides packing, like
>     git-prune. But all of those are even better sped up by using
>     reachability bitmaps. Packing, as the place where we generate the
>     bitmaps, and which is sensitive to things like traversal order,
>     remains the place where we will always need to actually walk.

`git log -- $path` isn't trivially improved with reachability bitmaps.
Its something we have been pondering a lot at $DAY_JOB and haven't
found a magic bullet solution for yet. Until someone comes up with
another chunk of magic, we need tree diffs for a lot of operations.

> [2] One option, of course, is to generate byte-wise deltas, but with a
>     promise to always align them on entry boundaries. I'm tempted by
>     this, because the result would be readable by existing packv2
>     readers. We'd have to set a flag somewhere that indicates the pack
>     was written with this property, though.

Yes, that was always something we wanted to look at doing.

> [3] I suspect you could come up with some heuristic that finds tree
>     entry boundaries with high probability, and in the low probability
>     case does not produce a wrong answer, but instead has to walk all
>     the way back to the beginning of the tree. That would be fine here.
>     But frankly, this "walk backwards" thing was just the straw that
>     broke the camel's back for me in working on this. Handling all the
>     possible cases was ending up quite complicated.

No, I tried this in JGit once. You can't do it reliably enough.
