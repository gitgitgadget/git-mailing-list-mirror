From: Stefan Beller <sbeller@google.com>
Subject: Re: [RFC PATCH, WAS: "weird diff output?"] Implement better chunk heuristics.
Date: Thu, 14 Apr 2016 17:43:14 -0700
Message-ID: <CAGZ79kZzb-4J82xONKX1RiAeLdJ7pGF1rBD4fJRyjbdZcPnkVA@mail.gmail.com>
References: <CAGZ79ka8pgPNZKaVWnsa_S07esxkN9nJfhcMZvCfd5U6MtsrYQ@mail.gmail.com>
	<20160415000730.26446-1-sbeller@google.com>
	<CA+P7+xqEPq=G_PMA-=h6jzWaUP=6hmWXcLzxbogs2PyuAZcn4g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>,
	Davide Libenzi <davidel@xmailserver.org>,
	Junio C Hamano <gitster@pobox.com>,
	Git mailing list <git@vger.kernel.org>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: Jacob Keller <jacob.keller@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 15 02:43:22 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aqrqz-0004Ip-9Y
	for gcvg-git-2@plane.gmane.org; Fri, 15 Apr 2016 02:43:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752782AbcDOAnQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Apr 2016 20:43:16 -0400
Received: from mail-ig0-f174.google.com ([209.85.213.174]:35577 "EHLO
	mail-ig0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752433AbcDOAnP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Apr 2016 20:43:15 -0400
Received: by mail-ig0-f174.google.com with SMTP id gy3so7705452igb.0
        for <git@vger.kernel.org>; Thu, 14 Apr 2016 17:43:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=tA9NrBsHY8CTzgWov36THKjYi4LGKzTQgOVvcbaNWkU=;
        b=jPm7xaJcTPSa4XNzxWnMV9AESP/OsrnjG4FRjnqTY9Bfd2JE/mHpRkA7zch7rEbTfK
         oRw7kyk4HK8Smf37eULZ4rzfjm6pXUE8w01C6OeiVnjfoAjv7WRyuSy6N3+8mEUE/YzK
         DCj+UCsAk1TKWUbtWoDOvyce2EsrRzkZruaQ6KP0S+K4gl8CIPXdaxLTsQG5nBxv5p9L
         yXSqAeBdQnCQnP4FJt3xqyJEh/e1+ubZxFAyql9G5uj+T+pcyHfkqKM9gB2Ji3wDH2kX
         6b6EJ+gxvL69EVko0B3ZWTAQ4EPFvA7aHIV8RkvssQ7TeSYDpjfLs7a3dOTPdOglf6Y8
         xgbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=tA9NrBsHY8CTzgWov36THKjYi4LGKzTQgOVvcbaNWkU=;
        b=cbSsFYw44pZyXs0Nzd+HaR84PLmvjKDbFmIYiGd4QUMKsSmImRN3+IKdkZFvpZn0dO
         KsQ3tDvAEyCyRmV2uIutsukgvvAkFPPOhfcmTv0MqMgZO2uI/riGy7G/g8T3KsgJVwqM
         sV5kc1/Ad3RpW3Qt3OqdwfIUv6s0UCVWtQquXWfzz++9XaBisISmbm8jTN1HQh5c9SnX
         EMVEwDNM5YMLVod80ylWtAIoVx+6OVlwbkP6wdmU0itylwtzkl1KfekeLteEx42w4mbP
         o0ArwQTublEeT/wNP2S0ev2AgJz+pFk/FlanheqCjm/x245WFsYjiJODtb8XVcPSRE6j
         nijg==
X-Gm-Message-State: AOPr4FUsgIjD68aCGzY1NXahFhRNkM3lP+MH8l/uZWkJfkOAUY5490aknQkq9CFq67HjyLzhw2FHRQoFlHHY4W2r
X-Received: by 10.50.72.107 with SMTP id c11mr1568560igv.85.1460680994292;
 Thu, 14 Apr 2016 17:43:14 -0700 (PDT)
Received: by 10.107.17.27 with HTTP; Thu, 14 Apr 2016 17:43:14 -0700 (PDT)
In-Reply-To: <CA+P7+xqEPq=G_PMA-=h6jzWaUP=6hmWXcLzxbogs2PyuAZcn4g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291586>

On Thu, Apr 14, 2016 at 5:26 PM, Jacob Keller <jacob.keller@gmail.com> wrote:
> On Thu, Apr 14, 2016 at 5:07 PM, Stefan Beller <sbeller@google.com> wrote:
>> TODO(sbeller):
>> * describe the discussion on why this is better
>> * see if this can be tested?
>>
>
> Thanks for taking time to do this! It looks like a few things are
> still missing, CRLF obviously, and making it a configuration option.

I mainly wanted to get this out in the world quickly as it took me a while to
understand the code. Do you know the feeling when you stare at code
for hours and debug it and read headers to make sense of these
cryptic variables and then after intensive thinking a clear image emerges?

I put comments into the loop to convey my thought process on why that
is enough code doing the job. So I'd be happy about a critical review. :)

>
>> Signed-off-by: Stefan Beller <sbeller@google.com>
>> ---
>>  xdiff/xdiffi.c | 39 +++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 39 insertions(+)
>>
>> diff --git a/xdiff/xdiffi.c b/xdiff/xdiffi.c
>> index 2358a2d..24eb9a0 100644
>> --- a/xdiff/xdiffi.c
>> +++ b/xdiff/xdiffi.c
>> @@ -400,9 +400,16 @@ static xdchange_t *xdl_add_change(xdchange_t *xscr, long i1, long i2, long chg1,
>>  }
>>
>>
>> +static int starts_with_emptyline(const char *recs)
>> +{
>> +       return recs[0] == '\n'; /* CRLF not covered here */
>> +}
>> +
>> +
>>  int xdl_change_compact(xdfile_t *xdf, xdfile_t *xdfo, long flags) {
>>         long ix, ixo, ixs, ixref, grpsiz, nrec = xdf->nrec;
>>         char *rchg = xdf->rchg, *rchgo = xdfo->rchg;
>> +       unsigned char has_emptyline;
>>         xrecord_t **recs = xdf->recs;
>>
>>         /*
>> @@ -436,6 +443,7 @@ int xdl_change_compact(xdfile_t *xdf, xdfile_t *xdfo, long flags) {
>>
>>                 do {
>>                         grpsiz = ix - ixs;
>> +                       has_emptyline = 0;
>>
>>                         /*
>>                          * If the line before the current change group, is equal to
>> @@ -447,6 +455,8 @@ int xdl_change_compact(xdfile_t *xdf, xdfile_t *xdfo, long flags) {
>>                                 rchg[--ixs] = 1;
>>                                 rchg[--ix] = 0;
>>
>> +                               has_emptyline |=
>> +                                       starts_with_emptyline(recs[ix]->ptr);
>
> I assume you're doing |= so that we don't overwrite the empty line
> setting each loop here to 0 when it's false? That's a bit subtle, and
> it took me a moment to figure out, since I am used to thinking of it
> as bitwise | and not a boolean or like we're intending here (though
> obviously we're using bitwise to perform that intended behavior).

Here are my thoughts:
* this loop shifts the group back and forth, "collecting" adjacent groups
  until no more groups are eaten.
* That is why the last iteration of the loop will shift around most
and completely
   cover the relevant area. we could do this in the last iteration
only of this loop.
   But we do not know when the last iteration will be, so do it every time.

   We could also have an extra loop after this loop to do a back and
forth once to look
   for empty lines.

* Yes, the |= should convey:

    if (starts_with_emptyline(...)
        has_emptyline = 1;

We could do += as well. (Then we'd get the count which is still good enough.)

* We do not want to overwrite the has_emptyline for non empty lines in
the inner loop.

* The outer loop doesn't matter as we reset has_emptyline to 0 each
time as explained
   above. Technically we could "has_emptyline = 0;" before the do{ }
while loop, to save
   a little bit of instructions.

* I assumed starts_with_emptyline returns a boolean (though it is int)
  In this code I use unsigned char, which should probably be int as well?

>
>>                                 /*
>>                                  * This change might have joined two change groups,
>>                                  * so we try to take this scenario in account by moving
>> @@ -475,6 +485,9 @@ int xdl_change_compact(xdfile_t *xdf, xdfile_t *xdfo, long flags) {
>>                                 rchg[ixs++] = 0;
>>                                 rchg[ix++] = 1;
>>
>> +                               has_emptyline |=
>> +                                       starts_with_emptyline(recs[ix]->ptr);
>> +
>>                                 /*
>>                                  * This change might have joined two change groups,
>>                                  * so we try to take this scenario in account by moving
>> @@ -498,6 +511,32 @@ int xdl_change_compact(xdfile_t *xdf, xdfile_t *xdfo, long flags) {
>>                         rchg[--ix] = 0;
>>                         while (rchgo[--ixo]);
>>                 }
>> +
>> +               /*
>> +                * If a group can be moved back and forth, see if there is an
>> +                * empty line in the moving space. If there is an empty line,
>> +                * make sure the last empty line is the end of the group.
>> +                *
>> +                * As we shifted the group forward as far as possible, we only
>> +                * need to shift it back if at all.
>> +                */
>> +               if (has_emptyline) {
>> +                       while (ixs > 0 && recs[ixs - 1]->ha == recs[ix - 1]->ha &&
>> +                              xdl_recmatch(recs[ixs - 1]->ptr, recs[ixs - 1]->size, recs[ix - 1]->ptr, recs[ix - 1]->size, flags) &&
>> +                              !starts_with_emptyline(recs[ix - 1]->ptr)) {
>> +                               rchg[--ixs] = 1;
>> +                               rchg[--ix] = 0;
>> +
>> +                               /*
>> +                                * This change did not join two change groups,
>> +                                * as we did that before already, so there is no
>> +                                * need to adapt the other-file, i.e.
>> +                                * running
>> +                                *     for (; rchg[ixs - 1]; ixs--);
>> +                                *     while (rchgo[--ixo]);
>> +                                */
>> +                       }
>> +               }
>>         }
>
> And this was the more difficult part which I wasn't able to fully
> understand how to do. It seems pretty reasonable. I think we can make
> it configurable by using a new XDIFF flag similar to how we handle
> various diff options like the different diff algorithms, and then we
> could add tests specific to ensure that the flag enables the behavior
> we want on some known test cases.

Ok I'll look into adding a flag for that.

I have no idea what the "recs->ha" is, though (short for hash?),
so I am not quite sure about the condition in the while loop. It was mainly
copied from above where we shift the group backward.

>
> I am not really sure how to thoroughly test it beyond that though.

Thanks for the review!
In case you want to pick it up (partially), feel free to do so. :)

Stefan

>
> Regards,
> Jake
>
>>
>>         return 0;
>> --
>> 2.8.1.474.gffdc890.dirty
>>
