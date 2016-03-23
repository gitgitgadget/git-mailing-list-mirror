From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] git-send-pack: Fix --all option when used with directory
Date: Wed, 23 Mar 2016 17:22:13 -0400
Message-ID: <20160323212213.GA19920@sigill.intra.peff.net>
References: <1458750262-25765-1-git-send-email-stanislav@assembla.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Dave Borowitz <dborowitz@google.com>, git@vger.kernel.org
To: Stanislav Kolotinskiy <stanislav@assembla.com>
X-From: git-owner@vger.kernel.org Wed Mar 23 22:22:35 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aiqEd-0008Nc-5F
	for gcvg-git-2@plane.gmane.org; Wed, 23 Mar 2016 22:22:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756943AbcCWVWT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Mar 2016 17:22:19 -0400
Received: from cloud.peff.net ([50.56.180.127]:36989 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755658AbcCWVWR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Mar 2016 17:22:17 -0400
Received: (qmail 2182 invoked by uid 102); 23 Mar 2016 21:22:16 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 23 Mar 2016 17:22:16 -0400
Received: (qmail 3504 invoked by uid 107); 23 Mar 2016 21:22:35 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 23 Mar 2016 17:22:35 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 23 Mar 2016 17:22:13 -0400
Content-Disposition: inline
In-Reply-To: <1458750262-25765-1-git-send-email-stanislav@assembla.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289684>

On Wed, Mar 23, 2016 at 06:24:22PM +0200, Stanislav Kolotinskiy wrote:

> When using git send-pack with --all option
> and a target directory, usage message is being
> displayed instead of performing the actual transmission.

Yeah, that seems very wrong.

Not that it matters for this bug, but for my own curiosity, what do you
use "send-pack --all" for? I've generally assumed that nobody directly
calls send-pack themselves these days, but of course we have no data to
support that either way. So I am always interested to hear about unusual
use cases.

> The reason for this issue is that refspecs variable is being
> calculated in a different way comparing to previous versions,
> and even though the number of refspecs (nr_refspecs) is 0,
> refspecs contain all the arguments and switches passed to send-pack.

Looks like this bisects to 068c77a (builtin/send-pack.c: use
parse_options API, 2015-08-19). Thanks for including a test, which made
the bisection easy.

I wondered how the original ever worked, since it also points to argv
with the "refspecs" variable. But we only do so when we see an actual
refspec argument, and otherwise leave it as NULL. Whereas the new code
lumps the destination and the refspecs into the same conditional.

That made me wonder if any other code cared about refspecs being NULL. I
don't think so, though. The other spots I looked at seem to use
nr_refspec, which is good. There is one interesting interaction with
--stdin, which _does_ always set refspecs to a non-NULL value.

In the original code (prior to 068c77a), doing this:

  git send-pack --stdin --all </dev/null

complained. If though we did not specify any refspecs, it saw that
"refspecs" was non-NULL.

With your patch, that works (since nr_refspecs ends up as 0, it is OK
with --all). I think that is probably OK, though of course it is a
somewhat nonsensical request.

Arguably the "if (stdin)" conditional should also check for --all or
--mirror and complain, but I doubt it really matters in practice.

> diff --git a/t/t9904-send-pack-all.sh b/t/t9904-send-pack-all.sh

The tests are roughly grouped by functionality. send-pack tests are in
the t540x range, and this should probably go there. Though I also
suspect it could easily be added to the end of an existing test script,
which is preferable.

> +test_expect_success setup '

This setup seems a bit more complicated than it needs to be. It's nice
to keep tests as simple as possible, so a reader can understand exactly
what is being tested.

Here are a few things I think we can simplify:

> +	git init --bare bare_repo && git init repo && (
> +		cd repo &&

We're in a repository already, so we should just be able to push
directly out of the "main" test repository.

> +		git remote add origin ../bare_repo &&

We don't need to define remotes; we can just push directly to paths.

> +		date >file1 && git add file1 && test_tick &&
> +		git commit -m Initial &&

You can use "test_commit" to make this simpler.

> +		git push origin master &&
> +
> +		git checkout -b other && date >file2 &&
> +		git add file2 && test_tick &&
> +		git commit -m Other &&
> +		git push origin other

I guess you have multiple branches here so that we can be sure that
"--all" is pushing all of them. But your later test doesn't actually
check that.

> +	) && git init another && (
> +		cd another &&
> +
> +		git config receive.denyCurrentBranch ignore
> +	)
> +'

If you make the destination repository bare, then you do not have to
worry about denyCurrentBranch.

> +test_expect_success 'send-pack --all should copy all refs' '
> +	cd bare_repo && git send-pack --all ../another
> +'

We try to keep mutations of the test script state (like "cd") inside a
subshell, so they don't influence later tests. There aren't any later
tests now, of course, but it's one less thing for somebody coming along
later to have to worry about.

-Peff
