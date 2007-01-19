From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] prune: --expire=time
Date: Fri, 19 Jan 2007 11:18:16 -0800
Message-ID: <7vfya6hll3.fsf@assigned-by-dhcp.cox.net>
References: <20070118171830.GA13521@moooo.ath.cx>
	<20070118172408.GG15428@spearce.org>
	<20070118174244.GA14287@moooo.ath.cx>
	<20070118175134.GH15428@spearce.org>
	<20070118222919.GA22060@moooo.ath.cx>
	<7vy7o0klt1.fsf@assigned-by-dhcp.cox.net>
	<20070119034404.GA17521@spearce.org>
	<20070119104935.GA5189@moooo.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Jan 19 20:18:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H7zFm-00048d-HD
	for gcvg-git@gmane.org; Fri, 19 Jan 2007 20:18:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932854AbXASTST (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 19 Jan 2007 14:18:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932856AbXASTST
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Jan 2007 14:18:19 -0500
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:64611 "EHLO
	fed1rmmtao10.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932854AbXASTSS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Jan 2007 14:18:18 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070119191817.IHVF20715.fed1rmmtao10.cox.net@fed1rmimpo02.cox.net>;
          Fri, 19 Jan 2007 14:18:17 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id D7Ja1W00Z1kojtg0000000; Fri, 19 Jan 2007 14:18:35 -0500
To: Matthias Lederhofer <matled@gmx.net>
In-Reply-To: <20070119104935.GA5189@moooo.ath.cx> (Matthias Lederhofer's
	message of "Fri, 19 Jan 2007 11:49:35 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37192>

Matthias Lederhofer <matled@gmx.net> writes:

> Shawn O. Pearce <spearce@spearce.org> wrote:
>
>> Junio C Hamano <junkio@cox.net> wrote:
>> > If this is something we would want, it might make sense if we
>> > allowed "prune --expire='1.day'" syntax ;-).
>> 
>> Yes, I agree.
>
> Here is the new version.

Thanks.

> Things I'm not sure about, any further comments/discussion?
> - default value for gc.pruneexpire
> - special value(s) for gc.pruneexpire/--expire which mean 'do not
>   check for the age', currently it is 'off'

No single timeout value can be the right timeout for everybody,
so a big debate is not useful here.  I think 1 day as you and
Shawn did makes sense.

	git prune --expire=off

felt a bit confusing to me at the first glance.  Does it turn
off the expiration mechanism, retaining all cruft, or turns off
the mechanism to give grace period for recent objects?  The
answer is obviosuly the latter as "retain all cruft" is
meaningless, but still it somehow feels funny.  It might be
easier to explain if it was:

	git prune --expire=now

Maybe an alternative:

	git prune --retain=1.day
	git prune --retain=off

perhaps?  I dunno.

We seem to use "unsigned long" as a stand-in type for time_t in
the rest of the code.  I'd feel better if prune_expire was also
"unsigned long".  We probably should talk about making them all
time_t at some point but not right now.

I was tempted to say that we might want to teach approxidate
"now" (add one entry to struct special in date.c), but I do not
think it is useful for this application (you want prune_expire
set to zero not the time we run time(NULL)), and I do not think
of any other application that wants "now".
