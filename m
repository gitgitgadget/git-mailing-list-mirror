From: Wincent Colaiuta <win@wincent.com>
Subject: Re: How to split a patch
Date: Mon, 28 Jan 2008 11:44:28 +0100
Message-ID: <E8308544-2613-463D-8277-5C1B40709A7B@wincent.com>
References: <4d8e3fd30801280105g2876cedfjbe1ba323ede57e0a@mail.gmail.com> <7vhcgyuwsx.fsf@gitster.siamese.dyndns.org> <4d8e3fd30801280132k59676921h272addab6cac6899@mail.gmail.com> <vpqfxwi5ljf.fsf@bauges.imag.fr> <7vy7aatfck.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v915)
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>,
	"Paolo Ciarrocchi" <paolo.ciarrocchi@gmail.com>,
	"git mailing list" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 28 11:45:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JJRUS-0005Bc-T8
	for gcvg-git-2@gmane.org; Mon, 28 Jan 2008 11:45:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755397AbYA1Kox convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 28 Jan 2008 05:44:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754668AbYA1Kox
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Jan 2008 05:44:53 -0500
Received: from wincent.com ([72.3.236.74]:37290 "EHLO s69819.wincent.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755156AbYA1Kov convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 28 Jan 2008 05:44:51 -0500
Received: from cuzco.lan (localhost [127.0.0.1])
	(authenticated bits=0)
	by s69819.wincent.com (8.12.11.20060308/8.12.11) with ESMTP id m0SAiTN1023137;
	Mon, 28 Jan 2008 04:44:30 -0600
In-Reply-To: <7vy7aatfck.fsf@gitster.siamese.dyndns.org>
X-Mailer: Apple Mail (2.915)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71876>

El 28/1/2008, a las 11:27, Junio C Hamano escribi=F3:

> Matthieu Moy <Matthieu.Moy@imag.fr> writes:
>
>> "Paolo Ciarrocchi" <paolo.ciarrocchi@gmail.com> writes:
>>
>>> Yes it helps but I still wonder whether thereis a "simpler" way to =
=20
>>> achive that.
>>> Is it possible to split a patch selecting the hunk in git gui or an=
y
>>> other graphical
>>> tool?
>>
>> You can apply the patch without commiting it, and them make several
>> partial commits, by right-click "stage hunk for commit" in git-gui.
>
> Yes, and you can do the same with "git add -i".  These tools are
> not quite nice, as they encourage a wrong workflow of committing
> what you haven't had as a whole in the work tree.  By
> definition, you are making untested commits between your base
> commit (that presumably was tested well) and your final commit
> (that would also be tested well).

And as another alternative, seeing as Git is so easy to script, it is =20
trivial to make a script that checks out all the commits in a series =20
and runs the test suite against them. This of course assumes that you =20
have a test suite!

=46or example, this is the script that I use on a topic branch before =20
submitting the corresponding patch series. It's one of the first =20
scripts for Git that I wrote, so it is probably a bit na=EFve, but it =20
works in the basic case. Basically bails if "make clean && make test" =20
doesn't work for any commit in the series.

I've used this on the series that I've sent to the Git mailing list, =20
but you can use it internally on your local projects too before =20
merging topic branches.

Cheers,
Wincent

#!/bin/sh -e
#
# check-series.sh
# Check all commits in a topic branch before submission
#
# Created by Wincent Colaiuta on 23 November 2007.
# Copyright 2007 Wincent Colaiuta.

#
# Functions
#

die () {
   echo "$1"
   exit 1
}

#
# Main
#

git diff --quiet || die "Unstaged changes; won't start"
git diff --cached --quiet || die "Staged changes; won't start"

# parse HEAD (something like "ref: refs/heads/my_local_branch") to get =
=20
remote and merge
GIT_DIR=3D$(git rev-parse --git-dir)
TOPIC=3D"$GIT_DIR/HEAD"
test -f "$TOPIC" || die "No HEAD found at '$TOPIC'"
BRANCH_REF=3D$(< "$TOPIC")
if [ "${BRANCH_REF%%: */*}" !=3D "ref" ]; then
   die "expected HEAD '$BRANCH_REF' to be of the form 'ref: .../...'"
fi
BRANCH=3D${BRANCH_REF##*/}
REMOTE=3D$(git config branch.$BRANCH.remote) || die "failed to get =20
branch.$BRANCH.remote"
MERGE=3D$(git config branch.$BRANCH.merge) || die "failed to get branch=
=2E=20
$BRANCH.merge"
MERGE=3D${MERGE##*/}

# remember which branch we were on prior to starting
trap 'git checkout $BRANCH' exit

# will check all commits in topic branch not present in origin
echo "On branch $BRANCH"
echo "Commits to be checked:"
git rev-list --pretty=3Doneline HEAD ^$REMOTE/$MERGE
for COMMIT in $(git rev-list HEAD ^$REMOTE/$MERGE); do
   echo "Checking $COMMIT"
   git checkout $COMMIT
   make clean
   make test || die "Commit $COMMIT is bad"
done

echo "All revisions passed!"
