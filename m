From: Ronnie Sahlberg <sahlberg@google.com>
Subject: Re: [PATCH v11 25/41] fast-import.c: use a ref transaction when
 dumping tags
Date: Wed, 28 May 2014 15:06:26 -0700
Message-ID: <CAL=YDWkUhdoJkdg_zaq+p=XRu7H9fqNXDz89uPhbr4equTyVLQ@mail.gmail.com>
References: <1401222360-21175-1-git-send-email-sahlberg@google.com>
	<1401222360-21175-26-git-send-email-sahlberg@google.com>
	<20140528194746.GX12314@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 29 00:06:40 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wplza-0004qg-Hh
	for gcvg-git-2@plane.gmane.org; Thu, 29 May 2014 00:06:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755685AbaE1WGd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 May 2014 18:06:33 -0400
Received: from mail-ve0-f178.google.com ([209.85.128.178]:45445 "EHLO
	mail-ve0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755563AbaE1WG1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 May 2014 18:06:27 -0400
Received: by mail-ve0-f178.google.com with SMTP id sa20so13173968veb.23
        for <git@vger.kernel.org>; Wed, 28 May 2014 15:06:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=z09ROVDQeXmejsPnpIhGL06FRvRWhsF4DAkdeclPrOc=;
        b=E6L9geM9swxIgpKNvwvFocdCGDo2onwsX5iS3Yycj5M7R9lfQ/TJnsnl+FRlOWZxdr
         OPj/Pv+AmMLY8C9c+0+Tzp+Bhsp5LzmIkcN8FgCQEmVKPLCCEqdVj8TNT5rXLvkbOPbW
         xeN/3nIPo0CM83o7lr+ASSi37K5bJ22xPK5vA1n6J/y8ePbkY06vgpjA39bOCQx6t1B1
         pFKCDH1Jz4gmL1V35lHRHTfK8wqaZHDCeUzJ8pKSV1kYkG7+9SP/9vY+klSGvzq2xTiq
         HHdD9R/wXEtiHq4H6ZhUSAXO/Q+G2ydhT8KSTH7EPDjMsSPRmemUv1JBPSKFzU9QXmb7
         SpLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=z09ROVDQeXmejsPnpIhGL06FRvRWhsF4DAkdeclPrOc=;
        b=QCmnz/2+fp3wKJJ+VU6q1rl5jiCqoz0dNOxP1cJQYJWM0APliIvnnLXOR/9xdyHMcZ
         v40ax3zs4WFIqAKaDGuN1CBjfht7bsmJfjYD++36b+TjtV8uZTN4oFwfl0PkAKk8XFyx
         KbfwOMEC1Vu6P1tzj1zeCnQAdh1HdWXqYCbwbT1a72v8AG5uiNE+IeiZPT2WH2uyGimB
         g1f7eywZXJ4JfuOWz/8GmcOg/5Lc8vEfqb/AmLjvcilwjyffiXtnpWXwQaLZgwxUDC8u
         minRhcYohS5Q8/B61seh+ZeCw+tybZstkI4/m61Z8Wxqsd77rhZUN1gsEwMEVtttr+JP
         l9JA==
X-Gm-Message-State: ALoCoQmbBMk0IonrGorqImh4OrZhHlh4bkHc68kHCrknGkYIzO5T+PXg5Irb/mAzM184uwHSoRme
X-Received: by 10.52.164.70 with SMTP id yo6mr2170929vdb.67.1401314786723;
 Wed, 28 May 2014 15:06:26 -0700 (PDT)
Received: by 10.52.6.163 with HTTP; Wed, 28 May 2014 15:06:26 -0700 (PDT)
In-Reply-To: <20140528194746.GX12314@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250337>

On Wed, May 28, 2014 at 12:47 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> Ronnie Sahlberg wrote:
>
>> --- a/fast-import.c
>> +++ b/fast-import.c
>> @@ -1735,15 +1735,22 @@ static void dump_tags(void)
>>  {
>>       static const char *msg = "fast-import";
>>       struct tag *t;
>> -     struct ref_lock *lock;
>>       char ref_name[PATH_MAX];
>> +     struct strbuf err = STRBUF_INIT;
>> +     struct ref_transaction *transaction;
>>
>> +     transaction = ref_transaction_begin(&err);
>>       for (t = first_tag; t; t = t->next_tag) {
>> -             sprintf(ref_name, "tags/%s", t->name);
>> +             snprintf(ref_name, PATH_MAX, "refs/tags/%s", t->name);
>
> That ignores the error if the refname happens to go longer than
> PATH_MAX.
>
> This is the part of fast-import that doesn't need to be super
> fast ;-).  (The objects have been written to the pack, and now
> we just need to write some refs.)  Could this use a strbuf?  By that,
> I mean something like
>
> diff --git i/fast-import.c w/fast-import.c
> index 3db5b3d..d5f6e63 100644
> --- i/fast-import.c
> +++ w/fast-import.c
> @@ -1735,21 +1735,28 @@ static void dump_tags(void)
>  {
>         static const char *msg = "fast-import";
>         struct tag *t;
> -       char ref_name[PATH_MAX];
> +       struct strbuf ref_name = STRBUF_INIT;
>         struct strbuf err = STRBUF_INIT;
>         struct ref_transaction *transaction;
>
> +       strbuf_addstr(&ref_name, "refs/tags/");
> +
>         transaction = ref_transaction_begin(&err);
>         for (t = first_tag; t; t = t->next_tag) {
> -               snprintf(ref_name, PATH_MAX, "refs/tags/%s", t->name);
> +               strbuf_setlen(&ref_name, strlen("refs/tags/"));
> +               strbuf_addstr(&ref_name, t->name);
>
> -               if (ref_transaction_update(transaction, ref_name, t->sha1,
> -                                          NULL, 0, 0, &err))
> -                       break;
> +               if (ref_transaction_update(transaction, ref_name.buf, t->sha1,
> +                                          NULL, 0, 0, &err)) {
> +                       failure |= error("%s", err.buf);
> +                       goto done;
> +               }
>         }
>         if (ref_transaction_commit(transaction, msg, &err))
>                 failure |= error("%s", err.buf);
> +done:
>         ref_transaction_free(transaction);
> +       strbuf_release(&ref_name);
>         strbuf_release(&err);
>  }

Changed to strbuf.  Thanks.

>
