From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: Trying to sync two svn repositories with git-svn (repost)
Date: Thu, 14 May 2009 02:35:18 -0400
Message-ID: <32541b130905132335t3cbd0e7wf29577ee15ba0bac@mail.gmail.com>
References: <20090502215852.GJ15420@raven.wolf.lan> <20090504211423.GK15420@raven.wolf.lan> 
	<20090506185224.GM15420@raven.wolf.lan> <32541b130905061223h7efddeecvcc52a369093a6b50@mail.gmail.com> 
	<20090506225042.GN15420@raven.wolf.lan> <32541b130905081344m634a78d5l984f4903ec1515eb@mail.gmail.com> 
	<20090508235821.GO15420@raven.wolf.lan> <20090513120922.GP15420@raven.wolf.lan> 
	<32541b130905131028i5c4b1a31j7f760f8157507df6@mail.gmail.com> 
	<20090513222243.GQ15420@raven.wolf.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Josef Wolf <jw@raven.inka.de>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 14 08:36:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M4UXq-0001B4-Dz
	for gcvg-git-2@gmane.org; Thu, 14 May 2009 08:35:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761808AbZENGfj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 14 May 2009 02:35:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761718AbZENGfj
	(ORCPT <rfc822;git-outgoing>); Thu, 14 May 2009 02:35:39 -0400
Received: from yx-out-2324.google.com ([74.125.44.28]:40829 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761677AbZENGfi convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 14 May 2009 02:35:38 -0400
Received: by yx-out-2324.google.com with SMTP id 3so633940yxj.1
        for <git@vger.kernel.org>; Wed, 13 May 2009 23:35:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:content-type
         :content-transfer-encoding;
        bh=LF72v64F07KBmB0MNrqH2kw+jZjsHnjwESENAAkAtv4=;
        b=uf3GsWBKQP5jSz3YE+dmLxskY2dWo+iHCP1AVjSc1Af+x1W78g7AxOU91L6iKVrSTR
         9YYHxwdXL+UuH1Z30r1LxFpY4CnRL8FUzLYdv4S1A/O225u6OI0pOFsIAWu0I+JD5O7m
         OBS6NYjXOpSm/NjgBqArB5XFthOUfcT2GpXU8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :content-type:content-transfer-encoding;
        b=YAnAtrYtZHrTobE9ca7CuuKQF/wWYRMVadkLDskoENsYZkMD4H1R9+le3QprhLVVJ0
         JK4firIYkJhPPJrqQWr7i7Nv/Zn258MXBkNNhzCZ7224L0JPX8sBmRBciIw3uapsPYmV
         p8y2oveM1nVFExVFXl6v17gYi6YltvCn1BDKI=
Received: by 10.151.129.4 with SMTP id g4mr2956568ybn.153.1242282938050; Wed, 
	13 May 2009 23:35:38 -0700 (PDT)
In-Reply-To: <20090513222243.GQ15420@raven.wolf.lan>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119151>

On Wed, May 13, 2009 at 6:22 PM, Josef Wolf <jw@raven.inka.de> wrote:
> Thanks for your patience, Avery! =A0I would be completely lost here w=
ithout
> your help..

Okay, well, I think I've been making things worse instead of better :(

=46undamentally, my claim that merging symmetrically between two svn
branches "ought to be easy" was incorrect.  The problem is that when
git does a merge from branch A to B and then back to A, it really
*really* wants the two branches to end up identical.  All of git's
merge machinery works on the assumption that this is what you want.

Now, you can still bypass this by using various clever tricks.  The
solution we were working with turned out to be *almost* right, and I
did get it working in my test environment, but it got so convoluted
that I couldn't even explain to myself why it was correct.  That's
usually a bad sign.  So I threw that one away.

By far the sanest thing you could possibly do is to create a central
"public" branch that contains all the common commits, then merge from
that public branch to the site-specific branches, but never merge in
the opposite direction.  In case you happen to make some changes on
the site-specific branches that you want to share, you can just
cherry-pick them; the resulting conflicts when merging back are likely
to be fairly minor.  This would be entirely consistent with git's
normal operations, and would be easy:

   git checkout public
   git cherry-pick stuff   # as rarely as possible; do the work
directly on public if you can

   git checkout svn-1
   git merge --no-ff public
   git svn dcommit

   git checkout svn-2
   git merge --no-ff public
   git svn dcommit

No criss-cross merges, no insanity, no question about whether it's corr=
ect.

More as an academic exercise than anything, I did find a way that will
let you do criss-cross merging of all changes on A and B.  I still
don't *really* recommend you use it, because it's extremely error
prone, and there are lots of places where you could get merge
conflicts and then end up in trouble.  (The above simple method, in
contrast, might get conflicts sometimes, but you can just fix them as
you encounter them and be done with it.)

The script below demonstrates how to take branches remote-ab and
remote-ac, and auto-pick their changes (as they happen) into a new
(automatically managed) branch public.  Then it merges public back
into each branch, while avoiding conflicts.  The magic itself happens
in extract() and crossmerge().

If nothing else, this method makes the gitk output far more sane than
the original method.  This is because it doesn't include the history
of 'public' in the site-specific branches.  That was the fundamental
flaw in the method I had identified originally.  You can trick that
original method into working too, but it's stunningly complex.  This
is much more sane, albeit still not really sane.

Enjoy!

Have fun,

Avery

P.S. Sorry for the mess.  I suppose I should have broken down and
written (or asked for :)) a minimal test case earlier, as it quickly
revealed the problem.


