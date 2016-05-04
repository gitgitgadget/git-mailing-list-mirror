From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] submodule: stop sanitizing config options
Date: Wed, 4 May 2016 15:04:24 -0400
Message-ID: <20160504190423.GB21259@sigill.intra.peff.net>
References: <cover.1461837783.git.johannes.schindelin@gmx.de>
 <cover.1462342213.git.johannes.schindelin@gmx.de>
 <20160504062618.GA9849@sigill.intra.peff.net>
 <20160504074559.GA3077@sigill.intra.peff.net>
 <20160504080047.GA2436@sigill.intra.peff.net>
 <CAGZ79kZUbhhjwV83_FQKfJR45K6QsZUN_-HJVJmefZUbJEDYYQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Jacob Keller <jacob.keller@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Wed May 04 21:04:32 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ay263-0004yw-E7
	for gcvg-git-2@plane.gmane.org; Wed, 04 May 2016 21:04:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752597AbcEDTE2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 May 2016 15:04:28 -0400
Received: from cloud.peff.net ([50.56.180.127]:34104 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750996AbcEDTE1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 May 2016 15:04:27 -0400
Received: (qmail 29522 invoked by uid 102); 4 May 2016 19:04:26 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 04 May 2016 15:04:26 -0400
Received: (qmail 12901 invoked by uid 107); 4 May 2016 19:04:38 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 04 May 2016 15:04:38 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 04 May 2016 15:04:24 -0400
Content-Disposition: inline
In-Reply-To: <CAGZ79kZUbhhjwV83_FQKfJR45K6QsZUN_-HJVJmefZUbJEDYYQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293567>

On Wed, May 04, 2016 at 10:58:26AM -0700, Stefan Beller wrote:

> > So this whitelist is probably not giving us any benefit, and
> > is already creating a hassle as people propose things to put
> > on it. Let's just drop it entirely.
> 
> Just to recap:
> Before jk/submodule-config-sanitize-fix (jk/submodule-c-credential actually)
> we passed nothing down to the commands operating on submodules.
> 
> Then we decided to pass on some of it based on a curated list.
> 
> Curating the list is too hard, so we pass on everything now, because
> it is easy to maintain and easy to explain. And when the user is hurt,
> they're holding it wrong?

Yes, I think that sums it up (the last paragraph is what's under
discussion, so it's up for debate).

> > Note that we still need to keep a special code path for
> > "prepare the submodule environment", because we still have
> > to take care to pass through $GIT_CONFIG_PARAMETERS (and
> > block the rest of the repo-specific environment variables).
> 
> So when running `git -c foo=bar command --recurse-submodules`
> the `-c` parsing calls git_config_push_parameter, which
> exports that string `foo=baz` into the environment variable
> GIT_CONFIG_PARAMETERS.
> 
> When the submodule command is called, sanitize_submodule_env
> just wipes all the Git related configurations except those in
> GIT_CONFIG_PARAMETERS as they are set again after
> clear_local_git_env wiped it.

Right.

> I wonder about the implementation detail, if we rather want to introduce
> a `git rev-parse --repo-only-local-env-vars` which is
> `git rev-parse --local-env-vars` without the GIT_CONFIG_PARAMETERS.
> such that clear_local_git_env does the right thing and we don't
> have to have 2 functions for it (i.e. clear_local_git_env and
> sanitize_submodule_env, which is the newer not as strict version of it)

I don't think that really buys you much. The policy is technically
duplicated in prepare_submodule_repo_env() in submodule.c and
sanitize_submodule_env in submodule.h. But without the whitelist, it's
such a simple policy that I'm not sure it's worth the boilerplate of
having the shell function call into the C code.

If we did want to go that route, the more appropriate interface would
probably be:

  git submodule--helper sanitize-env

or something. That avoids making it a public interface, and makes it
clear that we are invoking the submodule rules.

> Do we want to add documentation for the new behavior though?
>     Before: pass not -c arguments to submodules
>     Now: Pass all the -c arguments to submodules

I don't think there was any documentation for the _old_ behavior, and
certainly jk/submodule-c-credential didn't add any. But it probably is
worth document, maybe as part of "-c"? Care to roll a patch on top?

-Peff
