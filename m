From: Jason Wang <jason77.wang@gmail.com>
Subject: Re: help: the question about relative path in the objects/info/alternates
Date: Tue, 2 Aug 2011 15:15:56 +0800
Message-ID: <4E37A42C.3070702@gmail.com>
References: <4E366F08.2060808@gmail.com> <7vr555hvqf.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Jason Wang <jason77.wang@gmail.com>, <git@vger.kernel.org>,
	Tay Ray Chuan <rctay89@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 02 09:16:38 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qo9DR-0008VP-8U
	for gcvg-git-2@lo.gmane.org; Tue, 02 Aug 2011 09:16:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751413Ab1HBHQK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Aug 2011 03:16:10 -0400
Received: from mail.windriver.com ([147.11.1.11]:59115 "EHLO
	mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751048Ab1HBHQH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Aug 2011 03:16:07 -0400
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca [147.11.189.40])
	by mail.windriver.com (8.14.3/8.14.3) with ESMTP id p727G10E008469
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL);
	Tue, 2 Aug 2011 00:16:01 -0700 (PDT)
Received: from [128.224.163.220] (128.224.163.220) by ALA-HCA.corp.ad.wrs.com
 (147.11.189.50) with Microsoft SMTP Server (TLS) id 14.1.255.0; Tue, 2 Aug
 2011 00:16:00 -0700
User-Agent: Thunderbird 2.0.0.23 (X11/20090817)
In-Reply-To: <7vr555hvqf.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178446>

Junio C Hamano wrote:
> Jason Wang <jason77.wang@gmail.com> writes:
>
>   
>> From the objects/info/alternates part of this URL
>> http://www.kernel.org/pub/software/scm/git/docs/gitrepository-layout.html,
>> it says it will work if alternates has relative path in it.
>>     
>
> It does not just say "relative path", but "relative to the object
> database".  It expresses where the "objects" directory you are borrowing
> from is, relative to your own "objects" directory.
>   
Understand.
> For example, if you have /src/ib/{objects,refs,HEAD} as your repository
> that borrows from elsewhere, say /src/base/, then objects/info/alternates
> file in the borrowing repository should say either /src/base/objects/, or
> "../../base/objects".
>
> An easy way to make sure you do not make typo is to go to your borrowing
> objects directory, and then let your shell completion to type your path,
> like this:
>
>     $ cd /home/jason/source/incremental-bare
>     $ cd objects
>     $ echo ../../base-bare/objects >info/alternates
>
> While formulating that "echo" command line, you would type ../../ <TAB>
> and pick base-bare, <TAB> and pick objects.
>
>   
At first, thanks very much.

Yes, your concern is right. But here i really put a right relative path 
in the alternates file. Since i can verify it. For example, %> cd 
/home/jason/source/incremental-bare; %> git tag; %>git branch, all 
commands work well, while if i put a wrong relative path in the 
alternates file, those commands will fail.

The weird thing is if i operate git commands in the 
/home/jason/source/incremental-bare, all commands work well, it can 
successfully borrow objects (refs) from base-bare via relative path. But 
if i clone a new project-dir from incremental-bare (use incremental-bare 
as local machine dir), it will fail, from the failure output it seems it 
can't borrow objects (refs) from base-bare. But if i add "file://" or 
"git://" before incremental-bare, it can work successfully. Do you think 
it is a bug?
%> git clone /home/jason/source/incremental-bare project-dir // it will fail
%> git clone file:///home/jason/source/incremental-bare project-dir // 
it will work successfully


To be convenient, i give a reproduce step for this problem:
1. verify git version on my local machine
hwang4@wanghui-desktop:mainline$ git --version
git version 1.7.6

2. basing on linux-2.6, generate a bare repository linux-2.6-bare
hwang4@wanghui-desktop:mainline$ git clone --bare linux-2.6 linux-2.6-bare
Cloning into bare repository linux-2.6-bare...
done.
hwang4@wanghui-desktop:mainline$ du -hms linux-2.6-bare/
950 linux-2.6-bare/

