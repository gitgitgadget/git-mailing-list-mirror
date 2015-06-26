From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 3/3] connect: improve check for plink to reduce false
 positives
Date: Fri, 26 Jun 2015 12:27:01 -0400
Message-ID: <20150626162701.GA32123@peff.net>
References: <1429914505-325708-1-git-send-email-sandals@crustytoothpaste.net>
 <1430080212-396370-1-git-send-email-sandals@crustytoothpaste.net>
 <1430080212-396370-4-git-send-email-sandals@crustytoothpaste.net>
 <20150626131524.GA2626@peff.net>
 <xmqq381ewiln.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,
	git@vger.kernel.org,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 26 18:27:15 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z8WT7-0000cQ-PX
	for gcvg-git-2@plane.gmane.org; Fri, 26 Jun 2015 18:27:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752090AbbFZQ1G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Jun 2015 12:27:06 -0400
Received: from cloud.peff.net ([50.56.180.127]:52322 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751969AbbFZQ1E (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Jun 2015 12:27:04 -0400
Received: (qmail 14039 invoked by uid 102); 26 Jun 2015 16:27:04 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 26 Jun 2015 11:27:04 -0500
Received: (qmail 18438 invoked by uid 107); 26 Jun 2015 16:27:06 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 26 Jun 2015 12:27:06 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 26 Jun 2015 12:27:01 -0400
Content-Disposition: inline
In-Reply-To: <xmqq381ewiln.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272787>

On Fri, Jun 26, 2015 at 09:16:20AM -0700, Junio C Hamano wrote:

> > FYI, this ended up biting me today. We have some integration tests that
> > make sure we can clone over putty, and we wrap plink in a
> > "plink-wrapper.sh" script that tweaks a few extra options. That used to
> > match under the old scheme, but not the new. It would also match if we
> > looked for "plink" anywhere in the basename (but not in leading
> > directories).
> 
> So this was a minor regression? ;-)

Yes. :)

> > I was able to work around it pretty easily by changing our test setup,
> > but I thought I would include it here as a data point. It's probably not
> > that representative of real-world users.
> 
> I'd imagine that "/usr/local/github/wrapped/bin/plink" may be a more
> appropriate name to install that wrapper as than "plink-wrapper.sh",
> but then people would need to think how to help that wrapper find
> the real plink, so...

It's the test suite for the server side of our git infrastructure, so
nothing gets installed. It's more like:

  export GIT_SSH=$PROJECT_ROOT/test/plink-wrapper.sh
  export REAL_PLINK=$PROJECT_ROOT/vendor/putty/plink
  git clone localhost:foo.git

and the wrapper knows to chain to $REAL_PLINK. So it was actually pretty
easy to swap, without any hacks to avoid recursing to ourselves in the
$PATH.

I doubt it is a problem for most people, because I don't imagine they
are writing test suites for git-related software.

-Peff
