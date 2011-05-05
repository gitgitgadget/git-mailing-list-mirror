From: Jeff King <peff@peff.net>
Subject: Re: [RFC] require-work-tree wants more than what its name says
Date: Thu, 5 May 2011 00:23:19 -0400
Message-ID: <20110505042319.GA10243@sigill.intra.peff.net>
References: <7vhb9bgy0a.fsf@alter.siamese.dyndns.org>
 <20110504073850.GA8512@sigill.intra.peff.net>
 <7vliymfp4t.fsf@alter.siamese.dyndns.org>
 <20110504212848.GA27779@sigill.intra.peff.net>
 <7v62ppdhh5.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 05 06:23:37 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QHq6C-0004o4-Qn
	for gcvg-git-2@lo.gmane.org; Thu, 05 May 2011 06:23:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750921Ab1EEEXW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 May 2011 00:23:22 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:56428
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750857Ab1EEEXV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 May 2011 00:23:21 -0400
Received: (qmail 26468 invoked by uid 107); 5 May 2011 04:25:15 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 05 May 2011 00:25:15 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 05 May 2011 00:23:19 -0400
Content-Disposition: inline
In-Reply-To: <7v62ppdhh5.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172792>

On Wed, May 04, 2011 at 07:11:18PM -0700, Junio C Hamano wrote:

> >> I am Ok with renaming the thing to "require_work_tree_exists", and all the
> >> worry will go away.
> >
> > Yeah, that seems like a fine solution to me.
> 
> Ok, then here is a reroll.

Looks sane. A few comments:

> But the implementation of require_work_tree we have today is quite
> different.  I don't have energy to dig the history, but currently it says:
> 
>  	test "$(git rev-parse --is-inside-work-tree 2>/dev/null)" = true ||
>  	die "fatal: $0 cannot be used without a working tree."
> 
> Which is completely bogus.  Even though we may happen to be just outside
> of it right now, we may have a working tree that we can cd_to_toplevel
> back to.

AFAICT, it has been that way since 7ae3df8 (Use new semantics of
is_bare/inside_git_dir/inside_work_tree, 2007-06-03), which is around
the time GIT_WORK_TREE came into existence.

So I think it was a matter of being overly strict then, either
accidentally, or because it matched the prior semantics (which is that
there either was _no_ work tree, or you were in it).

> Add a function "require_work_tree_exists" that implements the check
> this function originally intended (this is so that third-party scripts
> that rely on the current behaviour do not have to get broken), and
> update all the in-tree users to use it.

Overall, I think this is a good thing to do. And for the existing
working cases (i.e., when you are in the repo) it should be a no-op.  It
may be worth doing some basic sanity tests to make sure that the scripts
properly work when GIT_DIR and GIT_WORK_TREE point elsewhere from the
current working directory. But I confess I am not excited about doing
the work to write those tests.

-Peff
