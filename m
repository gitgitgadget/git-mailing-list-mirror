From: Junio C Hamano <junkio@cox.net>
Subject: git merge (resolve) _is_ stupid
Date: Mon, 31 Jul 2006 01:44:58 -0700
Message-ID: <7v7j1u88ol.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Jul 31 10:45:13 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G7TOb-0002re-0A
	for gcvg-git@gmane.org; Mon, 31 Jul 2006 10:45:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932068AbWGaIpA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 31 Jul 2006 04:45:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751349AbWGaIpA
	(ORCPT <rfc822;git-outgoing>); Mon, 31 Jul 2006 04:45:00 -0400
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:5569 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S1751332AbWGaIo7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Jul 2006 04:44:59 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.5.203])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060731084459.BTEN27857.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 31 Jul 2006 04:44:59 -0400
To: git@vger.kernel.org
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24502>

While dealing with Jakub's gitweb changes, I found that merge we
use _is_ very stupid.  Perhaps it is not a surprise...

My "next" was at 688a750, and "master" was at b63fafd.  I had
already merged gitweb changes from Luben to "master" at this
point, and "next" was in sync with "master" with respect to
gitweb/, i.e. this gave empty:

	$ git diff master next gitweb/

Jakub's gitweb changes were stored in jn/web branch which
contained 16 patches on top of "master".

However, pulling "jn/web" (594e212) into "next" using resolve
strategy produced interesting conflicts.  Essentially, it said
that some changes done by Luben (which has already merged to
"master" and precedes what Jakub did in "jn/web") conflict with
what "jn/web" does, which is quite bogus.

This merge has three merge-bases, but

	$ git log master..next -- gitweb/

shows only two merges, and that is not so surprising given that
at this point gitweb/ files are identical between master and
next.

More interestingly, if I merge "master" to "next" first and then
merge "jn/web" on top of the result, the resolve strategy does
the right thing.  This is understandable -- by merging "master"
into "next", merge base between "next" and "jn/web" becomes
"master" and nothing else.

Using recursive strategy resolved this merge correctly, taking
gitweb/ files from "jn/web" branch.

By the way, the "recur" strategy in "next" produces the correct
result, but it produces a funny error in the middle (that is why
Johannes is CC'ed).

	error: Could not read 0100000000000000000000000000000000000000

: gitster; git merge -s recur 'test merge' next jn/web
Merging next with 594e212bc849039a204deef1d16c2eddcc451532
Merging:
688a75071490101dbc660e3304aafb7a13e28807 Merge branch '__/setup-n-mv' into next
594e212bc849039a204deef1d16c2eddcc451532 gitweb: Ref refactoring - use git_get_referencing for marking tagged/head commits
found 3 common ancestor(s):
7061cf0f205e86613c3a3306fdfedf2a5dcc8a65 Merge branch 'lt/setup' into __/setup-n-mv
acb0f6f33760b43c1fc9617a45346ab3738f021a gitweb.cgi: git_blame2: slight optimization reading the blame lines
2d023581c9a0ae5efdebfd0084d54d09669a25d5 Set datarootdir in config.mak.in
  Merging:
  7061cf0f205e86613c3a3306fdfedf2a5dcc8a65 Merge branch 'lt/setup' into __/setup-n-mv
  acb0f6f33760b43c1fc9617a45346ab3738f021a gitweb.cgi: git_blame2: slight optimization reading the blame lines
  found 1 common ancestor(s):
  634331061599a82968daddae2d2c0896b6137d4c gitweb.cgi: Centralize printing of the page path
  Auto-merging gitweb/gitweb.cgi
  Merging:
  virtual merged tree
  2d023581c9a0ae5efdebfd0084d54d09669a25d5 Set datarootdir in config.mak.in
error: Could not read 0100000000000000000000000000000000000000
  found 1 common ancestor(s):
  7b8cf0cf2973cc8df3bdd36b9b36542b1f04d70a Rename man1 and man7 variables to man1dir and man7dir
  Auto-merging .gitignore
  Auto-merging INSTALL
  Auto-merging Makefile
Auto-merging Makefile
Merge made by recur.
 Documentation/git-tar-tree.txt |    5 
 Makefile                       |    3 
 git.c                          |   76 ++---
 gitweb/gitweb.cgi              |  609 +++++++++++++++++-----------------------
 setup.c                        |    4 
 5 files changed, 300 insertions(+), 397 deletions(-)
