From: Jeff King <peff@peff.net>
Subject: [PATCH 0/8] caching rename results
Date: Sat, 4 Aug 2012 13:09:05 -0400
Message-ID: <20120804170905.GA19267@sigill.intra.peff.net>
References: <20120731141536.GA26283@do>
 <7vtxwnki1a.fsf@alter.siamese.dyndns.org>
 <20120731192342.GB30808@sigill.intra.peff.net>
 <CACsJy8B14qSLkAt9VRQTCkoZx5UtGTpAmMHKyqk+_o14bc9GmQ@mail.gmail.com>
 <20120801020124.GA18071@sigill.intra.peff.net>
 <CACsJy8AYzYTJ+k72ZEuWW-RdKe7arYbbscVALNYakKSfYqD_zw@mail.gmail.com>
 <20120801212719.GA16233@sigill.intra.peff.net>
 <CACsJy8CndopS7fg4mevFD5T0KJ85ba6jjhamrKDdKvKsWa_fQw@mail.gmail.com>
 <20120802224155.GB28217@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 04 19:09:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sxhqq-0001dX-45
	for gcvg-git-2@plane.gmane.org; Sat, 04 Aug 2012 19:09:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753622Ab2HDRJN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 Aug 2012 13:09:13 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:51665 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753537Ab2HDRJL (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Aug 2012 13:09:11 -0400
Received: (qmail 1893 invoked by uid 107); 4 Aug 2012 17:09:17 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 04 Aug 2012 13:09:17 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 04 Aug 2012 13:09:05 -0400
Content-Disposition: inline
In-Reply-To: <20120802224155.GB28217@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202881>

On Thu, Aug 02, 2012 at 06:41:55PM -0400, Jeff King wrote:

> > (1a) is good regardless rename overrides. Why don't you polish and
> > submit it? We can set some criteria to limit the cache size while
> > keeping computation reasonably low. Caching rename scores for file
> > pairs that has file size larger than a limit is one. Rename matrix
> > size could also be a candidate. We could even cache just rename scores
> > for recent commits (i.e. close to heads) only with the assumption that
> > people diff/apply recent commits more often.
> 
> I'll polish and share it. I'm still not 100% sure it's a good idea,
> because introducing an on-disk cache means we need to _manage_ that
> cache. How big will it be? Who will prune it when it gets too big? By
> what criteria? And so on.
> 
> But if it's all hidden behind a config option, then it won't hurt people
> who don't use it. And people who do use it can gather data on how the
> caches grow.

Here it is, all polished up. I'm still a little lukewarm on it for two
reasons:

  1. The whole idea. For the reasons above, I'm a little iffy on doing
     this cache at all. It does yield speedups, but only in some
     specific cases. So it's hidden behind a diff.renamecaches option
     and off by default.

  2. The implementation is a little...gross. Long ago, I had written a
     type-generic map class for git using void pointers. It ended up
     complex and had problems with unaligned accesses. So I rewrote it
     using preprocessor macro expansion (e.g., you'd call
     IMPLEMENT_MAP(foo, const char *, int) or similar). But that wasn't
     quite powerful enough, as I really want conditional compilation
     inside the macro expansion, but you can't #ifdef.

     So I really wanted some kind of code generation that could do
     conditionals. Which you can do with the C preprocessor, but rather
     than expanding macros, you have to #include templates that expand
     based on parameters you've set. Which is kind of ugly and
     non-intuitive, but it does work. Look at patch 1 to see what I
     mean.

     Also, this sort of pre-processor hackery to create type-generic
     data structures is the first step on the road that eventually led
     to C++ being developed. And that scares me a little.

So yeah. Here it is. I'm not sure yet if it's a good idea or not.

  [1/8]: implement generic key/value map

Infrastructure.

  [2/8]: map: add helper functions for objects as keys
  [3/8]: fast-export: use object to uint32 map instead of "decorate"
  [4/8]: decorate: use "map" for the underlying implementation

These ones are optional for this series, but since we are introducing
the infrastructure anyway (which is really just a generalized form of
what "decorate" does), it offsets the code bloat.

  [5/8]: map: implement persistent maps
  [6/8]: implement metadata cache subsystem

More infrastructure.

  [7/8]: implement rename cache
  [8/8]: diff: optionally use rename cache

And these are the actual rename cache.

-Peff
