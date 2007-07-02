From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: challenges using fast-import and svn
Date: Mon, 2 Jul 2007 18:24:00 -0400
Message-ID: <20070702222400.GB4495@spearce.org>
References: <7154c5c60707021226k3a7b82fcl7558cfc66d61dde@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: David Frech <nimblemachines@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 03 00:24:17 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I5UJX-00006D-V8
	for gcvg-git@gmane.org; Tue, 03 Jul 2007 00:24:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756573AbXGBWYI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 2 Jul 2007 18:24:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756223AbXGBWYH
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Jul 2007 18:24:07 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:53606 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756002AbXGBWYG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Jul 2007 18:24:06 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.66)
	(envelope-from <spearce@spearce.org>)
	id 1I5UJF-0000KP-5a; Mon, 02 Jul 2007 18:23:53 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 1224320FBAE; Mon,  2 Jul 2007 18:24:00 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <7154c5c60707021226k3a7b82fcl7558cfc66d61dde@mail.gmail.com>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51417>

David Frech <nimblemachines@gmail.com> wrote:
> So I wrote, in Lua, a parser for the (terrible) svn dump file format
> that feeds commands into fast-import. The parser took a day and a half
> to write; the fast-import backend took about an hour. ;-)

Heh.  That's about what most folks say.  ;-)
 
> However, there are issues. I don't currently track branch copies
> correctly, so branches start out with no history, rather than the with
> the history of the branch they are copied from; and handling deletes
> is tricky.

Branches are easy to create from the right branch in fast-import,
but its hard with the SVN dump file to know where it starts from.

One trick folks have used in the past is to assign a mark in
fast-import for each SVN revision.  Marks are very cheap and make
it easy to reference a commit in a from command when you need to
make a new branch.  You can just use the SVN revision number you
get from the SVN dump file.

> Here is the problem: if a file or directory is deleted in svn, the
> dumpfile shows simply this:
> 
> Node-path: trunk/project/file-or-directory
> Node-action: delete
> 
> In the case of a file, I can simply feed a "D" command to fast-import;
> but if I'm deleting a whole directory, my code knows nothing about
> what files exist in that directory. Is fast-import smart about this?
> Will it barf if given a directory argument rather than a file for "D"
> commands?

I just read the code again.  You can delete an entire subdirectory
just by sending a D command for that subdirectory, assuming you
don't end the name with a '/'.  So you should be able to just do:

  D file-or-directory

and whatever file-or-directory is, it goes away.  If you were to
send a trailing '/':

  D file-or-directory/

its likely bad things will happen because fast-import will try to
remove the file or directory named "" (yes, empty string) in the
subdirectory called "file-or-directory" but leave the subdirectory.


Another option is you can replace a tree with a file at any point in
time, without first deleting it.  So you could also just overwrite
the entire subdirectory with an empty file via the M command, then
delete the file.  But that shouldn't be necessary as the D command
should already do exactly what you want it to do.  Internally
the "replace entire directory with single file" is the same
implementation as the "delete entire directory" implementation...


So I guess this means a documentation update for the D command
would be a good idea?

> I could cache the directory contents in my code, but isn't that partly
> what fast-import is good for?

Yes.  fast-import is really quite good at helping you do Git side
of the equation.  ;-)

-- 
Shawn.
