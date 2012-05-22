From: Jeff King <peff@peff.net>
Subject: Re: remove_duplicates() in builtin/fetch-pack.c is O(N^2)
Date: Tue, 22 May 2012 13:46:48 -0400
Message-ID: <20120522174648.GE11600@sigill.intra.peff.net>
References: <4FB9F92D.8000305@alum.mit.edu>
 <20120521174525.GA22643@sigill.intra.peff.net>
 <CACsJy8Dw+mbP+ttTP6gAfX9o4q4NyZgPYpbhS=tket=5fvBXwg@mail.gmail.com>
 <20120522170101.GA11600@sigill.intra.peff.net>
 <7vaa105dah.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	git discussion list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 22 19:46:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SWtAe-0000Cd-3t
	for gcvg-git-2@plane.gmane.org; Tue, 22 May 2012 19:46:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752539Ab2EVRqv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 May 2012 13:46:51 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:51853
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751852Ab2EVRqu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 May 2012 13:46:50 -0400
Received: (qmail 20569 invoked by uid 107); 22 May 2012 17:47:16 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 22 May 2012 13:47:16 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 22 May 2012 13:46:48 -0400
Content-Disposition: inline
In-Reply-To: <7vaa105dah.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198214>

On Tue, May 22, 2012 at 10:35:50AM -0700, Junio C Hamano wrote:

> > In this case, the packed-refs file is 30MB. Even just gzipping it takes
> > it down to 2MB. As far as I know, we don't ever do random access on the
> > file, but instead just stream it into memory.
> 
> True.
> 
> The current code reads the whole thing in upon first use of _any_ element
> in the file, just like the index codepath does for the index file.
> 
> But the calling pattern to the refs machinery is fairly well isolated and
> all happens in refs.c file.  Especially thanks to the recent work by
> Michael Haggerty, for "I am about to create a new branch 'frotz'; do I
> have 'refs/heads/frotz' or anything that begins with 'refs/heads/frotz/'?"
> kind of callers, it is reasonably easy to design a better structured
> packed-refs file format to allow us to read only a subtree portion of
> refs/ hierarchy, and plug that logic into the lazy ref population code.
> Such a "design a better packed-refs format for scalability to 400k refs"
> is a very well isolated project that has high chance of succeeding without
> breaking things.  No code outside refs.c assumes that there is a flat
> array of refs that records what was read from the packed-refs file and can
> walk linearly over it, unlike the in-core index.

Yeah. As gross as I find a 30MB packed-refs file, I don't actually think
that is the bottle-neck at all. Sure, it wastes some disk cache, but
in the grand scheme of things, anybody with 400K refs probably has a
much, much bigger object database.

So there probably isn't much point in clever tricks to make it smaller
on disk, especially if they will make further partial-read optimizations
harder to do. But...

> If you do "for_each_ref()" for everything (e.g. sending 'have' during the
> object transfer, or repacking the whole repository), you would end up
> needing to read the whole thing for obvious reasons.

I think Michael's work is really great for the loose refs, where hitting
each directory is very expensive. But for a repo with packed refs that
is just going to call for_each_ref, I'm worried that breaking apart the
ref list is going to cause noticeable overhead. But still, the
regression I'm seeing seems way too big for that overhead, so I think
something else is going on. We just need to find it.

-Peff
