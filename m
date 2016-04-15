From: Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [RFC PATCH, WAS: "weird diff output?"] Implement better chunk heuristics.
Date: Thu, 14 Apr 2016 19:07:10 -0700
Message-ID: <CA+P7+xrx8+q3Tn=9a1RmU9hSS+HFb5y6QLvvZfb1PqYrKVivcw@mail.gmail.com>
References: <CAGZ79ka8pgPNZKaVWnsa_S07esxkN9nJfhcMZvCfd5U6MtsrYQ@mail.gmail.com>
 <20160415000730.26446-1-sbeller@google.com> <CA+P7+xqEPq=G_PMA-=h6jzWaUP=6hmWXcLzxbogs2PyuAZcn4g@mail.gmail.com>
 <CAGZ79kZzb-4J82xONKX1RiAeLdJ7pGF1rBD4fJRyjbdZcPnkVA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>,
	Davide Libenzi <davidel@xmailserver.org>,
	Junio C Hamano <gitster@pobox.com>,
	Git mailing list <git@vger.kernel.org>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Fri Apr 15 04:07:36 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aqtAV-0001Kj-Nm
	for gcvg-git-2@plane.gmane.org; Fri, 15 Apr 2016 04:07:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751751AbcDOCHb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Apr 2016 22:07:31 -0400
