From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/1] tests: fix gzip with exported GZIP variable in
 environment
Date: Wed, 4 Dec 2013 14:32:32 -0500
Message-ID: <20131204193232.GB11024@sigill.intra.peff.net>
References: <1386061054-30796-1-git-send-email-mail@eworm.de>
 <CAPig+cQqKQdVEojYF+-+ZE2hQjxsH4WrgPymj8g7P6pSQzfVpw@mail.gmail.com>
 <20131203131812.GC26667@sigill.intra.peff.net>
 <xmqqy541okwg.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Christian Hesse <mail@eworm.de>, Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 04 20:32:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VoIBb-0002al-9W
	for gcvg-git-2@plane.gmane.org; Wed, 04 Dec 2013 20:32:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933128Ab3LDTcf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Dec 2013 14:32:35 -0500
Received: from cloud.peff.net ([50.56.180.127]:50430 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S933112Ab3LDTce (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Dec 2013 14:32:34 -0500
Received: (qmail 22809 invoked by uid 102); 4 Dec 2013 19:32:34 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 04 Dec 2013 13:32:34 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 04 Dec 2013 14:32:32 -0500
Content-Disposition: inline
In-Reply-To: <xmqqy541okwg.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238804>

On Tue, Dec 03, 2013 at 10:21:35AM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > There are a few options I see:
> >
> >   1. Drop $GZIP variable, and hard-code the prerequisite check to
> >      "gzip", which is what is being tested.
> >
> >   2. Keep $GZIP (but rename it to $GIT_GZIP), and explicitly set up
> >      tar.tgz.command as "$GIT_GZIP -cn".
> >
> >   3. Teach the Makefile a knob to set the value for "gzip" at compile
> >      time, and use that for the baked-in config (and propagate it to the
> >      test to check the prerequisite).
> >
> > I think I'd be in favor of (1). It's the simplest, and we have not seen
> > any reports of people who do not actually have gzip called "gzip". Users
> > can still override it via config if they really want to.
> 
> I am OK with (1).
> 
> A related tangent is that we may have to worry about is how/if a
> random setting coming from GZIP in the environment (e.g. "GZIP=-1v")
> would interfere with the test.  It may be the simplest to unset
> $GZIP at the beginning of these tests, regardless of which of the
> above three is taken.

I don't think we should worry about it.

There are two levels to consider here. One, people may put junk in their
GZIP variable, which will impact normal running of git itself (e.g.,
when you run "git archive"). And two, they may put options in which
affect the test output (e.g., "-v").

In the former case, I do not think it is worth worrying about. If you
put something in your GZIP variable that causes "gzip -cn" to stop
working (like GZIP=-d), then it is your fault for breaking gzip (and it
is not just broken for git, but everywhere). If you put in tame things
like "--rsyncable" or "-9", I think it is a _good_ thing that git's
invocation of gzip is respecting your choice.  "Fixing" that would
involve git-archive clearing the GZIP variable, but I do not think it is
a good idea.

For tests, we could potentially clear GZIP to give us a more consistent
state for running the tests. But I do not think there is anything you
would put in GZIP that should negatively affect the tests. Obvious just
like "-d" is in the same boat as above; if you break gzip completely,
you deserve it. If you use "-v" or "-q" to change stderr, we handle that
just fine.

That leaves options which change the compressed output, like "-9". I'm
inclined to say that letting them affect the tests is a good thing. It
is true that we do not have a consistent state, but that also means we
are testing the real world a little bit better. Part of the point of
git's test suite is to make sure that from commit to commit, we do not
break things. But it is also to show that for a given commit, from
machine to machine we do not break things. Though we try to give a
consistent baseline, we must tolerate some amount of variance, and that
uncovers portability bugs (e.g., tests reveal that the shell on platform
X does not like our script).

If somebody shows up complaining that a test fails when they have GZIP
set, then that may be catching a bug, or it may be catching a fragility
in the test. But since we do not have a real-world complaint yet, I'd
rather leave it and judge when we have an actual case.

-Peff
