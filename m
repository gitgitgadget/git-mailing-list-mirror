From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] sha1_file: introduce close_one_pack() to close packs on
 fd pressure
Date: Tue, 30 Jul 2013 12:52:57 -0700
Message-ID: <20130730195257.GA16247@sigill.intra.peff.net>
References: <1375157113-608-1-git-send-email-bcasey@nvidia.com>
 <7v61vsxdiz.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Brandon Casey <bcasey@nvidia.com>, git@vger.kernel.org,
	spearce@spearce.org, Brandon Casey <drafnel@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 30 21:53:06 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V4Fyi-0000fS-RX
	for gcvg-git-2@plane.gmane.org; Tue, 30 Jul 2013 21:53:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756625Ab3G3TxA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Jul 2013 15:53:00 -0400
Received: from cloud.peff.net ([50.56.180.127]:40748 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756135Ab3G3Tw7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Jul 2013 15:52:59 -0400
Received: (qmail 19689 invoked by uid 102); 30 Jul 2013 19:52:59 -0000
Received: from host-199-115-243-177.moscone.com (HELO sigill.intra.peff.net) (199.115.243.177)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 30 Jul 2013 14:52:59 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 30 Jul 2013 12:52:57 -0700
Content-Disposition: inline
In-Reply-To: <7v61vsxdiz.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231388>

On Tue, Jul 30, 2013 at 08:39:48AM -0700, Junio C Hamano wrote:

> Brandon Casey <bcasey@nvidia.com> writes:
> 
> > From: Brandon Casey <drafnel@gmail.com>
> >
> > When the number of open packs exceeds pack_max_fds, unuse_one_window()
> > is called repeatedly to attempt to release the least-recently-used
> > pack windows, which, as a side-effect, will also close a pack file
> > after closing its last open window.  If a pack file has been opened,
> > but no windows have been allocated into it, it will never be selected
> > by unuse_one_window() and hence its file descriptor will not be
> > closed.  When this happens, git may exceed the number of file
> > descriptors permitted by the system.
> 
> An interesting find.  The patch from a cursory look reads OK.

Yeah. I wonder if unuse_one_window() should actually leave the pack fd
open now in general.

If you close packfile descriptors, you can run into racy situations
where somebody else is repacking and deleting packs, and they go away
while you are trying to access them. If you keep a descriptor open,
you're fine; they last to the end of the process. If you don't, then
they disappear from under you.

For normal object access, this isn't that big a deal; we just rescan the
packs and retry. But if you are packing yourself (e.g., because you are
a pack-objects started by upload-pack for a clone or fetch), it's much
harder to recover (and we print some warnings).

We had our core.packedGitWindowSize lowered on GitHub for a while, and
we ran into this warning on busy repositories when we were running "git
gc" on the server. We solved it by bumping the window size so we never
release memory.

But just not closing the descriptor wouldn't work until Brandon's patch,
because we used the same function to release memory and descriptor
pressure. Now we could do them separately (and progressively if we need
to).

> > This is not likely to occur during upload-pack since upload-pack
> > reads each object from the pack so that it can peel tags and
> > advertise the exposed object.
> 
> Another interesting find.  Perhaps there is a room for improvements,
> as packed-refs file knows what objects the tags peel to?  I vaguely
> recall Peff was actively reducing the object access during ref
> enumeration in not so distant past...

Yeah, we should be reading almost no objects these days due to the
packed-refs peel lines. I just did a double-check on what "git
upload-pack . </dev/null >/dev/null" reads on my git.git repo, and it is
only three objects: the v1.8.3.3, v1.8.3.4, and v1.8.4-rc0 tag objects.
In other words, the tags I got since the last time I ran "git gc". So I
think all is working as designed.

We could give receive-pack the same treatment; I've spent less time
micro-optimizing it because because we (and most sites, I would think)
get an order of magnitude more fetches than pushes.

-Peff
