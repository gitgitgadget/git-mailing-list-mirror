From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] fsck --lost-found: write blob's contents, not their
 SHA-1
Date: Sun, 22 Jul 2007 22:52:28 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707222246220.14781@racer.site>
References: <Pine.LNX.4.64.0707222120100.14781@racer.site>
 <7vodi4qfnx.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jul 22 23:52:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ICjM6-00046b-RY
	for gcvg-git@gmane.org; Sun, 22 Jul 2007 23:52:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759382AbXGVVwn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 22 Jul 2007 17:52:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758640AbXGVVwn
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Jul 2007 17:52:43 -0400
Received: from mail.gmx.net ([213.165.64.20]:56696 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757760AbXGVVwl (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Jul 2007 17:52:41 -0400
Received: (qmail invoked by alias); 22 Jul 2007 21:52:39 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp040) with SMTP; 22 Jul 2007 23:52:39 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19ZZbs88gZZxWlcPP/eVAY3Js0XSQR2/uvjm68cEh
	34ZHXGUXY6SACB
X-X-Sender: gene099@racer.site
In-Reply-To: <7vodi4qfnx.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53331>

Hi,

On Sun, 22 Jul 2007, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > When looking for a lost blob, it is much nicer to be able to grep
> > through .git/lost-found/other/* than to write an inefficient loop
> > over the file names.  So write the contents of the dangling blobs,
> > not their object names.
> 
> I think this is an idea to solve a good problem, but if we go
> this route, the need for us to worry about expiring lost-found
> entries would become more urgent, I suspect.

Why?  AFAICT lost+found/ has to be cleaned by people.  So if you look for 
something, you say "git fsck --lost-found", and once you found it, it's 
time for "rm -rf .git/lost-found".

> And when you think about expiring lost-found entries, another
> possible solution emerges.  If we teach git-prune to remove the
> corresponding entry from lost-found/other when it removes a
> loose blob from the object store, then we can easily and safely
> do this instead:
> 
> 	$ cat .git/lost-found/other/* |
> 	  xargs -r git grep 'the word to look for'

Well, it is not only for grepping.  In my case, I could get away by this:

$ ls -lrt $(grep -l filter_subdir .git/lost-found/other/* |
	sed "s/^.*other\/\(..\)/.git\/objects\/\1\//") 

IOW I found the loose dangling objects which matched a keyword, and sorted 
them by time.

In other cases, though, I wanted to see the size.

But what the whole thing boils down to: After finding dangling objects, 
you are much more likely using git tools on non-blobs than on blobs, and 
vice versa.

Ciao,
Dscho

P.S.: I fully forgot to mention that happily, I did "git add -u" sometime 
before "git reset --hard", otherwise I would have been lost.
