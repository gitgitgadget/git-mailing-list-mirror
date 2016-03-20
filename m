From: Jeff King <peff@peff.net>
Subject: Re: [PATCH/RFC] parse-options.c: make OPTION__COUNTUP consider
 negative values
Date: Sun, 20 Mar 2016 00:10:10 -0400
Message-ID: <20160320041009.GA18312@sigill.intra.peff.net>
References: <0102015381b7c7b5-5b57a780-369b-478b-94d2-7094f0befdad-000000@eu-west-1.amazonses.com>
 <20160317015044.GB12830@sigill.intra.peff.net>
 <CAFZEwPOib-3JJQ+ufAbmNf1HYb5003LJw_paF2s9L8OK59N0PQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git List <git@vger.kernel.org>
To: Pranit Bauva <pranit.bauva@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 20 05:16:11 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ahUmf-0006qb-UJ
	for gcvg-git-2@plane.gmane.org; Sun, 20 Mar 2016 05:16:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750838AbcCTEKP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Mar 2016 00:10:15 -0400
Received: from cloud.peff.net ([50.56.180.127]:34734 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750707AbcCTEKN (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Mar 2016 00:10:13 -0400
Received: (qmail 16952 invoked by uid 102); 20 Mar 2016 04:10:12 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sun, 20 Mar 2016 00:10:12 -0400
Received: (qmail 24255 invoked by uid 107); 20 Mar 2016 04:10:30 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sun, 20 Mar 2016 00:10:30 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 20 Mar 2016 00:10:10 -0400
Content-Disposition: inline
In-Reply-To: <CAFZEwPOib-3JJQ+ufAbmNf1HYb5003LJw_paF2s9L8OK59N0PQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289330>

On Fri, Mar 18, 2016 at 04:53:34PM +0530, Pranit Bauva wrote:

> > And we would need to verify that all of the existing callers are OK with
> > this. Did you check that that (not rhetorical; I suspect they are all
> > OK, but somebody needs to check)?
> 
> I did a grep on parse-options.h and saw that only "verbose", "quiet"
> and "force" use OPT_COUNTUP().
> I then did a git grep for "verbose = -1", "quiet = -1"
> But with "force = -1" showed that "builtin/clean.c" uses it. On a bit
> careful examination, this patch would not make difference to it.

Yeah, I see that it handles the config for force separately, and then
munges the "-1" into 0 before we get to parse_options.

There are uses of COUNTUP in cmd_hash_object() and test-parse-options.c,
but I think they are both fine.

Grepping for "verbose = -1" would miss any cases where we call the
argument something else (e.g., apply_verbosely). So I think it would be
more thorough to grep for OPT__VERBOSE, etc, and then follow-up on
whatever variable they use.

I just did so, and I didn't see any problems.

> > We are also changing semantics without changing the interface, which
> > means any topics in flight (that you _cannot_ review, because you have
> > not seen them yet) may be subtly broken. To me that is not an absolute
> > deal-breaker, but something to weigh against the utility of the change.
> 
> As I am new here, I don't really know how to go about with this. Could
> you describe in a little detail so that I can work on it?

A more canonical example is changing a function return value. Imagine I
have a function which returns "1" for success and "0" for error, and I
want to change it to return "0" for success and "-1" for error. If I do
so and update each caller, then merging with a branch that has a new
caller will not result in any conflicts (there is no textual link
between the callers and the function), but the result will be subtly
broken (the new caller will get the error-check wrong).

So we generally try to find some way that the compiler will notice the
breakage. E.g., if the function changes name when the return value
semantics change, or if it gains a new argument at the same time, then
the compiler will notice and complain. We still have to fix it up during
the merge, of course, but it's easy to spot.

Likewise here. If you change the semantics of OPT_COUNTUP(), then any
branch which introduces a new use of "int foo = -1" and expects the old
semantics will be subtly broken.

The obvious fix would be to switch the name (to OPT_COUNTUP_DEFAULT() or
something). But that's a bit painful, as almost nobody uses COUNTUP
directly, so we'd need OPT__VERBOSE_DEFAULT().

I do think we could also declare that it's sufficiently unlikely for
somebody to have been using the old semantics for OPT_COUNTUP() with
a negative integer (as it does not really do anything useful), and just
accept the risk.

Which in the end is the same as ignoring the problem in the first place,
but there is a big difference between not thinking about the problem,
and thinking about it and deciding it's not a problem. :)

-Peff
