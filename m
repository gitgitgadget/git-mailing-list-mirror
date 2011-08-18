From: Peter Baumann <waste.manager@gmx.de>
Subject: Re: [PATCH v2] git svn : hook before 'git svn dcommit'
Date: Thu, 18 Aug 2011 11:12:28 +0200
Message-ID: <20110818091228.GB16549@m62s10.vlinux.de>
References: <1313438699-9926-1-git-send-email-frederic.heitzmann@gmail.com>
 <7vty9ijs1i.fsf@alter.siamese.dyndns.org>
 <20110817003023.GA30153@dcvr.yhbt.net>
 <CALeToSWJNK=q4iPwxNvgGin0T61oLKJd=b9F3cSSo0vVebrhhQ@mail.gmail.com>
 <CALeToSUidWgiJ+PxuphnBZOQGNStNOO9==EswfLDpFr2GYy=nA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Eric Wong <normalperson@yhbt.net>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: =?iso-8859-1?Q?Fr=E9d=E9ric?= Heitzmann 
	<frederic.heitzmann@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 18 11:12:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QtyeU-0008T4-KJ
	for gcvg-git-2@lo.gmane.org; Thu, 18 Aug 2011 11:12:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755300Ab1HRJMd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 18 Aug 2011 05:12:33 -0400
Received: from mailout-de.gmx.net ([213.165.64.23]:53498 "HELO
	mailout-de.gmx.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1755199Ab1HRJMc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Aug 2011 05:12:32 -0400
Received: (qmail invoked by alias); 18 Aug 2011 09:12:29 -0000
Received: from m62s10.vlinux.de (EHLO m62s10.vlinux.de) [83.151.21.204]
  by mail.gmx.net (mp053) with SMTP; 18 Aug 2011 11:12:29 +0200
X-Authenticated: #1252284
X-Provags-ID: V01U2FsdGVkX1+hbegAQE+hKUvYMnm17rDieADoU2ZL1a+wud2IBQ
	yEDRERr3cA51Ww
Received: by m62s10.vlinux.de (Postfix, from userid 1000)
	id 76445D4003; Thu, 18 Aug 2011 11:12:28 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <CALeToSUidWgiJ+PxuphnBZOQGNStNOO9==EswfLDpFr2GYy=nA@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179584>

On Wed, Aug 17, 2011 at 04:35:03PM +0200, Fr=E9d=E9ric Heitzmann wrote:
> Hi all.
>=20
> Maybe I should give some more context to explain why a hook could be =
a
> potential improvement.
>=20
> Let's consider the following workflow :
> 1) git svn clone from the SVN server, then git checkout -b topic
> 2) git commit some "reference data", before starting some optimizatio=
n
> or code refactoring.
> ** These reference data are not supposed to find their way to the SVN=
 server **
> Committing such "reference data" is just a convenience because git
> does a great job to show how these data may or may not change during
> the development process.
> 3) hack, test, commit ...
> 3 bis) it may happen that reference data change for some very good
> reason (for instance some protocol change)
> New reference data are then commited.
>=20
> back to 3 ...
>=20
> 4) Before merging back to master and commitng to SVN, it is necessary
> to remove commits with reference data (git rebase -i --onto master
> master topic ...)
> 5) merge topic branch with master and git svn dcommit
>=20
> -- end --
>=20
> It is very easy to forget step 4, and svn commit lots of useless data=
=2E
>=20
> Proposal 1)
> * commit reference data with some specific mark in the commit message
> (e.g. "NO_SVN")
> * use pre-svn-dcommit hook to detect such commits
>=20
> Proposal 2) (not fully feasable for what I know)
> * git svn clone to a bare repo
> * clone a working repo from the the bare repo.
> * steps 2, 3, maybe 3bis, ... then 4
> * push commits to the bare repo, while using pre-receive or update
> hook to look for wrong commits, and abort if so.
> * use post-receive hook to trigger git svn dcommit
>=20
> Main drawback for proposal 2 (appart from needing 2 repo instead of
> one) is that each time you want to update your working=A0 repo, you h=
ave
> to git svn rebase the bare repo, then git pull.
>=20
> Proposal 2bis)
> * add a pre-send hook on the bare repo, and trigger some git svn
> rebase with this hook.
> I am not sure to see all the potential consequences of such a hook th=
ough.
>=20
> All things begin equal, proposal 1 seems to be the easier path, but i=
t
> is highly debatable.
>=20

