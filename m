From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: git-merge oddities (or: how to create a one-parent merge)
Date: Wed, 4 Jun 2008 14:04:11 +0200
Message-ID: <20080604120411.GD2126@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Catalin Marinas <catalin.marinas@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 04 14:07:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K3rjs-0006yk-5w
	for gcvg-git-2@gmane.org; Wed, 04 Jun 2008 14:05:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754411AbYFDMET convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 4 Jun 2008 08:04:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755335AbYFDMET
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Jun 2008 08:04:19 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:3293 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754392AbYFDMES (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Jun 2008 08:04:18 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1K3rit-0001WJ-00; Wed, 04 Jun 2008 13:04:11 +0100
Content-Disposition: inline
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83777>

Consider the following script:

git init
echo foo >> foo
git add foo
git commit -m initial

git checkout -b maint
echo bar >> bar
git add bar
git commit -m "bugfix"

git checkout master
echo foo2 >> foo
git commit -a -m "development"

git checkout -b branch
echo baz >> baz
git add baz
git commit -m "feature"
git merge maint

git checkout master
#git merge maint && git merge branch
#git merge branch && git merge maint
#git merge branch maint

gitk --all

Here we have two branches, "maint" and "branch", that we want to merge
to master. Containment-wise, both master and maint are subsets of
branch:

   o--A           A: master
    \  \          B: maint
     \  \         C: branch
      B--C

If we uncomment the first line, each merge creates a new commit, which
is what we asked for but not what we wanted:

   o--o--o--A
    \  \/  /
     \ /\ /
      B--C

So uncomment the second line instead; now both merges fast-forward,
and all is well.

I thought I could work around the problem of having to merge in the
right order by giving git-merge both branches at once, and having it
realize that a fast-forward will do. And uncommenting the third line,
I indeed see that git-merge has avoided creating a three-parent merge
-- it has correctly realized that maint is a subset of branch.

However, it has also realized that master is a subset of branch, and
skipped that parentage as well. So the resulting merge commit has just
one parent: "branch".

   o--o           A: master
    \  \          B: maint
     \  \         C: branch
      B--C--A

Surely the right thing to do here is to just make it fast-forward to
"branch"?

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
