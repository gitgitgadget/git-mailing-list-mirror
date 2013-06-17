From: Antoine Pelisse <apelisse@gmail.com>
Subject: Re: [PATCH] diff: add --ignore-blank-lines option
Date: Mon, 17 Jun 2013 23:33:08 +0200
Message-ID: <CALWbr2x0gxQ8boXEa3WJUbaA8e9imt9Ri_NFmANEhJuK6Moi+A@mail.gmail.com>
References: <7vhah35jn8.fsf@alter.siamese.dyndns.org>
	<1371301305-30160-1-git-send-email-apelisse@gmail.com>
	<7vzjuog175.fsf@alter.siamese.dyndns.org>
	<CALWbr2zM=rD3GE9a=Xyrvz0E5mAMsDesJu8-Zs7JH7W4U4AbeA@mail.gmail.com>
	<7vd2rkcy6r.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 17 23:33:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uoh35-0001I1-AJ
	for gcvg-git-2@plane.gmane.org; Mon, 17 Jun 2013 23:33:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751430Ab3FQVdL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Jun 2013 17:33:11 -0400
Received: from mail-la0-f42.google.com ([209.85.215.42]:36008 "EHLO
	mail-la0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751169Ab3FQVdK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Jun 2013 17:33:10 -0400
Received: by mail-la0-f42.google.com with SMTP id eb20so2955367lab.15
        for <git@vger.kernel.org>; Mon, 17 Jun 2013 14:33:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=ZMtWIhIn5RN56GUWoXC3Fq+tmQmJW3c2mU5i/lV3/Vw=;
        b=AOMh5I6kUWT5HboigNxt/gHyvhipAbfRDQG1KjGblEZnmpVqAoBc2t3RrVR45MBk8d
         hJY/JZfltXJkv01VF4IzphRFCveZHNAeSILtz+4JI8qIAGhYvLuSHCTUBajKjx24OFXm
         ezJTE1wlycfeBJ9RXGoECEXD6MqN3c4u2Pj0rS1VPJUgL5B22w5tGry1gD0Dl+bHDV91
         +GlunN5zLOUPTogLXuytiaq/GT0fBecPFrqMYfKbdup2a+PO05SIyF6dRlP3bbuX/tnv
         EG9fEub9ojwkCgwsxMNCr7hssgdCQUEuvpz8IFugvQF/eBjIhjFohzxWCYSr3aIMkIOJ
         qJTQ==
X-Received: by 10.152.9.69 with SMTP id x5mr7569870laa.57.1371504788349; Mon,
 17 Jun 2013 14:33:08 -0700 (PDT)
Received: by 10.112.61.8 with HTTP; Mon, 17 Jun 2013 14:33:08 -0700 (PDT)
In-Reply-To: <7vd2rkcy6r.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228117>

>>>> +             } else if (changes != ULONG_MAX &&
>>>> +                        xch->i1 + changes - (lxch->i1 + lxch->chg1) > max_common) {
>>>> +                     break;
>>
>> If we are no longer in "interesting zone" (changes != ULONG_MAX), it
>> means we will stop if the distance is too big.
>> "changes" is used in the calculation to consider the changes we have
>> already ignored (xch->i1 - (lxch->i1 + lxch->chg1) will only work if
>> xch and lxch are consecutive, we need to add the blank lines we
>> ignored).
>
> And this uses max_common that is much larger than max_ignorable
> because...?
>
> The last interesting change, with its post context and inter hunk
> gap, together with precontext for this one, is close enough to the
> beginning of this one.  So it is understandable if xch by itself is
> intereseting to use max_common.  Even an interesting one, if that is
> so far from the last interesting one, should not be part of this
> hunk.
>
> However, if the current one is by itself uninteresting, should we
> still use the max_common, or should this be compared with
> max_ignorable?

Because of the "recursive definition", we don't know yet if an
ignorable change will be interesting or not.
We need to make sure it will be close to another interesting change first.
If it is, it will fall in the first if part, and lxch will catch-up.
If not, we will eventually be too far and break.

Re-reading note: OK, This last sentence ("If not we will eventually be
too far and break") is actually a bug. We might break before we find
something interesting while we should keep going. For example in such
a case, we should display like this, but won't:

@@ -x,x +x,x @@
+change   <--- That is lxch
 1
 2
 3
+       <--- Here we leave "interesting"
 4
 5
+       <--- We are too far and quit searching
 6
 7
+
 8
 9
+
 10
 11
+change

>>>> +             } else {
>>>> +                     if (changes == ULONG_MAX)
>>>> +                             changes = 0;
>>>> +                     changes += xch->chg2;
>>>
>>> Puzzled beyond guessing.  Also it is curious why here and only here
>>> we look at chg2 side of the things, not i1/chg1 in this whole thing.
>>
>> chg2 being the number of blank line *additions*.
>
> This is on the else side of if (!xch->ignore), so we are looking at
> ignored hunk, which means there is only blank line change.  Can chg2
> be 0 while chg1 is not zero, i.e. xch being a blank line removal?

Exactly. It can be a blank line removal. But I don't want to consider
it in the calculation.
Here's why:
We have:
1
2
3




4
5
6

and change it to:
change
1
2
3
4
5
6
change

What should be the output of diff --ignore-blank-lines ?

I chose this alternative:
@@ -1,3 +1,4 @@
+change
 1
 2
 3
@@ -7,3 +5,4 @@
 4
 5
 6
+change

While one could have chosen:
@@ -1,10 +1,8 @@
+change
 1
 2
 3
-
-
-
-
 4
 5
 6
+change

> What should happen in that case?  Don't we want to show it, for the
> same reason we want to keep removal, as long as it is close enough
> to the interesting zone?

Nothing is interesting here, we just leave the interesting zone (if
not already left) because everything else failed.
