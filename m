From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH/RFC] blame: accept multiple -L ranges
Date: Tue, 9 Jul 2013 13:17:18 -0400
Message-ID: <CAPig+cSxiSWwZ6QANWtTt7ioAewD0tk62V=pkdiT9JLw3Fzb9g@mail.gmail.com>
References: <1373186706-19284-1-git-send-email-sunshine@sunshineco.com>
	<7vk3l26695.fsf@alter.siamese.dyndns.org>
	<CAPig+cQ9sfV+PRqn5vrL0=xOZrKDDmsKdAPiB4PsCFb=jnk4kQ@mail.gmail.com>
	<7v38rnwuvb.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>, Thomas Rast <trast@inf.ethz.ch>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 09 19:17:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UwbXY-0004Yy-GQ
	for gcvg-git-2@plane.gmane.org; Tue, 09 Jul 2013 19:17:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752113Ab3GIRRU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Jul 2013 13:17:20 -0400
Received: from mail-la0-f47.google.com ([209.85.215.47]:40453 "EHLO
	mail-la0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751761Ab3GIRRT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Jul 2013 13:17:19 -0400
Received: by mail-la0-f47.google.com with SMTP id fe20so4878832lab.6
        for <git@vger.kernel.org>; Tue, 09 Jul 2013 10:17:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=w3eSnvxxxVJYoXPtF5pIW3cf0bW9BC0kZNERCou+g4E=;
        b=gY64tQXl+FD0gNV1s5ZXbsjxPf+gWqsql3AuGCbOrAf2Crj66zX2RdvBW7T8VKszEI
         Ii5NMiKGa6gKJLVy82VqauEWT/IDjS0JTS5cycwq9/ISzw+jOeAGsHurVrMaxySoTOH1
         8LeScpJMydBvc5jjU7IbhmWVPXwZDDWkuIx613nSHX0wi2MPgFGeWVNc1kFTHDMmI8X6
         mWXa54hUBFYhXDKAUM3VN1otgBFUR09rlBVB/kAfJsB5pM+pSW8XdHOpbZCRkFik9mrQ
         QacWoUeUzKH4PZsYZDXr5av+rpfJ8CAlSeWEQvRrtmwrw1bonLvAJCWxJH4yA7T7Jl2P
         Mniw==
X-Received: by 10.152.4.65 with SMTP id i1mr13161013lai.21.1373390238358; Tue,
 09 Jul 2013 10:17:18 -0700 (PDT)
Received: by 10.114.187.78 with HTTP; Tue, 9 Jul 2013 10:17:18 -0700 (PDT)
In-Reply-To: <7v38rnwuvb.fsf@alter.siamese.dyndns.org>
X-Google-Sender-Auth: ITXQ1MWB9pW8AjN1Tw1XhHgQjns
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229970>

On Tue, Jul 9, 2013 at 12:39 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Eric Sunshine <sunshine@sunshineco.com> writes:
>
>> As implemented by this patch, the behavior of git-blame with multiple
>> -L's is consistent with that of git-log with multiple -L's. The
>> implemented behavior feels intuitive to me, but I can see how the
>> behavior you suggest could feel intuitive to others.
>>
>> If I re-do the patch to work the way you describe above, how should we
>> deal with the inconsistent behaviors between the two commands?
>
> The suggestion to error out was more about "start simple, strict and
> obvious to make it easy to explain" and nothing else.  If we start
> with a simple and strict version, we can later loosen it without
> making an input that was valid earlier invalid.  If we start with
> too loose, on the other hand, it would be hard to tighten it later.

Makes sense.

> But the only two things I care deeply about are, in a file whose
> contents is:
>
>         C
>         B
>         A
>         B
>         C
>         D
>
>  (1) The range "-L /A/,/B/" finds the first A from the beginning,
>      and then chooses B that comes _after_ it, making it equivalent
>      to -L3,4 (not -L3,2 or -L2,3).
>
>  (2) In the ranges "-L <anything>,/B/ -L /C/,<anything>", the
>      beginning of the second range is found by choosing C that comes
>      _after_ the end of the previous range (/B/ may choose either
>      the second or the 4th line, and the only C that comes after
>      either of them is the 5th line and that is where the second
>      range should begin, not at the beginning of the file).  The
>      same for "-L 1,3 -L /C/" (only C that comes after 3 is eligible
>      to be the beginning of the second range).

Thinking aloud: Thus, for "-L 1,5 -L /C/", no C would be found.

> I view it as a nice addition to coalesce two overlapping ranges
> given exactly by numbers, e.g. "-L 100,200 -L 50,102".  I do not
> have a strong objection to it, as long as it does not interfere
> negatively with ranges specified by patterns.

Okay, I will base my rewrite upon the above constraints, along with
other observations from your initial response.

-- ES
