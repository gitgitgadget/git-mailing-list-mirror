From: Jeff King <peff@peff.net>
Subject: Re: the pager
Date: Tue, 3 Sep 2013 04:01:19 -0400
Message-ID: <20130903080119.GF3608@sigill.intra.peff.net>
References: <201308261957.r7QJvfjF028935@freeze.ariadne.com>
 <201309030237.r832bjZp014060@freeze.ariadne.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: "Dale R. Worley" <worley@alum.mit.edu>
X-From: git-owner@vger.kernel.org Tue Sep 03 10:01:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VGlYE-000678-9T
	for gcvg-git-2@plane.gmane.org; Tue, 03 Sep 2013 10:01:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752558Ab3ICIBW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Sep 2013 04:01:22 -0400
Received: from cloud.peff.net ([50.56.180.127]:53183 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751941Ab3ICIBV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Sep 2013 04:01:21 -0400
Received: (qmail 22855 invoked by uid 102); 3 Sep 2013 08:01:21 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 03 Sep 2013 03:01:21 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 03 Sep 2013 04:01:19 -0400
Content-Disposition: inline
In-Reply-To: <201309030237.r832bjZp014060@freeze.ariadne.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233706>

On Mon, Sep 02, 2013 at 10:37:45PM -0400, Dale R. Worley wrote:

> > I've noticed that Git by default puts long output through "less" as a
> > pager.  I don't like that, but this is not the time to change
> > established behavior.  But while tracking that down, I noticed that
> > the paging behavior is controlled by at least 5 things:
> > 
> > the -p/--paginate/--no-pager options
> > the GIT_PAGER environment variable
> > the PAGER environment variable
> > the core.pager Git configuration variable
> > the build-in default (which seems to usually be "less")

This list has some orthogonal concepts. The "-p" and "--no-pager"
variables decide _whether_ to run the pager. The GIT_PAGER and PAGER
environment variables, along with core.pager and the compile-time
default, decide _which_ pager to run.

The fact that "cat" or the empty string becomes "no pager" is purely an
optimization (we could fork and run "sh -c ''" or "cat", but it would be
a no-op). So even though you might have instructed git to run the pager,
it may be a noop if your pager is "cat", and we optimize it out.

The confusing one (and missing from your list) is pager.$program, which
originally was a "whether", but later learned to optionally be a
"which". And you also omit the built-in defaults for "whether" on each
command (e.g., "log" runs a pager, "push" does not).

> There is a somewhat independent question of when the pager is
> activated.  What I know so far is that some commands use the pager by
> default and some by default do not.  My expectation is that
> --no-pager can be used to suppress the pager for *any* command.  Is it
> also true that -p can force the pager for *any* command, or are there
> commands which will not page even with -p?

Yes, --no-pager and -p suppress or force, respectively, for any command.
They take precedence over config (pager.$command), which in turn takes
precedence over builtin defaults (per-command defaults, in this case).

Environment variables should generally be less than command-line
options, but greater than config. But there is no "definitely use a
pager" environment variable, so it doesn't apply here.

And I say generally because we should put git-specific environment
variables over git-specific config, but git-specific config over general
environment variables (so similarly we should respect user.email in the
config over $EMAIL in the environment, but under $GIT_COMMITTER_EMAIL).

> I assume that if -p is specified but the "which pager" selection is
> "cat" (or some other specification of no pager), then there is no
> paging operation.

There is a pager in that case, but it doesn't do anything. And then we
optimize it out because it doesn't do anything. :) That is somewhat
tongue-in-cheek, but I hope it shows the mental model that goes into the
decision.

-Peff
