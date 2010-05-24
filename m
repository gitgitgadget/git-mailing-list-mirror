From: Tomas Pospisek <tpo@sourcepole.ch>
Subject: Re: Bug? file at the same time being deleted and not registered
Date: Mon, 24 May 2010 16:46:44 +0200 (CEST)
Message-ID: <alpine.DEB.2.00.1005241642040.5109@tpo-laptop>
References: <alpine.DEB.2.00.1005232245220.18372@tpo-laptop> <20100523234459.GA8285@coredump.intra.peff.net> <alpine.DEB.2.00.1005240932130.7107@tpo-laptop> <20100524082430.GA18755@coredump.intra.peff.net> <alpine.DEB.2.00.1005241027580.8425@tpo-laptop>
 <20100524084932.GA21051@coredump.intra.peff.net> <alpine.DEB.2.00.1005241228100.5304@tpo-laptop>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon May 24 16:47:08 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OGYvr-0004wb-KC
	for gcvg-git-2@lo.gmane.org; Mon, 24 May 2010 16:47:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754286Ab0EXOrB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 May 2010 10:47:01 -0400
Received: from pizol.sourcepole.ch ([80.74.153.203]:58446 "EHLO
	pizol.sourcepole.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754049Ab0EXOrA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 May 2010 10:47:00 -0400
Received: from cable-dynamic-87-245-106-94.shinternet.ch ([87.245.106.94] helo=localhost)
	by mail.sp-metanet with esmtpsa (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.69)
	(envelope-from <tpo_hp@sourcepole.ch>)
	id 1OGYva-0001JI-JY; Mon, 24 May 2010 16:46:55 +0200
X-X-Sender: tpo@tpo-laptop
In-Reply-To: <alpine.DEB.2.00.1005241228100.5304@tpo-laptop>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
X-SA-Score: -4.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147633>

On Mon, 24 May 2010, Tomas Pospisek wrote:

> On Mon, 24 May 2010, Jeff King wrote:
>
>> On Mon, May 24, 2010 at 10:29:02AM +0200, Tomas Pospisek wrote:
>> 
>>>> If it's empty or 32 bytes, then that explains what status is reporting
>>>> (but the question still remains how we got into that state).
>>> 
>>> There's no .git/index file there:
>>>
>>>  $ ls -l .git/
>>>  total 36
>>>  drwxr-xr-x 2 tpo tpo 4096 2010-05-23 21:36 branches
>>>  -rw-r--r-- 1 tpo tpo    4 2010-05-23 21:36 COMMIT_EDITMSG
>>>  -rw-r--r-- 1 tpo tpo   73 2010-05-23 21:36 description
>>>  -rw-r--r-- 1 tpo tpo   23 2010-05-23 21:36 HEAD
>>>  drwxr-xr-x 2 tpo tpo 4096 2010-05-23 21:36 hooks
>>>  drwxr-xr-x 2 tpo tpo 4096 2010-05-23 21:36 info
>>>  drwxr-xr-x 3 tpo tpo 4096 2010-05-23 21:36 logs
>>>  drwxr-xr-x 7 tpo tpo 4096 2010-05-24 09:26 objects
>>>  drwxr-xr-x 4 tpo tpo 4096 2010-05-23 21:36 refs
>> 
>> Thanks. That means "git status" is at least reporting the right thing.
>> Now we just need to figure out why, when the strace of commit shows it
>> being written and renamed into place, the index file is missing.
>> 
>> I tried setting up a simple mhddfs mount to reproduce your problem, but
>> everything works fine for me. What version of mhddfs are you using? I'm
>> using version 0.1.28. I wonder if git is somehow triggering an mhddfs
>> bug. Looking through the svn logs for mhddfs, between 0.1.27 and 0.1.28,
>> there is a commit with message "fixed rename bug".
>
> Oh wow (trying to reproduce the bug just from the strace). It's mhddfs. Look:
>
> $ touch bla
> $ touch bla.lock
> $ echo asdf > bla.lock
> $ mv bla.lock bla
> $ ls
> $ # nothing here
>
> That's a quite catastrophic bug in mhddfs :-((( ! Argh.
>
> Moving this over to mhddfs.

OK, I'm waering sackcloth and ashes. The problem was a config fault of 
mine - one of the backing fs/partitions was included *twice* in the mhdffs 
fs setup in /etc/fstab. And as of now mhdffs doesn't detect a user 
composing the mhddfs filesystem in a braindammaged way.

http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=582888
*t
