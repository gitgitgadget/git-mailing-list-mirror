From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: efficient way to filter several branches with common history?
Date: Wed, 4 Jul 2007 15:27:24 +0200
Message-ID: <6DC0E50A-CAD3-453E-BD9C-73E51EDD5785@zib.de>
References: <652B0F85-D0E4-4BF0-8DFC-212B6C0650AF@zib.de> <468B5C4B.26F5E90B@eudaptics.com>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Johannes Sixt <J.Sixt@eudaptics.com>
X-From: git-owner@vger.kernel.org Wed Jul 04 15:27:11 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I64sx-0003YD-0d
	for gcvg-git@gmane.org; Wed, 04 Jul 2007 15:27:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761570AbXGDN0Z (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 4 Jul 2007 09:26:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762214AbXGDN0Z
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Jul 2007 09:26:25 -0400
Received: from mailer.zib.de ([130.73.108.11]:39959 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761983AbXGDN0X (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Jul 2007 09:26:23 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id l64DQKW5026270;
	Wed, 4 Jul 2007 15:26:20 +0200 (CEST)
Received: from [130.73.68.185] (cougar.zib.de [130.73.68.185])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id l64DQJx5028755
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Wed, 4 Jul 2007 15:26:19 +0200 (MEST)
In-Reply-To: <468B5C4B.26F5E90B@eudaptics.com>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51610>


On Jul 4, 2007, at 10:37 AM, Johannes Sixt wrote:

> Steffen Prohaska wrote:
>>
>> Is there an efficient way to filter several branches at once
>> through git-filter-branch? Often several branches have a lot
>> of common history. Therefore, I suspect it would be much more
>> efficient to filter them with one call to git-filter-branch.
>> For example how can I efficiently filter all origin/* branches
>> to filtered/* branches?
>
> That feature is not yet implemented.
>
> In the meantime do it this way:
>
> Make an octopus merge of the branches onto a new branch. (If you have
> more than a dozen or so, you better make a hierarchy of  
> octopusses.) You
> don't need to resolve conflicts (you are not interested in the merge
> result), or use -s ours to avoid them in the first place.
> Then filter that new branch.
> Then create new refs at the rewritten commits:
>
>    $ git update-ref refs/filtered/b1 $id-of-rewritten-origin/b1
>    $ ...
>
> Use gitk to find the $ids-of-rewritten-origin/*

Thanks for your explanation. The following is the template I used
to build my fully automated version of what you proposed:

--- SNIP ---
echo "merging branches to be filtered ..."
git-checkout -b tmp/all origin/master

for b in origin/branchX origin/branchY [ ... more branches here ...]
do
     git merge -s ours -m "merge-for-preparing-filter-branch $b" $b
done

echo "... filtering ..."
git-filter-branch \
[... your git-filter-branch filters here ...] \
   filtered/all >filter-branch.log

echo "... setting heads of filtered branches."
lastp1=
git-log --pretty="format:%s %P" filtered/all |
while read t b p1 p2
do
     [[ "$t" == "merge-for-preparing-filter-branch" ]] || { git  
update-ref refs/heads/filtered/master $lastp1 ; break ; }
     b=filtered/$(basename $b)
     git update-ref refs/heads/$b $p2
     lastp1=$p1
done

echo "delete tmp/all and filtered/all after checking the result"
--- SNIP ---

	Steffen
