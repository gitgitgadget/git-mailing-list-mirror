From: Jeff King <peff@peff.net>
Subject: Re: git bisect code 125 - "WFT?"
Date: Thu, 17 Mar 2011 03:27:23 -0400
Message-ID: <20110317072723.GH11931@sigill.intra.peff.net>
References: <AANLkTikZ3Po-YdhO-qCn5usVkt4J196eFF6YdbAeMG_X@mail.gmail.com>
 <7v1v267no9.fsf@alter.siamese.dyndns.org>
 <AANLkTikRttGnxex1CYSQnSg4PgctFj0-qNjf5un+fL0W@mail.gmail.com>
 <4D81B04A.1010802@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Piotr Krukowiecki <piotr.krukowiecki@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	Christian Couder <chriscool@tuxfamily.org>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Thu Mar 17 08:27:33 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q07cL-0006lW-Ia
	for gcvg-git-2@lo.gmane.org; Thu, 17 Mar 2011 08:27:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751936Ab1CQH12 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Mar 2011 03:27:28 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:44883
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751647Ab1CQH11 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Mar 2011 03:27:27 -0400
Received: (qmail 21298 invoked by uid 107); 17 Mar 2011 07:27:59 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 17 Mar 2011 03:27:59 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 17 Mar 2011 03:27:23 -0400
Content-Disposition: inline
In-Reply-To: <4D81B04A.1010802@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169218>

On Thu, Mar 17, 2011 at 07:55:06AM +0100, Johannes Sixt wrote:

> Am 3/16/2011 23:06, schrieb Piotr Krukowiecki:
> > On Wed, Mar 16, 2011 at 10:36 PM, Junio C Hamano <gitster@pobox.com> wrote:
> >> Piotr Krukowiecki <piotr.krukowiecki@gmail.com> writes:
> >>
> >>> Opinions? Would it be possible to change the meaning of the codes now
> >>> (in 1.8.0)?
> >>
> >> How about just documenting why it is a bad idea to use 126 or 127 as you
> >> found out somewhere, and stopping there, iow, without changing the code to
> >> use 126/127 that we consider it is a bad idea to use and avoided using so
> >> far?
> > 
> > Documenting it won't help. If you get 126 code, you won't know if user
> > returned it to mark the code as bad, or if bash returned it to say
> > that it can't
> > execute a command.
> 
> Huh? Why should the user's script return 126 or 127, particularly if the
> documentation says "don't do that"? Moreover, any decent (shell)
> programmer will know that these two values are reserved by POSIX for
> particular purposes (they are _not_ specific to bash):
> 
> http://pubs.opengroup.org/onlinepubs/9699919799/utilities/V3_chap02.html#tag_18_09_01_01

I think the argument is not that the user would want to return those
codes, but that we can protect a poorly written test script from itself
by including those exit codes in the list of "indeterminate result"
codes.

IOW, currently this:

  git bisect run 'make && ./test-pogram'

will happily generate a bogus bisection. And obviously that's a trivial
example, but one can imagine a much larger script with a missing command
in it.

There are two problems with that argument that I see, though:

  1. It only protects some very specific cases, and they're not even
     interesting cases. Say your bisection runs a test script that looks
     like this:

       cmd1
       missing-cmd
       cmd2

     we _still_ won't see it as an indeterminate result, because the
     missing cmd's exit code is lost. So you would have to write:

       cmd1 &&
       missing-cmd &&
       cmd2

     but that doesn't really help much. If you are going to be that
     careful, what you really want is something like:

       cmd1 || exit 125
       missing-cmd || exit 125
       cmd2 || exit 125
       some-final-command-to-check-the-state

     So it can help, but I don't think it really helps in real-world
     cases.

  2. If we do detect such a mishap, I'm not sure that "indeterminate
     result" is necessarily the best result, as that will just keep
     trying more and more commits without success. It is more likely a
     sign of a poorly written test script, and the best thing we could
     do is die and say "your test script looks buggy".

-Peff
