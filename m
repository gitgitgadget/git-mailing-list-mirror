From: Johan Herland <johan@herland.net>
Subject: Re: fsck option to remove corrupt objects - why/why not?
Date: Thu, 16 Oct 2014 14:48:15 +0200
Message-ID: <CALKQrgdQt0gJ0Dy4M5i-aitiJNeYjHWC8UAY37O7=591MpsR5g@mail.gmail.com>
References: <20141015234637.9B4FC781EFB@mail110.syd.optusnet.com.au>
	<543F0DAE.2050205@optusnet.com.au>
	<CALKQrgda8mVbqP5=Ag8juN9HMQp7iQ9eDJETfRJe1b0taAFGkg@mail.gmail.com>
	<20141016122533.GA8451@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Ben Aveling <bena.001@optusnet.com.au>,
	Git mailing list <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Oct 16 14:48:29 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XekTk-0002tg-SV
	for gcvg-git-2@plane.gmane.org; Thu, 16 Oct 2014 14:48:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751448AbaJPMsZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Oct 2014 08:48:25 -0400
Received: from mail12.copyleft.no ([188.94.218.224]:41301 "EHLO
	mail12.copyleft.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750966AbaJPMsY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Oct 2014 08:48:24 -0400
Received: from locusts.copyleft.no ([188.94.218.116] helo=mail.mailgateway.no)
	by mail12.copyleft.no with esmtp (Exim 4.76)
	(envelope-from <johan@herland.net>)
	id 1XekTe-0001JT-M5
	for git@vger.kernel.org; Thu, 16 Oct 2014 14:48:22 +0200
Received: from mail-ob0-f178.google.com ([209.85.214.178])
	by mail.mailgateway.no with esmtpsa (TLSv1:RC4-SHA:128)
	(Exim 4.72 (FreeBSD))
	(envelope-from <johan@herland.net>)
	id 1XekTe-000CdH-Ek
	for git@vger.kernel.org; Thu, 16 Oct 2014 14:48:22 +0200
Received: by mail-ob0-f178.google.com with SMTP id wn1so2752691obc.37
        for <git@vger.kernel.org>; Thu, 16 Oct 2014 05:48:15 -0700 (PDT)
X-Received: by 10.202.224.9 with SMTP id x9mr877124oig.100.1413463695235; Thu,
 16 Oct 2014 05:48:15 -0700 (PDT)
Received: by 10.182.1.137 with HTTP; Thu, 16 Oct 2014 05:48:15 -0700 (PDT)
In-Reply-To: <20141016122533.GA8451@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 16, 2014 at 2:25 PM, Jeff King <peff@peff.net> wrote:
> On Thu, Oct 16, 2014 at 11:04:04AM +0200, Johan Herland wrote:
>> I simply copied the packfile containing the good copy into the
>> corrupted repo, and then ran a "git gc", which "happened" to use the
>> good copy of the corrupted object and complete successfully (instead
>> of barfing on the bad copy). The GC then removed the old
>> (now-obsolete) packfiles, and thus the corruption was gone.
>>
>> However, exactly _why_ git happened to prefer the good copy in my
>> copied packfile instead of the bad copy in the existing packfile, I do
>> not know. I suspect some amount of pure luck was involved.
>
> I'm not sure that it is luck, but more like 8eca0b4 (implement some
> resilience against pack corruptions, 2008-06-23) working as intended[1].
> Generally, git should be able to warn about corrupted objects and look
> in other packs for them (both for regular operations, and for
> repacking).
>
> -Peff
>
> [1] That's just one of the many commits dealing with this. Try running
>     "git log --author=Nicolas.Pitre --grep=corrupt" for more. :)

Indeed, from reading the logs, it seems what I assumed was a lucky
strike, was actually carefully designed behavior. With that in mind,
I'm no longer so sure that fsck actually needs an option to remove
corrupt objects. Instead, it's probably better to leave the corrupt
object in place until a good copy can be located and copied into the
repo, at which point Nicolas' brilliant work will make sure a simple
repack takes care of fixing the corruption.

That said, we should consider documenting this strategy for fixing corruptions:
 - Locate the a good copy of the affected objects in another repo
 - Copy relevant pack file or loose object into this repo
 - Run "git gc"
 - Profit!

...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
