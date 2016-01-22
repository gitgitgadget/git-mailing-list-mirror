From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] travis-ci: run previously failed tests first, then
 slowest to fastest
Date: Fri, 22 Jan 2016 00:52:55 -0500
Message-ID: <20160122055255.GA14657@sigill.intra.peff.net>
References: <1453195469-51696-1-git-send-email-larsxschneider@gmail.com>
 <20160119191234.GA17562@sigill.intra.peff.net>
 <xmqqegdd8997.fsf@gitster.mtv.corp.google.com>
 <20160120002606.GA9359@glandium.org>
 <xmqqfuxt6n00.fsf@gitster.mtv.corp.google.com>
 <DBA834D2-BFC9-4A2F-94D9-A1D0D60377BD@gmail.com>
 <20160122023359.GA686558@vauxhall.crustytoothpaste.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Lars Schneider <larsxschneider@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Mike Hommey <mh@glandium.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 22 06:53:39 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aMUfC-0005uP-Sj
	for gcvg-git-2@plane.gmane.org; Fri, 22 Jan 2016 06:53:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751064AbcAVFw7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Jan 2016 00:52:59 -0500
Received: from cloud.peff.net ([50.56.180.127]:58412 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750889AbcAVFw5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Jan 2016 00:52:57 -0500
Received: (qmail 6002 invoked by uid 102); 22 Jan 2016 05:52:58 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 22 Jan 2016 00:52:57 -0500
Received: (qmail 29430 invoked by uid 107); 22 Jan 2016 05:53:19 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 22 Jan 2016 00:53:19 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 22 Jan 2016 00:52:55 -0500
Content-Disposition: inline
In-Reply-To: <20160122023359.GA686558@vauxhall.crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284547>

On Fri, Jan 22, 2016 at 02:33:59AM +0000, brian m. carlson wrote:

> > Especially t0025-crlf-auto.sh failed multiple times ([2], [3]) on the OS X builds
> > when I increase the parallelism:
> > 
> > not ok 4 - text=true causes a CRLF file to be normalized
> > not ok 9 - text=auto, autocrlf=true _does_ normalize CRLF files
> > 
> > Anyone an idea why that might be the case?
> 
> I've seen this on my personal box too[0] when running make -j4 all test.
> I wasn't able to pin down why it was occurring, but if we're going to
> run the tests in parallel, it's probably worth spending some time
> figuring it out.

Interesting.  I run the test suite in parallel probably a dozen times
per day, and I've never seen this. However, I was able to trigger it
eventually with:

  for i in 1 2 3 4 5 6 7 8
  do
    (while ./t0025-crlf-auto.sh --root=/var/ram/git-tests/foo-$i -v -i >/tmp/foo-$i 2>&1
    do
      : nothing
    done
    echo FAILED $i
    ) &
  done

I get a few of the threads failing (in test 4) after 2-3 minutes. The
"-v" output is pretty unenlightening, though. I don't see anything
racy-looking in the test unless it is something with "read-tree" and
stat mtimes.

-Peff
