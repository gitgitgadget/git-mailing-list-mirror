From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: [PATCH] Documentation: update git-pull.txt for clone's new default behavior
Date: Mon, 1 Jan 2007 16:39:06 -0500
Message-ID: <20070101213906.GA23857@fieldses.org>
References: <11676088584199-git-send-email-bfields@fieldses.org> <1167608858759-git-send-email-bfields@fieldses.org> <11676088582634-git-send-email-bfields@fieldses.org> <7vd55zd1nm.fsf@assigned-by-dhcp.cox.net> <7vwt47bjwa.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Shawn Pearce <spearce@spearce.org>,
	Luben Tuikov <ltuikov@yahoo.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Jan 01 22:39:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H1Usb-0007Sc-7V
	for gcvg-git@gmane.org; Mon, 01 Jan 2007 22:39:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932626AbXAAVjK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 1 Jan 2007 16:39:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932573AbXAAVjK
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Jan 2007 16:39:10 -0500
Received: from mail.fieldses.org ([66.93.2.214]:34684 "EHLO
	pickle.fieldses.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932626AbXAAVjJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Jan 2007 16:39:09 -0500
Received: from bfields by pickle.fieldses.org with local (Exim 4.63)
	(envelope-from <bfields@fieldses.org>)
	id 1H1Us6-0006tJ-PY; Mon, 01 Jan 2007 16:39:06 -0500
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vwt47bjwa.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35745>

On Sun, Dec 31, 2006 at 05:44:37PM -0800, Junio C Hamano wrote:
> How about doing this?  The difference this time around is that
> if you have non-wildcard refspec listed first, which usually
> is the case for people with established git workflow with
> existing repositories, we use the old-and-proven rule to
> merge the first set of refs.  An earlier round botched this
> completely by basing the logic on lack of branch.*.merge,
> which broke for many people.

Updated man page assuming that change; does this look any better?

--b.

[PATCH] Documentation: update git-pull.txt for new clone behavior

Update examples, stop using branch named "origin" as an example.
Remove large example of use of remotes; that particular case is
nicely automated by default, so it's not so pressing to explain, and
we can refer to git-repo-config for the details.

Signed-off-by: "J. Bruce Fields" <bfields@citi.umich.edu>
---
 Documentation/git-pull.txt |   69 ++++++++++++++++----------------------------
 1 files changed, 25 insertions(+), 44 deletions(-)

diff --git a/Documentation/git-pull.txt b/Documentation/git-pull.txt
index 2a5aea7..13be992 100644
--- a/Documentation/git-pull.txt
+++ b/Documentation/git-pull.txt
@@ -37,17 +37,27 @@ EXAMPLES
 --------
 
 git pull, git pull origin::
-	Fetch the default head from the repository you cloned
-	from and merge it into your current branch.
-
-git pull -s ours . obsolete::
-	Merge local branch `obsolete` into the current branch,
-	using `ours` merge strategy.
+	Update the remote-tracking branches for the repository
+	you cloned from, then merge one of them into your
+	current branch.  Normally the branch merged in is
+	the HEAD of the remote repository, but the choice is
+	determined by the branch.<name>.remote and
+	branch.<name>.merge options; see gitlink:git-repo-config[1]
+	for details.
+
+git pull origin next::
+	Merge into the current branch the remote branch `next`;
+	leaves a copy of `next` temporarily in FETCH_HEAD, but
+	does not update any remote-tracking branches.
 
 git pull . fixes enhancements::
 	Bundle local branch `fixes` and `enhancements` on top of
 	the current branch, making an Octopus merge.
 
+git pull -s ours . obsolete::
+	Merge local branch `obsolete` into the current branch,
+	using `ours` merge strategy.
+
 git pull --no-commit . maint::
 	Merge local branch `maint` into the current branch, but
 	do not make a commit automatically.  This can be used
@@ -61,48 +71,19 @@ release/version name would be acceptable.
 Command line pull of multiple branches from one repository::
 +
 ------------------------------------------------
-$ cat .git/remotes/origin
-URL: git://git.kernel.org/pub/scm/git/git.git
-Pull: master:origin
-
 $ git checkout master
-$ git fetch origin master:origin +pu:pu maint:maint
-$ git pull . origin
+$ git fetch origin +pu:pu maint:tmp
+$ git pull . tmp
 ------------------------------------------------
 +
-Here, a typical `.git/remotes/origin` file from a
-`git-clone` operation is used in combination with
-command line options to `git-fetch` to first update
-multiple branches of the local repository and then
-to merge the remote `origin` branch into the local
-`master` branch.  The local `pu` branch is updated
-even if it does not result in a fast forward update.
-Here, the pull can obtain its objects from the local
-repository using `.`, as the previous `git-fetch` is
-known to have already obtained and made available
-all the necessary objects.
-
-
-Pull of multiple branches from one repository using `.git/remotes` file::
+This updates (or creates, as necessary) branches `pu` and `tmp`
+in the local repository by fetching from the branches
+(respectively) `pu` and `maint` from the remote repository.
 +
-------------------------------------------------
-$ cat .git/remotes/origin
-URL: git://git.kernel.org/pub/scm/git/git.git
-Pull: master:origin
-Pull: +pu:pu
-Pull: maint:maint
-
-$ git checkout master
-$ git pull origin
-------------------------------------------------
+The `pu` branch will be updated even if it is does not
+fast-forward; the others will not be.
 +
-Here, a typical `.git/remotes/origin` file from a
-`git-clone` operation has been hand-modified to include
-the branch-mapping of additional remote and local
-heads directly.  A single `git-pull` operation while
-in the `master` branch will fetch multiple heads and
-merge the remote `origin` head into the current,
-local `master` branch.
+The final command then merges the newly fetched `tmp` into master.
 
 
 If you tried a pull which resulted in a complex conflicts and
@@ -112,7 +93,7 @@ gitlink:git-reset[1].
 
 SEE ALSO
 --------
-gitlink:git-fetch[1], gitlink:git-merge[1]
+gitlink:git-fetch[1], gitlink:git-merge[1], gitlink:git-repo-config[1]
 
 
 Author
-- 
1.5.0.rc0.gac28
