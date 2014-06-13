From: Jeff King <peff@peff.net>
Subject: Re: [PATCHv2 4/6] t7510: exit for loop with test result
Date: Fri, 13 Jun 2014 08:45:44 -0400
Message-ID: <20140613124544.GA18621@sigill.intra.peff.net>
References: <cover.1402655838.git.git@drmicha.warpmail.net>
 <99893263f1819646a3a324b2fff0bcd0d56f3818.1402655839.git.git@drmicha.warpmail.net>
 <20140613114615.GE14066@sigill.intra.peff.net>
 <539AE8CA.50009@drmicha.warpmail.net>
 <539AED0C.8050107@drmicha.warpmail.net>
 <539AEF7E.1050402@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Fri Jun 13 14:46:05 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WvQrr-0001ri-VO
	for gcvg-git-2@plane.gmane.org; Fri, 13 Jun 2014 14:46:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751305AbaFMMpq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Jun 2014 08:45:46 -0400
Received: from cloud.peff.net ([50.56.180.127]:43490 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751289AbaFMMpq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jun 2014 08:45:46 -0400
Received: (qmail 27071 invoked by uid 102); 13 Jun 2014 12:45:45 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 13 Jun 2014 07:45:45 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 13 Jun 2014 08:45:44 -0400
Content-Disposition: inline
In-Reply-To: <539AEF7E.1050402@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251591>

On Fri, Jun 13, 2014 at 02:33:02PM +0200, Michael J Gruber wrote:

> > With X && Y || exit 1 inside the loop, the loop statement will return
> > false, but the loop will continue (if X returns false), which is exactly
> > the problem that the exit avoids.
> > 
> > Make your example iterate over false true instead in the inner loop and
> > you'll see ;)
> > 
> > Michael
> 
> ... with this loop, sorry:
> 
> for X in true false; do
>      for Y in false true; do
>        ($X && $Y || exit 1)
>      done
>      echo "$X/last inner $Y: $?"
> done

I'm somewhat confused, as my loops were meant only to expand the truth
table, not to simulate a real loop in the code. That is why I have a
subshell in the loop around my exit, to make sure we keep looping. In
the real code, the subshell surrounds the whole loop (so that an "exit"
leaves the entire loop without leaving the whole script).

The actual code is more like:

  (
    for i in a b c; do
      echo $i: got to first step &&
      test $i != b && 
      echo $i: got to second step || exit 1
    done
  )
  echo overall status: $?

which should fail on the second loop iteration. And it does:

  a: got to first step
  a: got to second step
  b: got to first step
  overall status: 1

That is, we short-circuit to the "exit 1" as soon as "test $i != b"
fails. You can replace the use of "$?" above with more "&&"-chaining, of
course.

-Peff
