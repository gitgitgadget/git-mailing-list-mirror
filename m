From: Jeff King <peff@peff.net>
Subject: Re: history damage in linux.git
Date: Thu, 21 Apr 2016 13:08:15 -0400
Message-ID: <20160421170815.GA10783@sigill.intra.peff.net>
References: <20160421113004.GA3140@aepfle.de>
 <87lh473xic.fsf@linux-m68k.org>
 <CA+55aFx8hPKKcuwe-HHoO7LHVYLmJ6khndd-OtQotMs3EJzZ0w@mail.gmail.com>
 <xmqqzismsxsu.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Andreas Schwab <schwab@linux-m68k.org>,
	Olaf Hering <olaf@aepfle.de>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 21 19:08:24 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1atI5X-0008NK-Og
	for gcvg-git-2@plane.gmane.org; Thu, 21 Apr 2016 19:08:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753126AbcDURIT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Apr 2016 13:08:19 -0400
Received: from cloud.peff.net ([50.56.180.127]:53658 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751841AbcDURIS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Apr 2016 13:08:18 -0400
Received: (qmail 17693 invoked by uid 102); 21 Apr 2016 17:08:17 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 21 Apr 2016 13:08:17 -0400
Received: (qmail 10973 invoked by uid 107); 21 Apr 2016 17:08:17 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 21 Apr 2016 13:08:17 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 21 Apr 2016 13:08:15 -0400
Content-Disposition: inline
In-Reply-To: <xmqqzismsxsu.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292128>

On Thu, Apr 21, 2016 at 09:59:13AM -0700, Junio C Hamano wrote:

> Linus Torvalds <torvalds@linux-foundation.org> writes:
> 
> > That commit aed06b9 can also be described as
> >
> >     v3.13-rc7~9^2~14^2~42
> >
> > so describing it as 'v4.6-rc1~9^2~792' is clearly not closer in any way.
> 
> I seem to recall that name-rev had an unexplained heuristics to
> strongly avoid following second parent changes (I see two ^2 in the
> path from 3.13-rc7 above).

Right, because it makes the names longer. We give the second-parent
traversal a heuristic cost. If we drop that cost to "1", like:

diff --git a/builtin/name-rev.c b/builtin/name-rev.c
index 092e03c..03be8be 100644
--- a/builtin/name-rev.c
+++ b/builtin/name-rev.c
@@ -17,7 +17,7 @@ typedef struct rev_name {
 static long cutoff = LONG_MAX;
 
 /* How many generations are maximally preferred over _one_ merge traversal? */
-#define MERGE_TRAVERSAL_WEIGHT 65535
+#define MERGE_TRAVERSAL_WEIGHT 1
 
 static void name_rev(struct commit *commit,
 		const char *tip_name, int generation, int distance,


then this case gives:

  v3.13~5^2~4^2~2^2~1^2~42

which is technically true, but kind of painful to read. It may be that a
reasonable weight is somewhere between "1" and "65535", though.

However, I think the more fundamental confusion with git-describe is
that people expect the shortest distance to be the "first" tag that
contained the commit, and that is clearly not true in a branchy history.

I actually think most people would be happy with an algorithm more like:

  1. Find the "oldest" tag (either by timestamp, or by version-sorting
     the tags) that contains the commit in question.

  2. Find the "simplest" path from that tag to the commit, where we
     are striving mostly for shortness of explanation, not of path (so
     "~500" is way better than "~20^2~30^2~14", even though the latter
     is technically a shorter path).

-Peff
