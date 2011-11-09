From: Dan McGee <dpmcgee@gmail.com>
Subject: Re: [PATCH 3/4] pack-objects: don't traverse objects unnecessarily
Date: Tue, 8 Nov 2011 22:31:48 -0600
Message-ID: <CAEik5nNmAnPni+rnLm7n5tO7f=LV_1TuTbVqxgjVaoqqaF_Ukw@mail.gmail.com>
References: <1318915284-6361-1-git-send-email-dpmcgee@gmail.com>
	<1318915284-6361-3-git-send-email-dpmcgee@gmail.com>
	<7vk47qxe9x.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Nov 09 05:32:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RNzpd-0006Ij-TN
	for gcvg-git-2@lo.gmane.org; Wed, 09 Nov 2011 05:32:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751708Ab1KIEbu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Nov 2011 23:31:50 -0500
Received: from mail-bw0-f46.google.com ([209.85.214.46]:64432 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750924Ab1KIEbu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Nov 2011 23:31:50 -0500
Received: by bke11 with SMTP id 11so1028563bke.19
        for <git@vger.kernel.org>; Tue, 08 Nov 2011 20:31:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=UsBEOEv8Hy32h0JXXE35ZhxWhFnsJTVVAsSTbH3ufN0=;
        b=BDHjjlDRSBk8DNcmm0QnL2u4CMsJ1pycyC447JvUYXs3ZXTE22Felni7Tx6iCSI05n
         pPjTa6zEQ8znYZKDoXITD5GKWNEZ7vu26u0OHU2twe/reI9+b4+Hfb+3J8jOqbvG5Fsc
         VfnQlV+XjtvmLzo0VVEb4C9YgYvlbiGqZ7zdI=
Received: by 10.204.157.27 with SMTP id z27mr439885bkw.8.1320813108611; Tue,
 08 Nov 2011 20:31:48 -0800 (PST)
Received: by 10.205.81.76 with HTTP; Tue, 8 Nov 2011 20:31:48 -0800 (PST)
In-Reply-To: <7vk47qxe9x.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185146>

On Thu, Oct 27, 2011 at 5:26 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Dan McGee <dpmcgee@gmail.com> writes:
>
>> Two optimizations take place here- we can start our objects array
>> iteration from a known point where we left off before we started trying
>> to find our tags,
>
> This I would understand (but I am somewhat curious how much last_untagged
> would advance relative to nr_objects for this half of the optimization to
> be worth it), but...
First off, sorry I wasn't able to respond to you until now, I've been
a bit swamped with other projects. I saw this made it into the 1.7.7.3
maint release today, but wanted to at least try to respond to the
points you raised (if you didn't investigate them by yourself
already).

If I remember right, the last_untagged optimization was pretty minor-
around 10% advancement of the pointer, never that much more. However,
it was a very easy change to make so I figured it was worth the slight
additional code (~5 lines changed for that part on its own).

>
>> and we don't need to do the deep dives required by
>> add_family_to_write_order() if the object has already been marked as
>> filled.
>
> I am not sure if this produces the identical result that was benchmarked
> in the original series.
I was not either when I wrote the patch, and I had hoped to confirm
the results you showed in the message of 1b4bb16b9ec. However, I was
unable to figure out how you generated those numbers so I wasn't able
to do so (and had planned to get back to you to find out how you made
those tables). Were you able to verify the ordering did not regress?

> For example, if you have a tagged object that is not a commit (say a
> blob), you would have written that blob in the second phase (write tagged
> objects together), so the family of blobs that share same delta parent as
> that blob will not be written in this "Finally all the rest" in the right
> place in the original list, no?
True, I think. They would not be written in the same place, but is
that necessarily the right place? The delta parent of an
already-filled tag object would eventually come up in the array as not
filled, and then we would do a full deep dive at that point, so the
majority of the objects would still be in close proximity.

Note that either way, we still have a gap between the original tagged
object and its "family"- potentially all the other tagged tips, tags,
commits, and trees before the blobs are finally hit and laid out in
family groups. So there is at least one potentially big seek that
can't be avoided.

> I do not think this change would forget to fill an object that needs to be
> filled, but it would affect the resulting ordering of the list, so...
This was the purpose of the added "if (wo_end != nr_objects) die()"
line; it confirms we have traversed and hit every object we originally
found.

-Dan
