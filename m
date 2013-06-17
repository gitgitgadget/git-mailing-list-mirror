From: Antoine Pelisse <apelisse@gmail.com>
Subject: Re: [PATCH] diff: add --ignore-blank-lines option
Date: Mon, 17 Jun 2013 21:09:59 +0200
Message-ID: <CALWbr2zM=rD3GE9a=Xyrvz0E5mAMsDesJu8-Zs7JH7W4U4AbeA@mail.gmail.com>
References: <7vhah35jn8.fsf@alter.siamese.dyndns.org>
	<1371301305-30160-1-git-send-email-apelisse@gmail.com>
	<7vzjuog175.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 17 21:10:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UoeoZ-0000Ml-5o
	for gcvg-git-2@plane.gmane.org; Mon, 17 Jun 2013 21:10:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752307Ab3FQTKB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Jun 2013 15:10:01 -0400
Received: from mail-qe0-f49.google.com ([209.85.128.49]:57360 "EHLO
	mail-qe0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751603Ab3FQTKA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Jun 2013 15:10:00 -0400
Received: by mail-qe0-f49.google.com with SMTP id cz11so1912956qeb.22
        for <git@vger.kernel.org>; Mon, 17 Jun 2013 12:09:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=xmbA+ogxbGRdfOnHPJELnni6ciIgLuigVLS1gZUpQhc=;
        b=EuH7RPdIJwsy1OBjFeTls8D2Fqj3TP6XVJxGHV6u81y21otREv/b2Se7OZIrHIjSOv
         hOMgdOhI9bJuHoCEk/Nnf5IkB8wtTHjhBc9WGSQl2HGB/lp1M6KSoAa9SyqUXyLQgrmF
         DTY1HwG8Fz4+wVZw1/WVAm1lg46+miWVYzvgVXf8IdVVDtR5rVsioKsob9BKHeT/Oz8H
         06bF2mAogUhTO4DaQJnyF7bX81eHNWuaR1IOqeEiUvlttKLipA/h9w2MEqmWF15hMUrz
         2Gef1uQQlOqvBRhGO0iKcEg4cAuXcvIcX7Mr+bFq+qt3ZMJqkN/NbLixvtU5p1vmtxvt
         imJQ==
X-Received: by 10.224.69.66 with SMTP id y2mr18369212qai.61.1371496199519;
 Mon, 17 Jun 2013 12:09:59 -0700 (PDT)
Received: by 10.49.108.105 with HTTP; Mon, 17 Jun 2013 12:09:59 -0700 (PDT)
In-Reply-To: <7vzjuog175.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228099>

On Mon, Jun 17, 2013 at 6:18 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Antoine Pelisse <apelisse@gmail.com> writes:
>
>> So here is a more thorough description of the option:
>
>> - real changes are interesting
>
> OK, I think I can understand it.
>
>> - blank lines that are close enough (less than context size) to
>>   interesting changes are considered interesting (recursive definition)
>
> OK.
>
>> - "context" lines are used around each hunk of interesting changes
>
> OK.
>
>> - If two hunks are separated by less than "inter-hunk-context", they
>>   will be merged into one.
>
> Makes sense.
>
>> The current implementation does the "interesting changes selection" in a
>> single pass.
>
> "current" meaning "the code after this patch is applied"?  Is there
> a possible future enhancement hinted here?

No. There might be, but I'm not sure it should be discussed right now
(In case you're curious, I'm thinking about interaction with combined
diff). I will take the hint and rephrase.

>> +xdchange_t *xdl_get_hunk(xdchange_t **xscr, xdemitconf_t const *xecfg)
>> +{
>> +     xdchange_t *xch, *xchp, *lxch;
>>       long max_common = 2 * xecfg->ctxlen + xecfg->interhunkctxlen;
>> +     long max_ignorable = xecfg->ctxlen;
>> +     unsigned long changes = ULONG_MAX;

Let me explain what "changes" means, as I know it will help the rest
of the message:
It counts the number of *added* blank lines we have ignored since
"lxch" (needed to calculate the distance between lxch and xch)
It also has the meaning of what was called "interesting" before.
If changes == ULONG_MAX, we are still in interesting zone, otherwise
it means we have ignored "changes" *added* blank lines (0 being a
valid value).
(Actually, After rereading this part, it looks like I could check that
lxch == xchp rather than setting changes to ULONG_MAX).

>> +
>> +     /* remove ignorable changes that are too far before other changes */
>> +     for (xchp = *xscr; xchp && xchp->ignore; xchp = xchp->next) {
>> +             xch = xchp->next;
>> +
>> +             if (xch == NULL ||
>> +                 xch->i1 - (xchp->i1 + xchp->chg1) >= max_ignorable)
>> +                     *xscr = xch;
>> +     }
>
> This strips leading ignorable ones away until we see an unignorable
> one.  Looks sane.
>
>> +     if (*xscr == NULL)
>> +             return NULL;
>> +
>> +     lxch = *xscr;
>
> "lxch" remembers the last one that is "interesting".
>
>> +     for (xchp = *xscr, xch = xchp->next; xch; xchp = xch, xch = xch->next) {
>> +             long distance = xch->i1 - (xchp->i1 + xchp->chg1);
>> +             if (distance > max_common)
>>                       break;
>
> If we see large-enough gap, the one we processed last (in xchp) is
> the end of the current hunk.  Looks sane.
>
>> +             if (distance < max_ignorable &&
>> +                 (!xch->ignore || changes == ULONG_MAX)) {
>> +                     lxch = xch;
>> +                     changes = ULONG_MAX;
>
> The current one is made into the "last interesting one we have seen"
> and the hunk continues, if either (1) the current one is interesting
> by itself, or (2) the last one we saw does not match some
> unexplainable criteria to cause changes set to not ULONG_MAX.
>
> Puzzling.

- If we are still in interesting zone, we take it, even if it's
ignorable change. Because it's close enough.
- Otherwise, only take real changes. We are close to another change,
and we are still in the loop, so it must be interesting.

>> +             } else if (changes != ULONG_MAX &&
>> +                        xch->i1 + changes - (lxch->i1 + lxch->chg1) > max_common) {
>> +                     break;
>
> If the last one we saw does not match some unexplainable criteria to
> cause changes set to not ULONG_MAX, and the distance between this
> one and the last "intersting" one is further than the context, this
> one will not be a part of the current hunk.
>
> Puzzling.

If we are no longer in "interesting zone" (changes != ULONG_MAX), it
means we will stop if the distance is too big.
"changes" is used in the calculation to consider the changes we have
already ignored (xch->i1 - (lxch->i1 + lxch->chg1) will only work if
xch and lxch are consecutive, we need to add the blank lines we
ignored).

> Could you add comment to the "changes" variable and explain what the
> variable means?
>
>> +             } else if (!xch->ignore) {
>> +                     lxch = xch;
>> +                     changes = ULONG_MAX;
>
> When this change by itself is interesting, it becomes the "last
> interesting one" and the hunk continues.

Exactly, and changes goes back to "interesting".

>> +             } else {
>> +                     if (changes == ULONG_MAX)
>> +                             changes = 0;
>> +                     changes += xch->chg2;
>
> Puzzled beyond guessing.  Also it is curious why here and only here
> we look at chg2 side of the things, not i1/chg1 in this whole thing.

chg2 being the number of blank line *additions*.
I don't want to coalesce two hunks because some blank lines have been
removed between the two, so we must not change the distance
calculation because of a blank line removal. That behavior can be seen
in "ignore-blank-lines: between changes" test.

Hope that makes things clearer,
Thanks again for the thorough reading,

Antoine
