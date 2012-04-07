From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 3/3] revision: insert unsorted, then sort in prepare_revision_walk()
Date: Sat, 7 Apr 2012 11:20:59 +0700
Message-ID: <CACsJy8Bj6jHypqk5OEuCmRm4YVf4ttnv5LL=9jukWDyY6H__4Q@mail.gmail.com>
References: <201203291818.49933.mfick@codeaurora.org> <201204021024.49706.mfick@codeaurora.org>
 <CAJo=hJshOBg4pT8nuWZ=eZvj=E9x+4b9M_EANa=02x=NFW2OfQ@mail.gmail.com>
 <201204021049.04901.mfick@codeaurora.org> <CAJo=hJsprQtjDChtrSMcne+OCeUx=NVxLHs3k_qnYLzO=aQWuw@mail.gmail.com>
 <20120402203728.GB26503@sigill.intra.peff.net> <CACsJy8DGaFg=oEwLWWo33cJa=SDuuZshW4=cZpifCWLp5gGcTA@mail.gmail.com>
 <CACsJy8BbNEJBn5i0Rntv21d8qvhPwkrNBdaj+sGh2W-aN9jYGg@mail.gmail.com> <CAJo=hJusnnaMomQzb90ed9=HHpamVTktN0Qrw8MsaY+addF=rw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>, Martin Fick <mfick@codeaurora.org>,
	=?UTF-8?Q?Ren=C3=A9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Colby Ranger <cranger@google.com>
To: Shawn Pearce <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sat Apr 07 06:22:07 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SGNA7-0007Dh-8D
	for gcvg-git-2@plane.gmane.org; Sat, 07 Apr 2012 06:22:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750780Ab2DGEVb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Apr 2012 00:21:31 -0400
Received: from mail-wg0-f44.google.com ([74.125.82.44]:57170 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750766Ab2DGEVa (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Apr 2012 00:21:30 -0400
Received: by wgbdr13 with SMTP id dr13so2633521wgb.1
        for <git@vger.kernel.org>; Fri, 06 Apr 2012 21:21:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=DbbXQCjBlG5KS7pbipDvpl8p/KgqkEORJplleslGRLM=;
        b=ts/OhqLH+dcr6FpaCJemuCsSQ6ZUfYrqG7e4eq7AV4+/wG+Ualq1/F4jZOPtkvJUVN
         VvqsxLl4jrYPsa9mVWHGipTahqOieeLB8DQ+O3JXOlXlgwP1uC+/7JoYYPn5pbQ8svzn
         00FzAXoCCQwdgXocBfZQJk92ysuA1Li3k+Tt0RZrN7/P7taKF8kcVH9a/BsSSI4PpqtC
         k8ZPEHemEOfldDVghqB3cD06QDL2mABggaxBfRVFUeaadPh1XxwskP7d+Z+UgqxAR9zN
         /93Zk1gml6PvwrvpfnVexgUUc128HI9eWxP3om6V3QtBgaiUxSuE2SQn5wt3d+aZI8Kz
         u77A==
Received: by 10.216.134.226 with SMTP id s76mr139149wei.115.1333772489439;
 Fri, 06 Apr 2012 21:21:29 -0700 (PDT)
Received: by 10.223.109.144 with HTTP; Fri, 6 Apr 2012 21:20:59 -0700 (PDT)
In-Reply-To: <CAJo=hJusnnaMomQzb90ed9=HHpamVTktN0Qrw8MsaY+addF=rw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194932>

Hi,

Very insightful write-up. I'll need more time to read through again,
just some initial opinions.

On Sat, Apr 7, 2012 at 2:21 AM, Shawn Pearce <spearce@spearce.org> wrote:
> My officemate Colby and I came up with a better solution a few weeks
> ago, but haven't really had a chance to discuss it in on the list. I
> guess I should try to do that now. Like anything else, we went into
> this work with some assumptions.
>
> There are two operations we really wanted to improve the performance
> of, `git rev-list --objects` for the two commonly used cases from
> pack-objects, notably `rev-list --objects $WANT` and `rev-list
> --objects $WANT --not $HAVE`. That is, clone and incrementally
> fetching something when you have a common ancestor. I'm currently
> ignoring shallow clone in this work as it tends to be a bit less
> expensive on the object enumeration part.
>
> Working from the linux repository, with roughly 2.2M objects, we can
> assume the vast majority of these objects are stored in a pack file.
> If we further assume these are mostly in a single pack file, we can
> easily assign every packed object a unique integer. We do this by
> assigning the N-th object in the pack integer N. You can already do
> this by taking the pack index and computing the reverse index, sorted
> by offset in pack. Finding the integer value for any SHA-1 is then a
> matter of locating its offset in the normal index, and locating the
> position of it in the reverse index... a O(2 log N) operation.
>
> With all of the packed objects named by an integer [0, N) we can build
> a series of bitmaps representing reachability. Given a commit, its
> bitmap has every bit set for every object that `git rev-list --objects
> $COMMIT_SHA1` would output. If the pack is built from a single branch
> (e.g. a repository with no tags and only a master branch), that tip
> commit would have every bit set in its bitmap, as all objects in the
> pack are contained in the bitmap.
>
> ...
>
> Having multiple packs is common, and does complicate this algorithm.
> There are known ways to combine different bitmap indexes together to
> create a single larger bitmap, mostly by applying a unique "base
> prefix" to each bitmap's values. Its very common in the full text
> search community to do this when incrementally updating a full text
> index.

Common repos usually have a big pack as a result of clone and several
smaller packs. How about we create the bitmap for the largest pack
only and fall back to normal rev walking for the rest? We need to deal
with loose objects anyway. I wonder if we could also mark the boundary
objects for a given commits (i.e. another bitmap) so we can start
walking from there to get to other packs and loose objects.

The second bitmap hopefully compresses well. Not sure how it
complicates the want-have bitmap operations you describe above though.

> A process can assign each pack it observes a unique base prefix, and
> then join together bitmaps across those packs to get a more complete
> picture. Its not entirely that simple though because a commit in a
> newer pack probably still references a parent in an older pack, and so
> that commit in the newer pack doesn't have a complete bitmap.
>
> One way out of this is to only produce bitmaps on a full GC, where the
> entire repository is rewritten. If every 10k commits worth of history
> costs about 100ms additional processing time to do object enumeration,
> we only really have to do a major repack about every 100k commits when
> processing is starting to come close to 1.2 seconds of CPU time. The
> linux history has done ~220k commits in ~5 years, or 44k commits/year.
> Asking a repository to do a full GC at least once per year so that
> there only needs to be one set of bitmaps might be acceptable. :-)

I'd be happy for it to run, even once a month, as long as it is not
run automatically, unexpectedly and stops me from doing whatever I'm
doing, like "gc --auto".
-- 
Duy
