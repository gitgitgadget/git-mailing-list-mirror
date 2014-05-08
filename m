From: Per Cederqvist <cederp@opera.com>
Subject: Re: [GUILT 25/28] "guilt push" now fails when there are no more
 patches to push.
Date: Thu, 8 May 2014 23:37:46 +0200
Message-ID: <CAP=KgsTSD6Dnh7V8MO3S3ZN45R7QYJfBQBS1x=GajJKdTm9syA@mail.gmail.com>
References: <1395387126-13681-1-git-send-email-cederp@opera.com>
	<1395387126-13681-26-git-send-email-cederp@opera.com>
	<20140507220427.GD1459@meili.valhalla.31bits.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Jeff Sipek <jeffpc@josefsipek.net>
X-From: git-owner@vger.kernel.org Thu May 08 23:37:52 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WiW0l-0001qP-4Q
	for gcvg-git-2@plane.gmane.org; Thu, 08 May 2014 23:37:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755325AbaEHVhr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 May 2014 17:37:47 -0400
Received: from mail-ig0-f177.google.com ([209.85.213.177]:56759 "EHLO
	mail-ig0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753348AbaEHVhq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 May 2014 17:37:46 -0400
Received: by mail-ig0-f177.google.com with SMTP id l13so356372iga.16
        for <git@vger.kernel.org>; Thu, 08 May 2014 14:37:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=KU2GgsjLhrAqIGw0nEPePsVsDeXc08SqybMhrIzAEh4=;
        b=Gp5Vx2/W/iw1n3O8rI8YDhhEokAleEkjlPjrLVYTN5wQSMeAXjHiMr09jXSS5O0oaa
         fJ4lZ8rkukFwmBEXJaedM13oSq4mFO4lsrL9V6SVwUfwySaCEFI94HtMzgyg2PajAHsh
         2Rss+hIeNASccoSIMizi/7Sj/TBNeU1vuuaEjqTD0QDnKdfSwctX4CAYppk5xDLtrCS0
         D5xupSnaOV1krhp3yeY1J0SgIB39vj18UiVx+j7kN7yLbEHaOu4Y7v7nJqw5JquWU99H
         l+982edWhT76brEs4p7EE9C0krm5ixWI+M4tDQ4YzzYhv2cEOLyuJdqS8V8/PrmlRkid
         D3Dw==
X-Gm-Message-State: ALoCoQldCtizOMS1xXbY+xZnDYL46gqsiIoq5ZRxsr68YPG3k8PzrOxOwtWVEfHofs1uUYL2pV5j
X-Received: by 10.50.253.130 with SMTP id aa2mr305619igd.39.1399585066570;
 Thu, 08 May 2014 14:37:46 -0700 (PDT)
Received: by 10.43.89.66 with HTTP; Thu, 8 May 2014 14:37:46 -0700 (PDT)
In-Reply-To: <20140507220427.GD1459@meili.valhalla.31bits.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248451>

On Thu, May 8, 2014 at 12:04 AM, Jeff Sipek <jeffpc@josefsipek.net> wrote:
> On Fri, Mar 21, 2014 at 08:32:03AM +0100, Per Cederqvist wrote:
>> This makes it easier to script operations on the entire queue, for
>> example run the test suite on each patch in the queue:
>>
>>     guilt pop -a;while guilt push; do make test||break; done
>>
>> This brings "guilt push" in line with the push operation in Mercurial
>> Queues (hg qpush), which fails when there are no patches to apply.
>>
>> Updated the test suite.
>>
>> "guilt push -a" still does not fail.  (It successfully manages to
>> ensure that all patches are pushed, even if it did not have to do
>> anything to make it so.)
>>
>> Signed-off-by: Per Cederqvist <cederp@opera.com>
>> ---
>>  guilt-push           | 14 ++++-----
>>  regression/t-020.out | 89 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>>  regression/t-020.sh  | 13 +++++++-
>>  3 files changed, 108 insertions(+), 8 deletions(-)
>>
>> diff --git a/guilt-push b/guilt-push
>> index 67687e7..2222350 100755
>> --- a/guilt-push
>> +++ b/guilt-push
>> @@ -55,6 +55,7 @@ fi
>>
>>  patch="$1"
>>  [ ! -z "$all" ] && patch="-a"
>> +[ -z "$patch" ] && { patch=1; num=t; }
>
> I don't think there's any other place in the repo that does this.  Instead
> you see a lot of if-then-fi.  To keep it consistent, I'd suggest:
>
> if [ -z "$patch" ] ; then
>         patch=1
>         num=t
> fi

Ok.

> Ah, this took me a while to figure out.  The above turns:
>
> $ guilt push
>
> into
>
> $ guilt push -n 1
>
> I'd throw in a comment.

Will do.

> (Note to self, this file is a huge mess and could use a bit of cleanup.)
>
>> @@ -78,11 +79,6 @@ elif [ ! -z "$num" ]; then
>>       # clamp to minimum
>>       [ $tidx -lt $eidx ] && eidx=$tidx
>>
>> -elif [ -z "$patch" ]; then
>> -     # we are supposed to push only the next patch onto the stack
>> -
>> -     eidx=`wc -l < "$applied"`
>> -     eidx=`expr $eidx + 1`
>>  else
>>       # we're supposed to push only up to a patch, make sure the patch is
>>       # in the series
>> @@ -109,7 +105,11 @@ if [ "$sidx" -gt "$eidx" ]; then
>>       else
>>               disp "File series fully applied, ends at patch `get_series | tail -n 1`"
>>       fi
>> -     exit 0
>> +     if [ -n "$all" ]; then
>> +             exit 0
>> +     else
>> +             exit 1
>> +     fi
>
> This changes the output on stdout.  E.g.,
>
> $ guilt pu
> $ guilt pu -n 1
> File series fully applied, ends at patch crashdump
>
> With this patch, both will print the message. Right?

Yes. Personally, I think that is a good change. It feels
strange that "guilt push" silently does nothing when
there is no patch to apply.

    /ceder

>>  fi
>>
>>  get_series | sed -n -e "${sidx},${eidx}p" | while read p
>
> Jeff.
