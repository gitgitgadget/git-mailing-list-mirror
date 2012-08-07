From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH/RFC v2 0/16] Introduce index file format version 5
Date: Tue, 7 Aug 2012 19:16:25 +0700
Message-ID: <CACsJy8CepAQr4r-c_hzwgT2-_bpFV-=VmOsFaBcDZqBpG52reQ@mail.gmail.com>
References: <1344203353-2819-1-git-send-email-t.gummerer@gmail.com>
 <1344263760-31191-1-git-send-email-pclouds@gmail.com> <7vehnjzzfd.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Thomas Gummerer <t.gummerer@gmail.com>, git@vger.kernel.org,
	trast@student.ethz.ch, mhagger@alum.mit.edu,
	robin.rosenberg@dewire.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 07 14:17:06 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Syiic-0002eN-ML
	for gcvg-git-2@plane.gmane.org; Tue, 07 Aug 2012 14:17:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754196Ab2HGMQ5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Aug 2012 08:16:57 -0400
Received: from mail-gh0-f174.google.com ([209.85.160.174]:49914 "EHLO
	mail-gh0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753849Ab2HGMQ4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Aug 2012 08:16:56 -0400
Received: by ghrr11 with SMTP id r11so3568999ghr.19
        for <git@vger.kernel.org>; Tue, 07 Aug 2012 05:16:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=x83lZnOi3ZUh3g5NT/GfnnH4XCMbK10njx85VBX86DM=;
        b=ogfzJI9Cm9Yo4bAdqakF1YEys50M5+hUju8ijBMgHSDibdOIa7l4eHCi1ZSdeveauw
         /QPw1jCC4HVfE9RiK/kQeA+ZZpyQlPEgqK7iJBvV3/XDNpIToBzIQMgL2d/iRRWFroJV
         Qe3wn8xmXl77rqliKL6RjCcUndnBoPqr0t3mVEWuo5b9kfM9/pkncANH2yb/ZZ7JEMMk
         XJuq3iQMj+Lc3wWVy0olioECXH6G8zA0KPLTLRtzCvcoaEovVEw2TXX9vPPvTyQve+5S
         wgJ+kSOWFBvY98ZxnuUEEOYlekmh/Vi6kfTuWxRc0ADFOsFR0wc72fMng+5iocKwMErZ
         xOZQ==
Received: by 10.50.6.197 with SMTP id d5mr8170923iga.44.1344341815659; Tue, 07
 Aug 2012 05:16:55 -0700 (PDT)
Received: by 10.64.90.2 with HTTP; Tue, 7 Aug 2012 05:16:25 -0700 (PDT)
In-Reply-To: <7vehnjzzfd.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203026>

On Tue, Aug 7, 2012 at 12:46 AM, Junio C Hamano <gitster@pobox.com> wrote:
> The index_ops abstraction is a right way to go, and I like it, but I
> think the split illustrated in this patch might turn out to be at
> wrong levels (and it is OK, as I understand this is a illustration
> of concept patch).
>
> For example, add_to_index() interface may be a good candidate to
> have in index_ops.  Because your in-core index may not be holding
> everything in a flat array, "find the location in the flat array the
> entry would sit, replace the existing one if there is any, otherwise
> insert" cannot be a generic way to add a new entry.  If you make the
> whole thing an abstract API entry point, a sparse implementation of
> the in-core index could still implement it without bringing the
> untouched and irrelevant parts of the index to core.
>
>         Side note: with a tree-like implementation of the in-core
>         index, "find the location the entry would sit", "get the
>         entry at the location", "insert the entry at the location",
>         could still be a set of good abstract API, though.  The
>         definition of _location_ may be quite different from "the
>         offset of the entry counting from the beginning of a flat
>         array", which is what index_name_pos() returns.
>
> The story is the same on the removal front.  The current
> remove_index_entry_at() interface is tied to the flat array
> implementation, so "remove the nth entry from the beginning" is an
> inappropriate interface for anything but such an implementation
> (unless we come up with an abstract notion of the "location" that is
> usable efficiently in a tree-like implementation, that is).

add_to_index and remove_index_entry_at seem good places for the cut.
But do we need to redefine the location? I think we need to sketch out
a long term plan first. In my mind it's like this:

 - for 3-5 years since v5 is released, we support v2 and v5 in
parallel. Other code can take advantage of v5, but it must neither
sacrifice v2 performance, compatibility nor maintainability
 - after that, we deprecate v2. v2 is automatically converted to v5 in
memory. v2 perf may suffer but at that point we don't care any more as
the majority of users should have been migrated to v5 (*)

If the long term plan is actually that, we will need to stick to flat
array implementation for forseeable future as moving from it most
likely impacts v2 performance. When v5 is used, it must maintain two
views, tree and list, at the same time. We can then postpone thinking
about the redefinition until v2 is deprecated and in-core moved to
tree view only.

This might not be the best way forward as v2 incompatible features
(like keeping empty directories in index, what else?) may never come
until v2 is deprecated.

(*) this is questionable though. Depending on the benchmarks, we may
want to support both v2 and v5 for indefinite time with v2 recommended
for small projects and v5 the rest. If it's so, yeah we need to think
of better API now.

> I wish that the development of this topic was done more in a
> top-down direction, instead of bottom-up, so that it identified the
> necessary access patterns to the in-core index early and come up
> with a good set of abstract API first, and then only after that is
> done, came up with in-core and on-disk format to support the
> necessary operations.

Yeah, which is why I asked to try out partial reading/writing early as
I'm a learn by example kind of guy. Speaking of which, now that we
have something substantial, what should be done before this may be
considered for 'next'?

I don't think we should wait until it reaches full potential (i.e.
significant perf gain from all major index-related commands). Apart
from patch preparation, more testing and benchmarking, should we wait
until we get new public API or just use current index API?

One API addition that I (if nobody else) will do soon is
read_index_partial(<pathspec>) and adapt as many read-only commands as
possible to it. (v2 just ignores the pathspec input and loads the
whole thing, so all commands must be aware the the loaded may be more
than what they asked). But this can wait until v5 gets in.
-- 
Duy
