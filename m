From: bdowning@lavos.net (Brian Downing)
Subject: Re: git cvsimport branches not consistent with CVS branches
Date: Sun, 8 Jul 2007 00:45:20 -0500
Message-ID: <20070708054520.GD4087@lavos.net>
References: <46903396.1010507@heydon.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Gordon Heydon <gordon@heydon.com.au>
X-From: git-owner@vger.kernel.org Sun Jul 08 07:45:38 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I7PaU-0005ad-6H
	for gcvg-git@gmane.org; Sun, 08 Jul 2007 07:45:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751667AbXGHFpb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 8 Jul 2007 01:45:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751747AbXGHFpb
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Jul 2007 01:45:31 -0400
Received: from gateway.insightbb.com ([74.128.0.19]:13684 "EHLO
	asav10.insightbb.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751610AbXGHFpa (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Jul 2007 01:45:30 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Ah5FAL0WkEZKhvbzR2dsb2JhbACBTIVdiAIBAT8B
Received: from 74-134-246-243.dhcp.insightbb.com (HELO mail.lavos.net) ([74.134.246.243])
  by asav10.insightbb.com with ESMTP; 08 Jul 2007 01:45:29 -0400
Received: by mail.lavos.net (Postfix, from userid 1000)
	id 9DC75309F31; Sun,  8 Jul 2007 00:45:20 -0500 (CDT)
Content-Disposition: inline
In-Reply-To: <46903396.1010507@heydon.com.au>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51862>

On Sun, Jul 08, 2007 at 10:45:10AM +1000, Gordon Heydon wrote:
> After some investigation I found that git cvsimport was not importing 
> branches 100% correctly with CVS.
> 
> Git and CVS do branching very differently in that CVS this is done at 
> the file level (like everything else) and git does it repository wide.
> 
> So if I have a CVS repository with the files a, b and c and I branch b 
> with a `cvs tab -b BRANCH test` on the branch test I will just have the 
> file b.
> 
> If I do a git cvsimport on the test branch there will actually be the 
> files a, b and c
> 
> What I think needs to happen is that when git cvsimport created the 
> branch in the git repository it needs to delete all files from the 
> branch that were not branched.

I've been vaguely working on Yet Another CVS Importer (an incremental
one; both git-cvsimport (thanks to cvsps) and tailor take about ten
minutes and a gigabyte of RAM to figure out that nothing has to happen
with my repository.  I think I can do better than that).

In thinking about this case, I think I've decided that you want an
option on what to do here.  For some repositories you're not going to
care about having extra files with the tag, and would greatly prefer
that to having to create a branch for each and every tag (assuming you
can arrange to have the correct files present otherwise; this isn't
always possible.)

For other cases, you really only want to get the subset of the files
that are tagged.  For this, I think the best arrangement would be to
make your branch, then make a commit that only deletes the files that
are not present in the CVS branch, as you said.  Then immediately make
an empty commit to the mainline (wherever you branched from) merging
from the deletion commit.  Then proceed to commit normally to the
branch.  This way, if a user chooses to merge from the branch in Git,
it won't try to delete a bunch of files in the target branch.  (I'm
having a hard time coming up with a situation where you'd want that
behavior assuming the missing files were never tagged in CVS.  A sane
usage pattern would be to tag the whole repository then "cvs rm" the
files you don't want otherwise...)

A fun third case is when a file in CVS doesn't have a branch tag,
but then you go and "cvs add" a file with the same name in a branch.
What CVS does then is to place the branch tag off the current HEAD.
I /think/ you can detect this situation by noticing that the date of
the HEAD revision and the date of the "file was created on branch ..."
revision are exactly the same.  You really need to detect this case,
because when this happens there is no real parent relationship between
the branch and the branch point.  Since CVS has that "wait for a second
to tick" delay at the end this might even be safe.  Sigh.

Don't get me started about the abomination that is vendor branches.

I /hate/ CVS.

-bcd
