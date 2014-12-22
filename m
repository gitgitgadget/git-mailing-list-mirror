From: Jeff King <peff@peff.net>
Subject: XDL_FAST_HASH can be very slow
Date: Sun, 21 Dec 2014 23:19:45 -0500
Message-ID: <20141222041944.GA441@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Thomas Rast <tr@thomasrast.ch>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 22 05:20:05 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y2uTQ-0001Ri-La
	for gcvg-git-2@plane.gmane.org; Mon, 22 Dec 2014 05:20:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753841AbaLVETq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Dec 2014 23:19:46 -0500
Received: from cloud.peff.net ([50.56.180.127]:56105 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753764AbaLVETq (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Dec 2014 23:19:46 -0500
Received: (qmail 4241 invoked by uid 102); 22 Dec 2014 04:19:46 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sun, 21 Dec 2014 22:19:46 -0600
Received: (qmail 10726 invoked by uid 107); 22 Dec 2014 04:19:56 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sun, 21 Dec 2014 23:19:56 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 21 Dec 2014 23:19:45 -0500
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261638>

I ran across an interesting case that diffs very slowly with modern git.
And it's even public. You can clone:

  git://github.com/outpunk/evil-icons

and try:

  git show fc4efe426d5b4e6aa8d5a4dc14babeada7c5f899

(which is also the tip of master as of this writing).

The interesting file there is a 10MB Illustrator file, "assets/ei.ai".
Git treats it as text, as the early part doesn't have any NULs, but it
is mostly non-human-readable. It has a large number of lines, and some
of the lines themselves are quite large.

On my machine, "git show" takes ~77 seconds using v2.2.1. But if I build
the same version with "make XDL_FAST_HASH=", it completes in about 0.4s.
Both produce the same output.

I'm not really sure what's going on.  A few points of interest:

 - You can replicate this with the very first commit that added
   XDL_FAST_HASH, 6942efc (xdiff: load full words in the inner loop of
   xdl_hash_record, 2012-04-06). So it was always bad on this case, and
   it's not part of any more recent changes.

 - We actually _don't_ spend most of our time in xdl_hash_record, the
   function modified by 6942efc. Instead, it all goes to
   xdl_classify_record, which is looping over the set of hash records.
   It's not clear to me if more or different hash records is part of the
   design of XDL_FAST_HASH, or if this is actually a bug.

I haven't dug much further than that.

-Peff
