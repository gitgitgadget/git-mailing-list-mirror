From: Jeff King <peff@peff.net>
Subject: Re: git log -z doesn't separate commits with NULs
Date: Fri, 24 Feb 2012 15:46:15 -0500
Message-ID: <20120224204615.GB21447@sigill.intra.peff.net>
References: <4F46036F.3040406@gmail.com>
 <20120223102426.GB2912@sigill.intra.peff.net>
 <4F462E61.4020203@gmail.com>
 <m34nuhelnf.fsf@localhost.localdomain>
 <4F4643BB.8090001@gmail.com>
 <20120223193451.GB30132@sigill.intra.peff.net>
 <7vy5rt2u0c.fsf@alter.siamese.dyndns.org>
 <4F475689.4040203@gmail.com>
 <20120224095253.GC11846@sigill.intra.peff.net>
 <7vsji0xalg.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Nikolaj Shurkaev <snnicky@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 24 21:46:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S122J-00085t-QA
	for gcvg-git-2@plane.gmane.org; Fri, 24 Feb 2012 21:46:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758122Ab2BXUqX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Feb 2012 15:46:23 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:55984
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758098Ab2BXUqR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Feb 2012 15:46:17 -0500
Received: (qmail 28471 invoked by uid 107); 24 Feb 2012 20:46:19 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 24 Feb 2012 15:46:19 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 24 Feb 2012 15:46:15 -0500
Content-Disposition: inline
In-Reply-To: <7vsji0xalg.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191472>

On Fri, Feb 24, 2012 at 12:03:39PM -0800, Junio C Hamano wrote:

> The above text is not telling the entire truth, though.
>
> When the command is run with the "--full-diff" option, seleted commits
> will be shown in full.  This is useful for example when you want to pick
> commits that add a new "frotz" driver, which obviously needs to include
> "drivers/frotz/" subdirectory, without missing necessary changes to the
> Makefiles in the higher level (e.g. "drivers/Makefile"), e.g.
> 
> 	git format-patch --full-diff v1.0..v1.1 -- drivers/frotz
> 
> In such a case, "some parts may be cut off" does not make the log message
> inappropriate.

True. That is also a slightly dangerous thing to do, though, because you
are omitting full patches in the middle that touch the same paths as the
patches you include. So I might send you a patch against Makefile that
does not apply, and nor do you have the interim sha1.

Of course that is a general problem with any commit-limiting in
format-patch (e.g., --grep), and even with sending patches in general (I
have to make sure I based my patch off of something reasonable in the
first place). The key is to be clueful about what you are doing. So
perhaps we are better off to refer the user to git-log(1), say that
commit limiting options in general would work, but be careful with
sending a partial result.

> On the other hand, people often do not use the resulting history of taking
> partial patches (i.e. without --full-diff) and feeding them to "am" as-is.
> The operation is used merely to give them a starting point for working on
> (possibly) an unrelated topic, and the history is further tweaked with
> "rebase -i" or even "commit --amend".  It is not "inappropriate" that the
> log says more than what the patch does in such a use case.  What the log
> says is irrelevant.

Right. I think this comes down to the "clueful" bit. If you understand
what it is you are asking git to do and deciding that the consequences
are OK (either because you are not using the log message, or you know
that the subset of a series you are sending should apply to what the
receiver has).

> > I don't know how well tested every option is, though, so maybe it's not
> > a good idea to encourage the use of random options.
> 
> I obviously agree and also suspect that the real question is not "how well
> tested" but "if it makes sense".
> 
> I am reasonably sure that over time the options and features that make
> sense in the context of producing something that is useful with "am" have
> been already made to work well, but I also am fairly certain that the
> coverage of the code to explicitly reject options that do not make sense
> in that context would be spotty at best.  For example, did we carefully
> design and implement how format-patch should behave when "-z" is given,
> or does the code happen to do whatever it happens to do?  If the latter,
> did we consider rejecting "-z" when given from the command line and
> implement such safety?

Yeah, I think that is a good way of putting it. I tend to think the
commit-limiting options are the useful and working ones, which is why I
suggested mentioning them explicitly above. But I admit I don't use them
myself, so I'm just guessing.

-Peff
