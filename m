From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] run-command: simplify wait_or_whine
Date: Sat, 1 Jun 2013 16:35:14 -0500
Message-ID: <CAMP44s078Vn6CMRyqAkgE6rFBgUyJV9wJaYqkQgz-w3WnEi-vQ@mail.gmail.com>
References: <1370094715-2684-1-git-send-email-felipe.contreras@gmail.com>
	<CACsJy8Df-O=D5LQBXCbiVLB=uHfn6ETbAxADWq3hd-9pPX4+mg@mail.gmail.com>
	<CAMP44s0L1M+_s2eDM=Ogy=rxLhpZYwSb8qWTuEe30pB4KGDVtA@mail.gmail.com>
	<20130601170147.GA19234@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j6t@kdbg.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	"John J. Franey" <jjfraney@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Jun 01 23:35:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UitSN-0005Vj-0y
	for gcvg-git-2@plane.gmane.org; Sat, 01 Jun 2013 23:35:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755984Ab3FAVfS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Jun 2013 17:35:18 -0400
Received: from mail-la0-f48.google.com ([209.85.215.48]:37491 "EHLO
	mail-la0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754901Ab3FAVfR (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Jun 2013 17:35:17 -0400
Received: by mail-la0-f48.google.com with SMTP id fs12so2361457lab.21
        for <git@vger.kernel.org>; Sat, 01 Jun 2013 14:35:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=MidYmvidPxW7g/LPWmnYqHORYTxFYpEo9FTD3qZdHcY=;
        b=msj6o1XoWRUpURaKFbayc8+Ha1mKXDztARKGP4Sp3QKGCF8ft9wgq/tXAvHAlWyqrx
         Q2ibeOF6XPuDWy/OR8XSWV2WIkIfq686D3nTyE+/g2qi3fLQyBoff+NH67AbxCHxSEx9
         4x7xKzHA9q3EY79XV/2iK7LoViwhbs+wMOkrQ4mtGHas8XSWbXmhXL5RVArzvgXjExhO
         iuMaI9BXYyZIpWbjgUpSvUcsfgg/qgITNCcfbOTMgkykkQ14WUX8yCgcLiAb6hN+nRvN
         ye/RQuK6uwtl+/xRPK98v8d5SU7KEA1QYFcKtm8wo0DMao10/HVWEljElHmetRTwE4bA
         pX+g==
X-Received: by 10.112.138.131 with SMTP id qq3mr8301674lbb.46.1370122515060;
 Sat, 01 Jun 2013 14:35:15 -0700 (PDT)
Received: by 10.114.177.164 with HTTP; Sat, 1 Jun 2013 14:35:14 -0700 (PDT)
In-Reply-To: <20130601170147.GA19234@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226146>

On Sat, Jun 1, 2013 at 12:01 PM, Jeff King <peff@peff.net> wrote:
> On Sat, Jun 01, 2013 at 09:30:50AM -0500, Felipe Contreras wrote:

>> commit 709ca730f8e093005cc882bfb86c0ca9c83d345b
>> Author: Jeff King <peff@peff.net>
>> Date:   Sat Jan 5 09:49:49 2013 -0500
>>
>>     run-command: encode signal death as a positive integer
>>
>>     When a sub-command dies due to a signal, we encode the
>>     signal number into the numeric exit status as "signal -
>>     128". This is easy to identify (versus a regular positive
>>     error code), and when cast to an unsigned integer (e.g., by
>>     feeding it to exit), matches what a POSIX shell would return
>>     when reporting a signal death in $? or through its own exit
>>     code.
>>
>>     So we have a negative value inside the code, but once it
>>     passes across an exit() barrier, it looks positive (and any
>>     code we receive from a sub-shell will have the positive
>>     form). E.g., death by SIGPIPE (signal 13) will look like
>>     -115 to us in inside git, but will end up as 141 when we
>>     call exit() with it. And a program killed by SIGPIPE but run
>>     via the shell will come to us with an exit code of 141.
>
> Your patch changes the error code that is propagated via exit() in this
> case. We cannot know "nobody is checking for the specific code", because
> the list of callers is every shell script or program which execs git.
> Some of them do care about the exit code. I can give an example of a
> case I have that cares, but I do not think it is even important. The
> point is that we would be regressing an existing interface, and cannot
> know who is broken by it.

Of course we can know, by going forward with the change, and quite
often that's the only way to know for sure.

But if it's true what you said that we haven't changed what the
process returns, then it doesn't make sense to attempt going forward,
because we have no reference point about the likelihood of scripts
relying on specific exit codes.

-- 
Felipe Contreras
