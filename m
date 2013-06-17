From: Antoine Pelisse <apelisse@gmail.com>
Subject: Re: [PATCH] diff: add --ignore-blank-lines option
Date: Mon, 17 Jun 2013 19:58:43 +0200
Message-ID: <CALWbr2w3hjdbsEUO4ta7UyoexTfeZQ864F4UeeAyr0uKvQRXbg@mail.gmail.com>
References: <7vhah35jn8.fsf@alter.siamese.dyndns.org>
	<1371301305-30160-1-git-send-email-apelisse@gmail.com>
	<7vzjuog175.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 17 19:58:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uodhb-0006SD-70
	for gcvg-git-2@plane.gmane.org; Mon, 17 Jun 2013 19:58:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753713Ab3FQR6q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Jun 2013 13:58:46 -0400
Received: from mail-qe0-f43.google.com ([209.85.128.43]:48131 "EHLO
	mail-qe0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753254Ab3FQR6o (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Jun 2013 13:58:44 -0400
Received: by mail-qe0-f43.google.com with SMTP id q19so1864390qeb.16
        for <git@vger.kernel.org>; Mon, 17 Jun 2013 10:58:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=4qhqFufEQOAQIyIlIdyOBv1msfWgruXf9vj0NOHp/S4=;
        b=0fTreuE6k1Nl7Hwlu9JM8bMksAc7oEAStsKQmaM/NI0K5z9DrApKfyl7MjvNEa0qzu
         4GuBkAi4VPuHpSQjRb56aBs2fa2Rj2Jbaj7dJibmXwe/xBzZEyQ2fQvcQ2Kmxa3PqIV6
         dUHpHOd/MSE7up0Rxthci+4ZNoYDEJoaz/OCWrgFYVPY8hSNbeke+t2sobPRJMMlHfcB
         kxrlgYBaLXWZjFjlDV3H4EhByzqXLVzUrKjrSid5MDMSbxVEd9unRDAUcaKbuRY2n4K1
         o/GEnOM5r2Qj/ta/D+xwLEKpinGnkZsYszpmmVWR7FvllCQLrQShokv6E09c7Uc3YhmD
         u1/g==
X-Received: by 10.224.69.66 with SMTP id y2mr18028603qai.61.1371491924021;
 Mon, 17 Jun 2013 10:58:44 -0700 (PDT)
Received: by 10.49.108.105 with HTTP; Mon, 17 Jun 2013 10:58:43 -0700 (PDT)
In-Reply-To: <7vzjuog175.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228093>

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
>
>> +xdchange_t *xdl_get_hunk(xdchange_t **xscr, xdemitconf_t const *xecfg)
>> +{
>> +     xdchange_t *xch, *xchp, *lxch;
>>       long max_common = 2 * xecfg->ctxlen + xecfg->interhunkctxlen;
>> +     long max_ignorable = xecfg->ctxlen;
>> +     unsigned long changes = ULONG_MAX;
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
>
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
>
> Could you add comment to the "changes" variable and explain what the
> variable means?
>
>> +             } else if (!xch->ignore) {
>> +                     lxch = xch;
>> +                     changes = ULONG_MAX;
>
> When this change by itself is interesting, it becomes the "last
> interesting one" and the hunk continues.
>
>> +             } else {
>> +                     if (changes == ULONG_MAX)
>> +                             changes = 0;
>> +                     changes += xch->chg2;
>
> Puzzled beyond guessing.  Also it is curious why here and only here
> we look at chg2 side of the things, not i1/chg1 in this whole thing.
