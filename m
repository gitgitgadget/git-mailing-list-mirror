From: Jeff King <peff@peff.net>
Subject: [PATCH 0/8] use merge-base for tag --contains
Date: Wed, 25 Jun 2014 19:34:30 -0400
Message-ID: <20140625233429.GA20457@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 26 01:34:37 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wzwi4-00074F-3N
	for gcvg-git-2@plane.gmane.org; Thu, 26 Jun 2014 01:34:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755951AbaFYXec (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Jun 2014 19:34:32 -0400
Received: from cloud.peff.net ([50.56.180.127]:51211 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755235AbaFYXeb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jun 2014 19:34:31 -0400
Received: (qmail 4544 invoked by uid 102); 25 Jun 2014 23:34:31 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 25 Jun 2014 18:34:31 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 25 Jun 2014 19:34:30 -0400
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252472>

Once upon a time we checked "tag --contains" by doing N merge-base
traversals, one per tag. That turned out to be really slow.

Later, I added a single traversal in ffc4b80 (tag: speed up --contains
calculation, 2011-06-11) that works in a depth-first way. That's fast
for the common case of tags spread throughout history, but slow when all
of the tags are close to the searched-for commit (which would be more
likely with branches, since they advance). That, plus the general
hacky-ness of the implementation, prevented it from being used for "git
branch" or in other places.

Over a year ago, Junio and I worked on the commit-slab code. The
original point of it[1] was to be able to do a merge-base traversal like
this, where we kept one bit per tip in each commit (so that we know not
only what the merge base is, but _which_ tip hit each commit). So now I
finally got around to it. :)

Timings are in the final patch, but the short of it is: it's about as
fast as the depth-first code for the normal tag case (tags spread out
through history), but way faster for the branch-like case (tags close to
the commit).

This series stops short of moving "git branch" over to it.  My next goal
once this is solid is to factor the logic out so that "tag -l", "branch
-l", and "for-each-ref" all use the same code. I got stuck on that
earlier because I just couldn't justify sharing the tag-contains
implementation with the others.

  [1/8]: tag: allow --sort with -n
  [2/8]: tag: factor out decision to stream tags
  [3/8]: paint_down_to_common: use prio_queue
  [4/8]: add functions for memory-efficient bitmaps
  [5/8]: string-list: add pos to iterator callback
  [6/8]: commit: provide a fast multi-tip contains function
  [7/8]: tag: use commit_contains
  [8/8]: perf: add tests for tag --contains

-Peff

[1] http://article.gmane.org/gmane.comp.version-control.git/220545
