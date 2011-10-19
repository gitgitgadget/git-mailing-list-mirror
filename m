From: Jeff King <peff@peff.net>
Subject: Re: How to verify that lines were only moved, not edited?
Date: Wed, 19 Oct 2011 12:33:54 -0400
Message-ID: <20111019163354.GB3157@sigill.intra.peff.net>
References: <4E9EDFEC.3040009@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Wed Oct 19 18:34:07 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RGZ5e-0003Fp-Pj
	for gcvg-git-2@lo.gmane.org; Wed, 19 Oct 2011 18:34:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756655Ab1JSQd6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Oct 2011 12:33:58 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:35688
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756386Ab1JSQd5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Oct 2011 12:33:57 -0400
Received: (qmail 30480 invoked by uid 107); 19 Oct 2011 16:34:03 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 19 Oct 2011 12:34:03 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 19 Oct 2011 12:33:54 -0400
Content-Disposition: inline
In-Reply-To: <4E9EDFEC.3040009@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183935>

On Wed, Oct 19, 2011 at 04:34:20PM +0200, Johannes Sixt wrote:

> I thought there was a way to use git-blame to find out whether a change
> only shuffled lines, but otherwise did not modify them. I tried "git blame
> -M -- the/file", but it does not work as expected, neither with a toy file
> nor with a 5000+ lines file (with 55 lines moved).
> 
> git init
> echo A > foo
> echo B >> foo
> git add foo
> git commit -m initial
> echo B > foo
> echo A >> foo
> git commit -a -m swapped
> 
> The results are:
> $ git blame -M -s -- foo
> ^e3abca2 1) B
> 6189cb46 2) A
> 
> I would have expected:
> ^e3abca2 1) B
> ^e3abca2 2) A
> 
> Oh, look! This produces the expected result:
> $ git blame -M1 -s -- foo

Right. Your toy lines aren't long enough to be considered "interesting"
by the default score. From git-blame(1):

  -M[<num>]
  [...]
  <num> is optional but it is the lower bound on the number of
  alphanumeric characters that git must detect as moving/copying within
  a file for it to associate those lines with the parent commit. The
  default value is 20.

Whereas with a longer sample:

  git init
  seq 1 5000 >foo
  git add foo
  git commit -m initial
  sed -i '/^2..$/d' foo
  seq 200 299 >>foo
  git commit -a -m 'move 200-299 to end'

I get the expected result from "git blame -M" (i.e., everything
attributed to the root commit).

> But neither helps with my 5000+ lines file. Does it mean that the lines
> were changed? But I'm sure they were just moved! Please help!

What does the file look like? I think blame has some heuristics about
lines which are uninteresting, and maybe you are triggering a corner
case there.

-Peff
