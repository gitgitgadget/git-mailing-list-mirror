From: Dan Zwell <dzwell@zwell.net>
Subject: [PATCH 0/3] Adding colors to git-add--interactive
Date: Sat, 10 Nov 2007 18:01:09 -0600
Message-ID: <20071110180109.34febc3f@paradox.zwell.net>
References: <47112491.8070309@gmail.com>
	<20071015034338.GA4844@coredump.intra.peff.net>
	<20071016194709.3c1cb3a8@danzwell.com>
	<20071017015152.GN13801@spearce.org>
	<20071022164048.71a3dceb@danzwell.com>
	<20071023042702.GB28312@coredump.intra.peff.net>
	<20071023035221.66ea537f@danzwell.com>
	<20071102224100.71665182@paradox.zwell.net>
	<20071104045735.GA12359@segfault.peff.net>
	<7v640ivagv.fsf@gitster.siamese.dyndns.org>
	<20071104054305.GA13929@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Wincent Colaiuta <win@wincent.com>,
	Git Mailing List <git@vger.kernel.org>,
	Jonathan del Strother <maillist@steelskies.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Frank Lichtenheld <frank@lichtenheld.de>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Nov 11 06:49:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ir5hK-00058C-Ps
	for gcvg-git-2@gmane.org; Sun, 11 Nov 2007 06:49:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752145AbXKKFtO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Nov 2007 00:49:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752190AbXKKFtO
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Nov 2007 00:49:14 -0500
Received: from gateway03.websitewelcome.com ([74.52.223.144]:33196 "EHLO
	gateway03.websitewelcome.com" rhost-flags-OK-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752145AbXKKFtL (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 11 Nov 2007 00:49:11 -0500
X-Greylist: delayed 5390 seconds by postgrey-1.27 at vger.kernel.org; Sun, 11 Nov 2007 00:49:10 EST
Received: (qmail 18083 invoked from network); 11 Nov 2007 00:02:17 -0000
Received: from gator290.hostgator.com (74.53.26.226)
  by gateway03.websitewelcome.com with ESMTPS (DHE-RSA-AES256-SHA encrypted); 11 Nov 2007 00:02:17 -0000
Received: from [143.44.70.185] (port=35685 helo=paradox.zwell.net)
	by gator290.hostgator.com with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.66)
	(envelope-from <dzwell@zwell.net>)
	id 1Ir0HQ-0008Dc-Tr; Sat, 10 Nov 2007 18:02:26 -0600
In-Reply-To: <20071104054305.GA13929@sigill.intra.peff.net>
X-Mailer: Claws Mail 3.0.2 (GTK+ 2.10.14; x86_64-pc-linux-gnu)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator290.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - zwell.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64404>

A bit of a recap--this feature was requested by a user a few weeks
ago, and I wrote a short patch that implemented partial coloring. The
main criticisms of this patch were:
- The name of the configuration key to turn on interactive coloring
was not well chosen.
- The color attribute synonyms "clear" and "reset" were used
interchangeably, though "reset" is what the rest of git uses.
- The colors were not user-settable.

When the above were fixed, the new patch garnered the following
criticism:
- The color names accepted in .gitconfig were perl color names (to be
fed to Term::ANSIColor), and this was not consistent with the rest
of git. For example, "red blue ul" would have to be written, "red
on_blue underline".

Fixing this (the colors could not be converted by a regex, but had to
be parsed) was very libraryish, and also a little confusing. I was
given a suggestion or two about how to make it more readable. This
parsing also needed to be added to Git.pm instead of
git-add--interactive.perl.

In the next iteration, all of the above were fixed, but as Jeff King
pointed out, I was printing $color before the beginning of a string,
and printing $clear at the end, which allowed ${COLOR}text\n${RESET},
which looks bad on some terminals.

Last iteration, it was pointed out that print_colored must take a
file handle to pave the way for pager support, and Junio Hamano and Jeff
King both gave suggestions as to how, and Junio sent me few changes
that allow printing colored diffs in addition to prompts. I ended up
making changes so that the two color functions can be used with perl's
print():
print colored($color, "some text")
print color_diff_hunk($hunk)

This way, file handles can be added directly to the print calls, when
support for $PAGER is added.

Let me know if other things need correction.

Dan
