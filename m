From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] test-lib: add the test_bash convenience function
Date: Sun, 15 Jan 2012 18:24:13 -0500
Message-ID: <20120115232413.GA14724@sigill.intra.peff.net>
References: <4F133069.10308@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Mon Jan 16 00:24:23 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RmZR0-0007vZ-KU
	for gcvg-git-2@lo.gmane.org; Mon, 16 Jan 2012 00:24:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752541Ab2AOXYR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Jan 2012 18:24:17 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:38997
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750811Ab2AOXYQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Jan 2012 18:24:16 -0500
Received: (qmail 26948 invoked by uid 107); 15 Jan 2012 23:31:11 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sun, 15 Jan 2012 18:31:11 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 15 Jan 2012 18:24:13 -0500
Content-Disposition: inline
In-Reply-To: <4F133069.10308@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188599>

On Sun, Jan 15, 2012 at 09:00:41PM +0100, Jens Lehmann wrote:

> Since 781f76b15 (test-lib: redirect stdin of tests) you can't simply put a
> "bash &&" into a test for debugging purposes anymore. Instead you'll have
> to use "bash <&6 >&3 2>&4".

Yeah, an unfortunate side effect.

If you're not relying on particular state in the middle of a chain of
commands, you can just put the "bash" outside of the test_expect_*. But
sometimes you do care about having it in the middle.

> As that invocation is not that easy to remember add the test_bash
> convenience function. This function also checks if the -v flag is given
> and will complain if that is not the case instead of letting the test
> hang until ^D is pressed.

Nice. Many times I have added such a "bash" or "gdb" invocation then
forgotten "-v", only to scratch my head at why the test seemed to be
hanging.

Two minor nits on the patch itself:

> +# Stop execution and start a bash shell. This is useful for debugging tests
> +# and only makes sense together with "-v".
> +
> +test_bash () {
> +	if test "$verbose" = t; then
> +		bash <&6 >&3 2>&4
> +	else
> +		say >&5 "skipping test_bash as it makes no sense without -v"
> +	fi
> +}

1. It may be worth putting a warning in the comment that this is never
   to be used in a real test, but only temporarily inserted.

2. I do this not just with bash, but with "gdb". I wonder if it is worth
   making this "test_foo bash", for some value of "foo" (the ones that
   occur to me are "debug" and "run", but of course they are taken).

   Actually, I wonder if the existing test_debug could handle this
   already (though you do have to remember to add "--debug" to your
   command line, then).

-Peff
