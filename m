From: Jeff King <peff@peff.net>
Subject: Re: Achieving efficient storage of weirdly structured repos
Date: Sun, 6 Apr 2008 12:10:03 -0400
Message-ID: <20080406161003.GA24358@coredump.intra.peff.net>
References: <7BE3E865-C30D-49B8-A1D9-898109514990@sun.com> <alpine.LFD.1.00.0804031402530.14670@woody.linux-foundation.org> <1207351858.13123.52.camel@work.sfbay.sun.com> <alpine.LFD.1.00.0804041634180.14670@woody.linux-foundation.org> <4A31E284-E7F1-4748-A2CB-D8682748D3D6@sun.com> <alpine.LFD.1.00.0804051729230.11277@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Roman Shaposhnik <rvs@sun.com>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sun Apr 06 18:11:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JiXSc-0001rL-Ry
	for gcvg-git-2@gmane.org; Sun, 06 Apr 2008 18:11:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754000AbYDFQKJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Apr 2008 12:10:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753956AbYDFQKI
	(ORCPT <rfc822;git-outgoing>); Sun, 6 Apr 2008 12:10:08 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:4989 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753865AbYDFQKH (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Apr 2008 12:10:07 -0400
Received: (qmail 26727 invoked by uid 111); 6 Apr 2008 16:10:04 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Sun, 06 Apr 2008 12:10:04 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 06 Apr 2008 12:10:03 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LFD.1.00.0804051729230.11277@woody.linux-foundation.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78895>

On Sat, Apr 05, 2008 at 05:48:43PM -0700, Linus Torvalds wrote:

> One thing that the git model sucks at is how it's not very good at 
> handling large objects. I've often wondered if I should have made "object" 
> be more fine-grained and tried to build up large files from multiple 
> smaller objects.
> 
> [ That said, I think git does the right thing - for source code. The 
>   blocking-up of files would cause a rather more complex model, and one of 
>   the great things about git is how simple the basic model is. But the
>   large-file thing does mean that git potentially sucks really badly for 
>   some other loads ]

I have considered something like this for one of my repos, which is full
of images. The large image data very rarely changes, but the small EXIF
tags do.

My thought was something like:

  - add a new object type, multiblob; a multiblob contains zero or more
    "child" sha1s, each of which is another multiblob or a blob. The
    data in the multiblob is an in-order concatenation of its children.

  - you would create multiblobs with a "smart" git-add that understands
    the filetype and splits the file accordingly (in my case, probably a
    chunk of headers and EXIF data, and then a chunk with the image
    data).

  - in most of git, whenever you need a blob, you just "unwrap" the
    multiblob to get the original blob data

  - because they're separate objects, pack-objects automagically does
    the right thing

  - a few places would benefit from handling multiblobs specially. In
    particular:
      - the diff machinery could do much more efficient comparisons for
        some inexact renames. E.g., multiblob "1234\n5678" and multiblob
        "abcd\n5678" could ignore the "5678" id.
      - the diff machinery could show diffs that were more human
        readable (e.g., even without understanding what the chunks of
        the multiblob _mean_, it can still say "most of this image
        didn't change, but this textual part did").

Of course there are a few drawbacks:

  - one of git's strengths is that content is the same no matter who
    adds it or how. Now the same file has a different sha1 as a
    multiblob versus a regular blob.

  - it breaks the git model of "we store state in the simplest way, and
    figure everything out afterwards." IOW, you are stuck with whatever
    crappy multiblob split you did when you added or updated the file.
    The usual pattern in git is "dumb add, smart view". Now maybe it is
    worth breaking this for two reasons:

      - dumb add, smart view is often very resource intensive; we can
        get smaller packs and faster rename detection out of this

      - we might be losing information; in the case of renames, we can
        justify not explicitly recording because we can figure out
        later what actually happened. I don't know if there is a
        multiblob split that would encapsulate useful user input.
        My EXIF example doesn't; with a little more CPU time, you could
        just do the automated split at diff or delta time.

So it's an approach that I think would work, but I'm not sure it's worth
the effort unless somebody comes up with a compelling reason that you
can't just split the blobs up after the fact (and maybe the right
approach is that pack v5 can split blobs intelligently to get better
deltas, so they are still blobs, but we just store them differently).

-Peff
