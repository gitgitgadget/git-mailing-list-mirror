From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [BUG] git-svn dcommit fails (connection closed unexpectedly)
Date: Fri, 18 May 2007 23:14:23 -0700
Message-ID: <20070519061422.GA17528@muzzle>
References: <vpq7irfengj.fsf@bauges.imag.fr> <8c5c35580705110427o4de686e8qdb37f6a2da0043e4@mail.gmail.com> <vpqtzuf46k9.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 19 08:14:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HpID6-0003Hu-V9
	for gcvg-git@gmane.org; Sat, 19 May 2007 08:14:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756312AbXESGO0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 19 May 2007 02:14:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756400AbXESGO0
	(ORCPT <rfc822;git-outgoing>); Sat, 19 May 2007 02:14:26 -0400
Received: from hand.yhbt.net ([66.150.188.102]:59110 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752257AbXESGOZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 May 2007 02:14:25 -0400
Received: from hand.yhbt.net (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id 9242C7DC0A4;
	Fri, 18 May 2007 23:14:23 -0700 (PDT)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Fri, 18 May 2007 23:14:23 -0700
Content-Disposition: inline
In-Reply-To: <vpqtzuf46k9.fsf@bauges.imag.fr>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47723>

Matthieu Moy <Matthieu.Moy@imag.fr> wrote:
> "Lars Hjemli" <lh@elementstorage.no> writes:
> 
> > Is this happening if you dcommit a file in a new directory?
> 
> That's it indeed.
> 
> The attached script seems to reproducibly trigger the problem on my
> box:
> 
> $ ../git-svn-test.sh
> Checked out revision 0.
> A         file
> Adding         file
> Transmitting file data .
> Committed revision 1.
> Initialized empty Git repository in .git/
> moy@localhost's password: 
>         A       file
> r1 = 4357177f2d927931d31c8c49c0237561648001a7 (git-svn)
> 
> Checked out HEAD:
>   svn+ssh://localhost//home/moy/tmp/test/test.26377/svnrepo r1
> Created commit aa2db5a: newdir
>  1 files changed, 1 insertions(+), 0 deletions(-)
>  create mode 100644 newdir/newfile
> moy@localhost's password: 
>         A       newdir/newfile
> Network connection closed unexpectedly: Connection closed unexpectedly at /home/moy/bin/local/verimag/git-svn line 405
> $

Thanks to your script I can reproduce it.
svnserve (not git-svn) is segfaulting on me...

> #! /bin/sh
> 
> mkdir test.$$
> cd test.$$
> 
> svnadmin create svnrepo
> 
> svn co file://$PWD/svnrepo svnco
> 
> cd svnco
> echo content > file
> svn add file
> svn commit -m "added file"
> cd ../
> 
> # This triggers the bug.
> git-svn clone svn+ssh://localhost/$PWD/svnrepo git-svn-co
> 
> # while this doesn't
> # git-svn clone file://localhost/$PWD/svnrepo git-svn-co
> 
> cd git-svn-co
> 
> mkdir newdir
> echo othercontent > newdir/newfile
> 
> git add newdir/newfile
> 
> git commit -m "newdir"
> 
> git-svn dcommit

Thanks.  I didn't realize entirely new directories (and not empty
directories in svn but git thought were new) were what was causing
things to break.

-- 
Eric Wong
