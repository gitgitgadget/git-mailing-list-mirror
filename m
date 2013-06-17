From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] diff: add --ignore-blank-lines option
Date: Mon, 17 Jun 2013 12:52:12 -0700
Message-ID: <7vd2rkcy6r.fsf@alter.siamese.dyndns.org>
References: <7vhah35jn8.fsf@alter.siamese.dyndns.org>
	<1371301305-30160-1-git-send-email-apelisse@gmail.com>
	<7vzjuog175.fsf@alter.siamese.dyndns.org>
	<CALWbr2zM=rD3GE9a=Xyrvz0E5mAMsDesJu8-Zs7JH7W4U4AbeA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>
To: Antoine Pelisse <apelisse@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 17 21:52:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UofTT-0007hc-9S
	for gcvg-git-2@plane.gmane.org; Mon, 17 Jun 2013 21:52:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753415Ab3FQTwQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Jun 2013 15:52:16 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52694 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753291Ab3FQTwP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Jun 2013 15:52:15 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 55DAD28455;
	Mon, 17 Jun 2013 19:52:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=V9BLGf8oFj1pC4pVr4HABhHrrbw=; b=D2Tp2z
	OnvfPfHediLXY9LAEcKD8sg51nA65cmHYwr0mibqiLdVGbEYWRNL/+gAjSCFy6lz
	+h2ori1hMGptG09CRrDCr7vWqarAMeyoOJgDCT5uWbn7Kdndlpj4G7ReYXhTkduC
	J333l/MsLY0QDeBfEm9Hz/DbPZodsOQMXOFck=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ruNgRMRytCSkHdWsDGRjZEOU9J40qRoj
	GF4D1rqtk7r7aXt2HKFMgTS38m91gTJNtZBfoy/o7qj/GTdvs03jDJrsu9l58X+v
	BnsAJYg2uPNOZak6IBn6eG4FRoS9nrfJKTd37NY5xDfwYKMv7dG+EZPct7AXnjrj
	vFUmS8GflXw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 45EBC28454;
	Mon, 17 Jun 2013 19:52:14 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7D80D28452;
	Mon, 17 Jun 2013 19:52:13 +0000 (UTC)
In-Reply-To: <CALWbr2zM=rD3GE9a=Xyrvz0E5mAMsDesJu8-Zs7JH7W4U4AbeA@mail.gmail.com>
	(Antoine Pelisse's message of "Mon, 17 Jun 2013 21:09:59 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 67B86DCA-D787-11E2-AE22-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228105>

Antoine Pelisse <apelisse@gmail.com> writes:

>>> +     unsigned long changes = ULONG_MAX;
>
> Let me explain what "changes" means, as I know it will help the rest
> of the message:
> It counts the number of *added* blank lines we have ignored since
> "lxch" (needed to calculate the distance between lxch and xch)
> It also has the meaning of what was called "interesting" before.
> If changes == ULONG_MAX, we are still in interesting zone, otherwise
> it means we have ignored "changes" *added* blank lines (0 being a
> valid value).

OK.  That deserves a comment next to this variable.

> (Actually, After rereading this part, it looks like I could check that
> lxch == xchp rather than setting changes to ULONG_MAX).

Yeah, I think so.

>>> +             if (distance < max_ignorable &&
>>> +                 (!xch->ignore || changes == ULONG_MAX)) {
>>> +                     lxch = xch;
>>> +                     changes = ULONG_MAX;
>>
> - If we are still in interesting zone, we take it, even if it's
> ignorable change. Because it's close enough.
> - Otherwise, only take real changes. We are close to another change,
> and we are still in the loop, so it must be interesting.

OK.

>>> +             } else if (changes != ULONG_MAX &&
>>> +                        xch->i1 + changes - (lxch->i1 + lxch->chg1) > max_common) {
>>> +                     break;
>
> If we are no longer in "interesting zone" (changes != ULONG_MAX), it
> means we will stop if the distance is too big.
> "changes" is used in the calculation to consider the changes we have
> already ignored (xch->i1 - (lxch->i1 + lxch->chg1) will only work if
> xch and lxch are consecutive, we need to add the blank lines we
> ignored).

And this uses max_common that is much larger than max_ignorable
because...?

The last interesting change, with its post context and inter hunk
gap, together with precontext for this one, is close enough to the
beginning of this one.  So it is understandable if xch by itself is
intereseting to use max_common.  Even an interesting one, if that is
so far from the last interesting one, should not be part of this
hunk.

However, if the current one is by itself uninteresting, should we
still use the max_common, or should this be compared with
max_ignorable?
    
>> Could you add comment to the "changes" variable and explain what the
>> variable means?
>>
>>> +             } else if (!xch->ignore) {
>>> +                     lxch = xch;
>>> +                     changes = ULONG_MAX;
>>
>> When this change by itself is interesting, it becomes the "last
>> interesting one" and the hunk continues.
>
> Exactly, and changes goes back to "interesting".
>
>>> +             } else {
>>> +                     if (changes == ULONG_MAX)
>>> +                             changes = 0;
>>> +                     changes += xch->chg2;
>>
>> Puzzled beyond guessing.  Also it is curious why here and only here
>> we look at chg2 side of the things, not i1/chg1 in this whole thing.
>
> chg2 being the number of blank line *additions*.

This is on the else side of if (!xch->ignore), so we are looking at
ignored hunk, which means there is only blank line change.  Can chg2
be 0 while chg1 is not zero, i.e. xch being a blank line removal?

What should happen in that case?  Don't we want to show it, for the
same reason we want to keep removal, as long as it is close enough
to the interesting zone?

> Hope that makes things clearer,

Yes, it helped quite a bit.
