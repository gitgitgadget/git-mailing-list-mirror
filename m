From: Claudia.Ignat@loria.fr
Subject: Re: Octopus merge
Date: Wed, 09 Dec 2009 16:10:22 +0100
Message-ID: <4B1FBDDE.60803@loria.fr>
References: <4B0EA512.1050001@loria.fr> <4B0EB257.8080002@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>,
	Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Wed Dec 09 16:10:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NIOBU-0003Vl-FI
	for gcvg-git-2@lo.gmane.org; Wed, 09 Dec 2009 16:10:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753437AbZLIPKT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Dec 2009 10:10:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752869AbZLIPKT
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Dec 2009 10:10:19 -0500
Received: from mail1-relais-roc.national.inria.fr ([192.134.164.82]:45029 "EHLO
	mail1-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752099AbZLIPKR (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 9 Dec 2009 10:10:17 -0500
X-IronPort-AV: E=Sophos;i="4.47,368,1257116400"; 
   d="scan'208";a="41687130"
Received: from coockie.loria.fr (HELO [152.81.12.125]) ([152.81.12.125])
  by mail1-relais-roc.national.inria.fr with ESMTP; 09 Dec 2009 16:10:22 +0100
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
In-Reply-To: <4B0EB257.8080002@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134973>

Michael and Thomas, thank you for your explanations. The fact that in 
some cases octopus merge fails, but changes of the first merges subparts 
of octopus merge are included in the worktree rests a dilemma.

Further, I have noticed that for the same conflicting changes the 
conflict messages (referring to conflict types) received in the case of 
an octopus merge are not the same as the conflict messages received for 
the corresponding sequential merges.

I slightly changed the scenario I described in my previous message.

Workspaces ws2, ws3 and ws4 are clones of the workspace ws1. Suppose the 
current workspace is ws3 and some changes are done in parallel in all 
these 3 workspaces. Changes of ws2 and ws3 are conflicting: both modify 
the same line of file file1.txt to different values and they rename the 
same file file2.txt to fileWS2.txt and fileWS3.txt respectively. Changes 
in ws4 are not conflicting with changes in ws2 and ws3.

While I am in the current workspace ws3 I perform the merge

git merge ws2

and content conflict in file1.txt as well as rename/rename conflict are 
signaled.

If instead I perform the merge

git merge ws4 ws2

only the content conflict  in file1.txt is raised, while the conflict 
rename/rename of file2.txt is not mentioned.

The script for the second mentioned scenario is given below.

Do you think this should be the normal behavior of octopus merge?

Thanks.
Cheers,
Claudia

# !/bin/bash

TEST_NAME="TP1" # name of the working directory
rm -rf ${TEST_NAME} # cleaning working directory
mkdir -p ${TEST_NAME}
cd ${TEST_NAME}

# initialising initial git workspace
mkdir ws1
cd ws1
git init

# adding 2 files to ws1
# commit changes
echo -e -n "1\n2\n3\n4\n5\n" > file1.txt
echo -e -n "a\nb\nc\nd\ne\n" > file2.txt
git add file1.txt file2.txt
git commit -m "ws1 | add 12345 in file1.txt; add abcde in file2.txt"
cd ..

# cloning three times ws1 (as ws2, ws3 and ws4)
git clone ws1 ws2
git clone ws1 ws3
git clone ws1 ws4

# updating file1.txt in ws2 (insert X at line 3, then write and quit 'ed')
# rename file2.txt to fileWS2.txt
# commit changes
cd ws2
echo -e "3i\nX\n.\nw\nq\n" | ed file1.txt
git add file1.txt
git mv file2.txt fileWS2.txt
git commit -m "ws2 | insert 12X345 in file1.txt; rename file2.txt to 
fileWS2.txt"
cd ..


# updating file1.txt in ws3 (insert Y at line 3, then write and quit 'ed')
# rename file2.txt to fileWS3.txt
# commit changes
cd ws3
echo -e "3i\nY\n.\nw\nq\n" | ed file1.txt
git add file1.txt
git mv file2.txt fileWS3.txt
git commit -m "ws3 | insert 12Y345 in file1.txt; rename file2.txt to 
fileWS3.txt"
cd ..

# add file u.txt in ws4
cd ws4
echo -e -n "U1\n2\n3\n4\n5\n" >  u.txt
git add u.txt
git commit -m "ws4 | add u.txt"
cd ..

# ws3 pull from ws2 ws4
cd ws3
git remote add bws2 ../ws2
git remote add bws4 ../ws4
git fetch bws2
git fetch bws4
git merge bws4/master bws2/master
cd ..



Michael J Gruber wrote:
> Claudia.Ignat@loria.fr venit, vidit, dixit 26.11.2009 16:56:
>> # !/bin/bash
>> TEST_NAME="TP1" # name of the working directory
>> rm -rf ${TEST_NAME} # cleaning working directory
>> mkdir -p ${TEST_NAME}
>> cd ${TEST_NAME}
>>
>> # initialising initial git workspace
>> mkdir ws1
>> cd ws1
>> git init
>>
>> # adding a file to ws1
>> # commit changes
>> echo -e -n "1\n2\n3\n4\n5\n" > file.txt
>> git add file.txt
>> git commit -m "ws1 | add 12345"
>> cd ..
>>
>> # cloning three times ws1 (as ws2, ws3 and ws4)
>> git clone ws1 ws2
>> git clone ws1 ws3
>> git clone ws1 ws4
>> git clone ws1 ws5
>>
>> # updating file.txt in ws2 (insert X at line 3, then write and quit 'ed')
>> # commit changes
>> cd ws2
>> echo -e "3i\nX\n.\nw\nq\n" | ed file.txt
>> git add file.txt
>> git commit -m "ws2 | insert 12X345"
>> cd ..
>>
>>
>> # updating file.txt in ws3 (insert Y at line 3, then write and quit 'ed')
>> # commit changes
>> cd ws3
>> echo -e "3i\nY\n.\nw\nq\n" | ed file.txt
>> git add file.txt
>> git commit -m "ws3 | insert 12Y345"
>> cd ..
>>
>> cd ws4
>> echo -e -n "U1\n2\n3\n4\n5\n" >  u.txt
>> git add u.txt
>> git commit -m "ws4 | add u.txt"
>> cd ..
>>
>> cd ws5
>> echo -e -n "W1\n2\n3\n4\n5\n" > w.txt
>> git add w.txt
>> git commit -m "ws5 | add w.txt"
>> cd ..
>>
>> # ws3 pull from ws2 ws4 ws5
>> cd ws3
>> git remote add bws2 ../ws2
>> git remote add bws4 ../ws4
>> git remote add bws5 ../ws5
>> git fetch bws2
>> git fetch bws4
>> git fetch bws5
>> git merge bws4/master bws2/master bws5/master
>> cd ..
>>
>> # resolve conflict in ws3
>> cd ws3
> 
> First of all, thanks for the clear description and test case!
> 
> The octopus strategy cannot do merges which need manual resolution. Or
> so the doc says. After trying the merge with 4 2 5, Git tells you:
> 
> Trying simple merge with 7ff9b5bd514cb600bac935ebd40eae366bba7d19
> Trying simple merge with 6872cd350154743d59cb4d313cbdb122ac43e537
> Simple merge did not work, trying automatic merge.
> Auto-merging file.txt
> ERROR: content conflict in file.txt
> fatal: merge program failed
> Automated merge did not work.
> Should not be doing an Octopus.
> Merge with strategy octopus failed.
> 
> That is, it aborts the merge completely. If you "resolve" it and commit
> it's simply a commit that you make.
> 
> If, instead, you merge 4 5 2, Git tells you:
> 
> Trying simple merge with e4f78f6905bed39bcd96790a4f63e138a455a445
> Trying simple merge with 14c1f2a70767334df5d6d3120631752564094699
> Trying simple merge with 8540a039d3fc964d097d4f037357668441d1d4f5
> Simple merge did not work, trying automatic merge.
> Auto-merging file.txt
> ERROR: content conflict in file.txt
> fatal: merge program failed
> Automatic merge failed; fix conflicts and then commit the result.
> 
> Admittedly this looks fatal also, but the last line tells you that the
> actual merge process is not aborted yet. If you resolve the conflict and
> commit without -m you even see the prepared commit message.
> 
> So, octopus can deal with manual conflict resolution if the conflicts
> appear in the last step only. That is the difference between the two cases.
> 
> Now, in the first case the aborted merge leaves some traces in the index
> as well as in the worktree. I'm not sure that is how it's supposed to be.
> 
> Cheers,
> Michael
