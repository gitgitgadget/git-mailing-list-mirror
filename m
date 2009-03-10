From: Pieter de Bie <pieter@frim.nl>
Subject: Re: BUG: git can't handle certain kinds of renames in merges
Date: Tue, 10 Mar 2009 16:02:05 +0000
Message-ID: <252A6411-2658-4DC6-A7F4-29CA3981F8FB@frim.nl>
References: <81bfc67a0903100745m3a425337h3f4f7cdbde6b5cfe@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v930.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Caleb Cushing <xenoterracide@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 10 17:04:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lh4R4-00081R-FZ
	for gcvg-git-2@gmane.org; Tue, 10 Mar 2009 17:04:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756537AbZCJQCT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Mar 2009 12:02:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755906AbZCJQCQ
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Mar 2009 12:02:16 -0400
Received: from frim.nl ([87.230.85.232]:45885 "EHLO
	lvps87-230-85-232.dedicated.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756780AbZCJQCN (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 10 Mar 2009 12:02:13 -0400
Received: from vpn-070.vpn.net.ed.ac.uk ([129.215.37.70])
	by lvps87-230-85-232.dedicated.hosteurope.de with esmtpsa (TLS-1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.63)
	(envelope-from <pieter@frim.nl>)
	id 1Lh4PB-000496-Jb; Tue, 10 Mar 2009 17:02:09 +0100
In-Reply-To: <81bfc67a0903100745m3a425337h3f4f7cdbde6b5cfe@mail.gmail.com>
X-Mailer: Apple Mail (2.930.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mar 10, 2009, at 2:45 PM, Caleb Cushing wrote:

> git://github.com/xenoterracide/git-test-case.git
>
> clone that. checkout branch 1. then git merge master to see my end  
> failure.
>
> steps to create
>
> add a file in a branch with a line (or more).
> create a new branch based on this branch and check it out.
> in the new branch mv the file into a directory with the same name as
> the file was. add -u and add the file so git sees the rename.
> checkout the original branch add some lines. checkout the new branch
> merge. the merge will go fine.
> remove a line from the new branches file.
> checkout master. add another line to that file.
> checkout new branch and attempt to merge.
>
> you should now see the point that may test case is at.

Yes, this is because automatic renaming detection fails
with this kind of toy examples. Git can't infer the file
was renamed because almost nothing is similar enough. Take
a look at the attached script and run it with 'sh test.sh'
and 'sh test.sh real_test', and look at the difference.

- Pieter

#!/usr/bin/bish
if test x$1 = x
then
	EXTRA_LINES=""
else
	EXTRA_LINES="line2\nline3\nline4\nline5"
fi
FILE1="a\n$EXTRA_LINES"
FILE2="a\n$EXTRA_LINES\nb"
FILE3="$EXTRA_LINES\nb"
FILE4="a\n$EXTRA_LINES\nb\nc"

echo -e $FILE2
rm -rf test_dir
mkdir test_dir
cd test_dir
git init

echo -e $FILE1 > file
git add file
git commit -am "Initial"

git checkout -b branch
git mv file a
mkdir file
git mv a file/file
git commit -m "Move"

git checkout master
echo -e $FILE2 > file
git commit -am "Add a line"

git checkout branch
git merge master

echo -e $FILE3 > file/file
git commit -am "Remove line"

git checkout master
echo -e $FILE4 > file
git commit -am "Add another line"

git checkout branch
git merge master
