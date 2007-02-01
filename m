From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: newbie questions about git design and features (some wrt hg)
Date: Thu, 1 Feb 2007 08:28:04 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0702010814470.3632@woody.linux-foundation.org>
References: <3c6c07c20701300820l42cfc8dbsb80393fc1469f667@mail.gmail.com>
 <200702010058.43431.jnareb@gmail.com> <20070201003429.GQ10108@waste.org>
 <200702010157.51452.jnareb@gmail.com> <45C19DD0.20504@fs.ei.tum.de>
 <Pine.LNX.4.63.0702011108430.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <45C1BDD3.8050103@fs.ei.tum.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: "Simon 'corecode' Schubert" <corecode@fs.ei.tum.de>
X-From: git-owner@vger.kernel.org Thu Feb 01 17:32:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HCeqt-0004cD-Tc
	for gcvg-git@gmane.org; Thu, 01 Feb 2007 17:32:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751892AbXBAQby (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 1 Feb 2007 11:31:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751916AbXBAQby
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Feb 2007 11:31:54 -0500
Received: from smtp.osdl.org ([65.172.181.24]:48384 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751892AbXBAQbx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Feb 2007 11:31:53 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l11GSE9V026973
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 1 Feb 2007 08:28:15 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l11GS5fl016313;
	Thu, 1 Feb 2007 08:28:10 -0800
In-Reply-To: <45C1BDD3.8050103@fs.ei.tum.de>
X-Spam-Status: No, hits=-0.436 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.111__
X-MIMEDefang-Filter: osdl$Revision: 1.172 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38369>



On Thu, 1 Feb 2007, Simon 'corecode' Schubert wrote:
>
> > So, can you explain to me how a filename is _not_ a file-id?
> 
> It is not a file-id like other SCM use it (I think monotone, not sure though).
> If you copy/move the content to a new name, the ID will not stay the same.
> Just see it as a hash bucket which allows you easy access to the history for a
> file currently with this name.

Well, that's actually just another "file ID" too. It's just not an "inode 
number" kind of file ID, it's more the "CVS file ID" kind of ID.

SVN uses "inode numbers" (I think they are just UUID's generated at "svn 
add" time, but I'm not sure) to track file ID's across renames. Some other 
SCM's do the same.

CVS uses "pathname" as the file ID (which obviously doesn't need any 
separate generation at all), which is why you have to do horrible things 
to track file ID's across renames (ie you really can't, but you *can* copy 
or move the *,v file so that your *new* "file ID" also has the same 
history as your old one).

So both of those are "file ID's" - they are what is used to index into the 
history, and they have real meaning for very fundamental operations.

You can view git as "closer" to CVS, in the sense that it certainly 
doesn't have the SVN kind of location-independent ID, and it _is_ able to 
look back in history using the path-name. So in that sense, you can 
certainly claim that the pathname is the "file ID" in git too, and that 
git is closer to CVS than to SVN.

But unlike SVN or CVS, there is no real fundamental "meaning" to the 
pathname in git. Sure, you can use the pathname to trace history of a 
file, but on the other hand, you can use a random aggregation of pathnames 
to track history of a set of files and directories, and the pathnames 
actually exist even when the file doesn't. So there obviously isn't any 
1:1 relationship, neither in usage, nor in any internal implementation.

So at least for me, "file ID" means "identifier for a particular chain of 
history". THAT exists in both CVS and SVN (it's a pathname and an "inode 
number" respectively), but does not exist in git at all.

			Linus
