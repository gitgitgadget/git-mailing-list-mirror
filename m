From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] [RFC] Making use of bitmaps for thin objects
Date: Mon, 6 Jan 2014 10:10:52 -0500
Message-ID: <20140106151052.GB15489@sigill.intra.peff.net>
References: <1387741654-14890-1-git-send-email-bmaurer@fb.com>
 <5CDDBDF2D36D9F43B9F5E99003F6A0D43B67C0DA@PRN-MBX02-1.TheFacebook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Ben Maurer <bmaurer@fb.com>
X-From: git-owner@vger.kernel.org Mon Jan 06 16:11:05 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W0BpY-0000K9-6S
	for gcvg-git-2@plane.gmane.org; Mon, 06 Jan 2014 16:11:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755163AbaAFPK4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jan 2014 10:10:56 -0500
Received: from cloud.peff.net ([50.56.180.127]:55910 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751099AbaAFPKy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Jan 2014 10:10:54 -0500
Received: (qmail 32609 invoked by uid 102); 6 Jan 2014 15:10:54 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 06 Jan 2014 09:10:54 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 06 Jan 2014 10:10:52 -0500
Content-Disposition: inline
In-Reply-To: <5CDDBDF2D36D9F43B9F5E99003F6A0D43B67C0DA@PRN-MBX02-1.TheFacebook.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240015>

On Sun, Dec 22, 2013 at 09:55:23PM +0000, Ben Maurer wrote:

> One issue with this approach is that it seems git-pack-index doesn't
> perform as well with thin packs. git-index-pack uses a multi-threaded
> approach to resolving the deltas. However, the multithreading only
> works on deltas that are exclusively in the pack. After the
> multi-threaded phase, it incrementally brings in objects from external
> packs, but in single threaded manner. Many objects in the pack have
> some dependency on an external object, therefore, defeating the
> multithreading.

Yes. It will also just plain perform worse, because it will have to
copy over more external objects. This is somewhat made up for getting an
actual smaller pack size, but I suspect the completed thin-pack ends up
larger than what the server would otherwise send. Because the server is
blindly reusing on-disk deltas (which is good, because it takes load off
of the server), it misses good delta opportunities between objects in
the sent pack (which are likely almost as small, but would not require
fixing on the other end).

Single-threading the extra work we have to do just exacerbates the
problem, of course.

Still, I think it will be a net win for end-to-end wall clock time of
the operation. You are saving CPU time on the server end, and you're
saving network bandwidth with a smaller pack.

In my tests on torvalds/linux, doing a fetch across a local machine (so
basically discounting network improvements), the times look like (this
is end-to-end, counting both server and client CPU time):

  [vanilla]
  real    0m3.850s
  user    0m7.504s
  sys     0m0.380s

  [patched]
  real    0m2.785s
  user    0m2.472s
  sys     0m0.180s

So it was a win both for wall-clock and CPU.

> What's the use case for a pack file with a SHA1 reference living
> inside the pack file (why not just use an offset?) Would it make sense
> to assume that all such files are external and bring them in in the
> first phase.

Once upon a time, ref-delta was the only format supported by packfiles. Later,
delta-base-offset was invented, and the client and server negotiate the
use of the feature before the packfile is generated (and even when we
reuse objects, pack-objects will rewrite the header on the fly to use
ref-delta if necessary).

These days, pretty much everybody supports delta-base-offset, so I don't
think there is any reason index-pack should see ref-delta for a non-thin
object. We could probably teach index-pack an "--assume-refs-are-thin"
option to optimize for this case, and have fetch-pack/receive-pack pass
it whenever they know that delta-base-offset was negotiated.

-Peff
