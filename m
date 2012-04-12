From: Jeff King <peff@peff.net>
Subject: Re: 'git log' numbering commits?
Date: Thu, 12 Apr 2012 04:41:23 -0400
Message-ID: <20120412084122.GG31122@sigill.intra.peff.net>
References: <4F868A24.9090004@monom.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Daniel Wagner <wagi@monom.org>
X-From: git-owner@vger.kernel.org Thu Apr 12 10:41:49 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SIFb8-0003V2-Ee
	for gcvg-git-2@plane.gmane.org; Thu, 12 Apr 2012 10:41:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762178Ab2DLIlj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Apr 2012 04:41:39 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:58450
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753849Ab2DLIlf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Apr 2012 04:41:35 -0400
Received: (qmail 24709 invoked by uid 107); 12 Apr 2012 08:41:39 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 12 Apr 2012 04:41:38 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 12 Apr 2012 04:41:23 -0400
Content-Disposition: inline
In-Reply-To: <4F868A24.9090004@monom.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195315>

On Thu, Apr 12, 2012 at 09:54:12AM +0200, Daniel Wagner wrote:

> My workflow involves a lot of "git rebase -i". For figuring out which
> commit id to use I do first a 'git log --oneline'. Then I do copy past
> the id to the 'git rebase -i'. The reason why I don't use relative
> id such as HEAD~4, because I keep miscounting the commits.
> 
> So my question is there a magic option to have git log to enumerate the
> commits, e.g.
> 
> 1: 2fcd2b3 network: Remove unused function
> 2: b376b2a session: Fix introspection for Change()
> 3: 15c9cd0 wifi: Refactor desctruction of network object
> 4: a9c699f network: Remove device pointer in network_remove()

No, there is no such feature. You can do this:

  git log --oneline | nl "-s: "

but that will just give you the count of commits shown. If the history
is not a single line of development, then those numbers will become
meaningless quickly. Also note that there is an off-by-one in this
scheme; HEAD~2 will be numbered as "3".

If you wanted to simply decorate each commit with a more readable name,
you could do this:

  git log --format='%H: %s' |
  git name-rev --stdin --name-only

though for simplicity, you may find that you prefer to name only based on
the current tip. You can do that like this:

  git log --format='%H: %s' |
  git name-rev --stdin --name-only \
    --refs `git symbolic-ref HEAD`

which yields output like:

  your-topic: network: Remove unused function
  your-topic~1: session: Fix introspection for Change()
  your-topic~2: wifi: Refactor desctruction of network object
  your-topic~3: network: Remove device pointer in network_remove()

However, if you really just want this to make "rebase -i" easier, have
you considered setting the upstream branch config for your branches?
When I create a topic branch, I do:

  git checkout -b topic origin/master

And then "git rebase -i @{upstream}" rebases everything up to my
upstream branch (origin/master). That may be slightly more than I want,
but it lets me see the whole series in the "rebase -i" sequencer. Recent
versions of git even default to "@{upstream}", so you can just say "git rebase
-i".

How do you usually create your branches? What version of git are you
using (the "@{upstream}" default is in v1.7.6 and later)?

-Peff