I have written a local script for exactly the problem you described aft=
er looking
for a git svn dcommit hook I could use (as you did).
I attached it, so feel free to use it. Simply add it to your bin and ru=
n it
with   git dcommit    instead of  git svn dcommit

Pls read the comment for further explanation how this script is used.


#!/bin/bash
# Copyright =A9 Peter Baumann, 2011
#
# Wrapper script around git svn dcommit, which adds some useful functio=
nality
#
# This script will prevent accidentally commiting some commits not yet =
ready
# into SVN. Commits starting with (case insensitive) debug, wip, fixup =
are
# considered not appropriate for putting them into SVN. The main reason=
 for
# this functionality is the specific workflow I use. I always have some=
=20
# internal debug commits (e.g. enhanced debug logging) or simply work i=
n progress
# commits which should never be put into SVN.=20
#
# To avoid putting those into SVN, I rebase all commits so that my WIP/=
DEBUG commits=20
# are on top of the commits ment for SVN.
# Calling this script via "git dcommit" after the rebase makes sure onl=
y commits
# beneath the WIP commits are considered for SVN.=20
# Furthermore, a shortlog of commits ment for SVN is shown and the user=
 has
# to confirm before actually putting them into SVN.
#
# If this script is called via a specific commit (e.g. via its SHA1) as=
 parameter,
# then only commits beneath and including the commit itself are committ=
et to SVN.


SUBDIRECTORY_OK=3DYes

=2E git-sh-setup
require_work_tree
cd_to_toplevel || die "foo"

# Upstream ref
upstream=3Dremotes/trunk

# Stop at this commit
last=3D
if [ ! -z $1 ]; then
	$(git rev-parse $1^{commit})
	echo $last
fi

# The latest git commit we want to commit SVN
commit=3D

# Remembers the original head
orig_head=3D
if branch=3D$(git symbolic-ref -q HEAD)
then
	orig_head=3D${branch#refs/heads/}
else
	orig_head=3D'(detached head)'
fi


function run()
{
	#echo "DEBUG: $@"
	$@
}=09

IFS=3D'
'
for c in $(git log --reverse --pretty=3D"%H %s" HEAD --not "${upstream}=
"); do
	# Split the log output into its fields
	sha1=3D"${c:0:40}"
	msg=3D"${c:41}"

	# Check if the commit subject matches (case insenstive) to one of the
	# following patterns. Leading whitespace is fine
	# 	debug
	#	wip
	#	fixup!
	if echo "$msg"|egrep -i -q '^\s*(debug|wip|fixup)'; then
		break
	fi
	commit=3D${sha1}

	if [ "x${commit}" =3D "x${last}" ]; then
		break
	fi
done


if [ "x${commit}" =3D=3D "x" ]; then
	die "Nothing to commit - Perhaps you have only stuff not ready for SVN=
?"
fi

echo ">>>> Committing the folling GIT commits to SVN <<<<"
git --no-pager log --pretty=3Doneline ${commit} --not "${upstream}"
echo

# Show the latest commit we are going to submit to SVN
#git show ${commit}

echo
echo "Commiting to SVN (y/N)?"
read yesno || die "Aborting"

if [ "x${yesno}" =3D=3D "xy" ] || [ "x$yesno" =3D=3D "xY" ]; then
	run git checkout -q "${commit}" || die "Checkout failed"
	run git svn dcommit || "Aborting - git svn dcommit failed!"

	if [ "${orig_head}" !=3D "(detached head)" ]; then
		echo "DO THIS:"
		run git checkout "${orig_head}" && run git rebase "${upstream}"
	else
		echo "You have started this script being on a detached HEAD."
		echo "Please rebase manually!"
	fi
fi
