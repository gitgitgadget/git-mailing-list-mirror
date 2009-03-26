From: Wincent Colaiuta <win@wincent.com>
Subject: Re: Test that every revision builds before pushing changes?
Date: Thu, 26 Mar 2009 10:59:59 +0100
Message-ID: <35F1F494-E496-4126-92CC-79FD241D7BF3@wincent.com>
References: <87myb8aja1.fsf@rimspace.net> <49CB39E5.5060000@op5.se> <87ljqs7ioz.fsf@rimspace.net> <20090326094900.GC14292@coredump.intra.peff.net>
Mime-Version: 1.0 (Apple Message framework v930.3)
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Daniel Pittman <daniel@rimspace.net>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Mar 26 11:01:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LmmPA-0004NU-L5
	for gcvg-git-2@gmane.org; Thu, 26 Mar 2009 11:01:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755097AbZCZKAO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 26 Mar 2009 06:00:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754951AbZCZKAN
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Mar 2009 06:00:13 -0400
Received: from wincent1.inetu.net ([209.235.192.161]:40206 "EHLO
	wincent1.inetu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753042AbZCZKAM convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 26 Mar 2009 06:00:12 -0400
Received: from cuzco.lan (179.pool85-53-16.dynamic.orange.es [85.53.16.179])
	(authenticated bits=0)
	by wincent1.inetu.net (8.13.8/8.13.8) with ESMTP id n2Q9xx0q013958
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Thu, 26 Mar 2009 06:00:01 -0400
In-Reply-To: <20090326094900.GC14292@coredump.intra.peff.net>
X-Mailer: Apple Mail (2.930.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114766>

El 26/3/2009, a las 10:49, Jeff King escribi=F3:

> On Thu, Mar 26, 2009 at 08:10:52PM +1100, Daniel Pittman wrote:
>
>> For example, the responsible person for that testing could use the
>> hypothetical (until someone tells me where to find it):
>>
>>    git test public..test make test
>>
>> Which would then effectively wrap:
>>
>>    for each revision between public and private:
>>         git checkout revision
>>         make test
>>         # report if that fails, allow fixing the commit or whatever
>>         # then 'git test continue' to carry on...
>>
>> That turn the process from a manual one to an automated one: it runs
>> that command for every revision until it fails, or until they all =20
>> pass.
>
> I don't think such a script exists. There are continuous integration
> systems that support git, but I don't know if they actually check =20
> every
> commit.

It shouldn't be too hard to put together a script that does exactly =20
what you want.

A couple of years ago I whipped up a simple script (see below) to test =
=20
all the commits on a topic branch before submitting them upstream.

It's designed for that specific case, and I'm neither a shell nor a =20
plumbing expert, but it worked for my simple workflow at least.

Cheers,
Wincent

die () {
   echo "$1"
   exit 1
}

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
# (note: may be more appropriate to use "git merge-base" here)
echo "On branch $BRANCH"
echo "Commits to be checked:"
git rev-list --pretty=3Doneline HEAD ^$REMOTE/$MERGE
for COMMIT in $(git rev-list HEAD ^$REMOTE/$MERGE); do
   echo "Checking $COMMIT"
   git checkout $COMMIT
   make clean
   make test || die "Commit $COMMIT is bad (make test failed)"
done

echo "All revisions passed!"
