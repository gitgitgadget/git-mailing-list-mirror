From: "Andrzej K. Haczewski" <ahaczewski@gmail.com>
Subject: Re: [PATCH 1/1] MSVC: port pthread code to native Windows threads
Date: Wed, 4 Nov 2009 11:53:30 +0100
Message-ID: <16cee31f0911040253t57e9f8a4le70db2f5607fd645@mail.gmail.com>
References: <1257283802-29726-1-git-send-email-ahaczewski@gmail.com>
	 <1257283802-29726-2-git-send-email-ahaczewski@gmail.com>
	 <4AF13819.7050306@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Wed Nov 04 11:53:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N5dUg-0005KZ-8T
	for gcvg-git-2@lo.gmane.org; Wed, 04 Nov 2009 11:53:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755309AbZKDKx1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 4 Nov 2009 05:53:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755308AbZKDKx1
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Nov 2009 05:53:27 -0500
Received: from mail-bw0-f227.google.com ([209.85.218.227]:46687 "EHLO
	mail-bw0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755083AbZKDKx0 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 4 Nov 2009 05:53:26 -0500
Received: by bwz27 with SMTP id 27so8693477bwz.21
        for <git@vger.kernel.org>; Wed, 04 Nov 2009 02:53:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=DZQcDabjzXKJxrY9SyahhUAvi3Ha/Kbsv85pLI35E0Y=;
        b=B3S/9ZbhBT2luoU3JgFkuGjQGH1Lg3Sz+d3vxasWECZmHSfMmWNxaIMzdA2oXGincU
         amUztixGuH5ZowRlIrPbyOicdDBROx3PYAg5Bk7AcBpammUVRv3XNSK9vOGxc8Z/hF7I
         LTexIT9HRvrL/00JT7uCKJ//m2QCQE9jofGsg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=eDLPTo521QTOKZYPPlvlZguVZxnIwqHXFZb7jXpNLf4iNXv2BSo4l8vvI7GbNQguou
         /4O08G6nXoZxeQC32h6zLiGokcMzt/HVIrhOO18kFI9yOlSig+e8zPXw0IkkhvIY+EIo
         kkVmDmckMv7dT8VvkihLuVlZwZbbnYsLaP43Q=
Received: by 10.239.190.227 with SMTP id y35mr132755hbh.212.1257332010693; 
	Wed, 04 Nov 2009 02:53:30 -0800 (PST)
In-Reply-To: <4AF13819.7050306@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132072>

2009/11/4 Johannes Sixt <j.sixt@viscovery.net>:
> Can't you just use the pthread package that is included in msysgit?

I don't like bloat, and msysgit is bloated. Sure, there are parts of
msysgit that are even heavier (bash, perl), but this will be removed
with further C'ification of scripts. I did what I thought could be
sensible for my first patch. I'm newbie after all.

>> + =A0 =A0 /* we're waiting... */
>> + =A0 =A0 EnterCriticalSection(&cond->waiters_lock);
>> + =A0 =A0 ++cond->waiters;
>> + =A0 =A0 LeaveCriticalSection(&cond->waiters_lock);
>> +
>> + =A0 =A0 /* unlock external mutex and wait for signal */
>> + =A0 =A0 LeaveCriticalSection(mutex);
>> + =A0 =A0 result =3D WaitForSingleObject(cond->sema, INFINITE);
>
> Releasing the mutex and entering the wait state as well as leaving th=
e
> wait state and reacquiring the mutex should be atomic. Neither are in=
 this
> implementation. You are not mentioning why you are implementing thing=
s
> like this and why this would be acceptable.

It's safe to do it like this here because we're serializing waiters
count and when signaling we make sure we have waiters before we
release semaphore. That implementation is based on ACE.

Andrew
