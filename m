From: Junio C Hamano <junkio@cox.net>
Subject: Re: [RFC PATCH] Add WEBDAV timeout to http-fetch.
Date: Sat, 07 Oct 2006 21:52:02 -0700
Message-ID: <7vbqonpfyl.fsf@assigned-by-dhcp.cox.net>
References: <20061006212616.GA5175@lumumba.uhasselt.be>
	<20061006220542.GA5890@lumumba.uhasselt.be>
	<BAYC1-PASMTP08A34A8FB0703E4D2ABAF9AE130@CEZ.ICE>
	<BAYC1-PASMTP11CF83A008B0B3BA5F6B15AE100@CEZ.ICE>
	<7viriwsa75.fsf@assigned-by-dhcp.cox.net> <eg82tq$2uq$1@sea.gmane.org>
	<Pine.LNX.4.63.0610071930300.14200@wbgn013.biozentrum.uni-wuerzburg.de>
	<20061007223023.GI20017@pasky.or.cz>
	<Pine.LNX.4.63.0610080034490.14200@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Petr Baudis <pasky@suse.cz>,
	Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sun Oct 08 06:52:22 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GWQe5-0005Ad-HN
	for gcvg-git@gmane.org; Sun, 08 Oct 2006 06:52:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750718AbWJHEwH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 8 Oct 2006 00:52:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750789AbWJHEwH
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Oct 2006 00:52:07 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:58053 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S1750718AbWJHEwD (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Oct 2006 00:52:03 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20061008045203.WTYL13992.fed1rmmtao11.cox.net@fed1rmimpo01.cox.net>;
          Sun, 8 Oct 2006 00:52:03 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id Xgru1V00a1kojtg0000000
	Sun, 08 Oct 2006 00:51:55 -0400
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0610080034490.14200@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Sun, 8 Oct 2006 00:36:42 +0200
	(CEST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28520>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Actually, I do not think that anybody in her right mind would set this to 
> different values for different repos or servers.
>
> I _know_ that if I hit that very problem, the next thing I'd do is set the 
> timeout to 5 seconds _globally_.

Let's step back a bit.

The DAV request in question the one to remote_ls() in
http-fetch.c, which tries to read directly from objects/pack/
instead of using objects/info/packs, and it does not matter if
DAV request fails because it would fall back to non-DAV anyway.

Using DAV, if it works with the server, has the advantage of not
having to keep objects/info/packs up-to-date from repository
owner's point of view.  But the repository owner ends up keeping
up-to-date as a side effect of keeping info/refs up-to-date
anyway (as I do not see a code to read that information over
DAV), so there is no point doing this over DAV in practice.

Perhaps we should remove call to remote_ls() from
fetch_indices() unconditionally, not just protected with
NO_EXPAT and be done with it?
