From: Ronnie Sahlberg <sahlberg@google.com>
Subject: Re: [PATCH v11 13/41] refs.c: change ref_transaction_create to do
 error checking and return status
Date: Wed, 28 May 2014 07:55:18 -0700
Message-ID: <CAL=YDWkQhq2oCkyBG0-ojUDwgApYj1qZt1vXa2gnYsJOEbnvxQ@mail.gmail.com>
References: <1401222360-21175-1-git-send-email-sahlberg@google.com>
	<1401222360-21175-14-git-send-email-sahlberg@google.com>
	<20140528004200.GK12314@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 28 16:55:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WpfGG-0006l9-9E
	for gcvg-git-2@plane.gmane.org; Wed, 28 May 2014 16:55:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753458AbaE1OzU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 May 2014 10:55:20 -0400
Received: from mail-vc0-f172.google.com ([209.85.220.172]:63930 "EHLO
	mail-vc0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752169AbaE1OzU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 May 2014 10:55:20 -0400
Received: by mail-vc0-f172.google.com with SMTP id ik5so9121436vcb.31
        for <git@vger.kernel.org>; Wed, 28 May 2014 07:55:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=1FVNA5NGyfvR+zcnUTtm6S3zRwyqL0OZB6W14r1bP0k=;
        b=akwdXLxPBOC592SrJqRlqLtyVxj53ILRz/R1fLN9znjJi+DEZ6G8eZ/P7RT4oPrc4m
         nhYfRJqCRQ6aJS1ric+zGyhZ/lCo8US/eBRkunl7ybIgjaE5EEd2qRUQZu9t4p10YZPz
         bqIVIguH7zlMBoQeUPIyNL5ucXjPU+W3C6XSGHurBXkEMyZValqxMzX1NbSFmHXXM6BJ
         HttUIzmAp7ghLZ9c3LNMu9vgBdvbe35aLxk/wWwiXV988Y36T19hlslZ7xgPjkMv61M7
         ZTHMM4GB4jTA3U4+rVMI9+uZawUIqY/I/T10rs1NHLVD7bEsvSzHMnZXZ2sFfzVOxOmg
         Jtdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=1FVNA5NGyfvR+zcnUTtm6S3zRwyqL0OZB6W14r1bP0k=;
        b=PAXD13V7P8B5hII5MMOtERe5Y82sflQd3OAsrQK3qxXsFRaBpwN0VJ5BznhKseyNCZ
         0sfb99fLZtlz1CBflo2PQRZvZhxjypMyKvpLB52AhQzf3bONvysOiZhLwQLO341Q6Zj5
         FnFTKqXPvYZO/CKKXGM9WUNmUM6mGTExHZTuuFKaETrJqyNsWh1+Dp0b6sPx809r2YwO
         c81bHlda5VcWFGVnD2BC23GiK+cbojkez+ByddP8YqPX+0hd2KdX2bFKHbdqQuDA2FY7
         XqPTaxVZALlC53noYkaV4N/BN9XVRCf5+fYZymRxsKetp0BlcaLxl8G0lavGgxEg3+zj
         7Y0g==
X-Gm-Message-State: ALoCoQm7KhZe9A48dGkV8epvDb0OcrZCajhjdlpEGIdw894ahrwlQ5V3RMz30R0VidEOKFbPetwe
X-Received: by 10.52.100.3 with SMTP id eu3mr106627vdb.68.1401288919046; Wed,
 28 May 2014 07:55:19 -0700 (PDT)
Received: by 10.52.6.163 with HTTP; Wed, 28 May 2014 07:55:18 -0700 (PDT)
In-Reply-To: <20140528004200.GK12314@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250287>

On Tue, May 27, 2014 at 5:42 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> Hi,
>
> Ronnie Sahlberg wrote:
>
>> --- a/refs.h
>> +++ b/refs.h
>> @@ -215,6 +215,15 @@ enum action_on_err {
>>  };
>>
>>  /*
>> + * Transaction functions that take an err argument will append an error
>> + * string to this buffer if there was a failure.
>> + * This string is not cleared on each call and may contain an aggregate of
>> + * errors from several previous calls.
>> + * If the caller needs a guarantee that the buffer will only contain the
>> + * current or most recent error it must call strbuf_reset before calling
>> + * the transaction function.
>> + */
>> +/*
>
> If I look at the documentation for ref_transaction_create(), it is not
> obvious I should look up here for how it handles errors.  Not sure how
> to fix that --- maybe this should go in a new
> Documentation/technical/api-ref-transactions.txt file?  Or maybe the
> top of refs.h where struct ref_transaction is declared.
>
> The content seems odd to me.  It says the string will contain an
> aggregate of errors from previous calls, but what it doesn't say is
> that that aggregate is a bunch of error messages juxtaposed without a
> newline or space between.  Is the idea that some callers will want
> this aggregate?
>
> Wouldn't it be clearer to say how the err argument is meant to be used
> from the caller's perspective?  E.g.,
>
>         On error, transaction functions append a message about what
>         went wrong to the 'err' argument.  The message mentions what
>         ref was being updated (if any) when the error occurred so it
>         can be passed to 'die' or 'error' as-is:
>
>                 if (ref_transaction_update(..., &err)) {
>                         ret = error("%s", err.buf);
>                         goto cleanup;
>                 }
>
> If it's expected that the err argument will be used to aggregate
> multiple messages in some callers then it would be useful to give an
> example of that, too, but I don't think that's needed.

Thanks. Updated the comment in refs.h

>
> Jonathan