Received: from mail-ig0-f179.google.com ([209.85.213.179]:35496 "EHLO
	mail-ig0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751535AbcDOCHb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Apr 2016 22:07:31 -0400
Received: by mail-ig0-f179.google.com with SMTP id gy3so8923761igb.0
        for <git@vger.kernel.org>; Thu, 14 Apr 2016 19:07:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=M04vUKfLZpTDOgmfVuydoxJiPditE5ij5WRpmuPUnAQ=;
        b=jbw4HusV96dvqnL3OjCgr9hBrXwrTojCNH0wgrMnMaKgSgqOHNg91Q4AJHVkpxE0S2
         yzPlqpvYxPrlbQiLGQ9uUjlCmTquEq9U+ow16ImO8cJYil8dsk1zhBkQIajFuC1vbsw/
         WjK14fA7LUDP4oRxsHpYtoDWsLdLdPlYZfqJKPlNAjmKhKf25vh1qJpOZ00ssH6MFQuN
         2d1udshwRPl6TWRVWgfszrgHt6dEet5oEEktYccDlM8u6xwLCF1KY76m6t7Z0s07tT73
         6nbcUfSt8dRcrlQWmAA2La4ocbc3oTfZV12bRF12IwfWIZJS/f3CGKO62d+QGwuyGW3c
         wUqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=M04vUKfLZpTDOgmfVuydoxJiPditE5ij5WRpmuPUnAQ=;
        b=SL8TXoSodIXs4Vw4HvfFQBU/hQuDc7UR1h4VSrRC743ZsLOHGqzslp5FxB4XqCch2B
         HzLIE6ug7TUTrFfb79fkavU+z9uTOnL+dhpASyFqI/QDubdr+SpeAr+PDJvgsvT8dRw+
         kqeKeyxP17B3pJcDK5emkjnyNkm6gkt7cieS6M4yD15HxxK6oFIVARwcmmu4uPsX63un
         uBvAQMMuwKteB5D9Z3I0lU1wmO2Whpi/PXmK26pXZC+Y+OJdJd65oZPcXZmJaoTINBsk
         QTMTO+Qex1KXRJzYxLTS0Ew3LtR16+4wucKoh0CDZPms3/4zBzT+FCgllFT9ataH/fe4
         f2bg==
X-Gm-Message-State: AOPr4FXskteNyhhbDzdfBlCI4mk1fzK85YvP+bASchk1RtEOfDQTpluT1cZqi3PVUa7apKtxoOkGpAkFq2tjaQ==
X-Received: by 10.50.189.233 with SMTP id gl9mr1728925igc.73.1460686049968;
 Thu, 14 Apr 2016 19:07:29 -0700 (PDT)
Received: by 10.107.59.78 with HTTP; Thu, 14 Apr 2016 19:07:10 -0700 (PDT)
In-Reply-To: <CAGZ79kZzb-4J82xONKX1RiAeLdJ7pGF1rBD4fJRyjbdZcPnkVA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291591>

On Thu, Apr 14, 2016 at 5:43 PM, Stefan Beller <sbeller@google.com> wrote:
> On Thu, Apr 14, 2016 at 5:26 PM, Jacob Keller <jacob.keller@gmail.com> wrote:
>> On Thu, Apr 14, 2016 at 5:07 PM, Stefan Beller <sbeller@google.com> wrote:
>>> TODO(sbeller):
>>> * describe the discussion on why this is better
>>> * see if this can be tested?
>>>
>>
>> Thanks for taking time to do this! It looks like a few things are
>> still missing, CRLF obviously, and making it a configuration option.
>
> I mainly wanted to get this out in the world quickly as it took me a while to
> understand the code. Do you know the feeling when you stare at code
> for hours and debug it and read headers to make sense of these
> cryptic variables and then after intensive thinking a clear image emerges?
>
> I put comments into the loop to convey my thought process on why that
> is enough code doing the job. So I'd be happy about a critical review. :)
>

Yes, I am glad you got it out here in the world. I'll do my best to
review it sometime early tomorrow. I know that feeling, and I tried to
do that for this code and started getting a headache so I stopped for
a bit.

I like the comments they help understand the process.

>>
>>> Signed-off-by: Stefan Beller <sbeller@google.com>
>>> ---
>>>  xdiff/xdiffi.c | 39 +++++++++++++++++++++++++++++++++++++++
>>>  1 file changed, 39 insertions(+)
>>>
>>> diff --git a/xdiff/xdiffi.c b/xdiff/xdiffi.c
>>> index 2358a2d..24eb9a0 100644
>>> --- a/xdiff/xdiffi.c
>>> +++ b/xdiff/xdiffi.c
>>> @@ -400,9 +400,16 @@ static xdchange_t *xdl_add_change(xdchange_t *xscr, long i1, long i2, long chg1,
>>>  }
>>>
>>>
>>> +static int starts_with_emptyline(const char *recs)
>>> +{
>>> +       return recs[0] == '\n'; /* CRLF not covered here */
>>> +}
>>> +
>>> +
>>>  int xdl_change_compact(xdfile_t *xdf, xdfile_t *xdfo, long flags) {
>>>         long ix, ixo, ixs, ixref, grpsiz, nrec = xdf->nrec;
>>>         char *rchg = xdf->rchg, *rchgo = xdfo->rchg;
>>> +       unsigned char has_emptyline;
>>>         xrecord_t **recs = xdf->recs;
>>>
>>>         /*
>>> @@ -436,6 +443,7 @@ int xdl_change_compact(xdfile_t *xdf, xdfile_t *xdfo, long flags) {
>>>
>>>                 do {
>>>                         grpsiz = ix - ixs;
>>> +                       has_emptyline = 0;
>>>
>>>                         /*
>>>                          * If the line before the current change group, is equal to
>>> @@ -447,6 +455,8 @@ int xdl_change_compact(xdfile_t *xdf, xdfile_t *xdfo, long flags) {
>>>                                 rchg[--ixs] = 1;
>>>                                 rchg[--ix] = 0;
>>>
>>> +                               has_emptyline |=
>>> +                                       starts_with_emptyline(recs[ix]->ptr);
>>
>> I assume you're doing |= so that we don't overwrite the empty line
>> setting each loop here to 0 when it's false? That's a bit subtle, and
>> it took me a moment to figure out, since I am used to thinking of it
>> as bitwise | and not a boolean or like we're intending here (though
>> obviously we're using bitwise to perform that intended behavior).
>
> Here are my thoughts:
> * this loop shifts the group back and forth, "collecting" adjacent groups
>   until no more groups are eaten.
> * That is why the last iteration of the loop will shift around most
> and completely
>    cover the relevant area. we could do this in the last iteration
> only of this loop.
>    But we do not know when the last iteration will be, so do it every time.
>

Ya I think this makes sense, and I think it's better to do it here
than having to do it as a separate loop after the fact.

>    We could also have an extra loop after this loop to do a back and
> forth once to look
>    for empty lines.
>

I think it's better to do it here.

> * Yes, the |= should convey:
>
>     if (starts_with_emptyline(...)
>         has_emptyline = 1;
>
> We could do += as well. (Then we'd get the count which is still good enough.)
>

We might do a += and rename the variable or something so that it's a
bit more clear what wer'e doing.

> * We do not want to overwrite the has_emptyline for non empty lines in
> the inner loop.
>

Right.

> * The outer loop doesn't matter as we reset has_emptyline to 0 each
> time as explained

Yes.

>    above. Technically we could "has_emptyline = 0;" before the do{ }
> while loop, to save
>    a little bit of instructions.
>
> * I assumed starts_with_emptyline returns a boolean (though it is int)
>   In this code I use unsigned char, which should probably be int as well?
>

I think the int is better, ya.

> Ok I'll look into adding a flag for that.
>
> I have no idea what the "recs->ha" is, though (short for hash?),
> so I am not quite sure about the condition in the while loop. It was mainly
> copied from above where we shift the group backward.
>

I don't really know either.

>>
>> I am not really sure how to thoroughly test it beyond that though.
>
> Thanks for the review!
> In case you want to pick it up (partially), feel free to do so. :)
>

I'll probably pick it up sometime tomorrow and try to see how it works and see

> Stefan
>
>>

Thanks again!
Jake
