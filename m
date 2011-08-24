From: Jeff King <peff@peff.net>
Subject: Re: git for game development?
Date: Wed, 24 Aug 2011 14:26:32 -0400
Message-ID: <20110824182632.GA22659@sigill.intra.peff.net>
References: <416D1A48-9916-4E44-A200-3A13C39C4D70@gmail.com>
 <20110824012418.GA19091@sigill.intra.peff.net>
 <7vwre2pw3m.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Lawrence Brett <lcbrett@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 24 20:26:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QwI9w-00059C-Jc
	for gcvg-git-2@lo.gmane.org; Wed, 24 Aug 2011 20:26:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752937Ab1HXS0g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Aug 2011 14:26:36 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:60556
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752697Ab1HXS0e (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Aug 2011 14:26:34 -0400
Received: (qmail 4895 invoked by uid 107); 24 Aug 2011 18:27:16 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 24 Aug 2011 14:27:16 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 24 Aug 2011 14:26:32 -0400
Content-Disposition: inline
In-Reply-To: <7vwre2pw3m.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180021>

On Wed, Aug 24, 2011 at 10:17:49AM -0700, Junio C Hamano wrote:

> I suspect that people with large binary assets were scared away by rumors
> they heard second-hand, based on bad experiences other people had before
> any of the recent efforts made in various "large Git" topics, and they
> themselves haven't tried recent versions of Git enough to be able to tell
> what the remaining pain points are. I wouldn't be surprised if none of the
> core Git people tried shoving huge binary assets in test repositories with
> recent versions of Git---I certainly haven't.

I haven't tried anything really big in a while. My personal interest in
big file support has been:

  1. Mid-sized photos and videos (objects top out around 50M, total repo
     size is 4G packed). Most commits are additions or tweaks of exif
     tags (so they delta well). Using gitattributes (and especially
     textconv caching), it's really quite pleasant to use. Doing a full
     repack is my only complaint; the delta-compression isn't bad, but
     just the I/O on rewriting the whole thing is a killer.

  2. Storing an entire audio collection in flac. Median file size is
     only around 20M, but the whole repo is 120G.  Obviously compression
     doesn't buy much, so a git repo plus checkout is 240G, which is
     pretty hefty for most laptops. I played with this early on, but
     gave up; the data storage model just doesn't make sense.

The two common use cases that aren't represented here are:

  3. Big files, not just big repos. I.e., files that are 1G or more.

  4. Medium-big files that don't delta well (e.g., metadata tweaks do
     delta well; rewriting media assets for a game don't delta well).

I think recent changes (like putting big files straight to packs) make
(3) and (4) reasonably pleasant.

I'm not sure of the right answer for (1). The repack is the only
annoying thing. But not repacking is not satisfying, either.  You don't
get deltas where they are applicable, and the server is always
re-examining the pack for possible deltas on fetch and push. Some sort
of hybrid loose-pack storage would be nice: store delta chains for big
files in their own individual packs, but otherwise keep everything in a
separate pack. We would want some kind of meta-index over all of these
little pack-files, not just individual pack-file indices.

But (2) is the hardest one. It would be nice if we had some kind of
local-remote hybrid storage, where objects were fetched on demand from
somewhere else. For example, developers on workstations with a fast
local network to a storage server wouldn't have to replicate all of the
objects locally. And for a true distributed setup, when the fast network
isn't there, it would be nice to fail gracefully (which maybe just means
saying "sorry, we can't do 'log -p' right now; try 'log --raw'").

I wonder how close one can get on (2) using alternates and a
network-mounted filesystem.

> People toyed around with ideas to have a separate object store
> representation for large and possibly incompressible blobs (a possible
> complaint being that it is pointless to send them even to its own
> packfile). One possible implementation would be to add a new huge
> hierarchy under $GIT_DIR/objects/, compute the object name exactly the
> same way for huge blobs as we normally would (i.e. hash concatenation of
> object header and then contents) to decide which subdirectory under the
> "huge" hierarchy to store the data (huge/[0-9a-f]{2}/[0-9a-f]{38}/ like we
> do for loose objects, or perhaps huge/[0-9a-f]{40}/ expecting that there
> won't be very many). The data can be stored unmodified as a file in that
> directory, with type stored in a separate file---that way, we won't have
> to compress, but we just copy. You still need to hash it at least once to
> come up with the object name, but that is what gives us integrity checks,
> is unavoidable and is not going to change.

Yeah. I think one of the bonuses there is that some filesystems are
capable of referencing the same inodes in a copy-on-write way, so "add"
and "checkout" cease to be a copy operation, but rather an inode-linking
operation. Which is a big win, both for speed and storage.

I've had dreams of using hard-linking to do something similar, but it's
just not safe enough without some filesystem-level copy-on-write
protection.

-Peff
