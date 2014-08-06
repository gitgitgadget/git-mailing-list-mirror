From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v1 03/19] rebase -i: reword executes pre-commit hook on
 interim commit
Date: Wed, 6 Aug 2014 17:46:24 -0400
Message-ID: <20140806214624.GA23878@peff.net>
References: <53A258D2.7080806@gmail.com>
 <cover.1406589435.git.bafain@gmail.com>
 <1bb7c0b9aed60f7c65bf812ac42b2f1ad8fd3f82.1406589435.git.bafain@gmail.com>
 <20140801234708.GA20040@peff.net>
 <53DFD63E.8040806@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>,
	Thomas Rast <tr@thomasrast.ch>
To: Fabian Ruch <bafain@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 06 23:46:36 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XF92W-0004gv-2I
	for gcvg-git-2@plane.gmane.org; Wed, 06 Aug 2014 23:46:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753951AbaHFVq2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Aug 2014 17:46:28 -0400
Received: from cloud.peff.net ([50.56.180.127]:47261 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753100AbaHFVq1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Aug 2014 17:46:27 -0400
Received: (qmail 17220 invoked by uid 102); 6 Aug 2014 21:46:27 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 06 Aug 2014 16:46:27 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 06 Aug 2014 17:46:24 -0400
Content-Disposition: inline
In-Reply-To: <53DFD63E.8040806@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254906>

On Mon, Aug 04, 2014 at 08:51:42PM +0200, Fabian Ruch wrote:

> > though I would also not be opposed to some more uniform hook selection
> > mechanism (e.g., "--no-verify=pre-commit" or something).
> 
> While the --no-verify= mechanism doesn't add a new option to the
> git-commit interface but lets one refine the --no-verify option, users
> might find it weird to have an argument to name disabled hooks but then
> not be able to disable all hooks that way.

Right, I think that is only worth doing if we add it uniformly for all
hooks. I wonder if it should be a "git" option, not one to specific
commands. Like:

  git --disable-hook=pre-commit commit ...

and then the run_hook code can just respect the disabled list.

I think a name like "--disable-hook" or your "--bypass-hook" is
better than "--no-verify" here, too. Not all hooks are about verifying
(I also think "disable" is better than "bypass" for that reason, too).

> Since the hook selection wouldn't have to change, the options parsing
> code seems to be simpler (--bypass-hook= would have to support several
> occurrences with different arguments which could be implemented as an
> OPT_CALLBACK?) and git-commit decided to have --no- options for hook
> selection so far, I would lean towards your patch from above.

You'd probably implement --disable-hook with OPT_STRING_LIST (or just do
it by hand if it's the git.c option parser). And then the
--no-post-rewrite arguments remain for historical compatibility, and can
be implemented as synonyms for "--disable-hook=post-rewrite", etc.

I think people have also asked for the ability to override hooks, too,
though I do not remember the exact details.  Instead of --disable-hook,
we could have an option for setting specific hooks (and setting them to
nothing to disable would just be one possibility).

This is getting bigger in scope, though. I was trying not to derail you
too much from your GSoC project, but see if we could just fix this one
hacky corner easily.

> Since all of the hook options are motivated by internal usage from
> git-rebase, perhaps they should be configured as PARSE_OPT_HIDDEN. Any
> thoughts on this?

I could go either way. Just because they are motivated by git-rebase
does not mean other callers might not find them useful (after all, git
commands are often meant to be scripted). As long as we promise to
support them in future versions as we do with normal options, I do not
think there is any problem in advertising them.

That being said, "git commit -h" is already getting pretty long. It
might be worth cutting some seldom-used options from that list just to
make it more palatable to normal users.

-Peff
