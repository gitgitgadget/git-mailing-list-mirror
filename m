From: Ronnie Sahlberg <sahlberg@google.com>
Subject: Re: [PATCH v8 26/44] fast-import.c: use a ref transaction when
 dumping tags
Date: Tue, 20 May 2014 13:53:27 -0700
Message-ID: <CAL=YDW=6jaTom5vUTU9YK3D93dGH8rB799Yt+X6bmSAR5-ZmUw@mail.gmail.com>
References: <1400174999-26786-1-git-send-email-sahlberg@google.com>
	<1400174999-26786-27-git-send-email-sahlberg@google.com>
	<20140520203857.GS12314@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 20 22:53:34 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wmr2T-0000Jx-PA
	for gcvg-git-2@plane.gmane.org; Tue, 20 May 2014 22:53:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751218AbaETUxa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 May 2014 16:53:30 -0400
Received: from mail-vc0-f175.google.com ([209.85.220.175]:42416 "EHLO
	mail-vc0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751210AbaETUx3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 May 2014 16:53:29 -0400
Received: by mail-vc0-f175.google.com with SMTP id hu19so1355247vcb.34
        for <git@vger.kernel.org>; Tue, 20 May 2014 13:53:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=HbAyvclKFS1nzJKcCCaJv2OSVSWS5KhfuMY3d5QajxE=;
        b=HS9gYUa6/dizRSuxH3DEtZy1mnx1j+gVqCbtJKtL3IRpzdYWVmjDSQLRFfzhTW6gpN
         exG7wOvlRI8Smb4Ic3oL1KG3wPYrM5K4NqL6ZXQNGv4JyFSlgOrZ/PukZ9yTuUBeBEQy
         JZbcBvGsiGDCHYF3Qkiuo8f+YSWfSRTnZX74g+s1YAluJ3MoEwKJkuz81gZ124d41VQr
         5KPjs5GM7VICvFLiE8gOpwL5LHQqJECcO51uSg86E0XdwHy6RBNUn9R8NTK8G9WVuAwR
         Ib+GjydwG4WHfL1qdzKaYSasJz66tKpP9uk/XwTxc+62Km1slhbopZBnSFJDfomtSmhc
         cO8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=HbAyvclKFS1nzJKcCCaJv2OSVSWS5KhfuMY3d5QajxE=;
        b=CWsIFKKmtsRmKuMF4wcP0g3Me4mvY+cU38QTu4RIQEuHg4QvBbiz4qHJVe3hEICFQt
         diynP6bKbieNLidhBtBBv5OkUzhdVKGT4SAYHgi+sm7Mhim2+tVZRnrfp/dPQAXyDTy7
         bwjLpFrdhtUmCYVR5vI3TyFVtw/CXxFmNg2WzhtNRrlQVT0Iqp/z23N61giVgywzsSz2
         gIcP+YoeNm49UbqZhYTQ6/WzY+fTJMlCIKRiGNv9MJNIc08YpppS2ME/WSDG7ZL3/e21
         5AO3h1ckiQ5Kw4d58xRge61BWwkQtQmsSY9Xue2Gnxh1ko1iE75AX/UO9TQOVNQq16FC
         h23A==
X-Gm-Message-State: ALoCoQm1m9F9GUH1bnx1WcPy8t4pm5Kb0zVd4NqXItKENghiX4t/hIC70GzR0WL1a9TtXA8ckEUO
X-Received: by 10.58.198.75 with SMTP id ja11mr182288vec.59.1400619207964;
 Tue, 20 May 2014 13:53:27 -0700 (PDT)
Received: by 10.52.6.163 with HTTP; Tue, 20 May 2014 13:53:27 -0700 (PDT)
In-Reply-To: <20140520203857.GS12314@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249742>

On Tue, May 20, 2014 at 1:38 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> Ronnie Sahlberg wrote:
>
>> [Subject: fast-import.c: use a ref transaction when dumping tags]
>
> This seems like an odd thing to do: either it would make sense to have
> a single transaction for all imported refs so all fail or succeed
> together, or there would be separate transactions for each ref.
>
> That said, I don't mind, particularly if it's a step on the way to
> using a single transaction for everything being dumped.

For now they are two transactions but I will merge them into a single one later.

>
> [...]
>> --- a/fast-import.c
>> +++ b/fast-import.c
>> @@ -1736,15 +1736,22 @@ static void dump_tags(void)
>>  {
>>       static const char *msg = "fast-import";
>>       struct tag *t;
>> -     struct ref_lock *lock;
>>       char ref_name[PATH_MAX];
>> +     struct strbuf err = STRBUF_INIT;
>> +     struct ref_transaction *transaction;
>>
>> +     transaction = ref_transaction_begin();
>>       for (t = first_tag; t; t = t->next_tag) {
>> -             sprintf(ref_name, "tags/%s", t->name);
>> +             sprintf(ref_name, "refs/tags/%s", t->name);
>
> Can this overflow the buffer?

Changed to snprint. (We probably should do this everywhere.)

>
>> -             lock = lock_ref_sha1(ref_name, NULL);
>> -             if (!lock || write_ref_sha1(lock, t->sha1, msg) < 0)
>> -                     failure |= error("Unable to update %s", ref_name);
>> +
>> +             if (ref_transaction_update(transaction, ref_name, t->sha1,
>> +                                        NULL, 0, 0, &err)) {
>> +                     failure |= 1;
>> +                     break;
>> +             }
>>       }
>> +     if (failure || ref_transaction_commit(transaction, msg, &err))
>> +             failure |= error("Unable to update %s", err.buf);
>
> This 'if (failure || ...) failure |=' idiom seems strange.
> Is err.buf always set if failure is nonzero?
>
> Elsewhere failure is 0 or -1 but this introduces the possibility for
> it to be temporarily 1.
>
> dump_branches could have caused failure to be -1 before dump_tags
> is called.  I think the intent is
>
>                 if (ref_transaction_update(...)) {
>                         failure |= error(...);
>                         goto out;
>                 }
>         }
>         if (ref_transaction_commit(...))
>                 failure |= error(...);
>  out:
>         ref_transaction_free(transaction);
>         ...
>

Actually, since the recent change to make _commit fail if the
transaction has an error, what we want is something like this :

    ...
        if (ref_transaction_update(transaction, ref_name, t->sha1,
NULL, 0, 0, &err))
            break;
    }
    if (ref_transaction_commit(transaction, msg, &err))
        failure |= error("%s", err.buf);
    ...


Please see updated ref-transactions branch.


Thanks.

> Thanks,
> Jonathan
