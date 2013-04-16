From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/3] usage: refactor die-recursion checks
Date: Mon, 15 Apr 2013 20:42:28 -0400
Message-ID: <20130416004228.GA14995@sigill.intra.peff.net>
References: <20130415230651.GA16670@sigill.intra.peff.net>
 <20130415230802.GA11267@sigill.intra.peff.net>
 <CA+sFfMes99EepY4FCW32s1L3ywv_gyFb76=Y=35rvPbc2K1BWA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Brandon Casey <drafnel@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 16 02:46:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1URu2K-0004pG-5r
	for gcvg-git-2@plane.gmane.org; Tue, 16 Apr 2013 02:46:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934799Ab3DPAmf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Apr 2013 20:42:35 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:47295 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753874Ab3DPAmf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Apr 2013 20:42:35 -0400
Received: (qmail 31474 invoked by uid 107); 16 Apr 2013 00:44:29 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 15 Apr 2013 20:44:29 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 15 Apr 2013 20:42:28 -0400
Content-Disposition: inline
In-Reply-To: <CA+sFfMes99EepY4FCW32s1L3ywv_gyFb76=Y=35rvPbc2K1BWA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221337>

On Mon, Apr 15, 2013 at 05:11:36PM -0700, Brandon Casey wrote:

> > +static void check_die_recursion(const char *fmt, va_list ap)
> > +{
> > +       static int dying;
> > +
> > +       if (!dying++)
> > +               return;
> > +
> > +       vreportf("fatal: ", fmt, ap);
> 
> How do you know it's safe to call vreportf() ?

Because I hand-audited it. But I think the more important question you
are getting at is: how do I know that it will remain safe to call
vreportf?

> If the bug is in the vreportf code path, we will recurse infinitely
> (at least until the stack is used up). An implementation of vsnprintf
> exists in compat/snprintf.c for example.

Right. My assumption was that we are primarily interested in protecting
against the die_routine. Compat functions should never be calling die.
Of course that is assuming nobody violates that rule, which is part of
the point of the check.

> It's nice to print out the error message here, but I think doing so
> defeats the purpose of this "dying" check.  Better to get the stack
> trace from a core dump.

Easier said than done, sometimes, if you are debugging somebody else's
problem from a dump of a terminal session. :)

But I can live with dropping this patch; my primary goal is the bug-fix
in patch three.

I was also tempted to suggest just dropping the recursion check
altogether. While it is neat to detect such things, it's a "should never
happen" bug situation, and an infinite loop of printing out the same
message is pretty easy to notice. Do you remember what spurred the
original check? The message in cd163d4 doesn't say.

-Peff
