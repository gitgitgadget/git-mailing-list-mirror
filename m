From: Junio C Hamano <gitster@pobox.com>
Subject: Re: CRLF problems with Git on Win32
Date: Wed, 09 Jan 2008 12:25:54 -0800
Message-ID: <7vmyrehhkd.fsf@gitster.siamese.dyndns.org>
References: <Pine.LNX.4.64.0801071010340.1864@ds9.cixit.se>
	<200801071947.28586.robin.rosenberg.lists@dewire.com>
	<alpine.LSU.1.00.0801071915470.10101@racer.site>
	<200801072203.23938.robin.rosenberg.lists@dewire.com>
	<alpine.LSU.1.00.0801072115120.10101@racer.site>
	<3B08AC4C-A807-4155-8AD7-DC6A6D0FE134@zib.de>
	<20080108172957.GG22155@fieldses.org>
	<CE10C08D-AAF1-44B5-89B5-9A16A4AB70EA@zib.de>
	<7vmyrgry20.fsf@gitster.siamese.dyndns.org>
	<02DC77F5-7465-418D-972E-0F76E56C3F75@zib.de>
	<20080108190952.GK22155@fieldses.org>
	<7vir24rtfp.fsf@gitster.siamese.dyndns.org>
	<alpine.LFD.1.00.0801081232120.3148@woody.linux-foundation.org>
	<7vd4sbmnmz.fsf@gitster.siamese.dyndns.org>
	<alpine.LSU.1.00.0801091041570.31053@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	"J. Bruce Fields" <bfields@fieldses.org>,
	Steffen Prohaska <prohaska@zib.de>,
	Robin Rosenberg <robin.rosenberg.lists@dewire.com>,
	Jeff King <peff@peff.net>,
	Peter Karlsson <peter@softwolves.pp.se>,
	Git Mailing List <git@vger.kernel.org>,
	msysGit <msysgit@googlegroups.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Jan 09 21:26:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JChVY-0003OG-8k
	for gcvg-git-2@gmane.org; Wed, 09 Jan 2008 21:26:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753933AbYAIU0Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Jan 2008 15:26:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753750AbYAIU0P
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Jan 2008 15:26:15 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:32975 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753926AbYAIU0O (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jan 2008 15:26:14 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 7BB31362C;
	Wed,  9 Jan 2008 15:26:12 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 81A05362B;
	Wed,  9 Jan 2008 15:26:01 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70009>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> IMHO this is really not good.  Better do it in the global /etc/gitconfig 
> we install _anyway_ (it says core.symlinks=false).

That sounds like a perfect place for a per-platform tweak like
this than in the code, but I wonder if peoples' scripts have
valid use case of GIT_CONFIG to bypass it (git-svn's use of the
variable to access its private data seems to be Ok).

>> Perhaps we can do something similar to core.filemode?  Create a file 
>> that we would need to create anyway in "text" mode, and read it back in 
>> "binary" mode to see what stdio did?
>
> The problem is that MinGW behaves sanely, i.e. it does not output CRLF but 
> only LF.

Won't that behaviour be viewed rather as "insanely" from
majority of Windows users?

> But maybe I am the minority here, and we really should default to 
> crlf=true on Windows, and provide a way to unset that.
>
> My preference would be to have Peff's -c switch to clone, but 
> _additionally_ a way to force a full re-checkout of files (for example 
> after "git config core.crlf false").

I have been hoping a better (simpler to use, and somewhat more
importantly harder to misuse by being not overly flexible) way
than that "clone -c" solution, but that is an implementation
issue (I think the tweak rather belongs to init than clone
anyway, and the point of "-c" is that it is not easy to tweak
the way "init" that is used by "clone" behaves).

Switching core.crlf (or gitattributes to change filter -- in
general, "affecting the way convert_to_working_tree() and
convert_to_git() works") can be done for two opposite reasons.

 (1) repository is correct and checkout is wrong.  This wants
     re-checkout.

 (2) repository records in a wrong convention by mistake and
     needs to be fixed.  Re-checkout is obviously a wrong thing
     to do, and re-checkin (not necessarily commit, but updating
     the index) is necessary.

We need both.
