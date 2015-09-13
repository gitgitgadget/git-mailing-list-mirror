From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v4 3/8] branch: roll show_detached HEAD into regular ref_list
Date: Sun, 13 Sep 2015 14:31:21 -0400
Message-ID: <CAPig+cR42jzxeeqpVh2sMojSCVD7Xg4RF6TDfTeg0y10o-2TLQ@mail.gmail.com>
References: <1442129035-31386-1-git-send-email-Karthik.188@gmail.com>
	<1442129035-31386-4-git-send-email-Karthik.188@gmail.com>
	<vpqa8sqv7p1.fsf@anie.imag.fr>
	<CAPig+cTzEQ=+FKa2j2RbfHv_NP35_vPDq1NZCeek8LX9fJF3aQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Karthik Nayak <karthik.188@gmail.com>,
	Git List <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Sun Sep 13 20:31:48 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZbC43-0008Lg-Bj
	for gcvg-git-2@plane.gmane.org; Sun, 13 Sep 2015 20:31:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754097AbbIMSbW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Sep 2015 14:31:22 -0400
Received: from mail-yk0-f172.google.com ([209.85.160.172]:36709 "EHLO
	mail-yk0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753550AbbIMSbW (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Sep 2015 14:31:22 -0400
Received: by ykdt18 with SMTP id t18so114358269ykd.3
        for <git@vger.kernel.org>; Sun, 13 Sep 2015 11:31:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=7S/bYJhTEHucmJkpH9+31RYwtv3+cWpRu7a5KbADBvE=;
        b=I6g0DD+SJmhW7LosjfO/DECWc/iMrLExTK+9fcd99IqjAxwutePKfg7+KO9oBVjTgE
         ouC204IMB3lQUHUy6zUtNG9yUCw3gg4B+3wu+lFgnNQRnPIRCWGl8AWSDEHSq66PZjqC
         FZL0SRd15T7pIdqMRKpHP9M2c0J1wzb87nT5QhtaIsxMO1OjZBKDaYaQI8IIgjzmUkIL
         ZM71UXU50sgQUFFxwRojh51kQW9fSRh1tYF7hlSEJ7n/n20ukSPc/9qj0m4N0g3TpsgA
         i9k9Wsfeojc2KXkOZIB2iIQa+ZXERyJIAnRHBNtOOvm9fazeRj66n4wLAED5adclkFzi
         njsA==
X-Received: by 10.170.123.83 with SMTP id p80mr9869655ykb.127.1442169081520;
 Sun, 13 Sep 2015 11:31:21 -0700 (PDT)
Received: by 10.37.36.145 with HTTP; Sun, 13 Sep 2015 11:31:21 -0700 (PDT)
In-Reply-To: <CAPig+cTzEQ=+FKa2j2RbfHv_NP35_vPDq1NZCeek8LX9fJF3aQ@mail.gmail.com>
X-Google-Sender-Auth: LCfolEFV8QzWcvhFpuyEq3F7pAs
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277789>

On Sun, Sep 13, 2015 at 12:46 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Sun, Sep 13, 2015 at 8:12 AM, Matthieu Moy
> <Matthieu.Moy@grenoble-inp.fr> wrote:
>> Karthik Nayak <karthik.188@gmail.com> writes:
>>
>>> @@ -679,15 +682,20 @@ static int print_ref_list(int kinds, int detached, int verbose, int abbrev, stru
>>>       if (verbose)
>>>               maxwidth = calc_maxwidth(&ref_list, strlen(remote_prefix));
>>>
>>> -     qsort(ref_list.list, ref_list.index, sizeof(struct ref_item), ref_cmp);
>>> +     index = ref_list.index;
>>> +
>>> +     /* Print detached HEAD before sorting and printing the rest */
>>> +     if (detached && (ref_list.list[index - 1].kind == REF_DETACHED_HEAD) &&
>>> +         !strcmp(ref_list.list[index - 1].name, head)) {
>>> +             print_ref_item(&ref_list.list[index - 1], maxwidth, verbose, abbrev,
>>> +                            1, remote_prefix);
>>> +             index -= 1;
>>> +     }
>>
>> I think Eric already mentionned it, but I don't remember the conclusion
>> and can't find it in the archives. Wouldn't it be cleaner to actually
>> remove the detached head from the array (do "ref_list.index -= 1"
>> instead of "index -= 1", and possibly free() what needs to be freed?
>
> I think Michael Haggerty mentioned something along those lines...

Specifically, I think you're referring to [1] (?).

[1]: http://thread.gmane.org/gmane.comp.version-control.git/276363/focus=276676
