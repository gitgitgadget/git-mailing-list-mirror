From: Ronnie Sahlberg <sahlberg@google.com>
Subject: Re: [PATCH v8 30/44] refs.c: add transaction.status and track OPEN/CLOSED/ERROR
Date: Wed, 21 May 2014 15:11:29 -0700
Message-ID: <CAL=YDW=Vpc8XGLGUTgKQc4yP5v+ViN02EeLzgRipntskok+fbw@mail.gmail.com>
References: <1400174999-26786-1-git-send-email-sahlberg@google.com>
	<1400174999-26786-31-git-send-email-sahlberg@google.com>
	<20140521220035.GE12314@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 22 00:11:36 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WnEjX-0004Ve-N2
	for gcvg-git-2@plane.gmane.org; Thu, 22 May 2014 00:11:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753475AbaEUWLc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 May 2014 18:11:32 -0400
Received: from mail-vc0-f177.google.com ([209.85.220.177]:54119 "EHLO
	mail-vc0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753351AbaEUWLb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 May 2014 18:11:31 -0400
Received: by mail-vc0-f177.google.com with SMTP id if11so17934vcb.8
        for <git@vger.kernel.org>; Wed, 21 May 2014 15:11:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=GFa9TD9X3kxBqN1kB3/1wDBdaUzGlUyr0iBQazrBs8A=;
        b=H9QAZxj4dEBDXhe5o7/XGFG+g0YfxAomxxEzzxmrUXuNYnPK8wMXWkFhXtZVjH94LW
         jnmZYWDwvhIJTp6vls/OkOwWHcQf6n63iECs2fXlI57hP6NPp1dS3iyvKWmwt42xMa2g
         gTilTzW0iWV6TEcY4z15O9RfsmQHv53m7TyWDKXqur7CFjeKM2RHLtELPjU79NDXbaMp
         cZdqYyJDFUamnwPrXPI56qA5boWW/3vW/LPPlLQNd+l1Rf7Sbk/PEs6GfsvAkDivrU1F
         q80OTWQR4ubwQ1sEm20xJT83SrQLEpyPSM7u79TaLfrueU3PDEs0uxGmhcJay279WaFj
         wfzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=GFa9TD9X3kxBqN1kB3/1wDBdaUzGlUyr0iBQazrBs8A=;
        b=g/sjJOpXSFQMu9Vd0HcIBdxffyTAUrs8hFIc23bgL+pnLrKaPTEZgmsMxw4Mt+gyin
         zVr1kIFZZC+58QHEWYkc7PROcpMpoopt6rrD6YlOG7hn76PdNUiZlnRxZ6ye3Kp3CwzD
         QpqGsgb8ZPkvqZZMZQs7GdvIus1r8Moox9GEYH9OMyD3+2feL4HTB3VdrdYe98yQLjYs
         B2Wd+9M91DiFZhQuT/SqRqm9LdbamfjvVRyX2HPRtPz6tJ3FjmxhS2RQBJLoWDVZYpu0
         VVsHGuwzLUBJwvis8CB+Ut9CJDd4l08yDkmNiythNct79j37res8ggJs/5pi9dJxPMVW
         rL8A==
X-Gm-Message-State: ALoCoQll+5PYZRNXdslYSUyI309d/OV6EScSU3pQKpsLpYXfo1d0asODW8+aUi5lyfum0HsadGkN
X-Received: by 10.52.147.200 with SMTP id tm8mr2561333vdb.54.1400710289694;
 Wed, 21 May 2014 15:11:29 -0700 (PDT)
Received: by 10.52.6.163 with HTTP; Wed, 21 May 2014 15:11:29 -0700 (PDT)
In-Reply-To: <20140521220035.GE12314@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249848>

Please pull my ref-transactions branch.

On Wed, May 21, 2014 at 3:00 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> Ronnie Sahlberg wrote:
>
>> --- a/refs.c
>> +++ b/refs.c
>> @@ -3308,6 +3308,12 @@ struct ref_update {
>>       const char refname[FLEX_ARRAY];
>>  };
>>
>> +enum ref_transaction_status {
>> +     REF_TRANSACTION_OPEN   = 0,
>> +     REF_TRANSACTION_CLOSED = 1,
>> +     REF_TRANSACTION_ERROR  = 2,
>
> What is the difference between _TRANSACTION_CLOSED and
> _TRANSACTION_ERROR?

Closed is a transaction that has been committed successfully, and
which we can not do any more updates onto.
Error is a transaction that has failed, and which we can not do any
more updates onto.

The distinction could be useful if in the future we add support to
reuse a transaction

>
> [...]
>> @@ -3340,6 +3347,11 @@ void ref_transaction_free(struct ref_transaction *transaction)
>>
>>  void ref_transaction_rollback(struct ref_transaction *transaction)
>>  {
>> +     if (!transaction)
>> +             return;
>> +
>> +     transaction->status = REF_TRANSACTION_ERROR;
>> +
>>       ref_transaction_free(transaction);
>
> Once the transaction is freed, transaction->status is not reachable any
> more so no one can tell that you've set it to _ERROR.  What is the
> intended effect?

ref_transaction_rollback is no more. It has been removed.

>
> [...]
>> @@ -3366,6 +3378,9 @@ int ref_transaction_update(struct ref_transaction *transaction,
>>       if (have_old && !old_sha1)
>>               die("BUG: have_old is true but old_sha1 is NULL");
>>
>> +     if (transaction->status != REF_TRANSACTION_OPEN)
>> +             die("BUG: update on transaction that is not open");
>
> Ok.
>
> [...]
>> @@ -3538,6 +3564,9 @@ int ref_transaction_commit(struct ref_transaction *transaction,
>>       clear_loose_ref_cache(&ref_cache);
>>
>>  cleanup:
>> +     transaction->status = ret ? REF_TRANSACTION_ERROR
>> +       : REF_TRANSACTION_CLOSED;
>
> Nit: odd use of whitespace.

fixed in ref-transactions.


>
> Overall thoughts: I like the idea of enforcing the API more strictly
> ("after an error, the only permitted operations are...").  The details
> leave me a little confused because I don't think anything is
> distinguishing between _CLOSED and _ERROR.  Maybe the enum only needs
> two states.

A buggy caller might do :

transaction_begin()
transaction_update()
transaction_commit()  (A)
transaction_update() (B)
transaction_commit() (C)

After A the transaction in no longer open and until we decide we want
to add support for re-usable transactions (which may or may not be a
good idea) we need to make sure that both B and C fails.
Since the transaction in A completed successfully we can't really mark
is as ERROR, instead we flag it as CLOSED.



>
> Thanks,
> Jonathan
