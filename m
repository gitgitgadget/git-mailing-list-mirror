From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/1] tests: fix gzip with exported GZIP variable in
 environment
Date: Tue, 3 Dec 2013 08:18:12 -0500
Message-ID: <20131203131812.GC26667@sigill.intra.peff.net>
References: <1386061054-30796-1-git-send-email-mail@eworm.de>
 <CAPig+cQqKQdVEojYF+-+ZE2hQjxsH4WrgPymj8g7P6pSQzfVpw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Christian Hesse <mail@eworm.de>, Git List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Tue Dec 03 14:18:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vnprm-00019X-Sk
	for gcvg-git-2@plane.gmane.org; Tue, 03 Dec 2013 14:18:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753328Ab3LCNSP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Dec 2013 08:18:15 -0500
Received: from cloud.peff.net ([50.56.180.127]:49635 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752485Ab3LCNSO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Dec 2013 08:18:14 -0500
Received: (qmail 24957 invoked by uid 102); 3 Dec 2013 13:18:13 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 03 Dec 2013 07:18:13 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 03 Dec 2013 08:18:12 -0500
Content-Disposition: inline
In-Reply-To: <CAPig+cQqKQdVEojYF+-+ZE2hQjxsH4WrgPymj8g7P6pSQzfVpw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238690>

On Tue, Dec 03, 2013 at 04:49:06AM -0500, Eric Sunshine wrote:

> > -if $GZIP --version >/dev/null 2>&1; then
> > -       test_set_prereq GZIP
> > +if $GZIPCMD --version >/dev/null 2>&1; then
> > +       test_set_prereq GZIPCMD
> 
> test_set_prereq is not actually operating on an environment variable.
> Its argument is just a generic tag, which is uppercase by convention,
> but not otherwise related to a variable which may share the same name,
> and which does not pollute the environment. Consequently, it should
> not be necessary to rename the argument to test_set_prereq, thus all
> changes following this one become superfluous (since they are checking
> for presence of tag GZIP, not referencing environment variable GZIP or
> GZIPCMD). Thus, the patch becomes much smaller.

Right. We can get away with just changing the environment variable, and
leaving the prereq.

By the way, we had the exact same problem with $UNZIP, fixed in ac00128
(t0024, t5000: clear variable UNZIP, use GIT_UNZIP instead, 2013-01-06).
I'd probably call the new variable GIT_GZIP for consistency, but...

> In fact, the GZIP command does not appear to be used at all by the
> tests, so a simpler solution might be to remove the variable
> altogether, and perhaps the prerequisite. Peff?

Yes, though it's a bit more subtle than that. The gzip tests are relying
on git's internally-configured "tar.tgz.command" filter, which is
hard-coded to "gzip -cn". So we do depend on having a working gzip, but
we do _not_ depend on the one found in the $GZIP variable. It must be
called "gzip".

There are a few options I see:

  1. Drop $GZIP variable, and hard-code the prerequisite check to
     "gzip", which is what is being tested.

  2. Keep $GZIP (but rename it to $GIT_GZIP), and explicitly set up
     tar.tgz.command as "$GIT_GZIP -cn".

  3. Teach the Makefile a knob to set the value for "gzip" at compile
     time, and use that for the baked-in config (and propagate it to the
     test to check the prerequisite).

I think I'd be in favor of (1). It's the simplest, and we have not seen
any reports of people who do not actually have gzip called "gzip". Users
can still override it via config if they really want to.

-Peff
