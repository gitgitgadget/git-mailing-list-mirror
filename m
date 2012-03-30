From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/4] git-cherry-pick: add keep-empty option
Date: Fri, 30 Mar 2012 17:15:13 -0400
Message-ID: <20120330211513.GB20734@sigill.intra.peff.net>
References: <1333136922-12872-1-git-send-email-nhorman@tuxdriver.com>
 <1333136922-12872-2-git-send-email-nhorman@tuxdriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Phil Hord <phil.hord@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Neil Horman <nhorman@tuxdriver.com>
X-From: git-owner@vger.kernel.org Sat Mar 31 00:10:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SDk1j-0006Td-KC
	for gcvg-git-2@plane.gmane.org; Sat, 31 Mar 2012 00:10:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935910Ab2C3WK2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Mar 2012 18:10:28 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:41416
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965290Ab2C3VPS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Mar 2012 17:15:18 -0400
Received: (qmail 20574 invoked by uid 107); 30 Mar 2012 21:15:15 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 30 Mar 2012 17:15:15 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 30 Mar 2012 17:15:13 -0400
Content-Disposition: inline
In-Reply-To: <1333136922-12872-2-git-send-email-nhorman@tuxdriver.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194415>

On Fri, Mar 30, 2012 at 03:48:39PM -0400, Neil Horman wrote:

> +--keep-empty:
> +	If a commit is not a fast forward, or if fast forwarding is not allowed,
> +	cherry-picking an empty commit will fail, indicating that an explicit
> +	invokation of git commit --allow-empty is required.  This option
> +	overrides that behavior, allowing empty commits to be preserved
> +	automatically in a cherry-pick

This didn't parse very well for me. A commit cannot be "a fast forward"
by itself. Fast-forwarding is an operation that depends on the
relationship between commits.

I think what you are trying to say is that this option is used only if
the "--ff" logic does not kick in. Maybe it would be clearer to get to
the point early, and mention --ff later, like:

  --keep-empty:
          By default, cherry-picking an empty commit will fail,
          indicating that an explicit invocation of `git commit
          --allow-empty` is required. This option overrides that
          behavior, allowing empty commits to be preserved automatically
          in a cherry-pick. Note that when "--ff" is in effect, empty
          commits that meet the "fast-forward" requirement will be kept
          even without this option.

Like Junio, I agree this should simply be called --allow-empty.

> diff --git a/sequencer.c b/sequencer.c
> index a37846a..71929ba 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -260,8 +260,8 @@ static int do_recursive_merge(struct commit *base, struct commit *next,
>   */
>  static int run_git_commit(const char *defmsg, struct replay_opts *opts)
>  {
> -	/* 6 is max possible length of our args array including NULL */
> -	const char *args[6];
> +	/* 7 is max possible length of our args array including NULL */
> +	const char *args[7];
>  	int i = 0;

It might be nice to refactor this to use argv_array, which handles the
allocation automatically.

> +	if (opts->allow_empty)
> +		args[i++] = "--allow-empty";
> +

What happens if I cherry-pick a commit that is not empty, but that
becomes empty because its changes have already been applied?

-Peff
