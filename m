From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH 5/4] run-command: implement abort_async for pthreads
Date: Fri, 1 Apr 2011 21:57:14 +0200
Message-ID: <AANLkTimKPD6rw1B9gG3ZN0KEOY41nk=6jE0MVcdotpkp@mail.gmail.com>
References: <20110331184243.GA12027@sigill.intra.peff.net> <201104011927.03366.j6t@kdbg.org>
 <AANLkTi=8+V3w-1uQgekjntM1qREGZYWSTE_ra1NbDxG8@mail.gmail.com> <201104012142.22065.j6t@kdbg.org>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Fri Apr 01 21:57:47 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q5kTV-0006bM-Bo
	for gcvg-git-2@lo.gmane.org; Fri, 01 Apr 2011 21:57:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754962Ab1DAT5g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Apr 2011 15:57:36 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:53486 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754495Ab1DAT5f (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Apr 2011 15:57:35 -0400
Received: by fxm17 with SMTP id 17so2840711fxm.19
        for <git@vger.kernel.org>; Fri, 01 Apr 2011 12:57:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:reply-to:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=/zfTV467bVqSigXxHw5cnd1xFFW4MpJQVwBayt76ZjA=;
        b=EYiwWkBC5UVj7mQtV6CJPOXBUJSQmGC8L4AGLU33b/0JNWnAm4O9I2W2MLYxfYUfPQ
         IUv5F4emd1LVtHUYWp+sgBCmxa75w77NjMxTcmy0kVweGRoqTDbUyyNgJTKBfkrIJ+IT
         EuQtdIuzYEalEnZGf4qys1x0wtYgKSbJYOxCY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        b=b7HI95k96Y5+4133gkElcL5ea53XTz3DSPI5rrD313VbNDXFjuybP8dff+xmrgYTlB
         LgEU7RfUpT5dUCgjGVDZmmTuTNQ5CqiIsSCvmoNKTVVPMCYCwAstZ0eo6yBSWVKqXWAg
         kjW5X53Sc6IHwamR4WKcN1k5xxDKO/PxSYRUg=
Received: by 10.223.96.16 with SMTP id f16mr778676fan.146.1301687854056; Fri,
 01 Apr 2011 12:57:34 -0700 (PDT)
Received: by 10.223.126.145 with HTTP; Fri, 1 Apr 2011 12:57:14 -0700 (PDT)
In-Reply-To: <201104012142.22065.j6t@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170612>

On Fri, Apr 1, 2011 at 9:42 PM, Johannes Sixt <j6t@kdbg.org> wrote:
> On Freitag, 1. April 2011, Erik Faye-Lund wrote:
>> On Fri, Apr 1, 2011 at 7:27 PM, Johannes Sixt <j6t@kdbg.org> wrote:
>> > On Freitag, 1. April 2011, Erik Faye-Lund wrote:
>> >> OK, I've read up on thread-cancellation, and this code seems correct.
>> >> pthread_cancel doesn't kill the thread right away, it just signals a
>> >> cancellation-event, which is checked for at certain
>> >> cancellation-points. A lot of the CRT functions are defined as
>> >> cancellation points, so it'll be a matter for us Win32-guys to
>> >> implement pthread_testcancel() and inject that into the
>> >> function-wrappers of the CRT functions that are marked as
>> >> cancellation-points.
>> >
>> > That's not going to happen. We cannot implement pthread_cancel() on
>> > Windows because it would have to be able to interrupt blocking system
>> > calls. (TerminateThread() is a no-no, given all the caveats about leaking
>> > system resources that are mentioned in the manual.)
>>
>> Did you read my suggestion?
>
> Yes, I did.
>
>> I was talking about implementing
>> cancellation-points, just like on other platforms. This should not
>> lead to TerminateThread, but instead a conditional ExitThread from the
>> thread in question.
>>
>> Something like this (I've only added a cancellation-point at close,
>> just to illustrate what I mean):
>
> But this does not help the case at hand in any way. How would you interrupt a
> thread that is blocked in ReadFile()? The point of pthread_cancel() is that
> it interrupts blocked system calls

There is no mention of such a guarantee in POSIX (section 2.9.5 Thread
Cancellation), so relying on that is undefined behavior.
