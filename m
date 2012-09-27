From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] diff: diff.context configuration gives default to -U
Date: Thu, 27 Sep 2012 14:43:10 -0400
Message-ID: <20120927184309.GC2519@sigill.intra.peff.net>
References: <A74D9034-E5BA-4CD5-B621-1C388EF4CE2B@mozilla.com>
 <7vobl82u26.fsf@alter.siamese.dyndns.org>
 <C4993A4E-E443-4DB4-9DCA-20128CADDC6E@mozilla.com>
 <7vr4pnqs8l.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jeff Muizelaar <jmuizelaar@mozilla.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Sep 27 20:43:24 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1THJ3S-0004TF-4K
	for gcvg-git-2@plane.gmane.org; Thu, 27 Sep 2012 20:43:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752550Ab2I0SnM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Sep 2012 14:43:12 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:32997 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751725Ab2I0SnM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Sep 2012 14:43:12 -0400
Received: (qmail 4622 invoked by uid 107); 27 Sep 2012 18:43:40 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 27 Sep 2012 14:43:40 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 27 Sep 2012 14:43:10 -0400
Content-Disposition: inline
In-Reply-To: <7vr4pnqs8l.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206507>

On Thu, Sep 27, 2012 at 10:40:26AM -0700, Junio C Hamano wrote:

> > +test_expect_success 'diff.context affects log' '
> > +	git log -1 -p | grep -q -v firstline
> > +	git config diff.context 8 &&
> > +	git log -1 -p | grep -q firstline
> > +'
> 
> Three points:
> 
>  - Please avoid "grep -q", which does not help people who ran tests
>    (the output is hidden by default) and hurts people who want to
>    debug tests.
> 
>  - Your test will ignore breakage from the first "log 1" output and
>    goes on running "git config".  Make sure you got your && cascades
>    right.
> 
>  - Because an error from the command on the upstream side of the
>    pipe is ignored, we tend to prefer writing things like this:
> 
> 	git log -n 1 -p >output &&
>         grep -v firstline output &&

I agree with all of that. But also, is "grep -v" the right thing? I
think the intent of the test is "firstline does not appear". But that is
not what  "grep -v" will tell you. It will tell you whether any line
that did not have "firstline" in it was shown (which it would be, since
there are a bunch of other lines shown).

I think "! grep firstline" is what is needed here. Or even just
explicitly matching the diff that we expect via test_cmp. I like the
latter much better anyway, as a failure will show exactly what is wrong.
Whereas if the grep ends up not matching, there is no helpful output for
somebody reading the test.

We already produce nice messages from things like test_must_fail. Maybe
it would be nice to have:

  test_contains () {
          if ! grep "$1" "$2"; then
	          echo >&2 "File '$2' does not contain a line with '$1'"
		  return 1
	  fi
  }

and likewise a "test_not_contains" or something to negate it. That makes
both the tests and their failure output readable.

-Peff
