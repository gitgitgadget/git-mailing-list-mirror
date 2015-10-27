From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/6] Facilitate debugging Git executables in tests with
 gdb
Date: Tue, 27 Oct 2015 19:58:24 -0400
Message-ID: <20151027235823.GD4172@sigill.intra.peff.net>
References: <cover.1445865176.git.johannes.schindelin@gmx.de>
 <082d6474a31c405b16087f76de7bc5d01faba529.1445865176.git.johannes.schindelin@gmx.de>
 <20151026191724.GE7881@google.com>
 <alpine.DEB.1.00.1510271036100.31610@s15462909.onlinehome-server.info>
 <xmqqr3kge0d3.fsf@gitster.mtv.corp.google.com>
 <20151027232848.GA4172@sigill.intra.peff.net>
 <CAGZ79karRbOTSEfFHRU6MG21T1L5GyuZW2ATqfdP4NE7wHMmHQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jonathan Nieder <jrnieder@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Wed Oct 28 00:58:33 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZrE8N-0002y4-Jl
	for gcvg-git-2@plane.gmane.org; Wed, 28 Oct 2015 00:58:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754805AbbJ0X61 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Oct 2015 19:58:27 -0400
Received: from cloud.peff.net ([50.56.180.127]:48904 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753510AbbJ0X60 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Oct 2015 19:58:26 -0400
Received: (qmail 10552 invoked by uid 102); 27 Oct 2015 23:58:26 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 27 Oct 2015 18:58:26 -0500
Received: (qmail 30238 invoked by uid 107); 27 Oct 2015 23:58:50 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 27 Oct 2015 19:58:50 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 27 Oct 2015 19:58:24 -0400
Content-Disposition: inline
In-Reply-To: <CAGZ79karRbOTSEfFHRU6MG21T1L5GyuZW2ATqfdP4NE7wHMmHQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280321>

On Tue, Oct 27, 2015 at 04:39:37PM -0700, Stefan Beller wrote:

> On Tue, Oct 27, 2015 at 4:28 PM, Jeff King <peff@peff.net> wrote:
> > I agree doing so would be crazy. But would:
> >
> >   ./t1234-frotz.sh --gdb=17
> >
> > be sane to run gdb only inside test 17?
> 
> OT:
> We have two ways of addressing tests, by number and by name.

Yeah. The numbers are not stable if the script gets new test, but they
are usually fine for within a debugging session. Names are annoying to
type (and also not guaranteed unique).

> Usually when a test fails ("Foo gobbles the bar correctly" failed),
> I want to run tests 1,17 (1 is the correct setup and 17 is the failing test)
> But coming up with that tuple is hard.
>   * How do I know we need to run 1 as the setup ? (usually we do,
>     sometimes we don't and other times we also need 2,3 to completely
> setup the tests)

I think trying to deduce that tuple is a fool's errand. It takes a lot
of manual work, and even if you _think_ you have it, sometimes state
left from earlier tests is accidentally important. But it's usually not
that expensive to run earlier tests at all; it's just expensive to run
them with extra debugging. That's why we have options like
"--valgrind-only=17". We still _run_ tests 1..16, but we do it quickly,
and then execute the expensive and slow valgrind git only on the
suspicious one.

And I'd propose --gdb to work the same way (run all the other tests, but
only kick in gdb for the suspicious one).

If you had multiple "git" invocations inside test 17, you could even do
something like "--gdb=17:4" to kick in only for the 4th git invocation
or something. But counting up git invocations is probably too irritating
to be worth doing manually.

>   * How do I know it's test 17 which is failing? My workflow up to now
>     I just searched the test title in the file, such that I'd be there anyway
>     to inspect it further. But still I found it inconvenient to
> mentally map between
>     17 and the test title.

I usually just run the test script and look at the output. Here's a
failure (which I obviously induced with an extra line):

  $ ./t4103-apply-binary.sh -v -i
  [...]
  ok 5 - check binary diff -- should fail.
  
  expecting success: 
          git checkout master &&
          echo whoops, we fail here && false &&
          test_must_fail git apply --check C.diff
  
  Already on 'master'
  whoops, we fail here
  not ok 6 - check binary diff (copy) -- should fail.
  #
  #               git checkout master &&
  #               echo whoops, we fail here && false &&
  #               test_must_fail git apply --check C.diff
  #

I'd pull the test number from the "not ok" above (it's actually even
easier to see if you drop the "-v", but I usually start my debugging
with "-v" anyway, since error messages often make the problem obvious).

-Peff
