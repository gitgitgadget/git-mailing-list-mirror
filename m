From: Jeff King <peff@peff.net>
Subject: Re: How to use git attributes to configure server-side checks?
Date: Thu, 22 Sep 2011 13:13:41 -0400
Message-ID: <20110922171340.GA2934@sigill.intra.peff.net>
References: <4E7A3BDE.3040301@alum.mit.edu>
 <7vy5xh1whq.fsf@alter.siamese.dyndns.org>
 <4E7AF1AE.5030005@alum.mit.edu>
 <CAG+J_DxtCx6-RKWLKFy+V7tOtu7UnUrke7iN8gNdGiY-sC52sQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Junio C Hamano <gitster@pobox.com>,
	git discussion list <git@vger.kernel.org>
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 22 19:13:49 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R6mqJ-00055s-V3
	for gcvg-git-2@lo.gmane.org; Thu, 22 Sep 2011 19:13:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751886Ab1IVRNn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Sep 2011 13:13:43 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:40916
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751491Ab1IVRNn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Sep 2011 13:13:43 -0400
Received: (qmail 9353 invoked by uid 107); 22 Sep 2011 17:18:42 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 22 Sep 2011 13:18:42 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 22 Sep 2011 13:13:41 -0400
Content-Disposition: inline
In-Reply-To: <CAG+J_DxtCx6-RKWLKFy+V7tOtu7UnUrke7iN8gNdGiY-sC52sQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181901>

On Thu, Sep 22, 2011 at 11:41:34AM -0400, Jay Soffian wrote:

> Thank you for this thread. I was under the illusion that diff-tree
> --check considered in-tree .gitattributes, but the code seems to
> indicate otherwise. :-(

No, we definitely don't use in-tree gitattributes. IIRC, there are some
precedence and ordering questions. I think the ordering now is:

  1. Look in $GIT_DIR/info/attributes

  2. If not found, look in per-directory .gitattributes

  3. If not found, look in core.gitattributesfile

Where do in-tree attributes fit in? Between 1 and 2? Or 2 and 3? And
which tree do we look at?

Here are some examples:

  a. If I do "git checkout branch-foo", we should look at branch-foo's
     tree for things like crlf, right?  Do we still fall back to
     per-directory .gitattributes in the working tree? On the one hand,
     they're not really relevant to the commit we're moving to. But they
     are respected in the current code, and can be useful when moving to
     old commits which lack attributes.

     I think this is where the index magic comes in in the current code
     (we do something like "load the index, then respect gitattributes
     from the index").

     So maybe this is solved already.

  b. You're diffing commit $a against commit $b. Whose gitattributes
     have precedence? Is order important? Are gitattributes in the
     working tree and index relevant?

  c. You're diffing commit $a against HEAD. Which gitattributes have
     precedence? Again, is order important (i.e., does "diff -R" look at
     different attributes than "diff")?

I'm sure there are others, too. And I don't think any of these is
insurmountable. But somebody needs to think through a lot of cases and
come up with consistent, sane behavior that does the right thing in each
case (considering both bare repositories and ones with working trees).

-Peff
