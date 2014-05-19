From: Ronnie Sahlberg <sahlberg@google.com>
Subject: Re: [PATCH v8 24/44] fetch.c: use a single ref transaction for all
 ref updates
Date: Mon, 19 May 2014 09:56:43 -0700
Message-ID: <CAL=YDWkmYxTm_RJ2O0Wt0xW8MxsmyZD2nDa=4_p9wQYKFPTvVw@mail.gmail.com>
References: <1400174999-26786-1-git-send-email-sahlberg@google.com>
	<1400174999-26786-25-git-send-email-sahlberg@google.com>
	<20140516225211.GI12314@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 19 18:56:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WmQru-0004eB-DP
	for gcvg-git-2@plane.gmane.org; Mon, 19 May 2014 18:56:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932610AbaESQ4q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 May 2014 12:56:46 -0400
Received: from mail-ve0-f178.google.com ([209.85.128.178]:40330 "EHLO
	mail-ve0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751790AbaESQ4o (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 May 2014 12:56:44 -0400
Received: by mail-ve0-f178.google.com with SMTP id sa20so6883782veb.9
        for <git@vger.kernel.org>; Mon, 19 May 2014 09:56:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=WRFhEwDCYwxpTShm3S2xzYacXj9VH++/w8gYb6Ysu8M=;
        b=SFKPb8T5L3RYuWN+wbBXWVNWoou7dv9qCPF9ZQ3Q/B9W/WmYIUcELiEBc0jtK0SYfj
         4993Bimt7eHD9QajAmAJAkUcXf2ifEY48mTq+EXGZFJW54aJ00Ap/a9O3vQQGs9DIYpU
         /o4uWEDua3XnUj1H5Nd2oe27OjTY0f0HULPDxAdDVYXoXji/Kmo3aWij7aQwPNioeyaT
         Tvu6QbvR5gD9tlQLC1vv2GbfzetLA0xdSB/1i7F/9ATeKbrCkuCvaBiP5OYrP4TI8qZS
         UddCDXGcoqHR3diPdC0RQlOY5/NVDI9beBHK2flCe6kbJXrHrkHy6ecqOui73ybk42UH
         ioSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=WRFhEwDCYwxpTShm3S2xzYacXj9VH++/w8gYb6Ysu8M=;
        b=C8BZGGXskP1yQfWX847IZkDxXZeY+61lmYcTQUgV9uxs0tNrsNLLJQVxzDG0cst0td
         IOV0P3NbMgdCHOCCfst28ScbHZL1xshUKJq2FeuXN5H7R7rVKs6NCmKhuWQ/M2pgoYjQ
         E54jg6TOWdnOxLo1KHLEg3fFNUiIbQwjODhCJ6jM7FHabP5QFpxXgBe+5wwkzZunxmuY
         Q/zW1aeizgrysbxuOF1Laz3q5OTSaDU0K+VED8IR9fDYSj8DPssqr5FDbWLGV51vl4By
         xetD221pJt7jw4D7NhZ7nQfXaKU0HlEqw1D+pVnSyl4mZS9sxrRSTNpmsHMr7kw076MM
         +Vsg==
X-Gm-Message-State: ALoCoQmsPH+StqATYyOUpekPIrTnFyeuOeou+sPaXFuiHigu7GrjvhgYiy/egwfkotNGpI4a0iFe
X-Received: by 10.58.186.207 with SMTP id fm15mr32559855vec.4.1400518603634;
 Mon, 19 May 2014 09:56:43 -0700 (PDT)
Received: by 10.52.6.163 with HTTP; Mon, 19 May 2014 09:56:43 -0700 (PDT)
In-Reply-To: <20140516225211.GI12314@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249599>

On Fri, May 16, 2014 at 3:52 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> Ronnie Sahlberg wrote:
>
>> Change store_updated_refs to use a single ref transaction for all refs that
>> are updated during the fetch. This makes the fetch more atomic when update
>> failures occur.
>
> Fun.
>
> [...]
>> --- a/builtin/fetch.c
>> +++ b/builtin/fetch.c
> [...]
>> @@ -373,27 +374,13 @@ static int s_update_ref(const char *action,
>>                       struct ref *ref,
>>                       int check_old)
>>  {
>> -     char msg[1024];
>> -     char *rla = getenv("GIT_REFLOG_ACTION");
>> -     struct ref_transaction *transaction;
>
> Previously fetch respected GIT_REFLOG_ACTION, and this is dropping
> that support.  Intended?

I think it was added back later in the series when
ref_transaction_update started taking a "msg" argument.
I have reordered the patches in the ref-transactions so that the fetch
updates come after we add msg support to _update.

Please see current builtin/fetch.c in my ref-transactions branch.


>
> [...]
>> +     if (ref_transaction_update(transaction, ref->name, ref->new_sha1,
>> +                            ref->old_sha1, 0, check_old))
>> +             return STORE_REF_ERROR_OTHER;
>
> Should pass a strbuf in to get a message back.

I added err strbuf to both update and commit and now also error("%s",
err.buf) on failure.


>
> [...]
>> +
>>       return 0;
>>  }
>>
>> @@ -565,6 +552,13 @@ static int store_updated_refs(const char *raw_url, const char *remote_name,
>>               goto abort;
>>       }
>>
>> +     errno = 0;
>> +     transaction = ref_transaction_begin();
>> +     if (!transaction) {
>> +             rc = error(_("cannot start ref transaction\n"));
>> +             goto abort;
>
> error() appends a newline on its own, so the message shouldn't
> end with newline.
>
> More importantly, this message isn't helpful without more detail about
> why _transaction_begin() failed.  The user doesn't know what
>
>         error: cannot start ref transaction
>
> means.
>
>         error: cannot connect to mysqld for ref storage: [etc]
>
> would tell what they need to know.  That is:
>
>         transaction = ref_transaction_begin(err);
>         if (!transaction) {
>                 rc = error("%s", err.buf);
>                 goto abort;
>         }
>

I add this in the next patch series. Right now ref_transaction_begin
can never return failure back to the caller.


> errno is not used here, so no need to set errno = 0.

removed.

>
> [...]
>> @@ -676,6 +670,10 @@ static int store_updated_refs(const char *raw_url, const char *remote_name,
>>                       }
>>               }
>>       }
>> +     if ((ret = ref_transaction_commit(transaction, NULL)))
>> +             rc |= ret == -2 ? STORE_REF_ERROR_DF_CONFLICT :
>> +                             STORE_REF_ERROR_OTHER;
>
> (I cheated and stole the newer code from your repo.)
>
> Yay!  Style nit: git avoids assignments in "if" conditionals.
>
>         ret = ref_tr...
>         if (ret == -2)
>                 rc |= ...
>         else if (ret)
>                 rc |= ...
>
> Does _update need the too as futureproofing for backends that can
> detect the name conflict sooner?

Yes it will. I will update the next series to do this. If _update
fails with name conflict it will return -2.
Also it will store the status in the transaction so that a later call
to _commit will also return -2.



>
> Thanks,
> Jonathan
