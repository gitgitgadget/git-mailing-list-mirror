From: Junio C Hamano <junkio@cox.net>
Subject: Re: cvsimport woes
Date: Mon, 06 Mar 2006 21:34:39 -0800
Message-ID: <7vek1e6cnk.fsf@assigned-by-dhcp.cox.net>
References: <44094618.6070404@asianetindia.com>
	<46a038f90603060124h4ea1c3c6gaa5d8b52ed311230@mail.gmail.com>
	<46a038f90603060137o758ea7ch6c40652ad86a102a@mail.gmail.com>
	<440C68B9.9030305@asianetindia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Matthias Urlichs <smurf@smurf.noris.de>
X-From: git-owner@vger.kernel.org Tue Mar 07 06:34:57 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FGUqN-0004B6-EW
	for gcvg-git@gmane.org; Tue, 07 Mar 2006 06:34:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750846AbWCGFen (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 7 Mar 2006 00:34:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751027AbWCGFen
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Mar 2006 00:34:43 -0500
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:38298 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S1750846AbWCGFem (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Mar 2006 00:34:42 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060307053154.TORB17006.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 7 Mar 2006 00:31:54 -0500
To: Rajkumar S <rajkumars@asianetindia.com>
In-Reply-To: <440C68B9.9030305@asianetindia.com> (Rajkumar S.'s message of
	"Mon, 06 Mar 2006 22:22:09 +0530")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17321>

I've run your reproduction recipe and also looked at #git log
from yesterday.

Here is what I see immediately after the initial cvs import:

$ git show-branch
* [master] Initial revision
 ! [origin] Initial revision
  ! [start] Imported sources
---
  + [start] Imported sources
*++ [master] Initial revision

And here is what I get immediately after the second one:

$ git show-branch
* [master] v2.0
 ! [origin] v2.0
  ! [start] Imported sources
---
*+  [master] v2.0
  + [start] Imported sources
*++ [master^] Initial revision
$ git diff --cached --abbrev -r
:100644 100644 b8b933b... e251870... M  file.txt
:100644 100644 b8b933b... e251870... M  file1.txt

I think what is happening is that cvsimport updates origin and
master branch HEAD without updating the working tree.  I am not
sure what the cvsimport command line you used is intended to do:

	git cvsimport -v -k -u -m -d $CVSROOT -C git/ src

Specifically, what branch, if any, is used as the "tracking
branch" (i.e. stores the unmodified copy from CVS)?  I presume
it is "origin", in which case, I would have expected to see
something like this instead.

$ git show-branch
* [master] Initial revision
 ! [origin] v2.0
  ! [start] Imported sources
---
 +  [origin] v2.0
  + [start] Imported sources
*++ [master^] Initial revision
$ git diff --cached --abbrev -r
(empty)

Then I would understand what cvsimport author means by "it does
not do fast forward, you have to do it yourself".  What it means
is that the import only updates the tracking branch but does not
update your working tree; merging the updates to the tracking
branch made from the foreign SCM into your working branch is
left for you to perform whenever it is convenient for you to do
(meaning, you may have some intermediate change in your master
branch in which case you would first commit them first and then
merge from CVS).  And if that is they way cvsimport is intended
to be used, then you would at this point do:

$ git pull . origin

to do the fast forward.

I do not understand what cvsimport is trying to do here; I
_suspect_ the part that updates the "master" branch head might
be a bug.

Smurf, mind clarifying what is happening here for me please?
