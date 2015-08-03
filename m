From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v8 0/11] Port tag.c over to use ref-filter APIs
Date: Tue, 4 Aug 2015 02:52:31 +0530
Message-ID: <CAOLa=ZSRLaRjyif_7auUWfX6DmtA_g2MonumDf-3cMZvvrRXGg@mail.gmail.com>
References: <CAOLa=ZTYWTjc-OC7N7FGWETP1svpCkqhQ2wwPmbf5nVRyPRAqg@mail.gmail.com>
 <xmqq8u9s86n3.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 03 23:23:41 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZMNCs-0002Tg-Gi
	for gcvg-git-2@plane.gmane.org; Mon, 03 Aug 2015 23:23:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932464AbbHCVXg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Aug 2015 17:23:36 -0400
Received: from mail-ob0-f169.google.com ([209.85.214.169]:33578 "EHLO
	mail-ob0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932498AbbHCVXC (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Aug 2015 17:23:02 -0400
Received: by obdeg2 with SMTP id eg2so108888131obd.0
        for <git@vger.kernel.org>; Mon, 03 Aug 2015 14:23:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=8hri0owKTb3ICNWKZ+GVVNGpiZX/zLlSBKgSU5XUN2g=;
        b=hRUrDt2RJFHvHazQEBXHKU9sLLUvrB3wS5ZsHt7KdxvmzxlBR+lR161oQEihXsap8X
         hkg6+WoEy3wGBfPzqEAhQOT+zApDKOjBj6yhcL9U+nxNfUKnVS9Ks+9bvPTXN4V/CkuS
         8bJVn+VlpHry65Xc7lveYUm6hhhw34aHS0fELcVuTyNajmuc+QkOc8MYRlKJIJIy2wC2
         ZdxPIAfSE24QEiVXFquHiWRcBl8AoXDElVe+o8S+X28hVeWgaax3hlbfIwPdge6XoGbt
         W26v7tlz28hqNBPlEjudQjUeug5XwlqrjEor2OEKekV+Afruc6Cc5t8SZHasHC05FDRU
         tsmg==
X-Received: by 10.182.60.130 with SMTP id h2mr130187obr.42.1438636980890; Mon,
 03 Aug 2015 14:23:00 -0700 (PDT)
Received: by 10.182.26.73 with HTTP; Mon, 3 Aug 2015 14:22:31 -0700 (PDT)
In-Reply-To: <xmqq8u9s86n3.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275208>

On Tue, Aug 4, 2015 at 1:51 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> This is part of my GSoC project to unify git tag -l, git branch -l,
>> git for-each-ref.  This patch series is continued from: Git (next)
>> https://github.com/git/git/commit/bf5418f49ff0cebc6e5ce04ad1417e1a47c81b61
>>
>> This series consists of porting tag.c over to using the ref-filter APIs
>>
>> Version 7 can be found here:
>> http://thread.gmane.org/gmane.comp.version-control.git/274990
>>
>> Changes:
>> * Make padright a general align atom.
>> * Make print_value() and emit() output to a strbuf rather than stdout directly.
>>
>> Interdiff:
>>
>> diff --git a/Documentation/git-for-each-ref.txt
>> b/Documentation/git-for-each-ref.txt
>> index bcf319a..e89b9b0 100644
>> --- a/Documentation/git-for-each-ref.txt
>> +++ b/Documentation/git-for-each-ref.txt
>> @@ -127,11 +127,12 @@ color::
>>      Change output color.  Followed by `:<colorname>`, where names
>>      are described in `color.branch.*`.
>>
>> -padright::
>> -    Pad succeeding atom or string to the right. Followed by
>> -    `:<value>`, where `value` states the total length of atom or
>> -    string including the padding. If the `value` is lesser than
>> -    the atom or string length, then no padding is performed.
>> +align::
>> +    Align succeeding atoms to the right, left or middle. Followed
>> +    by `:<type>,<paddinglength>`, where the `<type>` is either
>> +    left, right or middle and `<paddinglength>` is the total
>> +    length of the padding to be performed. If the atom length is
>> +    more than the padding length then no padding is performed.
>
> It is very very dissapointing to allow the "next atom only"
> implementation to squat on a good name "align:<type>,<width>",
> especially when I thought that the list agreed
>
>   %(align:<type>,<width>) any string with or without %(atom) %(end)
>
> would be the way to go.

>From what I read, I thought we wanted the next atom or string to be
aligned, if we need to align everything within the %(end) atom. I could
do that :)

-- 
Regards,
Karthik Nayak
