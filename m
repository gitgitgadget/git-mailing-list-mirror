From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] travis-ci: run previously failed tests first, then
 slowest to fastest
Date: Tue, 19 Jan 2016 18:27:10 -0500
Message-ID: <20160119232710.GA31181@sigill.intra.peff.net>
References: <1453195469-51696-1-git-send-email-larsxschneider@gmail.com>
 <xmqqmvs19w5n.fsf@gitster.mtv.corp.google.com>
 <xmqqio2p89mb.fsf@gitster.mtv.corp.google.com>
 <20160119230633.GA31142@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: larsxschneider@gmail.com, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 20 00:27:32 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aLfgQ-0003VD-Lx
	for gcvg-git-2@plane.gmane.org; Wed, 20 Jan 2016 00:27:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933505AbcASX1W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Jan 2016 18:27:22 -0500
Received: from cloud.peff.net ([50.56.180.127]:56561 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S933504AbcASX1N (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jan 2016 18:27:13 -0500
Received: (qmail 17273 invoked by uid 102); 19 Jan 2016 23:27:13 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 19 Jan 2016 18:27:13 -0500
Received: (qmail 27809 invoked by uid 107); 19 Jan 2016 23:27:33 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 19 Jan 2016 18:27:33 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 19 Jan 2016 18:27:10 -0500
Content-Disposition: inline
In-Reply-To: <20160119230633.GA31142@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284397>

On Tue, Jan 19, 2016 at 06:06:33PM -0500, Jeff King wrote:

> > It seems that exporting something like
> > 
> >     GIT_PROVE_OPTS="--timer --state=slow,save -j8" 
> > 
> > when running "make DEFAULT_TEST_TARGET=prove test" does give me the
> > same benefit by leaving the stats from the previous run in t/.prove
> > when making the test scheduling decisions.
> 
> Yes, I've been using this on my local machine for years (which is why I
> suggested it to Lars for the Travis build). I have also noticed that my
> test runs take about as much time as the longest-running test, and do
> not fully utilize all of my processors. I suspect we could drop the
> run-time of the test suite substantially by splitting a few of the
> longer tests.

Here are the numbers for that:

  $ time make ;# configured to use prove --state=slow,save -j16
  [...]
  real    0m47.035s
  user    1m6.884s
  sys     0m19.892s

  $ grep -v '^\.\.\.' .prove |
    perl -MYAML -e '
      local $/;
      $x = YAML::Load(<>)->{tests};
      print int($x->{$_}->{elapsed}), " $_\n" for keys(%$x)
    ' |
    sort -rn |
    head
  39 t3404-rebase-interactive.sh
  29 t3421-rebase-topology-linear.sh
  27 t9001-send-email.sh
  16 t9500-gitweb-standalone-no-errors.sh
  15 t3425-rebase-topology-merges.sh
  14 t6030-bisect-porcelain.sh
  13 t7610-mergetool.sh
  13 t5572-pull-submodule.sh
  13 t3426-rebase-submodule.sh
  12 t3415-rebase-autosquash.sh

So we're running t3404 for the majority of the time. I guess that
doesn't tell us how full our pipelines are for the rest of the time,
though. It could be worth splitting some of those long tests and seeing
if that improves run-time, though.

-Peff
