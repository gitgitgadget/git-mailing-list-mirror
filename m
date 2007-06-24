From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: [PATCH] transplant: move a series of commits to a different parent
Date: Sun, 24 Jun 2007 11:05:29 +0200
Message-ID: <4D530871-0CBE-4F9A-99B7-ECF0F4656D85@zib.de>
References: <1BD13366-B4BD-4630-9046-49567A345CBC@zib.de> <11826268772950-git-send-email-prohaska@zib.de> <20070624082906.GB2467@steel.home>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 24 11:04:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I2O1Y-0002uw-Om
	for gcvg-git@gmane.org; Sun, 24 Jun 2007 11:04:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753898AbXFXJEr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 24 Jun 2007 05:04:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753904AbXFXJEr
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Jun 2007 05:04:47 -0400
Received: from mailer.zib.de ([130.73.108.11]:61520 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753898AbXFXJEq (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Jun 2007 05:04:46 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id l5O94ME6011739;
	Sun, 24 Jun 2007 11:04:44 +0200 (CEST)
Received: from [192.168.178.32] (brln-4db104ed.pool.einsundeins.de [77.177.4.237])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id l5O94LNH024482
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Sun, 24 Jun 2007 11:04:22 +0200 (MEST)
In-Reply-To: <20070624082906.GB2467@steel.home>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50781>


On Jun 24, 2007, at 10:29 AM, Alex Riesen wrote:

> Steffen Prohaska, Sat, Jun 23, 2007 21:27:57 +0200:
>> +for commit in $(git-rev-list --reverse $from..$to)
>> +do
>> +    echo "rewriting commit $commit..."
>> +    git-diff-tree -r $commit | grep ^: | cut -b 9-15,57-97,100- |
>> +    while read mode sha path
>> +    do
>> +        echo " $mode $sha $path"
>> +        git-update-index --add --cacheinfo $mode $sha $path
>> +    done
>
> Why not just read-tree for every commit? It is not like you're
> modifying the repository in any way, just changing parenthood. That'd
> solve the problem with deletions.
> So it should be enough to read-tree the repo state for each and every
> source commit into the index (and you can just use a temporary index
> file for that, see GIT_INDEX_FILE). Than just commit the index.

I am changing the repository.

I only modify the index for files that have changes in $commit. Their
content gets replaced by the content from the commit. I'm leaving
all other files untouched.

This creates a new series of commits that starts from the repository
state of <onto> and has mixed in files only if they are changed in
the series of commits from..to. These files are just replaced. I'm not
trying to merge changes but just replace the whole file.

Opposed to that, read-tree would modify the content of _all_ files.


Here's the situation before transplant

           o--Y--3
          /
   1--X--2--o--o--o

Say at X the file x.txt got modified. At Y the file y.txt got modified.
3 has both modifications.

Now I do transplant 1 2 3, which yields

     o--Y--4
    /
   1--X--2--o--o--o

y.txt is identical in 3 and 4 but x.txt is identical in 1 (!) and 4.
Hence 3 and 4 are different. The changes to x.txt in commit X got
eliminated from the history. 4 is a mixture of 1 and the repository
state of files at 3 that got modified between 2 and 3. Changes between
1 and 2 got eliminated from the history.

This is exactly what I want to achieve. The content of the files on
branch 3 is correct for all files that were committed after 2. But
because 2 is the wrong branching point all the content originating
from commits between 1 and 2 is wrong. Files committed between
2 and 3 have the right content but the branch needs to be attached
at 1.

	Steffen
