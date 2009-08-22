From: Nicolas Pitre <nico@cam.org>
Subject: git fetch --depth=* broken?
Date: Sat, 22 Aug 2009 01:52:01 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0908220106470.6044@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Aug 22 07:52:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MejWU-0001qI-6S
	for gcvg-git-2@lo.gmane.org; Sat, 22 Aug 2009 07:52:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933135AbZHVFwJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Aug 2009 01:52:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933104AbZHVFwI
	(ORCPT <rfc822;git-outgoing>); Sat, 22 Aug 2009 01:52:08 -0400
Received: from relais.videotron.ca ([24.201.245.36]:14419 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932778AbZHVFwH (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Aug 2009 01:52:07 -0400
Received: from xanadu.home ([66.130.28.92]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0KOR009FSKAPFF90@VL-MH-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Sat, 22 Aug 2009 01:52:01 -0400 (EDT)
X-X-Sender: nico@xanadu.home
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126797>


try out:

	git clone --depth=1 git://git.kernel.org/pub/scm/git/git
	cd git
	git fetch --depth=2

It then silently fails, except for the return code of 1.

With -v this is the same result.  Only if I remove --depth= do I get:

>From git://git.kernel.org/pub/scm/git/git
 = [up to date]      html       -> origin/html
 = [up to date]      maint      -> origin/maint
 = [up to date]      man        -> origin/man
 = [up to date]      master     -> origin/master
 = [up to date]      next       -> origin/next
 = [up to date]      pu         -> origin/pu
 = [up to date]      todo       -> origin/todo

and a return code of 0.

It seems that commit c6bc400585 is partly responsible for that 
misbehavior.  At least reverting it makes the status list appear again 
even with the presence of --depth=.

But still, actual result isn't any better.  Using --depth=2 or 
--depth=1000 doesn't change anything, unless there is _also_ a ref that 
was updated on the remote end.  Looks like the code is happy to conclude 
that there is nothing to do if local refs match remote refs and never go 
to talk further to the remote end ("no "shallow ..." nor "deepen ..." 
are sent over the wire) despite the fact that --depth=1000 would 
certainly have to trigger a pack transfer.

I'm also surprised that such thing as simple deepening of a repo is not 
in the test suite.  We certainly document this operation in the 
git-fetch man page though.

The code in builtin-fetch-pack.c still looks rather confusing to me, so 
hopefully you are more familiar with it and can provide a fix.


Nicolas