3. make some change in the linux-2.6, and generate a commit
hwang4@wanghui-desktop:mainline$ emacs linux-2.6/Makefile
hwang4@wanghui-desktop:mainline$ cd linux-2.6
hwang4@wanghui-desktop:linux-2.6$ git commit -m "just test" ./Makefile
[master f2c6e4f] just test
1 files changed, 1 insertions(+), 1 deletions(-)

4. let the linux-2.6-bare as a reference, generate a new INCREMENTAL 
repositry from linux-2.6
hwang4@wanghui-desktop:mainline$ git clone --bare --reference 
./linux-2.6-bare/ file:///home/hwang4/work/mainline/linux-2.6 linux-2.6-inc
Cloning into bare repository linux-2.6-inc...
remote: Counting objects: 5, done.
remote: Compressing objects: 100% (3/3), done.
Receiving objects: 100% (3/3), 293 bytes, done.
Resolving deltas: 100% (2/2), completed with 2 local objects.
remote: Total 3 (delta 2), reused 0 (delta 0)
hwang4@wanghui-desktop:mainline$ du -hms linux-2.6-inc/
1 linux-2.6-inc/

{
here i must add "file://" before source repository, otherwise, the 
mini-tree is full repository instead of incremental, E.G.:
hwang4@wanghui-desktop:mainline$ git clone --bare --reference 
./linux-2.6-bare/ linux-2.6 linux-2.6-inc
Cloning into bare repository linux-2.6-inc...
done.
hwang4@wanghui-desktop:mainline$ du -hms linux-2.6-inc/
950 linux-2.6-inc/
}

5. replace the absolute path in the 
linux-2.6-inc/objects/info/alternates to the relative path.
hwang4@wanghui-desktop:mainline$ cd linux-2.6-inc/objects/
hwang4@wanghui-desktop:objects$ cat info/alternates
/home/hwang4/work/mainline/linux-2.6-bare/objects
hwang4@wanghui-desktop:objects$ echo ../../linux-2.6-bare/objects/ > 
info/alternates
hwang4@wanghui-desktop:objects$ cat info/alternates
../../linux-2.6-bare/objects/

6. verify relative path can work
hwang4@wanghui-desktop:objects$ git tag
v2.6.11
v2.6.11-tree
v2.6.12
v2.6.12-rc2
v2.6.12-rc3
<snip>

7. from the linux-2.6-inc, we clone a new project, if we don't add 
"file://", it will fail
hwang4@wanghui-desktop:mainline$ git clone 
/home/hwang4/work/mainline/linux-2.6-inc new-project
Cloning into new-project...
done.
error: object directory 
/home/hwang4/work/mainline/new-project/.git/objects/../../linux-2.6-bare/objects/ 
does not exist; check .git/objects/info/alternates.
error: refs/tags/v2.6.38-rc8 does not point to a valid object!
error: refs/tags/v2.6.38-rc7 does not point to a valid object!
<snip>

8. but if we add "file://" before source repository or change to 
absolute path in the linux-2.6-inc/objects/info/alternates, i will work 
successfully
hwang4@wanghui-desktop:mainline$ git clone 
file:///home/hwang4/work/mainline/linux-2.6-inc new-project
Cloning into new-project...
remote: Counting objects: 1970908, done.
remote: Compressing objects: 100% (370377/370377), done.
Receiving objects: 100% (1970908/1970908), 433.54 MiB | 12.60 MiB/s, done.
remote: Total 1970908 (delta 1644814), reused 1908550 (delta 1582482)
Resolving deltas: 100% (1644814/1644814), done.
hwang4@wanghui-desktop:mainline$ ls new-project/
arch COPYING crypto drivers fs init Kbuild kernel MAINTAINERS mm README 
samples security tools virt
block CREDITS Documentation firmware include ipc Kconfig lib Makefile 
net REPORTING-BUGS scripts sound usr
