From: Jeff King <peff@peff.net>
Subject: Re: autocrlf=input and safecrlf (was Re: CVS import [SOLVED])
Date: Tue, 24 Feb 2009 01:11:34 -0500
Message-ID: <20090224061134.GF4615@coredump.intra.peff.net>
References: <20090220152849.GA3826@coredump.intra.peff.net> <32886.77.61.241.211.1235147143.squirrel@hupie.xs4all.nl> <20090220172918.GB4636@coredump.intra.peff.net> <499F3B9B.3020709@pelagic.nl> <20090223000840.GA20392@coredump.intra.peff.net> <2944.77.61.241.211.1235371848.squirrel@hupie.xs4all.nl> <20090223065615.GA24807@coredump.intra.peff.net> <1570.77.61.241.211.1235372943.squirrel@hupie.xs4all.nl> <20090223071056.GA29241@coredump.intra.peff.net> <59288.77.61.241.211.1235374197.squirrel@hupie.xs4all.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	git@vger.kernel.org
To: "Ferry Huberts (Pelagic)" <ferry.huberts@pelagic.nl>
X-From: git-owner@vger.kernel.org Tue Feb 24 07:13:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LbqXQ-0000gE-Rh
	for gcvg-git-2@gmane.org; Tue, 24 Feb 2009 07:13:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753299AbZBXGLj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Feb 2009 01:11:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753218AbZBXGLi
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Feb 2009 01:11:38 -0500
Received: from peff.net ([208.65.91.99]:38010 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753207AbZBXGLh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Feb 2009 01:11:37 -0500
Received: (qmail 11504 invoked by uid 107); 24 Feb 2009 06:12:00 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Tue, 24 Feb 2009 01:12:00 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 24 Feb 2009 01:11:34 -0500
Content-Disposition: inline
In-Reply-To: <59288.77.61.241.211.1235374197.squirrel@hupie.xs4all.nl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111218>

On Mon, Feb 23, 2009 at 08:29:57AM +0100, Ferry Huberts (Pelagic) wrote:

> > Wouldn't setting autocrlf=true, safecrlf=true do the import you want?
> > Then you could reset autocrlf to input after import but before checkout
> > time.
> 
> No. As I demonstrated in my testing setup the combination of autocrlf=true
> and safecrlf=true ALWAYS makes the import NOT work (for repositories that
> have CRLF files). In my own experience I also found that the combination

OK, sorry I missed that before.

It actually works fine with CRLF files. It breaks on _LF_ files.  Look
again at the output you posted, which shows it barfing while working on
unix.txt.

This is the flip-side of the CRLF and autocrlf=input problem; safecrlf
is protecting us from the case where the file would change on checkout,
in addition to when it would actually be corrupted.

But both of those checks (CRLF on autocrlf=input and safecrlf=true, and
LF on autocrlf=output/true and safecrlf=true) aren't useful to us here;
we are not coming from the working tree to git, and worried about
getting back. We are munging input coming from cvs, and whatever gets
put into the working tree is fine (as long as it is not binary
corruption).

So I think the right solution is a relaxed safecrlf mode that protects
against corruption, but not these other cases. And then git-cvsimport
should use that.

In the meantime, detecting the situation is not a bad idea.

> of autocrlf=input and safecrlf=true ALWAYS makes the import NOT work for
> PRATICAL repositories. That lead me to the conclusion to require
> safecrlf=false. From the discussion and arguments from you it appeared
> that that wouldn't be enough. Therefore I think that we have to require
> autocrlf=false (which makes git ignore the safecrlf setting).

So yes, in some sense it is safecrlf that is broken. I'm just concerned
about tweaking the user's options behind their back. The import can
happen differently than they expected no matter which of safecrlf or
autocrlf you tweak. So I think you are better off to complain and die.

-Peff
