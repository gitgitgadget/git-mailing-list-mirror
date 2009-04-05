From: Jeff King <peff@peff.net>
Subject: Re: Performance issue: initial git clone causes massive repack
Date: Sun, 5 Apr 2009 15:57:14 -0400
Message-ID: <20090405195714.GA4716@coredump.intra.peff.net>
References: <20090404220743.GA869@curie-int>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git Mailing List <git@vger.kernel.org>
To: "Robin H. Johnson" <robbat2@gentoo.org>
X-From: git-owner@vger.kernel.org Sun Apr 05 22:10:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LqYUr-00036S-Vx
	for gcvg-git-2@gmane.org; Sun, 05 Apr 2009 21:59:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753492AbZDET5e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Apr 2009 15:57:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753466AbZDET5e
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Apr 2009 15:57:34 -0400
Received: from peff.net ([208.65.91.99]:60544 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752294AbZDET5d (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Apr 2009 15:57:33 -0400
Received: (qmail 17446 invoked by uid 107); 5 Apr 2009 19:57:51 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sun, 05 Apr 2009 15:57:51 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 05 Apr 2009 15:57:14 -0400
Content-Disposition: inline
In-Reply-To: <20090404220743.GA869@curie-int>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115691>

On Sat, Apr 04, 2009 at 03:07:43PM -0700, Robin H. Johnson wrote:

> During an initial clone, I see that git-upload-pack invokes
> pack-objects, despite the ENTIRE repository already being packed - no
> loose objects whatsoever. git-upload-pack then seems to buffer in
> memory.

We need to run pack-objects even if the repo is fully packed because we
don't know what's _in_ the existing pack (or packs). In particular we
want to:

  - combine multiple packs into a single pack; this is more efficient on
    the network, because you can find more deltas, and I believe is
    required because the protocol sends only a single pack.

  - cull any objects which are not actually part of the reachability
    chain from the refs we are sending

If no work needs to be done for either case, then pack-objects should
basically just figure that out and then send the existing pack (the
expensive bit is doing deltas, and we don't consider objects in the same
pack for deltas, as we know we have already considered that during the
last repack). It does mmap the whole pack, so you will see your virtual
memory jump, but nothing should require the whole pack being in memory
at once.

pack-objects streams the output to upload-pack, which should only ever
have an 8K buffer of it in memory at any given time.

At least that is how it is all supposed to work, according to my
understanding. So if you are seeing very high memory usage, I wonder if
there is a bug in pack-objects or upload-pack that can be fixed.

Maybe somebody more knowledgeable than me about packing can comment.

> During 'remote: Counting objects: 4886949, done.', git-upload-pack peaks at
> 2474216KB VSZ and 1143048KB RSS. 
> Shortly thereafter, we get 'remote: Compressing objects:   0%
> (1328/1994284)', git-pack-objects with ~2.8GB VSZ and ~1.8GB RSS. Here,
> the CPU burn also starts. On our test server machine (w/ git 1.6.0.6),
> it takes about 200 minutes walltime to finish the pack, IFF the OOM
> doesn't kick in.

Have you tried with a more recent git to see if it is any better? There
have been a number of changes since 1.6.0.6, although it looks like
mostly dealing with better recovery from corrupted packs.

> Given that the repo is entirely packed already, I see no point in doing
> this.
> 
> For the initial clone, can the git-upload-pack algorithm please send
> existing packs, and only generate a pack containing the non-packed
> items?

I believe that would require a change to the protocol to allow multiple
packs. However, it may be possible to munge the pack header in such a
way that you basically concatenate multiple packs. You would still want
to peek in the big pack to try deltas from the non-packed items, though.

I think all of this falls into the realm of the GSOC pack caching project.
There have been other discussions on the list, so you might want to look
through those for something useful.

-Peff
