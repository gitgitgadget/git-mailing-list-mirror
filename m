From: Fabien POTENCIER <fabien.potencier@gmail.com>
Subject: A possible subtree split bug
Date: Tue, 31 Jul 2012 13:21:20 +0200
Message-ID: <5017BFB0.9070701@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 31 13:21:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SwAVy-0004MW-Kj
	for gcvg-git-2@plane.gmane.org; Tue, 31 Jul 2012 13:21:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755969Ab2GaLVW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 31 Jul 2012 07:21:22 -0400
Received: from mail-we0-f174.google.com ([74.125.82.174]:62573 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755715Ab2GaLVV convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 31 Jul 2012 07:21:21 -0400
Received: by weyx8 with SMTP id x8so4251102wey.19
        for <git@vger.kernel.org>; Tue, 31 Jul 2012 04:21:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:subject
         :content-type:content-transfer-encoding;
        bh=Vu3i9C7Flgk//UGT6i/yqiwH2MLpGszczSq1jw5nPNo=;
        b=kIRaLEgWFAVPptg6K07b6oUv4qOORSXH2IFijgzs9PJ2Vp2ci8HKarNWbgW2GdqP2A
         gERYztOpm4vfE6jlMmJNF0XWLK/MkMwc3nWGu0PFfE6lud7zBjkrjio06A58ysl7eiKH
         xnl6eMdu3A4nY8y24+72hWEddw21iUTYNXILfn6+q/KOo8CrRkX0DuiSIdI+0wKFZefy
         YX02w219caxq0X9iKpXGvvqRge4EsumaoBe19a+RxHHx/saSlyI/74teOjc0NmLu/Rqm
         SxV+5XDG0748HJtyq8Nnq54sdtXDrluVMJz9K4kOWGvz8u/FF4aWI7r410a65Ba/gBWu
         zRQA==
Received: by 10.180.78.135 with SMTP id b7mr6006828wix.11.1343733680676;
        Tue, 31 Jul 2012 04:21:20 -0700 (PDT)
Received: from Fabiens-MacBook-Air.local (vln78-1-82-238-161-203.fbx.proxad.net. [82.238.161.203])
        by mx.google.com with ESMTPS id bc2sm32005692wib.0.2012.07.31.04.21.19
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 31 Jul 2012 04:21:19 -0700 (PDT)
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.8; rv:14.0) Gecko/20120713 Thunderbird/14.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202645>

Hi all,

I've encountered what I think is a bug in the subtree split command=20
included in contrib.

According to the docs:

"Repeated splits of exactly the same history are
guaranteed to be identical (ie. to produce the same
commit ids).  Because of this, if you add new commits
and then re-split, the new commits will be attached as
commits on top of the history you generated last time..."

But unfortunately, that's not always the case.

I've found that if you have a commit that reverts the previous one and=20
then merge a branch where those two commits did not exist, then the nex=
t=20
time you split, they won't be present anymore in the split tree.

Here is a simple script that exhibits the issue:

#!/bin/sh

git init

# create a directory that is going to be split
mkdir doc
echo "TEST" > doc/README
git add doc
# commit A
git ci -a -m"first version"

# create a branch with a new commit (Z)
git co -b test
echo "TEST" > doc/README1
git add doc/README1
git ci -a -m"added README1"
git co master

# modify the README file (commit B)
echo "TEST_" > doc/README
git ci -a -m"second version"

# revert the change (commit C)
echo "TEST" > doc/README
git ci -a -m"revert second version"

# split
git subtree split --prefix=3D"doc" --branch=3DTARGET

# the log will show the 3 commits as expected (including B and C)
git log --oneline TARGET

# merge the test branch
git merge -m"merged test" test

# re-split
# deleting the target as the bug prevents the split to happen correctly
git branch -D TARGET
git subtree split --prefix=3D"doc" --branch=3DTARGET

# the 2 commits B and C are not in the split anymore
# the split will only show A then Z which is not the expected result
git log --oneline TARGET


=46abien

--=20
=46abien Potencier
Sensio CEO - Symfony lead developer
sensiolabs.com | symfony.com | fabien.potencier.org
T=E9l: +33 1 40 99 80 80
