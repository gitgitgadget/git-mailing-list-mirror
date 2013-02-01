From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 4/6] introduce a commit metapack
Date: Fri, 1 Feb 2013 04:42:41 -0500
Message-ID: <20130201094237.GE30644@sigill.intra.peff.net>
References: <20130129091434.GA6975@sigill.intra.peff.net>
 <20130129091610.GD9999@sigill.intra.peff.net>
 <7vy5fbq48t.fsf@alter.siamese.dyndns.org>
 <7vtxpzq2uv.fsf@alter.siamese.dyndns.org>
 <20130130071209.GD11147@sigill.intra.peff.net>
 <7vboc6mzpf.fsf@alter.siamese.dyndns.org>
 <CAJo=hJv0aqLpitnRJ6WKdPCETT6YgX5Njpv44DAYUg_KALhf=g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>,
	Duy Nguyen <pclouds@gmail.com>
To: Shawn Pearce <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Feb 01 10:43:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U1D9d-0006cz-3o
	for gcvg-git-2@plane.gmane.org; Fri, 01 Feb 2013 10:43:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756169Ab3BAJnG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Feb 2013 04:43:06 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:55337 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755721Ab3BAJnE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Feb 2013 04:43:04 -0500
Received: (qmail 19990 invoked by uid 107); 1 Feb 2013 09:44:24 -0000
Received: from c-71-206-173-132.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.206.173.132)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 01 Feb 2013 04:44:24 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 01 Feb 2013 04:42:41 -0500
Content-Disposition: inline
In-Reply-To: <CAJo=hJv0aqLpitnRJ6WKdPCETT6YgX5Njpv44DAYUg_KALhf=g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215226>

On Thu, Jan 31, 2013 at 09:03:26AM -0800, Shawn O. Pearce wrote:

> > Of course, it is more convenient to store this kind of things in a
> > separate file while experimenting and improving the mechanism, but I
> > do not think we want to see each packfile in a repository comes with
> > 47 auxiliary files with different suffixes 5 years down the road.
> 
> Arrrrgggh.
> 
> Right now we are in the middle of refactoring the JGit reachability
> bitmap implementation to store it into a separate file and get it out
> of the .idx file. This work is nearly completed. So this thread is
> great timing. :-)
> 
> I think Junio is right about not wanting 47 different tiny auxiliary
> files for a single pack. We are unlikely to create that many, but
> right now there are proposals floating around for at least 2 new
> auxiliary files (commit cache and reachability bitmaps). So its not
> impossible that another will be discovered in the future.

Why don't we want 47 files (or even 3)? If it makes the implementation
more flexible or simple without sacrificing performance, I don't see a
problem. The filesystem is there to organize our data; we do not cram
all of our files into one just to save a few inodes.

We _do_ cram our data into packfiles and packed-refs when we can save
O(n) inodes. But if we are talking about a handful of extra files that
we must readdir() over while preparing the objects/pack directory, I
don't think that is the same thing.

The data dependency issues (can the files get out of sync? How common is
it? Can we detect it?) and performance issues are more interesting to
me. With respect to the latter, here's specifically what I'm thinking
of. Let's imagine we have an extension for reachability bitmaps that
takes up an extra 10MB. When we mmap the .idx file, do we always mmap
the extra bytes? What's the performance impact of the extra mmap? I
recall on some non-Linux systems it can be quite expensive. For most git
commands which are not going to do a reachability analysis, this is a
loss.

I don't know if this is an issue big enough to care about or not. But I
think it's worth benchmarking and including in the decision.

> Junio may be right about the hole in the index file for git-core. I
> haven't checked the JGit implementation, but I suspect it does not
> have this hole. IIRC JGit consumes the index sections and then expects
> the pack trailer SHA-1 to be present immediately after the last table.
> This happens because JGit doesn't use mmap() to load the index, it
> streams the file into memory and does some reformatting on the tables
> to make search faster.

Yeah, looking at the PackIndexV2 implementation, it counts the 64-bit
offsets from the first table, calculates the size of the large offset
table, reads past it, and then expects the pack checksum. So let's
assume we would have to bump to v3 to implement it inside the .idx file.

> If we are going to change the index to support extension sections and
> I have to modify JGit to grok this new format, it needs to be index v3
> not index v2. If we are making index v3 we should just put index v3 on
> the end of the pack file.

I'm not sure what you mean by your last sentence here.

-Peff
