From: Ronnie Sahlberg <sahlberg@google.com>
Subject: Re: [PATCH v11 16/41] refs.c: add transaction.status and track OPEN/CLOSED/ERROR
Date: Wed, 28 May 2014 14:50:34 -0700
Message-ID: <CAL=YDWnq=MPF3EYZLJJxR8TJLF=QSk5v=OpZC7S97GqL3=3Zbw@mail.gmail.com>
References: <1401222360-21175-1-git-send-email-sahlberg@google.com>
	<1401222360-21175-17-git-send-email-sahlberg@google.com>
	<20140528185123.GT12314@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 28 23:50:45 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wplk7-0005BO-8b
	for gcvg-git-2@plane.gmane.org; Wed, 28 May 2014 23:50:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752878AbaE1Vuf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 May 2014 17:50:35 -0400
Received: from mail-vc0-f178.google.com ([209.85.220.178]:60983 "EHLO
	mail-vc0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752180AbaE1Vue (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 May 2014 17:50:34 -0400
Received: by mail-vc0-f178.google.com with SMTP id ij19so9664373vcb.23
        for <git@vger.kernel.org>; Wed, 28 May 2014 14:50:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=lr6cWfUVyXjpJpZHOyyrpSPXLjAKOx12GN7Y/liFrQE=;
        b=ikIF/5MyzPWVoR2//npy4iV+AJBH3RPZR75M5CSVVoDJkKNFzXIOK0vMn+wjCGbeDz
         JnhMcwdpsntRna3wq2f4clzFy1nlakowqb7Fm/HSci/ZLXkUcGcIb/ACRmlxN6K/c55P
         QSlEA3FFus5tJwOp9ZAc9YNnBGCDjE30F245p/SupEpvkbRUeRVAJYSKFQJmbk7hjshy
         egji+xaSkqnW+jVspT1su/zt4VI21E4S8U50lp3TA3SQrbbub8SNu/+9hQtZ5h+wiLG2
         Q5cEdx56YuuKxouDG+A4cuCJx4+r84S2LDhQxqwrB1PKllAP02pnHZtjCvYAb8OQlEJM
         /nDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=lr6cWfUVyXjpJpZHOyyrpSPXLjAKOx12GN7Y/liFrQE=;
        b=Rf5Jz+lQuywmdmYNuXJ9EOW/fhPk0tNi7Vc05gZeAYFm+tqDYGnNAxcMp6c4rdTRQ3
         kClSXE7nrd1ytJGvtmCWgk7oVp/0f/wRATDzX68N8W3mPew7edcJZc1mmAR3h1/fGIJi
         xBkDqJSPsMStSSje8Fs14jSOM8pJ4ZSvBJ9HLkNn6E47Bnl+lJ90tXHAwpOFJpjaAR+R
         s7x4c0bbY/tVG8Erkh43ZG91D5et2fkBcxcz9aY0iMIWsBL5wo5cccLvEEm2zajN3DX6
         zUauSW3W/w09X6CzQpeDSAUm9K2fLe3lqoK9uB2e6BxJDdptwg7RG6vWzBAYyBWx7kvz
         Shiw==
X-Gm-Message-State: ALoCoQk5xUciTsTK1g2PpiZiW4Qs+S69GbsggoEQ69U1bdeIpwlsjavL9esosUpZcBXTaBYtx4hs
X-Received: by 10.52.137.83 with SMTP id qg19mr2353019vdb.60.1401313834108;
 Wed, 28 May 2014 14:50:34 -0700 (PDT)
Received: by 10.52.6.163 with HTTP; Wed, 28 May 2014 14:50:34 -0700 (PDT)
In-Reply-To: <20140528185123.GT12314@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250333>

On Wed, May 28, 2014 at 11:51 AM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> Ronnie Sahlberg wrote:
>
>> --- a/refs.c
>> +++ b/refs.c
> [...]
>> @@ -3385,6 +3408,9 @@ int ref_transaction_update(struct ref_transaction *transaction,
>>  {
>>       struct ref_update *update;
>>
>> +     if (transaction->state != REF_TRANSACTION_OPEN)
>> +             return -1;
>
> I still think this is a step in the wrong direction.  It means that
> instead of being able to do
>
>         if (ref_transaction_update(..., &err))
>                 die("%s", err.buf);
>
> and be certain that err.buf has a meaningful message, now I have to
> worry that if the state were not REF_TRANSACTION_OPEN (e.g., due to
> someone else's code forgetting to handle an error) then the result
> would be a plain
>
>         fatal:
>
> The behavior would be much easier to debug if the code were
>
>         if (transaction->state != REF_TRANSACTION_OPEN)
>                 die("BUG: update on transaction that is not open");
>
> since then the symptom would be
>
>         fatal: BUG: update on transaction that is not open
>
> which is easier to work with.
>
> If a non-OPEN state were a normal, recoverable error, then it could
> append a message to the *err argument.  But there's no message that
> could be put there that would be meaningful to the end-user.  So I
> suspect it's not a normal, recoverable error.
>
> If we want to collect errors to make _commit() later fail with a
> message like '38 refs failed to update' or something (or a
> string_list, if the API is to change that way in the future), then
> _update() should not fail.

Agreed.
I have removed the if (transaction->state != REF_TRANSACTION_OPEN)
check from _update/_delete/_create and documented this usecase.

Thanks.!

  It can record information about what is
> wrong with this update in the transaction and succeed so the caller
> knows to keep going and collect other updates before the _commit()
> that will fail.
>
> Of course it's easily possible I'm missing something.  That's just how
> I see it now.
>
> Does that make sense?

Makes perfect sense.
