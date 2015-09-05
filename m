From: Jeff King <peff@peff.net>
Subject: Re: [RFC] test_when_finished in subshells
Date: Sat, 5 Sep 2015 04:54:30 -0400
Message-ID: <20150905085429.GB25039@sigill.intra.peff.net>
References: <54923cf9cc5a66bf9034051b3c2f930fa7ef88a4.1441388803.git.john@keeping.me.uk>
 <xmqqfv2uf2kc.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: John Keeping <john@keeping.me.uk>, git@vger.kernel.org,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Sep 05 10:54:58 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZY9FQ-0005Oc-Tv
	for gcvg-git-2@plane.gmane.org; Sat, 05 Sep 2015 10:54:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750936AbbIEIyi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Sep 2015 04:54:38 -0400
Received: from cloud.peff.net ([50.56.180.127]:55369 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750838AbbIEIyd (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Sep 2015 04:54:33 -0400
Received: (qmail 16398 invoked by uid 102); 5 Sep 2015 08:54:33 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sat, 05 Sep 2015 03:54:33 -0500
Received: (qmail 1182 invoked by uid 107); 5 Sep 2015 08:54:38 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sat, 05 Sep 2015 04:54:38 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 05 Sep 2015 04:54:30 -0400
Content-Disposition: inline
In-Reply-To: <xmqqfv2uf2kc.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277364>

On Fri, Sep 04, 2015 at 11:43:15AM -0700, Junio C Hamano wrote:

> > t7800 (in its final test) calls test_config in a subshell which has cd'd
> > into a submodule.
> >
> > Is this something worth worrying about, or is it sufficiently rare that
> > we can live with the current behaviour?
> 
> Fixing the instances you found is good, obviously ;-).  Thanks for
> working on this.
> 
> Even though the proposed detection is BASH-ism, I think it would not
> hurt other shells (they obviously do not help you catch bugs, but
> they would not misbehave as long as you make sure BASH_SUBSHELL is
> either unset or set to 0 at the beginning of the test), and the only
> impact to them would be a invocation of (often built-in) 'test'
> utility, whose performance impact should be miniscule.
> 
> I'll wait for opinion from others, of course.

I like it. In general I'm in favor of any lint-like fixes (whether for
the tests or the C code itself) as long as:

  1. they don't create false positive noise

  2. they don't require extra effort at each call-site

  3. they don't have a performance impact

And I think this passes all three. Of course it would be nice if the new
check ran on all shells, but even this seems like a strict improvement.

And I couldn't come up with anything better. I thought we might be able
to use a canary trap, like this:

  trap canary QUIT
  echo outside
  trap
  echo inside
  (trap)

Because traps are reset inside a subshell, the first "trap" without
arguments should print a string with "canary" in it, and the second
should print nothing.

Except that it isn't remotely how it works in practice. :) Bash leaves
the trap in place inside the subshell. And while dash does the right
thing, any attempt to actually _look_ at the output will put us in a
subshell. So:

  case "$(trap)" in
  *canary*) ... not in a subshell ...
  *) ... in a subshell ...
  esac

doesn't work; the trap report inside backticks is always empty (despite
there being an explicit example in the POSIX manpage for trap of using
$(trap) to get the value for a later eval).

It looks like if we use the EXIT trap rather than a signal, bash _does_
do the right thing (which kind of makes sense, I guess). So rather than
a custom canary, we could use our regular EXIT handler as the canary.
But I couldn't find a way to work around dash's issue.

Looks like there was even some discussion in 2010:

  http://www.spinics.net/lists/dash/msg00331.html

but my dash 0.5.7 remains broken. Oh, well.

-Peff
