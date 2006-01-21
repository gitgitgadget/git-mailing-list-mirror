From: Junio C Hamano <junkio@cox.net>
Subject: What is in git.git
Date: Sat, 21 Jan 2006 00:03:12 -0800
Message-ID: <7v3bjiuhxb.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sat Jan 21 09:03:24 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F0DiP-0004rL-2Q
	for gcvg-git@gmane.org; Sat, 21 Jan 2006 09:03:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751124AbWAUIDO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 21 Jan 2006 03:03:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751126AbWAUIDO
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Jan 2006 03:03:14 -0500
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:16040 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S1751124AbWAUIDO (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Jan 2006 03:03:14 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060121080159.PWLD6244.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 21 Jan 2006 03:01:59 -0500
To: git@vger.kernel.org
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14986>

The "bind commit" experiments for subproject support is coming
along rather nicely.  Near the tip of the "pu" branch, there
are:

 - read-tree --prefix;
 - write-tree --prefix and write-tree --exclude;
 - commit-tree --bind;
 - fsck-objects and convert-objects that understand "bind" lines
   in commit objects;
 - rev-list --objects that understand "bind" lines
   in commit objects;

I think the first four are more-or-less well debugged.

I am reasonably confident that I did not break rev-list for
repositories without "bind" commits, but I have no clue how
correct it is when dealing with commits with "bind" lines.  This
is the last major remaining piece of the puzzle, and the rest is
just the matter of scripting.  I'd be sending out a request for
help on the rev-list in a separate message.

There still is no barebone Porcelainish work done using these
changes.  The attached script demonstrates a superproject that
binds two subprojects with their own development histories.

-- >8 --
#!/bin/sh
rm -fr .git
git init-db
: >main
for i in 1 2
do
	echo "Version #$i of primary subproject" >main
	git add main
	git commit -a -m "`cat main`"
	git tag main-$i
done
git branch main
rm -f .git/refs/heads/master .git/index

mkdir dir
: >sub1
: >dir/sub2
for i in A B C
do
	echo "subproject sub1 ($i)" >sub1
	echo "subproject dir/sub2 ($i)" >dir/sub2
	git add sub1 dir/sub2
	git commit -a -m "subproject #$i"
	git tag subpro-$i
done
git branch subpro
rm -fr dir sub1 main
rm -f .git/refs/heads/master .git/index

git read-tree main-1
git read-tree --prefix=sub/ subpro-A
toptree=`git write-tree`
topcommit=$(echo "Initial top commit" |
git commit-tree $toptree \
	--bind `git rev-parse --verify main-1` / \
	--bind  `git rev-parse --verify subpro-A` sub/)
echo $topcommit >.git/refs/heads/master
git tag top-1A

git read-tree main-1
git read-tree --prefix=sub/ subpro-B
toptree=`git write-tree`
topcommit=$(echo "Second top commit" |
git commit-tree $toptree \
	-p `git rev-parse --verify top-1A` \
	--bind `git rev-parse --verify main-1` / \
	--bind  `git rev-parse --verify subpro-B` sub/)
echo $topcommit >.git/refs/heads/master
git tag top-1B

git read-tree main-2
git read-tree --prefix=sub/ subpro-C
toptree=`git write-tree`
topcommit=$(echo "Third top commit" |
git commit-tree $toptree \
	-p `git rev-parse --verify top-1B` \
	--bind `git rev-parse --verify main-2` / \
	--bind  `git rev-parse --verify subpro-C` sub/)
echo $topcommit >.git/refs/heads/master
git tag top-2C

git log

git rev-list --objects top-1A..top-2C |
git name-rev --tags --stdin
