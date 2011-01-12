From: Jeff King <peff@peff.net>
Subject: Re: I want to report a bug/anomaly in Git
Date: Wed, 12 Jan 2011 13:35:56 -0500
Message-ID: <20110112183556.GD31747@sigill.intra.peff.net>
References: <AANLkTimt+U3oo4FaywUr86ArG8d29yWAeVYhpRkBYa_K@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Tony Sales <vinux.development@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 12 19:36:12 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pd5YF-00045h-1n
	for gcvg-git-2@lo.gmane.org; Wed, 12 Jan 2011 19:36:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754570Ab1ALSgA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Jan 2011 13:36:00 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:59596 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754388Ab1ALSf7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Jan 2011 13:35:59 -0500
Received: (qmail 23048 invoked by uid 111); 12 Jan 2011 18:35:58 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Wed, 12 Jan 2011 18:35:58 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 12 Jan 2011 13:35:56 -0500
Content-Disposition: inline
In-Reply-To: <AANLkTimt+U3oo4FaywUr86ArG8d29yWAeVYhpRkBYa_K@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165026>

On Tue, Jan 11, 2011 at 10:22:29PM +0000, Tony Sales wrote:

> The bug is that if you happen to create a new remote branch which
> shares it's name with an existing directory in the top level of the
> git repository, git then seems to get confused and the: git checkout
> <branch> - command doesn't switch to that branch or turn tracking on
> (and seems to think it was created from origin/<branch> rather than
> from refs/remotes/origin/<branch>), which it does if the branch
> doesn't share a name with an existing top level directory. This can be
> rectified by running: git checkout --track -b debian origin/debian

I don't think this is a bug so much as a confusing application of too
much DWIMmery in git-checkout. "git checkout foo" can mean several
things:

  1. If it's a branch name, then switch to that branch.

  2. Otherwise, if it's a tag name, switch to a detached HEAD at that
     tag.

  3. Otherwise, if it's a file known to git, then checkout its content
     in the index into the working tree.

  4. Otherwise, if there is a remote branch that matches
     refs/remotes/*/foo, create a new branch "foo" that tracks it.

So the problem is that you expect behavior (4), but behavior (3) is
getting in the way.

I assume it was written this way because (4) came much later, and
therefore came last so as not to break existing behavior for the other
cases. Conceptually, though, I think it makes more sense for it to come
(3) (i.e., to keep all of the "checking out a ref" behavior together).
And one can disambiguate the path-mode already by doing:

  git checkout -- debian

-Peff
