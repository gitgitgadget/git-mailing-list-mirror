From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 1/2] t0303: immediately bail out w/o
 GIT_TEST_CREDENTIAL_HELPER
Date: Thu, 15 Mar 2012 09:24:28 -0400
Message-ID: <20120315132428.GB8467@sigill.intra.peff.net>
References: <20120314141401.GC28595@in.waw.pl>
 <1331734704-14281-1-git-send-email-zbyszek@in.waw.pl>
 <7v8vj2omiv.fsf@alter.siamese.dyndns.org>
 <20120315035405.GA4149@sigill.intra.peff.net>
 <7vk42ml5er.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>,
	git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 15 14:24:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S8AfT-0002Xy-Me
	for gcvg-git-2@plane.gmane.org; Thu, 15 Mar 2012 14:24:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756856Ab2CONYb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Mar 2012 09:24:31 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:49864
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752288Ab2CONYa (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Mar 2012 09:24:30 -0400
Received: (qmail 21695 invoked by uid 107); 15 Mar 2012 13:24:42 -0000
Received: from c-71-206-173-132.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.206.173.132)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 15 Mar 2012 09:24:42 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 15 Mar 2012 09:24:28 -0400
Content-Disposition: inline
In-Reply-To: <7vk42ml5er.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193214>

On Wed, Mar 14, 2012 at 11:55:24PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > On Wed, Mar 14, 2012 at 03:17:28PM -0700, Junio C Hamano wrote:
> >> This is probably not related to your patch, but
> >> 
> >> 	GIT_TEST_CREDENTIAL_HELPER=cache sh t0303-*.sh
> >> 
> >> passes OK for me while
> >> 
> >> 	make GIT_TEST_CREDENTIAL_HELPER=cache T=t0303-*.sh prove
> >> 
> >> seems to get stuck forever.
> >
> > It's because t0303 is the generic "test any helper" script, and does not
> > know how to clean up the credential-cache daemon. So the daemon sticks
> > around, holding onto a file descriptor that causes prove to hang.
> 
> And the reason why "sh t0303-*.sh" version does not have this problem is...?

Most helpers don't spawn a daemon that hangs around (and if they do, the
instructions for killing said daemon are outside the scope of the helper
protocol -- though I would recommend having an "exit" command, as
credential-cache has). You could add something like:

  GIT_TEST_CREDENTIAL_HELPER='cache' \
  GIT_TEST_CREDENTIAL_HELPER_EXIT='git credential-cache exit' \
  ./t0303-*

But like I said, I didn't bother. If you are testing credential-cache,
then use t0301, which handles this. If you are testing something
external, use t0303. My external testing didn't require such an exit
hook, so I didn't bother with it. If somebody writes a helper that
requires such a hook, they can add it then. I didn't want to get into
the business of guessing which hooks people might need (and it is not as
if these tests are an end-user visible piece of code; they are purely a
convenience for developers to test their implementations against the
same battery of tests that credential-cache and credential-store use).

-Peff
