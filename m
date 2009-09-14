From: Ben Bradshaw <ben@catalyst.net.nz>
Subject: Re: could not detach HEAD error didn't identify the cause of the
 issue
Date: Tue, 15 Sep 2009 09:01:28 +1200
Message-ID: <4AAEAF28.2050604@catalyst.net.nz>
References: <4AAD8AE0.9070305@catalyst.net.nz> <20090914112211.GC9216@sigill.intra.peff.net> <4AAEAE15.7050607@catalyst.net.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Sep 14 23:01:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MnIgA-0005o0-AN
	for gcvg-git-2@lo.gmane.org; Mon, 14 Sep 2009 23:01:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757173AbZINVB1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Sep 2009 17:01:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757168AbZINVB1
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Sep 2009 17:01:27 -0400
Received: from bertrand.catalyst.net.nz ([202.78.240.40]:39956 "EHLO
	mail.catalyst.net.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757169AbZINVB0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Sep 2009 17:01:26 -0400
Received: from localhost (localhost [127.0.0.1])
	by mail.catalyst.net.nz (Postfix) with ESMTP id 271313232D;
	Tue, 15 Sep 2009 09:01:29 +1200 (NZST)
X-Virus-Scanned: Debian amavisd-new at mail.catalyst.net.nz
Received: from mail.catalyst.net.nz ([127.0.0.1])
	by localhost (bertrand.catalyst.net.nz [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bY8VQAmBsmuS; Tue, 15 Sep 2009 09:01:28 +1200 (NZST)
Received: from [192.168.2.54] (leibniz.catalyst.net.nz [202.78.240.7])
	(Authenticated sender: ben)
	by mail.catalyst.net.nz (Postfix) with ESMTPA id 722DC322E0;
	Tue, 15 Sep 2009 09:01:28 +1200 (NZST)
User-Agent: BC/2.0.0.22
In-Reply-To: <4AAEAE15.7050607@catalyst.net.nz>
X-Enigmail-Version: 0.95.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128498>

Hi Jeff,

I'm using git version 1.5.6.5 - I think I can elaborate on the issue
some more though. I'll step through the process that got me to the point
of failure. For the purposes of this example 'ben@carbon' is me at my
local machine, 'ben@staging' is our staging server. Our development
setup for this project has us all working on the staging server except
when we need to test something that we don't want on staging (could
break things) so I also have a local copy of staging. (This seems
backwards to me but it's working rather well for the short time line we
have).

In this case I did the following:
1. Add module site_map to carbon
2. Install and test on carbon
3. Add module site_map to staging
4. Install and test on staging
5. git commit && git push on staging
6. git pull --rebase on carbon

I think you will need two checkouts of your repo in order to trigger
this case?

Ben
>
> Jeff King wrote:
>> On Mon, Sep 14, 2009 at 12:14:24PM +1200, Ben Bradshaw wrote:
>>
>>   
>>> I was asked to post this issue to the list, I've just had git tell me it
>>> can't detach HEAD which left me scratching mine as to the cause and fix.
>>> Turns out if I have local untracked files that the remote branch also
>>> has then this error will trigger. I have included my shell backlog
>>> (client data removed). In this example the site_map folder was present
>>> on master and I had a local, untracked copy.
>>>
>>> git can obviosly detect this issue and stop my local copy getting in a
>>> bad state, but an error message such as "sites/all/modules/site_map/ is
>>> present in HEAD but is untracked locally, unable to apply changes" (or
>>> something to point the finger) would be much appreciated.
>>>     
>>
>> I couldn't reproduce it here; I get such a message.
>>
>>   # set up forked repo, "another" exists only on master
>>   $ mkdir repo && cd repo
>>   $ git init
>>   $ echo content >file && git add file && git commit -m base
>>   $ echo content >another && git add another && git commit -m another
>>   $ git checkout -b other HEAD^
>>   $ echo changes >file && git commit -a -m changes
>>
>>   # add untracked "another" here
>>   $ echo untracked >another
>>
>>   # try rebase
>>   $ git rebase master
>>   First, rewinding head to replay your work on top of it...
>>   error: Untracked working tree file 'another' would be overwritten by merge.
>>   could not detach HEAD
>>
>>   # try git pull --rebase, in case it hides the message
>>   $ git config branch.other.remote .
>>   $ git config branch.other.merge refs/heads/master
>>   $ git pull --rebase
>>   From .
>>    * branch            master     -> FETCH_HEAD
>>   First, rewinding head to replay your work on top of it...
>>   error: Untracked working tree file 'another' would be overwritten by merge.
>>   could not detach HEAD
>>
>> I'll admit the "could not detach HEAD" message would probably be better as:
>>
>>   rebase: unable to move HEAD to 'master', aborting rebase
>>
>> or something similar.
>>
>> What version of git are you using? What does my test case above produce
>> for you?
>>
>> -Peff
>>
>>   
