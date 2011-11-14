From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: Git shouldn't allow to push a new branch called HEAD
Date: Mon, 14 Nov 2011 11:45:46 +0100
Message-ID: <4EC0F15A.9010502@alum.mit.edu>
References: <1318591877.2938.20.camel@mastroc3.mobc3.local>	 <1318592153.2938.21.camel@mastroc3.mobc3.local> <1321261662.2941.13.camel@mastroc3.mobc3.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Daniele Segato <daniele.bilug@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 14 11:45:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RPu30-0000dR-G9
	for gcvg-git-2@lo.gmane.org; Mon, 14 Nov 2011 11:45:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754903Ab1KNKpu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Nov 2011 05:45:50 -0500
Received: from einhorn.in-berlin.de ([192.109.42.8]:41791 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752803Ab1KNKpt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Nov 2011 05:45:49 -0500
X-Envelope-From: mhagger@alum.mit.edu
Received: from [192.168.100.152] (ssh.berlin.jpk.com [212.222.128.135])
	(authenticated bits=0)
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id pAEAjkGC013124
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Mon, 14 Nov 2011 11:45:46 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.23) Gecko/20110921 Lightning/1.0b2 Thunderbird/3.1.15
In-Reply-To: <1321261662.2941.13.camel@mastroc3.mobc3.local>
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185374>

On 11/14/2011 10:07 AM, Daniele Segato wrote:
> On Fri, 2011-10-14 at 13:35 +0200, Daniele Segato wrote:
>> On Fri, 2011-10-14 at 13:31 +0200, Daniele Segato wrote:
>>> following from a discussion in IRC freenode #git between me, sitaram an
>>> shruggar
>>>
>>>
>>> step to reproduce:
>>>
>>> $ mkdir /tmp/gitbug
>>> $ cd /tmp/gitbug/
>>>
>>> $ # create a fake remote repo
>>> $ git init --bare remote.git
>>>
>>> $ # clone it with the user that will generate the bug
>>> $ git clone remote.git buggenerator
>>> $ cd buggenerator/
>>> $ touch whatever
>>> $ git add .
>>> $ git commit -m "first commit"
>>> $ git push origin master 
>>>
>>> $ # now clone the same repo the other guy is the "victim" of this issue
>>> $ cd ..
>>> $ git clone remote.git victim
>>>
>>> $ # time to create the remote HEAD branch
>>> $ cd buggenerator/
>>> $ git push origin HEAD:HEAD
>>>
>>> $ # the remote refs has been created!
>>> $ git ls-remote
>>>
>>> $ # another commit
>>> $ echo 'any change' >> whatever 
>>> $ git commit -a -m "some change"
>>> $ git push origin master 
>>>
>>> $ # the refs/heads/HEAD is still where it was
>>> $ git ls-remote
>>>
>>> $ # now from the victim perspective
>>> $ cd ../victim/
>>>
>>> $ # every time executing a fetch he will get a force update
>>> $ # or maybe even an error, seen it my real repo, don't know how
>>> $ # to reproduce
>>> $ git fetch 
>>> $ git fetch 
>>> $ git ls-remote
>>> $ git fetch 
>>> $ git ls-remote
>>> $ git branch -a
>>
>> This should also help understanding what happen in the "victim" local
>> repo at every fetch:
>>
>> mastro@mastroc3 /tmp/gitbug/victim (master) $ git br -av
>> * master                11d0a12 [behind 1] first commit
>>   remotes/origin/HEAD   -> origin/master
>>   remotes/origin/master 77852ef some change
>> mastro@mastroc3 /tmp/gitbug/victim (master) $ git fetch 
>> From /tmp/gitbug/remote
>>  + 77852ef...11d0a12 HEAD       -> origin/HEAD  (forced update)
>> mastro@mastroc3 /tmp/gitbug/victim (master) $ git br -av
>> * master                11d0a12 first commit
>>   remotes/origin/HEAD   -> origin/master
>>   remotes/origin/master 11d0a12 first commit
> 
> I'm aware my request has been ignored for a good reason but I would
> appreciate someone stepping in and explaining to me why this is not a
> bug or why it has been ignored.

This is a nice little bug.

I'm sure that you noticed that running "git fetch" repeatedly from the
"victim" repository alternates between two behaviors (I'm using 1.7.7.2):

> $ git fetch
> From /home/mhagger/tmp/gitbug/remote
>  + 6bf3df1...4c9ebba HEAD       -> origin/HEAD  (forced update)
> $ git for-each-ref
> 4c9ebba3c0618bd6238a810013da4a8cd4f2213b commit	refs/heads/master
> 4c9ebba3c0618bd6238a810013da4a8cd4f2213b commit	refs/remotes/origin/HEAD
> 4c9ebba3c0618bd6238a810013da4a8cd4f2213b commit	refs/remotes/origin/master
> $ git fetch
> From /home/mhagger/tmp/gitbug/remote
>    4c9ebba..6bf3df1  master     -> origin/master
> $ git for-each-ref
> 4c9ebba3c0618bd6238a810013da4a8cd4f2213b commit	refs/heads/master
> 6bf3df178cd92ca72625ae5bda9206c4333fd807 commit	refs/remotes/origin/HEAD
> 6bf3df178cd92ca72625ae5bda9206c4333fd807 commit	refs/remotes/origin/master
> $ git fetch
> From /home/mhagger/tmp/gitbug/remote
>  + 6bf3df1...4c9ebba HEAD       -> origin/HEAD  (forced update)
> $ git fetch
> From /home/mhagger/tmp/gitbug/remote
>    4c9ebba..6bf3df1  master     -> origin/master

The whole time, victim's .git/HEAD contains "ref: refs/heads/master",
.git/refs/remotes/origin/HEAD contains "ref:
refs/remotes/origin/master", and its packed-refs file contains

# pack-refs with: peeled
4c9ebba3c0618bd6238a810013da4a8cd4f2213b refs/remotes/origin/master

In "remote.git", refs/heads/HEAD contains not a symbolic reference but
the explicit SHA1 "4c9ebba...".  This is of course not affected by
running "git fetch" in the "victim" tree.  Deleting this file makes the
problem go away.


Given that this problem seems to be in the remote protocol rather than
in the refs API, I think I'll stop working on this.  I hope that my
observations are helpful to somebody.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
