From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] tests: turn on network daemon tests by default
Date: Wed, 12 Feb 2014 17:12:58 -0500
Message-ID: <20140212221258.GB6799@sigill.intra.peff.net>
References: <20140210191521.GA3112@sigill.intra.peff.net>
 <20140210212931.GA16154@sigill.intra.peff.net>
 <xmqqa9dxpgw9.fsf@gitster.dls.corp.google.com>
 <20140211200445.GA27946@sigill.intra.peff.net>
 <xmqq61oknoak.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 12 23:13:07 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WDi3F-0008Sb-VY
	for gcvg-git-2@plane.gmane.org; Wed, 12 Feb 2014 23:13:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753919AbaBLWNB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Feb 2014 17:13:01 -0500
Received: from cloud.peff.net ([50.56.180.127]:49435 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753426AbaBLWNA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Feb 2014 17:13:00 -0500
Received: (qmail 8371 invoked by uid 102); 12 Feb 2014 22:13:00 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 12 Feb 2014 16:13:00 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 12 Feb 2014 17:12:58 -0500
Content-Disposition: inline
In-Reply-To: <xmqq61oknoak.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242029>

On Wed, Feb 12, 2014 at 11:06:43AM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > Agreed, but I think the only way to know the size of those fallouts is
> > to try it and see who complains.  I would not normally be so cavalier
> > with git itself, but I think for the test infrastructure, we have a
> > small, tech-savvy audience that can help us iterate on it without too
> > much pain.
> 
> There is another.

I somehow pictured this while reading your email:
http://youtu.be/X4JVcvR7IM0

> $ GIT_TEST_HTTPD=false sh t5537-fetch-shallow.sh 
> ok 1 - setup
> ok 2 - setup shallow clone
> ok 3 - clone from shallow clone
> ok 4 - fetch from shallow clone
> ok 5 - fetch --depth from shallow clone
> ok 6 - fetch --unshallow from shallow clone
> ok 7 - fetch something upstream has but hidden by clients shallow boundaries
> ok 8 - fetch that requires changes in .git/shallow is filtered
> ok 9 - fetch --update-shallow
> error: Can't use skip_all after running some tests

Ah, yeah, I did not notice that t5537 does its own special handling of
GIT_TEST_HTTPD. I think it is wrong to do so, and it is already buggy in
the case that GIT_TEST_HTTPD is set, but apache cannot be started.

E.g., with the current "master":

  $ sudo chmod -x `which apache2`
  $ GIT_TEST_HTTPD=1 ./t5537-fetch-shallow.sh
  ok 1 - setup
  ok 2 - setup shallow clone
  ok 3 - clone from shallow clone
  ok 4 - fetch from shallow clone
  ok 5 - fetch --depth from shallow clone
  ok 6 - fetch --unshallow from shallow clone
  ok 7 - fetch something upstream has but hidden by clients shallow boundaries
  ok 8 - fetch that requires changes in .git/shallow is filtered
  ok 9 - fetch --update-shallow
  error: Can't use skip_all after running some tests

lib-httpd was never designed to be included from anywhere except the
beginning of the file. But that wouldn't be right for t5537, because it
wants to run some of the tests, even if apache setup fails. The right
way to do it is probably to have lib-httpd do all of its work in a lazy
prereq. I don't know how clunky that will end up, though; it might be
simpler to just move the shallow http test into one of the http-fetch
scripts.

-Peff
