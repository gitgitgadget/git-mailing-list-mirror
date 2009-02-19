From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Use DIFF_XDL_SET/DIFF_OPT_SET instead of raw
	bit-masking
Date: Wed, 18 Feb 2009 20:02:46 -0500
Message-ID: <20090219010246.GD25808@coredump.intra.peff.net>
References: <1234841209-3960-1-git-send-email-keith@cs.ucla.edu> <alpine.DEB.1.00.0902171304130.6185@intel-tinevez-2-302> <alpine.GSO.2.00.0902170918180.27811@kiwi.cs.ucla.edu> <alpine.DEB.1.00.0902172354570.10279@pacific.mpi-cbg.de> <alpine.GSO.2.00.0902181238320.29723@kiwi.cs.ucla.edu> <alpine.DEB.1.00.0902182219370.10279@pacific.mpi-cbg.de> <alpine.GSO.2.00.0902181437260.6181@kiwi.cs.ucla.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>,
	Pierre Habouzit <madcoder@madism.org>, git@vger.kernel.org
To: Keith Cascio <keith@CS.UCLA.EDU>
X-From: git-owner@vger.kernel.org Thu Feb 19 02:04:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZxKx-0007HV-9V
	for gcvg-git-2@gmane.org; Thu, 19 Feb 2009 02:04:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752379AbZBSBCt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Feb 2009 20:02:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751969AbZBSBCt
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Feb 2009 20:02:49 -0500
Received: from peff.net ([208.65.91.99]:60683 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751816AbZBSBCs (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Feb 2009 20:02:48 -0500
Received: (qmail 18272 invoked by uid 107); 19 Feb 2009 01:03:09 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Wed, 18 Feb 2009 20:03:09 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 18 Feb 2009 20:02:46 -0500
Content-Disposition: inline
In-Reply-To: <alpine.GSO.2.00.0902181437260.6181@kiwi.cs.ucla.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110602>

On Wed, Feb 18, 2009 at 02:59:29PM -0800, Keith Cascio wrote:

> Actually I appreciate your feedback, and the more direct the better.
> The chief value I see in revising the code to accomplish these bit
> settings uniformly using well known macros is that later, if someone
> has good reason to extend the macro so it results in some new side
> effect, e.g. to update a dirty bit mask, the new behavior
> automatically cascades to every appropriate use out there in the code.
> A macro is essentially a "code constant".  As with other constants,
> the benefit comes from defining it once and using it everywhere.  Is
> this effect not worth as much as I think it is?  Is there a hidden
> gotcha in my ideal?  Or does anyone else see value here?  Please speak
> up!

I think you are running into "if it's not broken, don't fix it".  That
is, there is a transaction cost to making changes to the code. It can be
as small a cost as "now somebody working in a related area has a
conflict (even if textual) and has to spend time resolving". Or it can
be as big as "you introduced new bugs".  In this case, I think any costs
would tend towards the former and not the latter.

That cost has to be weighed against the benefit.

The usual attitude in git is that minor cleanups or enhancements like
this should be coupled with patches that build on them. Saying "this
might help in the future if somebody does X" means you are paying the
cost now, but there may or may not ever _be_ any benefit.

In this case, I think there are actually two changes in your patch:

  1. consistently using DIFF_OPT_* macros, which are used in 99% of
     callsites already

  2. adding and using DIFF_XDL macros

I think (1) has immediate value. Anyone looking at the code and seeing
the existence of DIFF_OPT macros and how commonly they are used might
think they are used exclusively. And that means it is easy to miss
callsites when searching through the code. So to me, making things
consistent brings value.

For (2), that situation does not exist, since you are introducing new
macros.

Personally, I don't mind the abstraction layer of the XDL macros,
especially since they match the style of the existing DIFF_OPT macros
(and the only reason they are not in the DIFF_OPT bitfield at all is
that they must be passed separately to xdiff).

-Peff
