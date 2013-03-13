From: Karsten Blees <karsten.blees@gmail.com>
Subject: Re: [RFC/PATCH] Documentation/technical/api-fswatch.txt: start with
 outline
Date: Wed, 13 Mar 2013 18:50:56 +0100
Message-ID: <5140BC80.4000201@gmail.com>
References: <1362946623-23649-1-git-send-email-artagnon@gmail.com> <513FB85C.5010106@gmail.com> <CACsJy8CBru+Z0+oYVKGdwjiF4DDH3w4vCjunaoCnoDQ6AizwWg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Git List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2U=?= =?UTF-8?B?bg==?= 
	<tboegi@web.de>, Robert Zeh <robert.allan.zeh@gmail.com>,
	Jeff King <peff@peff.net>,
	Erik Faye-Lund <kusmabite@gmail.com>,
	Drew Northup <n1xim.email@gmail.com>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 13 18:51:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UFppl-0007aE-TM
	for gcvg-git-2@plane.gmane.org; Wed, 13 Mar 2013 18:51:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933231Ab3CMRu6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Mar 2013 13:50:58 -0400
Received: from mail-ee0-f49.google.com ([74.125.83.49]:37294 "EHLO
	mail-ee0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933132Ab3CMRu5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Mar 2013 13:50:57 -0400
Received: by mail-ee0-f49.google.com with SMTP id d41so606868eek.8
        for <git@vger.kernel.org>; Wed, 13 Mar 2013 10:50:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:message-id:date:from:user-agent:mime-version:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=NCD2uIoZDne0LkP7UPrvHWFi4SJ/etG0ZOmkIWP/zdc=;
        b=X871cCDNcLjTuq/7njfXuHacJfMOnY+74XJRAmShqH+ZADkz3XM01vNRgO/Hq+5AeO
         7fbsjGqHvFb0ABaf8BgMJpWcxb/mzOVHtemsSjjQ1DLRsWaty4mSxPpNGHWsjiag4+Nr
         ZkSldUsxxNAxLrDBJbFS9w/J5l3ThujpxUArK3SDT154LGkVT/25WxpIDZdqol6I3/aV
         IrDVpWwLSdQQOqCJlr4HqO0zFtJPiHlAOGCu764p6dQ44Lib+P+ry1nluYknsPZbyYPi
         laprBXDpx+0Ggic1S1n/JSmm4hK1V6atPrgABTDJQoypPOne+eMHmUCanKcKvP2zDswl
         xqUQ==
X-Received: by 10.14.218.71 with SMTP id j47mr61233914eep.28.1363197056549;
        Wed, 13 Mar 2013 10:50:56 -0700 (PDT)
Received: from [10.1.100.50] (ns.dcon.de. [77.244.111.149])
        by mx.google.com with ESMTPS id a1sm37432348eep.2.2013.03.13.10.50.54
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 13 Mar 2013 10:50:55 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:17.0) Gecko/20130307 Thunderbird/17.0.4
In-Reply-To: <CACsJy8CBru+Z0+oYVKGdwjiF4DDH3w4vCjunaoCnoDQ6AizwWg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218077>

Am 13.03.2013 02:03, schrieb Duy Nguyen:
> On Wed, Mar 13, 2013 at 6:21 AM, Karsten Blees <karsten.blees@gmail.com> wrote:
>> Hmmm...I don't see how filesystem changes since last invocation can solve the problem, or am I missing something? I think what you mean to say is that the daemon should keep track of the filesystem *state* of the working copy, or alternatively the deltas/changes to some known state (such as .git/index)?
> 
> I think git process can keep track of filesystem state (and save it
> down if necessary).
[...]
Ah, saving the state was the missing bits, thanks.

However, AFAIK inotify doesn't work recursively, so the daemon would at least have to track the directory structure to be able to register / unregister inotify handlers as directories come and go.

>> Consider 'git status; make; make clean; git status'...that's a *lot* of changes to process for nothing (potentially slowing down make).
> 
> Yeah. In my opinion, the daemon should realize that at some point
> accumulated changes are too much that it's not worth collecting
> anymore, and drop them all. Git will do it the normal/slow way. After
> that the daemon picks up again. We only optimize for the case when
> little changes are made in filesystem.
> 

That sounds reasonable...

>> Then there's the issue of stale data in the cache. Modifying porcelain commands that use 'git status --porcelain' to compile their changesets will want 100% exact data. I'm not saying its not doable, but adding another platform specific, caching daemon to the tool chain doesn't exactly simplify things...
>>
>> But perhaps I'm too pessimistic (or just stigmatized by inherently slow and out-of-date TGitCache/TSvnCache on Windows :-)
> 
> Thanks. I didn't know about TGitCache. Will dig it up. Maybe we can
> learn something from it (or realize the daemon approach is futile
> after all).
> 

TGitCache/TSvnCache are the background processes in TortoiseGit/TortoiseSvn that keep track of filesystem state to display icon overlays in Windows Explorer.
