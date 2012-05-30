From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 0/3] clone --local fixes
Date: Wed, 30 May 2012 07:03:05 -0400
Message-ID: <20120530110305.GA13445@sigill.intra.peff.net>
References: <20120526034226.GA14287@sigill.intra.peff.net>
 <7vsjemp20j.fsf@alter.siamese.dyndns.org>
 <20120528053602.GA11174@sigill.intra.peff.net>
 <7vhauy6fy3.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Emeric Fermas <emeric.fermas@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 30 13:03:15 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SZggN-0005ne-4g
	for gcvg-git-2@plane.gmane.org; Wed, 30 May 2012 13:03:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752679Ab2E3LDL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 May 2012 07:03:11 -0400
Received: from 99-108-225-23.lightspeed.iplsin.sbcglobal.net ([99.108.225.23]:36232
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752573Ab2E3LDK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 May 2012 07:03:10 -0400
Received: (qmail 3690 invoked by uid 107); 30 May 2012 11:03:10 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 30 May 2012 07:03:10 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 30 May 2012 07:03:05 -0400
Content-Disposition: inline
In-Reply-To: <7vhauy6fy3.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198797>

On Tue, May 29, 2012 at 10:43:32AM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > I think it depends on the definition of "--local". If it means "when we
> > are cloning without a URL, turn on the local optimizations", then yes,
> > "file://" should not work. If it means "turn on local optimizations if
> > this destination supports it", then it should.
> 
> It has meant the former since the day --local was introduced, and
> the semi-deprecation at 3d5c418 (git-clone: aggressively optimize
> local clone behaviour., 2007-08-01) didn't change it, either.

Right, but my argument was that since nobody probably ever cared about
the distinction, it is more important to do the least surprising thing.

> > The current behavior is ambiguous as to whether it is the first case, or
> > whether it is the second, and it was simply buggy. The history you gave
> > argues that the original intent was the former. But to me that is much
> > less important than what is useful and least surprising to users.
> 
> Changing it would make it even more confusing to people who started
> using Git before mid 2007, though.  That is why I am for deprecating
> (and eventually removing) "--local".

Yes, it would technically be a regression. But I highly doubt that
somebody is relying on the fact that "--local" with file:// is a silent
no-op. And other than that, the behavior remains the same (note that my
patch explicitly did not try to turn on --local when it sees file://).

Anyway, I do not really care about this part of the series. It was not
"this is a needed feature" but rather "this is less surprising and easy
to do, so why not?". We can drop it and replace it with a documentation
update.

I would still like to keep the --no-local patch, for two reasons:

  1. The fact that using file:// overrides the local optimizations is
     somewhat non-obvious if you do not already know that it is the
     case.

  2. File URLs require absolute paths[1]. You can't do the equivalent of
     "git clone --no-local foo.git" without resorting to $PWD.

So here's an updated series (I see you took the test cleanups already).

  [1/2]: docs/clone: mention that --local may be ignored
  [2/2]: clone: allow --no-local to turn off local optimizations

I didn't bother with deprecation or erroring out on URLs. So far we have
had exactly one report on this, and I think the improved documentation
would have solved this particular case.

-Peff
