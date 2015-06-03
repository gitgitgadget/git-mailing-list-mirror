From: Jeff King <peff@peff.net>
Subject: Re: Suggestion: make git checkout safer
Date: Wed, 3 Jun 2015 05:35:15 -0400
Message-ID: <20150603093514.GF32000@peff.net>
References: <loom.20150603T104534-909@post.gmane.org>
 <20150603090654.GD32000@peff.net>
 <loom.20150603T110826-777@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Ed Avis <eda@waniasset.com>
X-From: git-owner@vger.kernel.org Wed Jun 03 11:36:02 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z0552-0007KR-Hz
	for gcvg-git-2@plane.gmane.org; Wed, 03 Jun 2015 11:35:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754108AbbFCJfU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Jun 2015 05:35:20 -0400
Received: from cloud.peff.net ([50.56.180.127]:40319 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753578AbbFCJfS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Jun 2015 05:35:18 -0400
Received: (qmail 17781 invoked by uid 102); 3 Jun 2015 09:35:18 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 03 Jun 2015 04:35:18 -0500
Received: (qmail 18093 invoked by uid 107); 3 Jun 2015 09:35:18 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 03 Jun 2015 05:35:18 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 03 Jun 2015 05:35:15 -0400
Content-Disposition: inline
In-Reply-To: <loom.20150603T110826-777@post.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270674>

On Wed, Jun 03, 2015 at 09:21:59AM +0000, Ed Avis wrote:

> I had expected that 'git checkout .' would fix up my working tree to make it
> match the repository (in this case, the current revision of the master
> branch).

It did. :)

> The user interface might be something like:
> 
> % git checkout .
> error: Your local changes to the following files would be overwritten:
>         foo
> You may want to commit or stash these changes, or delete the files if you
> don't want them.  Use 'git checkout --force' to proceed, throwing away
> local changes.
> Aborting
> 
> If the checkout operation would only involve creating some files on disk
> which aren't currently there, then it would proceed without prompting.

Thanks for explaining. I see where you are coming from, though I'm still
a bit lukewarm on the idea, if only because the vast majority of
invocations would involve "--force".

It also seems a bit special-cased to treat restoring deletions
specially.  I would say the more "usual" way to use checkout like this
is to give specific paths. I.e., run "git status", say "oh, I need to
restore the contents of 'foo', but not 'bar'", and run "git checkout
foo". That works regardless of the type of change to "foo" and "bar".

If we want to introduce more safety here, I'd be inclined to perform the
operation by default, but give a better escape hatch. For example, by
creating a loose object for any file we're about to overwrite, and
possibly writing an entry into a log. That's a lot more work, but has a
few advantages:

  1. It helps even when you just ran with "--force" followed by an
     "oops, why did I do that?" moment.

  2. It can help other commands like "git clean".

  3. That log could form a basis for a "git undo" program to help with
     "oops" moments in general (e.g., if you use "git reset ." to
     overwrite what is in the index, we have all of the old file content
     in objects, but it can sometimes be a pain to figure out _which_
     objects went where.

-Peff
