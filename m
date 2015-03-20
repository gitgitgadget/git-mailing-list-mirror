From: Jeff King <peff@peff.net>
Subject: Re: test &&-chain lint
Date: Fri, 20 Mar 2015 13:24:07 -0400
Message-ID: <20150320172406.GA15172@peff.net>
References: <20150317072750.GA22155@peff.net>
 <20150317072844.GA25191@peff.net>
 <CAPig+cTfqWr9un=4+QGs0jcUaV9U=z5Xyg3-r-D6dABGXUkmzg@mail.gmail.com>
 <20150320013217.GA15302@peff.net>
 <CAPig+cQKhBw8air5y3NJaP5Rx9pXVaz9Lmvhe20AimW7pCsWBw@mail.gmail.com>
 <20150320020851.GC15302@peff.net>
 <20150320022532.GA5502@peff.net>
 <xmqqd244go0h.fsf@gitster.dls.corp.google.com>
 <xmqq384zha6s.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Git List <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 20 18:24:32 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YZ0eh-0007K9-Ui
	for gcvg-git-2@plane.gmane.org; Fri, 20 Mar 2015 18:24:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751774AbbCTRYN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Mar 2015 13:24:13 -0400
Received: from cloud.peff.net ([50.56.180.127]:35899 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751710AbbCTRYK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Mar 2015 13:24:10 -0400
Received: (qmail 25581 invoked by uid 102); 20 Mar 2015 17:24:09 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 20 Mar 2015 12:24:09 -0500
Received: (qmail 25334 invoked by uid 107); 20 Mar 2015 17:24:21 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 20 Mar 2015 13:24:21 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 20 Mar 2015 13:24:07 -0400
Content-Disposition: inline
In-Reply-To: <xmqq384zha6s.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265914>

On Fri, Mar 20, 2015 at 10:04:43AM -0700, Junio C Hamano wrote:

> One case where this might misdetect a good test would be this one:
> 
>     test_expect_success 'either succeed or fail with status 1' '
> 	git subcmd || case "$?" in 1) : happy ;; *) false failure ;; esac
>     '

Yes. Any use of "||" is going to cause problems. See the conversions in
the series I posted a few hours ago. The solution is to adapt the test
style to encase any "||" inside a block. I don't like having to modify
the tests to match our lint check, but it is a fairly rare case, and the
modification is not complex. And in fact I think it often highlights to
the reader that something funny is going on; a snippet like the one
above is OK to run at the start of a test, but:

  foo &&
  bar ||
  case "$?"
   ...

is potentially dangerous. You do not know if you are checking the $? of
"foo" or "bar" in that case statement.

Your case above is actually better spelled as test_expect_code, but
there are more complex one-off cases that I solved using a {} block.

> I wonder if another valid way to make it harder for us to commit
> "broken && chain" errors in our test may be to make it not an error
> in the first place.  Do we know how buggy various implementations of
> shells are with respect to their handling of "set -e"?

Certainly that is a thought that occurred to me while writing the
series. At GitHub, we have a shell-based test harness for internal
projects that is somewhat like Git's t/test-lib.sh, but uses "-e" to
catch errors.

It's mostly OK, but there are some surprising bits. For instance, try
this sequence of snippets:

     set -e
     false
     echo should not reach

That should print nothing. So far so good. How about in a subshell:

     set -e
     (
       false
       echo 1
     )
     echo 2

That also prints nothing. Good. But "set -e" is suppressed in a
conditional or in the presence of logic operators like "||".  So you'd
expect this:

     set -e
     (
       false
       echo 1
     ) || {
         echo outcome=$?
         false
     }
     echo 2

to break out of the subshell, print the failed outcome, and then exit.
But it doesn't. It prints "1" and "2". The suppression of "set -e"
continues inside the subshell, even though the inner commands are not
part of their own conditionals.

OK, so when we open a subshell we have to re-iterate our desire for "set
-e":

    set -e
    (
      set -e
      false
      echo 1
    ) || {
        echo outcome=$?
	false
    }
    echo 2

Nope, does nothing, at least in bash and dash. The ||-operator
suppression is clearly not "turn off set -e", but "globally make -e
useless inside here".

So you end up having to use manual exits to jump out of the subshell,
like:

     set -e
     (
       false || exit 1
       echo 1
     ) || {
         echo outcome=$?
         false
     }
     echo 2


That snippet produces "outcome=1", which is what I expect.

Of course most tests are not so complicated to have subshells with
conditional operators on the side. But I did not just type out that
example right now from scratch. I cut-and-pasted it from a real-world
commit message.

So I dunno. I think "set -e" is kind of a dangerous lure. It works so
well _most_ of the time that you start to rely on it, but it really does
have some funny corner cases (even on modern shells, and for all I know,
the behavior above is mandated by POSIX).

-Peff
