From: Frank Lichtenheld <frank@lichtenheld.de>
Subject: Re: [PATCH] cvsserver: fix legacy cvs client and branch rev issues
Date: Sun, 17 Jun 2007 12:37:44 +0200
Message-ID: <20070617103744.GE1828@planck.djpig.de>
References: <11820198064114-git-send-email-djk@tobit.co.uk> <20070617081959.GD1828@planck.djpig.de> <4674FA9B.10806@tobit.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Dirk Koopman <djk@tobit.co.uk>
X-From: git-owner@vger.kernel.org Sun Jun 17 12:38:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hzs8s-0001ZB-MX
	for gcvg-git@gmane.org; Sun, 17 Jun 2007 12:37:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757755AbXFQKhw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 17 Jun 2007 06:37:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757400AbXFQKhw
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Jun 2007 06:37:52 -0400
Received: from planck.djpig.de ([85.10.192.180]:4907 "EHLO planck.djpig.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757755AbXFQKhv (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Jun 2007 06:37:51 -0400
Received: from localhost (localhost [127.0.0.1])
	by planck.djpig.de (Postfix) with ESMTP id E6CEC88102;
	Sun, 17 Jun 2007 12:37:49 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at planck.djpig.de
Received: from planck.djpig.de ([127.0.0.1])
	by localhost (planck.djpig.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id pD7D0d723GCf; Sun, 17 Jun 2007 12:37:45 +0200 (CEST)
Received: by planck.djpig.de (Postfix, from userid 1000)
	id 090F0881B7; Sun, 17 Jun 2007 12:37:44 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <4674FA9B.10806@tobit.co.uk>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50347>

On Sun, Jun 17, 2007 at 10:10:51AM +0100, Dirk Koopman wrote:
> Frank Lichtenheld wrote:
> >On Sat, Jun 16, 2007 at 07:50:06PM +0100, Dirk Koopman wrote:
> >Hmm, I don't see how you could have a problem with that since cvsserver
> >doesn't support branches and never generates any revision numbers in
> >that format?
> >
> >There is probably much more code out there in cvsserver that does assume
> >that revision is always a simple integer.

Let me rephrase that (after actually looking through the code):
All of the revision handling code assumes that.

> The specific issue that I was trying to solve is that I have (in CVS 
> terms) a main line (git head: master) and an active CVS development 
> branch and git head (called SR [for the sake of argument]).
> 
> I have imported both into git using cvsimport. For compatibility (and 
> windows users) I need a anonymous, read only, :pserver: CVS 
> implementation that can serve either head.
> 
> The version numbers in the CVS import on branch SR are standard CVS 
> single level branch 1.2.3.4. Doing a 'cvs update' on this branch was 
> causing all sorts of warnings about 1.2.3.4 not being numeric on that 
> test. After changing the test, the warnings have gone away and it all 
> still seems to work.
>
> Having said that, I haven't worked out where cvsserver is getting those 
> version numbers from in the first place, but it obviously knows that it 
> is dealing with a branch sufficient to work well enough for my needs.

Hmm, so you did the cvs update in an old working copy of the original
CVS repository? Then CVS sent those version numbers from the CVS/Entries
file to the server, cvsserver certainly never generates numbers like
that. And I would be very suprised if you could do anything remotely
useful with abusing the old working copy this way... The revision
numbers that cvsserver assigns to the files of the main branch might
be almost always identical to the ones they had in CVS before the
import, but the ones for branches will definetly not be.

> Of course, quite what happens when the branch merges back and people 
> want to 'cvs update -A', I shall leave for the future...

I don't think that cvsserver actually cares about what the client sends
as sticky tags/dates/..., so it might not actually change anything
whether you use -A or not (pure speculation on my part here).

Summary: You're (ab)using cvsserver in very interesting ways that are not
really beeing thought of in the current design/implementation. There'll
be dragons ;)

Gruesse,
-- 
Frank Lichtenheld <frank@lichtenheld.de>
www: http://www.djpig.de/
