From: Sebastian Kuzminsky <seb@highlab.com>
Subject: Re: surprising behavior from merge
Date: Mon, 14 May 2012 12:14:21 -0600
Message-ID: <8F6454B6-5C93-45AA-8AB0-881FEEE22848@highlab.com>
References: <9A9AD20F-B316-4DC1-8C6A-E0FC6ED80A61@highlab.com> <ae419d8bbc2b44bfa4c0a7eb421f5037-mfwitten@gmail.com> <4FADA967.10808@highlab.com> <4FADCA05.60109@blizzard.com>
Mime-Version: 1.0 (Apple Message framework v1257)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Illia Bobyr <ibobyr@blizzard.com>
X-From: git-owner@vger.kernel.org Mon May 14 20:14:48 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1STzn8-0004o5-Mi
	for gcvg-git-2@plane.gmane.org; Mon, 14 May 2012 20:14:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932123Ab2ENSOh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 May 2012 14:14:37 -0400
Received: from smtp.quartz.synacor.com ([205.169.121.111]:59745 "EHLO
	smtp.q.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932073Ab2ENSOg convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 14 May 2012 14:14:36 -0400
X_CMAE_Category: 0,0 Undefined,Undefined
X-CNFS-Analysis: v=1.1 cv=WzqRc1FjMqjoJrKlRBOavx4tBi4xUTjIXTxDts6qZHk= c=1 sm=0 a=oddu3yYFaF8A:10 a=8D6UOEW8R_kA:10 a=8nJEP1OIZ-IA:10 a=NEAV23lmAAAA:8 a=NuROZhZ1_UltXTFBSjYA:9 a=mZO3Y9GTKf3Ae6h4FVYA:7 a=wPNLvfGTeEIA:10 a=C8-wxyFeZeF9dpQ-:21 a=BHB1bcjKQTx98A7R:21 a=noO3zNo7aAGhcWOY2lY1YQ==:117
X-CM-Score: 0
X-Scanned-by: Cloudmark Authority Engine
Authentication-Results: smtp03.quartz.synacor.com smtp.mail=seb@highlab.com; spf=neutral; sender-id=neutral
Authentication-Results: smtp03.quartz.synacor.com header.from=seb@highlab.com; sender-id=neutral
Authentication-Results: smtp03.quartz.synacor.com smtp.user=highlab@q.com; auth=pass (LOGIN)
Received-SPF: neutral (smtp03.quartz.synacor.com: 75.166.179.153 is neither permitted nor denied by domain of highlab.com)
Received: from [75.166.179.153] ([75.166.179.153:58089] helo=highlab.com)
	by smtp.q.com (envelope-from <seb@highlab.com>)
	(ecelerity 2.2.2.40 r(29895/29896)) with ESMTPA
	id 9C/C3-11205-B8B41BF4; Mon, 14 May 2012 14:14:35 -0400
Received: from [67.51.249.130] (helo=[10.126.1.197])
	by highlab.com with esmtpsa (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.69)
	(envelope-from <seb@highlab.com>)
	id 1STzn0-0006ud-As; Mon, 14 May 2012 12:14:34 -0600
In-Reply-To: <4FADCA05.60109@blizzard.com>
X-Mailer: Apple Mail (2.1257)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197796>

Here's a little script that reproduces the problem:

-----
#!/bin/bash
set -e

if [ -e git-merge-problem ]; then
    echo "'git-merge-problem' exists, not running test!"
    exit 1
fi

mkdir git-merge-problem
cd git-merge-problem
git init

echo "first line" > myfile
echo "second line" >> myfile
echo "" >> myfile
echo "next to last line" >> myfile
echo "final line" >> myfile
git add myfile
git commit -m 'initial commit of myfile'

git branch other

sed -i -e 's/second line/this line is in the context of the crucial patch/' myfile
git add myfile
git commit -m 'change context for crucial patch'

sed -i -e 's/^$/\nthis line is added only once, but in two branches\n/' myfile
git add myfile
git commit -m 'add a line'

git tag add-a-line

git checkout other
git cherry-pick -x add-a-line

git checkout master

git merge other

NUM_LINES=$(grep 'added only once' myfile | wc -l)
if [ $NUM_LINES -eq 2 ]; then
    echo "FAIL!  the merge added the line twice"
    cat myfile
    exit 1
elif [ $NUM_LINES -ne 1 ]; then
    echo "FAIL!  the merge added the line a strange number of times ($NUM_LINES)"
    exit 1
fi

echo "PASS!  the merge added the line just once!"
exit 0
-----



On May 11, 2012, at 20:25 , Illia Bobyr wrote:

> On 5/11/2012 5:05 PM, Sebastian Kuzminsky wrote:
>> On 05/11/2012 05:57 PM, Michael Witten wrote:
>>> On Fri, 11 May 2012 16:25:29 -0600, Sebastian Kuzminsky wrote:
>>> 
>>>> The simplified repo is here if anyone wants to inspect it:
>>>> https://github.com/SebKuzminsky/merge-problem
>> ...
>> 
>>> In other words, rather than burdening people with the task of
>>> constructing a mental picture of what you have done, you should
>>> show them as directly and precisely as possible; in this way,
>>> people can go about the business of discussing your issue much
>>> more quickly and, most importantly, PRECISELY.
>>> 
>> 
>> Ah, I had intended the extremely tiny git repo I linked to to provide 
>> the info in the most concise way possible.  The surprising behaviour 
>> happened at the final commit in the repo, which was made by 'git merge 
>> other'.
>> 
>> I can email a list of commands to reproduce the issue later tonight if 
>> that would make anything clearer.
> 
> The repository you provided is actually quite simple and clear, though I 
> have no idea why this might be happening.  Or if it is an expected behavior.
> 
> At the same time if you provide a list of command if someone will be 
> fixing this they may server as an automated test.  Git has a lot of them.
> 
> --
> Illia Bobyr

-- 
Sebastian Kuzminsky
