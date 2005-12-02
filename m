From: linux@horizon.com
Subject: Re: More merge questions (why doesn't this work?)
Date: 2 Dec 2005 04:19:46 -0500
Message-ID: <20051202091946.1631.qmail@science.horizon.com>
References: <7vek4xsx49.fsf@assigned-by-dhcp.cox.net>
Cc: junkio@cox.net, linux@horizon.com
X-From: git-owner@vger.kernel.org Fri Dec 02 10:20:58 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ei75G-00063j-VY
	for gcvg-git@gmane.org; Fri, 02 Dec 2005 10:20:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750966AbVLBJT6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 2 Dec 2005 04:19:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751772AbVLBJT6
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Dec 2005 04:19:58 -0500
Received: from science.horizon.com ([192.35.100.1]:11313 "HELO
	science.horizon.com") by vger.kernel.org with SMTP id S1750966AbVLBJT5
	(ORCPT <rfc822;git@vger.kernel.org>); Fri, 2 Dec 2005 04:19:57 -0500
Received: (qmail 1632 invoked by uid 1000); 2 Dec 2005 04:19:46 -0500
To: git@vger.kernel.org
In-Reply-To: <7vek4xsx49.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13110>

I was playing with the implications of the "deleted file in the
index is not a conflict" merge rule, and came up with the following
octopus test which fails to work.  Note line 2 when choosing a
directory to run it in!

#!/bin/bash -xe
rm -rf .git
git-init-db
echo "File A" > a
echo "File B" > b
echo "File C" > c
git-add a b c
git-commit -a -m "Octopus test repository"

git-checkout -b a
echo "Modifications to a" >> a
git-commit -a -m "Modified file a"

git-checkout -b b master
echo "Modifications to b" >> b
git-commit -a -m "Modified file b"

git-checkout -b c master
rm c
git-commit -a -m "Deleted file c"

git-checkout master
#git merge --no-commit "" master c b a
#git merge --no-commit "" master a b c
git-rev-parse a b c > .git/FETCH_HEAD
git-octopus

(Commented out are the first few things I tried.)
Can someone tell me why this doesn't work?  It should be a simple
in-index merge.

Right after the incomplete merge (I hacked this into the
git-octopus script), git-ls-files -s produces

100644 8fb437b77759c7709c122fbc8ba43f720e1fbc0a 0       a
100644 b3418f25da4393974aa205e2863f012e5b503369 0       b
100644 df78d3d51c369e1d2f1eadb73464aadd931d56b4 1       c
100644 df78d3d51c369e1d2f1eadb73464aadd931d56b4 2       c

Which should be case 10 of the t/t1000-read-tree-m-3way.sh
table and succeed.




Other things I've discovered...

1) The MAJOR difference between "git checkout" and "git reset --hard"
   are that git-checkout takes a *head* as an argument and changes the
   .git/HEAD *symlink* to point to that head (ln -sf refs/heads/<head>
   .git/HEAD).  "git reset" takes a *commit* (<rev>) as an argument and
   changes the head that .git/HEAD points to to have that commit as its
   hew tip (git-rev-parse <rev> > .git/HEAD)

   All the other behavioural differences are relatively minor, and
   appropriate for this big difference.

2) Don't use "git branch" to create branches, unless you really
   *don't* want to switch to them.  Use "git checkout -b".

3) Dumb question: why does "git-commit-tree" need "-p" before the
   parent commit arguments?  Isn't just argv[2]..argv[argc-1]
   good enough?

4) If the "git-read-tree" docs for "--reset", does "ignored" mean
   "not overwritten" or "overwritten"?

5) The final "error" message on "git-merge --no-commit" is a bit
   alarming for a newbie who uses it because they don't quite trust
   git's enough to enable auto-commit.  And it should be changed
   from ""Automatic merge failed/prevented; fix up by hand" to
   "fix up and commit by hand".
   Or how about:
   "Automatic commit prevented; edit and commit by hand."
   which actually tells the truth.

6) The "pickaxe" options are being a bit confusing, and the fact they're
   only documented in cvs-migration.txt doesn't help.

7) The git-tag man page could use a little better description of -a.
