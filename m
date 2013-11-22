From: Jeff King <peff@peff.net>
Subject: Re: What's cooking in git.git (Nov 2013, #05; Thu, 21)
Date: Fri, 22 Nov 2013 05:23:45 -0500
Message-ID: <20131122102345.GC12042@sigill.intra.peff.net>
References: <xmqqtxf51e5c.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Nov 22 11:23:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vjntv-0001Ul-PJ
	for gcvg-git-2@plane.gmane.org; Fri, 22 Nov 2013 11:23:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752567Ab3KVKXs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Nov 2013 05:23:48 -0500
Received: from cloud.peff.net ([50.56.180.127]:43695 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751879Ab3KVKXr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Nov 2013 05:23:47 -0500
Received: (qmail 9234 invoked by uid 102); 22 Nov 2013 10:23:47 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 22 Nov 2013 04:23:47 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 22 Nov 2013 05:23:45 -0500
Content-Disposition: inline
In-Reply-To: <xmqqtxf51e5c.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238176>

On Thu, Nov 21, 2013 at 04:19:43PM -0800, Junio C Hamano wrote:

> * np/pack-v4 (2013-09-18) 90 commits
>  . packv4-parse.c: add tree offset caching
>  . t1050: replace one instance of show-index with verify-pack
>  . index-pack, pack-objects: allow creating .idx v2 with .pack v4
>  . unpack-objects: decode v4 trees
>  . unpack-objects: allow to save processed bytes to a buffer
>  - ...
> 
>  Nico and Duy advancing the eternal vaporware pack-v4.  This is here
>  primarily for wider distribution of the preview edition.
> 
>  Temporarily ejected from 'pu', to try out jk/pack-bitmap, which
>  this topic conflicts with.

I had a look at the conflicts. Textually, I do not think it is anything
too serious; it is mostly a case of adding unrelated lines in the same
spot. I am happy to help with resolving that if there is a need.

However, there may be semantic conflicts. The big one I can think of is
how packfile reuse interacts with various versions. We only do pack
reuse during a --stdout pack to a client. At this point, that means we
must be outputting packv2. If we have packv2 on disk, we are fine. If we
have packv4 on disk, I guess we simply need to disable reuse, which
should not be hard.

Once we start sending packv4 to clients, we'll have to reevaluate.
Probably we can just get away with turning off reuse when there is a
mismatch, though if my understanding of packv4 is correct, we could
still reuse packv2 entries. We can put that off until somebody works on
packv4-on-the-wire, though. :)

> * jk/pack-bitmap (2013-11-18) 22 commits
>  - compat/mingw.h: Fix the MinGW and msvc builds
>  - pack-bitmap: implement optional name_hash cache
>  - t/perf: add tests for pack bitmaps
>  - t: add basic bitmap functionality tests
>  - count-objects: recognize .bitmap in garbage-checking
>  - repack: consider bitmaps when performing repacks
>  - repack: handle optional files created by pack-objects
>  - repack: turn exts array into array-of-struct
>  - repack: stop using magic number for ARRAY_SIZE(exts)
>  - pack-objects: implement bitmap writing
>  - rev-list: add bitmap mode to speed up object lists
>  - pack-objects: use bitmaps when packing objects
>  - pack-bitmap: add support for bitmap indexes
>  - documentation: add documentation for the bitmap format
>  - ewah: compressed bitmap implementation
>  - compat: add endianness helpers
>  - sha1_file: export `git_open_noatime`
>  - revision: allow setting custom limiter function
>  - pack-objects: factor out name_hash
>  - pack-objects: refactor the packing list
>  - revindex: export new APIs
>  - sha1write: make buffer const-correct
> 
>  Borrows the bitmap index into packfiles from JGit to speed up
>  enumeration of objects involved in a commit range without having to
>  fully traverse the history.

Looks like you picked up my latest re-roll with Ramsay's fix on top.
There wasn't a lot of review on this past round (I'm not surprised; it's
a dauntingly large chunk to review).  I outlined a few possible open
issues in the cover letter, but I'd be happy to build those on top,
which I think will make review of them a lot easier.

Do we want to try this in 'next' post-1.8.5, or should I try to prod an
area expert like Shawn into doing another round of review?

-Peff
