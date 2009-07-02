From: Nick Woolley <nickwoolley@yahoo.co.uk>
Subject: Re: CVS <--> GIT workflow...
Date: Thu, 02 Jul 2009 13:01:27 +0100
Message-ID: <4A4CA197.5050202@yahoo.co.uk>
References: <ac3d41850907011132q8e19b37ofa10813258a97555@mail.gmail.com>	 <m3d48kw4uz.fsf@localhost.localdomain> <ac3d41850907011425x966483awe1757e24417d9da4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: David Chanters <david.chanters@googlemail.com>
X-From: git-owner@vger.kernel.org Thu Jul 02 14:01:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MMKz4-00013e-RW
	for gcvg-git-2@gmane.org; Thu, 02 Jul 2009 14:01:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754308AbZGBMBL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Jul 2009 08:01:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754417AbZGBMBK
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Jul 2009 08:01:10 -0400
Received: from udon.noodlefactory.co.uk ([80.68.88.167]:51936 "EHLO
	udon.noodlefactory.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754403AbZGBMBJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Jul 2009 08:01:09 -0400
Received: from 87-194-154-6.bethere.co.uk ([87.194.154.6] helo=[192.168.0.100])
	by udon.noodlefactory.co.uk with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <nickwoolley@yahoo.co.uk>)
	id 1MMKyU-0004Et-FO; Thu, 02 Jul 2009 13:01:10 +0100
User-Agent: Thunderbird 2.0.0.22 (X11/20090608)
In-Reply-To: <ac3d41850907011425x966483awe1757e24417d9da4@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122639>

Hi,

David Chanters wrote:
> So what would I do?  Something like this:
> 
> 1.  Use git-cvsimport to "convert" a snapshot of the current CVS
> project to something Git can understand.
> 2.  Checkout this git project via git clone in the usual way.
> 3,  Hack away in this Git clone.
> 4.  Use git-cvsexportcommit to extract commits?
> 

I don't think step 2 is needed, since git-cvsimport imports into a local .git
repository that you can work with directly.  A read-only copy of all the
imported CVS commits go into the git repository, within a "remote" whose name
you need to specify with git-cvsimport's -r parameter.  I normally use "-r cvs
-o cvshead", which will import CVS's HEAD onto remotes/cvs/cvshead and BRANCHX
onto remotes/cvs/BRANCHX.

> What about my workflow within the Git repository?  I assume that
> "Master" would be the branch I would want to merge *to* if I have
> local topic brances I wish to have in to CVS, and then the commits on
> Master would be something git-cvsexportcommit would look at?
>
> Indeed, it seems git-cvsexportcommit is somewhat "manual" -- is there
> no way of automating that to say something like:  "Take all commits on
> branch $FOO in Git, which aren't in CVS, and apply them?"   I might be
> missing some understanding here.

Yes, git-cvsexportcommit has to be told explicitly which commits to export.  It
will only check that they seem to be sane, in that they will apply cleanly.

Currently I presume everyone has to roll their own solution to this.  In my
case, with the absence of any available prior art, I wrote a wrapper script, in
an attempt to simplify the process to 'git-cvs push' and 'git-cvs pull'.  See my
earlier post to this list:

 http://article.gmane.org/gmane.comp.version-control.git/120351

This works for me for basic day-to-day interaction with my CVS repository, which
has over a year's work in it, although there are times when I still need to
manually intervene.

If you do try it I'd be interested hear how  well it works, especially if it
means I can improve it. Currently it doesn't have a lot of documentation besides
what's in the script itself,  but if I could be encouraged to write more if
asked nicely.



Note, you probably also want a step 5 before cycling back to step 3: use
git-cvsimport to incrementally import your exported commits back into git.  If
this succeeds, git-cvsimport will also merge the remote CVS branch with your
local one - like this, where c' and d' are the re-imported copies of commits c
and d which come via CVS:

 a-b----c'-d'    <- e.g. remotes/cvs/cvshead
    \       \
     c-d-----e-  <- e.g. master

I find that merge loops in the history like this make it hard to get the list of
exports to commit next time.

i.e. After adding some more commits to master:

 a-b----c'-d'      <- remotes/cvs/cvshead
    \       \
     c-d-----e-f-g <- master

Then you want to commit f and g.  But:

  git rev-list master..remotes/cvs/cvshead

Will return c, d, e, f, g.  So instead I typically add this to step 5:

  git reset --hard remotes/cvs/cvshead

Which discards c, d and e, leaving:

 a-b-c'-d'      <- remotes/cvs/cvshead and master

Then you have a clean linear history and future commits to export.  My script
doesn't do this for you, currently, since in the case where there have been
multiple branches merged in before commit e, you might prune away those branches
as well as the duplicate commits on the working branch (i.e. c and d).

(I've just been avoiding this situation rather than fixing it, partly because
I'd not found a better way yet, despite fiddling with various invocations of
git-rebase. So I'd be particularly interested if anyone can suggest one.)

In theory c' and d' should be identical to c and d - although if you haven't set
up an author map for git-cvsimport, you may find that your commits come back
with the username you use in CVS, which may differ from that in git.

In this case, you need to have supplied the -A parameter to git-cvsimport in step 1.



Finally, whatever you use, you'll probably want the latest release of git, since
it has a bug fix for git-cvsexportcommit.  See:

  http://article.gmane.org/gmane.comp.version-control.git/120241


Cheers,

N
