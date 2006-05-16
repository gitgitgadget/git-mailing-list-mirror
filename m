From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] improve depth heuristic for maximum delta size
Date: Tue, 16 May 2006 16:34:57 -0700
Message-ID: <7vmzdh35ni.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0605132305580.18071@localhost.localdomain>
	<Pine.LNX.4.64.0605151129540.18071@localhost.localdomain>
	<7v4pzqhh3t.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0605161510200.18071@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 17 01:35:09 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fg949-0004Bz-Dc
	for gcvg-git@gmane.org; Wed, 17 May 2006 01:35:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932284AbWEPXe7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 16 May 2006 19:34:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932288AbWEPXe7
	(ORCPT <rfc822;git-outgoing>); Tue, 16 May 2006 19:34:59 -0400
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:25483 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S932284AbWEPXe6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 May 2006 19:34:58 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060516233458.OJSE27967.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 16 May 2006 19:34:58 -0400
To: Nicolas Pitre <nico@cam.org>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20150>

Nicolas Pitre <nico@cam.org> writes:

> This provides a linear decrement on the penalty related to delta depth
> instead of being an 1/x function.  With this another 5% reduction is 
> observed on packs for both the GIT repo and the Linux kernel repo, as 
> well as fixing a pack size regression in another sample repo I have.

Good job, and it does not seem to spend too many more cycles
either (it does slow it down a bit because it needs to do more
deltas, but that is to be expected).

Here is the average chain length and resulting pack size from
full repacking of git.git repository, with three versions.

        Avg 6.20   6516kB (master)
        Avg 5.97   5784kB (next, has 1/x version)
        Avg 6.89   5536kB (this patch on top of next)

What's interesting is that the 1/x version shortens the chain
(i.e. decreased runtime cost) while producing smaller results,
compared to the master version.  The story is the same on the
kernel archive.

	Avg 5.82 113808kB (master)
	Avg 4.76 108044kB (next, has 1/x version)
	Avg 5.81 105768kB (this patch on top of next)
