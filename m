From: Jeff King <peff@peff.net>
Subject: Re: Adding git hooks
Date: Mon, 28 Apr 2014 15:11:48 -0400
Message-ID: <20140428191148.GB25993@sigill.intra.peff.net>
References: <1398504843.79785833@f133.i.mail.ru>
 <7vy4yshul9.fsf@alter.siamese.dyndns.org>
 <20140426175002.GC21493@sigill.intra.peff.net>
 <xmqq4n1dtnfl.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Suvorov Ivan <sv_91@inbox.ru>, git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 28 21:12:24 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WeqyI-00085L-42
	for gcvg-git-2@plane.gmane.org; Mon, 28 Apr 2014 21:12:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753851AbaD1TLy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Apr 2014 15:11:54 -0400
Received: from cloud.peff.net ([50.56.180.127]:40565 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753857AbaD1TLu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Apr 2014 15:11:50 -0400
Received: (qmail 11687 invoked by uid 102); 28 Apr 2014 19:11:50 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 28 Apr 2014 14:11:50 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 28 Apr 2014 15:11:48 -0400
Content-Disposition: inline
In-Reply-To: <xmqq4n1dtnfl.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247390>

On Mon, Apr 28, 2014 at 09:43:10AM -0700, Junio C Hamano wrote:

> Yes, I'd love to see something along that line in the longer term,
> showing all the objects as just regular objects under the hood, with
> implementation details hidden in the object layer (just like there
> is no distinction between packed and loose objects from the point of
> view of read_sha1_file() users), as a real solution to address
> issues in larger trees.
> 
> Also see http://thread.gmane.org/gmane.comp.version-control.git/241940
> where Shawn had an interesting experiment.

Yeah, I think it's pretty clear that a naive high-latency object store
is unusably slow. You mentioned in that thread trying to do pre-fetching
based on commits/trees, and I recall that Shawn's Cassandra experiments
did that (and maybe the BigTable-backed Google Code does, too?).

There's also a question of deltas. You don't want to get trees or text
blobs individually without deltas, because your total size ends up way
bigger.

But I think for large object support, we can side-step the issue. The
objects will all be blobs (so they cannot refer to anything else), they
will typically not delta well, and the connection setup and latency will
be dwarfed by actual transfer time. My plan was to have all clones fetch
all commits and trees (and small blobs, too), and then download and
cache the large blobs as-needed.

That doesn't help with repositories where the actual commit history or
tree size is a problem. But we already have shallow clones to help with
the former. And for the latter, I think we would want a narrow clone
that behaves differently than what I described above. You'd probably
want a specific "widen" operation that would fetch all of the objects
for the newly-widened part of the tree in one go (including deltas), and
you wouldn't want it to happen on an as-needed basis.

-Peff
