From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH/RFC] blame: accept multiple -L ranges
Date: Tue, 9 Jul 2013 11:04:55 -0400
Message-ID: <CAPig+cQ9sfV+PRqn5vrL0=xOZrKDDmsKdAPiB4PsCFb=jnk4kQ@mail.gmail.com>
References: <1373186706-19284-1-git-send-email-sunshine@sunshineco.com>
	<7vk3l26695.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>, Thomas Rast <trast@inf.ethz.ch>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 09 17:05:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UwZTS-0007IX-4I
	for gcvg-git-2@plane.gmane.org; Tue, 09 Jul 2013 17:05:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754072Ab3GIPE6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Jul 2013 11:04:58 -0400
Received: from mail-lb0-f175.google.com ([209.85.217.175]:54565 "EHLO
	mail-lb0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753630Ab3GIPE5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Jul 2013 11:04:57 -0400
Received: by mail-lb0-f175.google.com with SMTP id r10so4775505lbi.20
        for <git@vger.kernel.org>; Tue, 09 Jul 2013 08:04:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=awk5rZ9HWGdnIDdydbqmcFk6wDmxwyptOFRL/XLwRIA=;
        b=ISxSPgqgr031WzktDv4SJkQan+G0weZDtijBxEacYuYYGFmTzE4jALPxIJW+JTNnBI
         k4+mS6FLQq01CaZxxAJ8o7V1VWwgcR0wgQGnhTJY16yW5AUNPQZR7yd6Sg6Lyp/Lpn4F
         MNuqu1/uNPsEuSykhVH3s/X2fjTBf6FofQrajvMglmS7iBfe0kYwXqAFuKEXOAYPREWe
         GXIzA/ycoUgtWZB84wxbrwd53Efa1DmvYsm3IclgcVEfb5S9Wgh2SQ+4dBruX1lIjkbo
         fxTwwwzyg6MpdO243U9baOih7DaADCIu/IMAwBEs9EF+tt9VwPaKVfnGX5tb+qrTZVqc
         wS/g==
X-Received: by 10.152.6.228 with SMTP id e4mr12715342laa.61.1373382295778;
 Tue, 09 Jul 2013 08:04:55 -0700 (PDT)
Received: by 10.114.187.78 with HTTP; Tue, 9 Jul 2013 08:04:55 -0700 (PDT)
In-Reply-To: <7vk3l26695.fsf@alter.siamese.dyndns.org>
X-Google-Sender-Auth: o-VDPs2wyzEARl7LjVk9f4lbZPA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229959>

[Added Cc:Thomas Rast]

On Sun, Jul 7, 2013 at 5:58 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Eric Sunshine <sunshine@sunshineco.com> writes:
>
>> git-blame accepts only zero or one -L option. Clients requiring blame
>> information for multiple disjoint ranges are therefore forced either to
>> invoke git-blame multiple times, once for each range, or only once with
>> no -L option to cover the entire file, which can be costly. Teach
>> git-blame to accept multiple -L ranges.
>>
>> Overlapping and out-of-order ranges are accepted and handled gracefully.
>> For example:
>>
>>   git blame -L 3,+4 -L 91,+7 -L 2,3 -L 89,100 source.c
>>
>> emits blame information for lines 2-6 and 89-100.
>> ---
>>
>> This is RFC because it lacks documentation and test updates, and because
>> I want to make sure the approach is sound and not abusive of the blame
>> machinery.
>
> A few commments (without reading too deep in the patch, so do not
> take any of these as complaint---if you did it the way I said "I'd
> prefer", take it as a praise ;-).
>
>  - I'd prefer to see the command parser for multiple -L options to
>    ensure that they are in strictly increasing order without
>    overlap.  Error out with a message if the input ranges are out of
>    order or with overlap.  Doing it that way, it would be easier to
>    explain to the users how "blame -L /A/,/B/ -L /C/,/D/" should
>    work.  It would find the first line that matches C _after_ the
>    end of the first range.  This is in line with the way we find the
>    end of the range (e.g. the line that matches B) starting from the
>    last line previously specified (e.g. the line that matches A).

As implemented by this patch, the behavior of git-blame with multiple
-L's is consistent with that of git-log with multiple -L's. The
implemented behavior feels intuitive to me, but I can see how the
behavior you suggest could feel intuitive to others.

If I re-do the patch to work the way you describe above, how should we
deal with the inconsistent behaviors between the two commands?

>  - I'd be somewhat unhappy to see coalesce() butchered to blindly
>    accept overlapping ranges (if anything, I'd rather see it
>    tightened to detect such input as a programming error), but this
>    is a minor point.

Loosening the behavior bothered enough that I mentioned it centrally
in the patch commentary. I can re-implement without (ab)using
coalesce().

(In fact, I already have an implementation which re-uses the machinery
employed by git-log -L.)

-- ES
