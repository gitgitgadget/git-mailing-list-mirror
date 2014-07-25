From: David Besen <david.besen@hp.com>
Subject: Re: Amending merge commits?
Date: Fri, 25 Jul 2014 22:11:02 +0000 (UTC)
Message-ID: <loom.20140726T001014-124@post.gmane.org>
References: <22F01493C523F940B4B5E53BB6D0F5352275F207@G5W2738.americas.hpqcorp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 26 00:15:14 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XAnlh-0002ic-Aq
	for gcvg-git-2@plane.gmane.org; Sat, 26 Jul 2014 00:15:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752017AbaGYWPH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 25 Jul 2014 18:15:07 -0400
Received: from plane.gmane.org ([80.91.229.3]:44632 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751506AbaGYWPG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jul 2014 18:15:06 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1XAnlX-0002aF-QS
	for git@vger.kernel.org; Sat, 26 Jul 2014 00:15:04 +0200
Received: from zcce02cs1745-db20.houston.hp.com ([15.203.233.79])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 26 Jul 2014 00:15:03 +0200
Received: from david.besen by zcce02cs1745-db20.houston.hp.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 26 Jul 2014 00:15:03 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 15.203.233.79 (Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/36.0.1985.125 Safari/537.36)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254270>

Besen, David <david.besen <at> hp.com> writes:

>=20
>=20
> Hi folks,
>=20
> I think one of my coworkers has stumbled on a git bug -- if you amend=
 a=20
merge commit, and then pull, your amends
> are lost.
>=20
> Is this expected behavior?
>=20
> I've reproduced the problem in a script (attached).=C2=A0 I ran it ag=
ainst a=20
couple of versions of git (1.7.1,
> 1.7.9, 1.8.4, 2.0.0) and in each case it seemed to lose the amend.
>=20
> - Dave
>=20
>=20
> Attachment (amend-merge.sh): application/octet-stream, 1061 bytes


Whoops, accidentally encoded the script, here it is inline:

#!/bin/bash

set -ex

if [ -z "$GIT" ]; then GIT=3Dgit; fi
GIT_MERGE_AUTOEDIT=3Dno

# Clean up from the last run
rm -rf repo.git repo repo2 || :

# Set up a bare "remote" repo
$GIT init --bare repo.git

# Check out the "remote" repo
$GIT clone repo.git repo

# Add a commit
cd repo
echo "file" > file.txt
$GIT add file.txt
$GIT commit -m "Add file.txt"
$GIT push origin master

# Make a branch
$GIT checkout -b mybranch

# Add a commit on the branch
echo "mybranch" >> file.txt
$GIT add .
$GIT commit -m "Add 'mybranch' line"

# Go back to master
$GIT checkout master

# Merge in mybranch to create a merge commit
$GIT merge --no-ff mybranch

# Push that back
$GIT push

# Amend the merge commit
echo "amended" >> file.txt
$GIT add .
$GIT commit -C HEAD --amend

cd ..

# Make a second checkout
$GIT clone repo.git repo2
cd repo2

# Add some unrelated changes to be pulled
echo "repo2" > file2.txt
$GIT add .
$GIT commit -m "Add file2"
$GIT push

cd ..
cd repo

# Pull
$GIT pull --rebase

# Now, we expect the text "amended" to be in file.txt
grep amended file.txt
