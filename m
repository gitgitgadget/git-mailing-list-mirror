From: Jeff King <peff@peff.net>
Subject: Re: suggestion: git status = restored
Date: Tue, 29 Mar 2011 10:58:18 -0400
Message-ID: <20110329145818.GC10771@sigill.intra.peff.net>
References: <imil67$oec$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Neal Kreitzinger <neal@rsss.com>
X-From: git-owner@vger.kernel.org Tue Mar 29 16:58:29 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q4aNH-0001v0-70
	for gcvg-git-2@lo.gmane.org; Tue, 29 Mar 2011 16:58:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752754Ab1C2O6W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Mar 2011 10:58:22 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:52732
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750980Ab1C2O6V (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Mar 2011 10:58:21 -0400
Received: (qmail 28911 invoked by uid 107); 29 Mar 2011 14:59:02 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 29 Mar 2011 10:59:02 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 29 Mar 2011 10:58:18 -0400
Content-Disposition: inline
In-Reply-To: <imil67$oec$1@dough.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170273>

On Fri, Mar 25, 2011 at 12:59:34PM -0500, Neal Kreitzinger wrote:

> We deleted (git-rm) a file from the repo by mistake.  Several commits later 
> we restored it (git-checkout, git-commit).  Git status shows "added" for 
> this file.  IMHO, it seems like git status should be "restored" or 
> "unremoved", etc, for this file.  Git detects renames and copies so it seems 
> like it could detect restores.

I am mildly negative on the idea, though I think it is mostly just
because I would not find that information useful at all.

But what gives me pause is that it is adding a totally new dimension to
git-status. Currently status is about three things:

  1. What's in your index, and how does it differ from what's in HEAD.

  2. What's in your working tree, and how does it differ from what's in
     your index.

  3. What untracked files are in your working tree.

So it is only about HEAD, the index, and the working tree, and we only
have to look at those things. We detect copies and renames, yes, but
only in the diffs between those points.

But what you are proposing requires looking backwards in history to see
if we used to have something like the thing that has been added. So that
introduces a few questions:

  1. What are we claiming to have "used to have"? Some arbitrary content
     at the same path, or similar content at the same path, or similar
     content at any path?

  2. Which history do we look at? Do we start traversing backwards from
     HEAD? If so, how far back do we go (you probably don't want to go
     to the roots, which is expensive)? Is it useful to see similar
     files on other branches (e.g., instead of "you are adding foo,
     which is being resurrected from 'HEAD~20: remove foo'", you would
     find out that "you are adding foo, which has also been added on
     branch 'topic'").

  3. How expensive is the test going to end up? For generating a commit
     template or running "git status", it's probably OK. But keep in
     mind also that people run "git status --porcelain" to generate
     their shell prompt. So it needs to either be really fast, or it
     needs to be easy to turn it off in some cases.

-Peff
