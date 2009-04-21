From: Jeff King <peff@peff.net>
Subject: Re: correct git merge behavior or corner case?
Date: Mon, 20 Apr 2009 22:44:33 -0400
Message-ID: <20090421024433.GC14479@coredump.intra.peff.net>
References: <4ac8254d0904191540j68246cd8qa36a034209d4c800@mail.gmail.com> <alpine.DEB.1.00.0904201148150.6955@intel-tinevez-2-302> <41354.bFoQE3daRhY=.1240222235.squirrel@webmail.hotelhot.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Tuncer Ayaz <tuncer.ayaz@gmail.com>, git@vger.kernel.org
To: Anders Melchiorsen <mail@cup.kalibalik.dk>
X-From: git-owner@vger.kernel.org Tue Apr 21 04:46:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lw5zw-0000SE-5c
	for gcvg-git-2@gmane.org; Tue, 21 Apr 2009 04:46:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751696AbZDUCoj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Apr 2009 22:44:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751192AbZDUCoi
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Apr 2009 22:44:38 -0400
Received: from peff.net ([208.65.91.99]:60302 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750931AbZDUCoi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Apr 2009 22:44:38 -0400
Received: (qmail 6095 invoked by uid 107); 21 Apr 2009 02:44:45 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Mon, 20 Apr 2009 22:44:45 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 20 Apr 2009 22:44:33 -0400
Content-Disposition: inline
In-Reply-To: <41354.bFoQE3daRhY=.1240222235.squirrel@webmail.hotelhot.dk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117078>

On Mon, Apr 20, 2009 at 12:10:35PM +0200, Anders Melchiorsen wrote:

> I think that I managed to recreate what he is describing.
> 
> 
> #!/bin/bash
> 
> cd $(mktemp -d repo.XXXXX)
> 
> git init
> 
> touch date
> git add date
> git commit -memptydate
> 
> git branch parallel
> 
> touch LICENSE
> git add LICENSE
> git commit -mLICENSE
> 
> git checkout parallel
> date >date
> git add date
> git commit -mdate
> 
> git checkout master
> git rm date
> git commit -mnodate
> 
> git merge parallel
> 
> cat LICENSE

So basically one branch removes a file and adds an identical file under
a different name, while the other branch modifies the original file. Git
detects it as a rename, and applies the change from the second branch to
the newly added file instead of generating a conflict.

This is _exactly_ what git's rename detection is designed to do. Yes, it
seems horribly confusing in this toy example, but that is because it is
a toy example: both 'date' and 'LICENSE' are empty files. But with real
files, if a source file has actual content but is deleted, there is a
new filename with the identical or near-identical content, and the patch
applies to the new content without conflicts, then applying it there is
probably exactly what you want.

The only complaint I have in that example is that there is nothing
indicating to the user that the patch was applied to a renamed version.
The output I get is:

  $ git merge parallel
  Merge made by recursive.
   LICENSE |    1 +
   1 files changed, 1 insertions(+), 0 deletions(-)

Perhaps a note indicating that it applied changes for "date" to
"LICENSE" would be helpful.

-Peff
