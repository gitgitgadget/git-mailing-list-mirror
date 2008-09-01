From: "Theodore Ts'o" <tytso@mit.edu>
Subject: git gc can require using a *huge* amount of space
Date: Sun, 31 Aug 2008 21:22:18 -0400
Message-ID: <E1KZy7W-00023U-UN@closure.thunk.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 01 03:23:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KZy8d-0007oQ-Kw
	for gcvg-git-2@gmane.org; Mon, 01 Sep 2008 03:23:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753020AbYIABWY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 Aug 2008 21:22:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752989AbYIABWY
	(ORCPT <rfc822;git-outgoing>); Sun, 31 Aug 2008 21:22:24 -0400
Received: from www.church-of-our-saviour.org ([69.25.196.31]:44793 "EHLO
	thunker.thunk.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752894AbYIABWW (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Aug 2008 21:22:22 -0400
Received: from root (helo=closure.thunk.org)
	by thunker.thunk.org with local-esmtp   (Exim 4.50 #1 (Debian))
	id 1KZy7Y-0004ZR-8G; Sun, 31 Aug 2008 21:22:20 -0400
Received: from tytso by closure.thunk.org with local (Exim 4.69)
	(envelope-from <tytso@mit.edu>)
	id 1KZy7W-00023U-UN; Sun, 31 Aug 2008 21:22:19 -0400
Full-Name: Theodore Ts'o
Phone: (781) 391-3464
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@mit.edu
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94522>


One of the things which I noticed which can be a bit of a misfeature is
if you are trying to save disk space by running "git gc", it can
sometimes take *substantially* more disk space.  For example, I ran "git
reflog --all --expire=0 --expire-unreachable=0" on a repository that had
linux-next as one of its remotes.  Before I ran "git gc --prune" the
repository was packed, and its .git/objects was a bit over 50 megs
(there was an alternates file).  While I was running the "git gc", it
was busy ejecting all of the objects that were no longer reachable
separate files, and the size of .git/objects ballooned to over 200 megs,
before settling in at 150 megs or so after "git gc" completed.  After I
ran "git prune", the size of .git/objects shrank back down to 48 megs.

That kind of swing in disk usage seems a bit excessive....  maybe
instead of pushing out all of the no-longer-reachable objects into
separate files, they could be put in a separate pack file (which the
user could then delete much more quickly than it would take "git prune"
to run)?

     	     	      	   	       	     - Ted
