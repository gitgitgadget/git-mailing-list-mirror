From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] git-web--browser: avoid errors in terminal when running
 Firefox on Windows
Date: Fri, 11 Nov 2011 15:26:36 -0500
Message-ID: <20111111202636.GA20515@sigill.intra.peff.net>
References: <20111003095731.GB16078@sigill.intra.peff.net>
 <1321028283-17307-1-git-send-email-Alex.Crezoff@gmail.com>
 <20111111183555.GC16055@sigill.intra.peff.net>
 <20111111234830.32dccd87@zappedws>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Chris Packham <judge.packham@gmail.com>
To: Alexey Shumkin <alex.crezoff@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 11 21:26:45 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ROxgS-00026f-Kx
	for gcvg-git-2@lo.gmane.org; Fri, 11 Nov 2011 21:26:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754390Ab1KKU0j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Nov 2011 15:26:39 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:39707
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752119Ab1KKU0i (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Nov 2011 15:26:38 -0500
Received: (qmail 5998 invoked by uid 107); 11 Nov 2011 20:26:41 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 11 Nov 2011 15:26:41 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 11 Nov 2011 15:26:36 -0500
Content-Disposition: inline
In-Reply-To: <20111111234830.32dccd87@zappedws>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185281>

On Fri, Nov 11, 2011 at 11:48:30PM +0400, Alexey Shumkin wrote:

> > I'm not sure there's a good way to do it.  You would need either to
> > wait some pre-determined "it could not possibly take it longer than N
> > seconds to run" sleep, or we need some kind of synchronization point.
> > We can't wait call "wait" on the child PID (if we even have it,
> > because it's not our child).
> hmm... we can delete "actual" file and wait its appearance (with
> some timeout), no ? but I didn't see in tests anything like this

Even that's not foolproof, as the open and write are not atomic (so you
could see it's there, but read an empty file). But in this case, we
really just care that the thing ran, not that it writes any specific
output. So you could probably get away with something like:

  cat >fake-browser <<\EOF &&
  #!/bin/sh
  >fake-browser-ran
  EOF
  git web--browse ... &&
  {
    for timeout in 1 2 3 4 5; do
          test -f fake-browser-ran && break
          sleep 1
    done
    test "$timeout" -ne 5
  }

which would note success as soon as possible (to within a one second
margin), but would eventually give up after 5 seconds. So you'd get a
false positive on a _very_ loaded system, but that's kind of unlikely.

I dunno. Maybe this hackery is OK, or maybe it just isn't worth it, and
we should declare this as something that's too hard to test to make it
into our test suite.

-Peff
