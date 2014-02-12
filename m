From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] tests: turn on network daemon tests by default
Date: Wed, 12 Feb 2014 16:47:53 -0500
Message-ID: <20140212214753.GA6799@sigill.intra.peff.net>
References: <20140210191521.GA3112@sigill.intra.peff.net>
 <20140210212931.GA16154@sigill.intra.peff.net>
 <xmqqa9dxpgw9.fsf@gitster.dls.corp.google.com>
 <20140211200445.GA27946@sigill.intra.peff.net>
 <xmqqzjlxnqvw.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 12 22:48:01 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WDhey-0005N2-E3
	for gcvg-git-2@plane.gmane.org; Wed, 12 Feb 2014 22:48:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751933AbaBLVr4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Feb 2014 16:47:56 -0500
Received: from cloud.peff.net ([50.56.180.127]:49414 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751218AbaBLVrz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Feb 2014 16:47:55 -0500
Received: (qmail 6858 invoked by uid 102); 12 Feb 2014 21:47:55 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 12 Feb 2014 15:47:55 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 12 Feb 2014 16:47:53 -0500
Content-Disposition: inline
In-Reply-To: <xmqqzjlxnqvw.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242026>

On Tue, Feb 11, 2014 at 03:58:27PM -0800, Junio C Hamano wrote:

> Sure. One immediate complaint is that I would probably need to do
> something like this in the build automation:
> 
> 	if testing a branch without this patch
>         then
> 		: do nothing
> 	else
> 		GIT_TEST_GIT_DAEMON=false
> 	fi
> 
> Arguably, it is the fault of the current/original code that treated
> *any* non-empty value that is set in the environment variable as
> "true"---if it paid attention to GIT_TEST_GIT_DAEMON=NoThanks, we
> wouldn't have to have a workaround like this.

Yes, I didn't really think about build config that works reliably
between both versions (though personally, I think you should be building
with GIT_TEST_GIT_DAEMON=true :) ).

> I wonder if GIT_TEST_X=$(test_tristate "$GIT_TEST_X") pattern can be
> made a bit more friendly, though.  For example, can we behave
> differently depending on the reason why $GIT_TEST_X is empty?
> 
>  - People who have *not* been opting in to the expensive tests have
>    not done anything special; GIT_TEST_X environment variable did
>    not exist for them (i.e. unset), and we used to skip when
>    "$GIT_TEST_X" is an empty string.
> 
>  - We want to encourage people who do not care to run these tests.
>    If people do not do anything, their $GIT_TEST_X will continue to
>    be an empty string without GIT_TEST_X variable in the
>    environment.
> 
> If we let people who *do* want to opt out of the expensive tests by
> explicitly setting $GIT_TEST_X to an empty string in the new scheme,
> wouldn't the transition go a lot smoother?

Hmm. So you are suggesting that the old code treated "undefined" and
"empty" the same (as "false"). But that in the new code, we would treat
them _differently_, taking undefined to mean "auto" and empty to mean
"false". I suppose that works, but it is rather unfortunate that the end
state we are left with (for all time) makes such a confusing and subtle
distinction.

I think this should work OK with the existing Makefile conventions. That
is, we do not ever set GIT_TEST_HTTPD in the Makefile ourselves, but
rely on it being either unset or set to whatever the user likes (this is
opposed to something like CFLAGS, where the distinction is long gone).

So I'm not excited about it, but I do not think there is any other
loophole through which we can maintain compatibility. If that's
important, I think we have to do it.

> The caller may have to pass the name of the variable:
> 
> 	GIT_TEST_DAEMON=$(test_tristate GIT_TEST_DAEMON)

I don't think that's a big deal. I actually was tempted to just make
this:

  test_normalize_tristate GIT_TEST_DAEMON

in the first place, since you would always want to look at the
normalized value from there on out.

> and then the callee may become
> 
> 	test_tristate () {
> 		variable=$1
>                 if eval "test x\"\${$variable+isset}\" = xisset"

Hmm, today I learned about "{foo:+bar}" versus "${foo+bar}". I'm not
sure how that bit of shell trivia escaped me for so many years.

-Peff