#!/bin/bash -x
set -e
rm -rf tt
mkdir tt
cd tt
git init

count=3D100
newfile()
{
	count=3D$(($count + 1))
	echo $count >$1
	git add $1
	git commit -m "$1"
}

newfile .gitignore
git checkout -b public
newfile a
git checkout -b remote-ab public
newfile b
git checkout -b remote-ac public
newfile c

# We've simulated two remote branches (perhaps svn repositories), remot=
e-ab
# and remote-ac.  They contain one identical file (a) and one different=
 file
# (b vs. c).  We've arranged for the common part to end up in 'public'.

git tag -f remote-ab-lastmerge remote-ab
git tag -f remote-ac-lastmerge remote-ac

extract()
{
	last_public=3D"$(git merge-base $1-lastmerge public)"
	if false; then
		# use this if you want each patch separately
		git branch -f $1-public $1
		git checkout $1-public
		git rebase --onto "$last_public" $1-lastmerge
	else
		# use this if you want changes squashed into one patch
		git branch -f $1-public "$last_public"
		git checkout $1-public
		git diff --binary $1-lastmerge $1 -- | git apply --index
		(
			echo "merged from $1"
			echo
			git log $1-lastmerge..$1
		) | git commit -F -
	fi
=09
	git checkout $1
	git merge -s ours -m 'no-op' $1-public
}

crossmerge()
{
	branches=3D"remote-ab remote-ac"
=09
	for b in $branches; do
		# extract the most recent changes from $b-lastmerge..$b
		# The changes can be found as public..$b-public
		extract $b
	=09
		# Merge those completed changes into public
		git checkout public
		git merge $b-public
		git branch -d $b-public
		git tag -f $b-lastmerge $b  # to reduce problems if this script dies
halfway through
	done
=09
	# merge changes from public back into each branch.
	# changes that originated in each branch won't be re-merged, because
	# we already merged back $b-public into each $b.
	for b in $branches; do
		git checkout $b
		git merge --no-ff public
		git tag -f $b-lastmerge $b
	done
}

iterate()
{
	# Some changes have arrived in the remote repos:
	#git svn fetch ab
	#git svn fetch ac
	git checkout remote-ab
	newfile x$1
	git checkout remote-ac
	newfile y$1

	crossmerge
}

iterate 1
git tag remote-ab-1 remote-ab
git tag remote-ac-1 remote-ac

iterate 2
git tag remote-ab-2 remote-ab
git tag remote-ac-2 remote-ac

iterate 3

gitk --all
