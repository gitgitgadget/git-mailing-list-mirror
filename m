From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 1/2] t0303: immediately bail out w/o
 GIT_TEST_CREDENTIAL_HELPER
Date: Wed, 14 Mar 2012 23:54:05 -0400
Message-ID: <20120315035405.GA4149@sigill.intra.peff.net>
References: <20120314141401.GC28595@in.waw.pl>
 <1331734704-14281-1-git-send-email-zbyszek@in.waw.pl>
 <7v8vj2omiv.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>,
	git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 15 04:54:16 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S81lY-0000q5-9D
	for gcvg-git-2@plane.gmane.org; Thu, 15 Mar 2012 04:54:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755640Ab2CODyJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Mar 2012 23:54:09 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:49575
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754163Ab2CODyI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Mar 2012 23:54:08 -0400
Received: (qmail 16167 invoked by uid 107); 15 Mar 2012 03:54:19 -0000
Received: from c-71-206-173-132.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.206.173.132)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 14 Mar 2012 23:54:19 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 14 Mar 2012 23:54:05 -0400
Content-Disposition: inline
In-Reply-To: <7v8vj2omiv.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193175>

On Wed, Mar 14, 2012 at 03:17:28PM -0700, Junio C Hamano wrote:

> > +$GIT_TEST_CREDENTIAL_HELPER_SETUP
> 
> This used to be 'test -z "$it" || eval "$it"'; doesn't it make a
> difference?
>
> What is the value expected to be in this variable?  Nobody seems to set it
> in our codebase, so I cannot say "with the current code, this rewrite is
> safe" or anything like that.

I think eval is a better route, as it gives the caller more flexibility
about what shell code to run. The only use is here:

  http://article.gmane.org/gmane.comp.version-control.git/186757

which does work either way.

> This is probably not related to your patch, but
> 
> 	GIT_TEST_CREDENTIAL_HELPER=cache sh t0303-*.sh
> 
> passes OK for me while
> 
> 	make GIT_TEST_CREDENTIAL_HELPER=cache T=t0303-*.sh prove
> 
> seems to get stuck forever.

It's because t0303 is the generic "test any helper" script, and does not
know how to clean up the credential-cache daemon. So the daemon sticks
around, holding onto a file descriptor that causes prove to hang.
If you look at t0301 (which runs the same tests on credential-cache), we
kill the resulting daemon explicitly. t0303 could learn hooks to do
this, but I didn't bother, as I didn't need them for testing the
osxkeychain helper (which is the only thing I've used t0303 for, as
t0301 and t0302 cover the in-tree helpers). I figured that somebody
could add the hooks easily if and when they needed.

-Peff
