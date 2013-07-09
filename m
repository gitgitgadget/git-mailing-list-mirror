From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH/RFC] blame: accept multiple -L ranges
Date: Tue, 9 Jul 2013 15:07:00 -0400
Message-ID: <CAPig+cTjNqopExzBGy7hwf+E=1BQNEZvk+JmoqUmRK=ZyBXH1w@mail.gmail.com>
References: <1373186706-19284-1-git-send-email-sunshine@sunshineco.com>
	<7vk3l26695.fsf@alter.siamese.dyndns.org>
	<CAPig+cQ9sfV+PRqn5vrL0=xOZrKDDmsKdAPiB4PsCFb=jnk4kQ@mail.gmail.com>
	<7v38rnwuvb.fsf@alter.siamese.dyndns.org>
	<87ehb7d3za.fsf@hexa.v.cablecom.net>
	<CAPig+cT9U7L-03Fe5YLft=WS2EZY1B_BhLzkM_sT_3wQQ1g1MQ@mail.gmail.com>
	<7vy59fv9zr.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Thomas Rast <trast@inf.ethz.ch>, Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 09 21:07:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UwdGB-0005in-E0
	for gcvg-git-2@plane.gmane.org; Tue, 09 Jul 2013 21:07:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752312Ab3GITHD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Jul 2013 15:07:03 -0400
Received: from mail-lb0-f179.google.com ([209.85.217.179]:42344 "EHLO
	mail-lb0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752102Ab3GITHC (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Jul 2013 15:07:02 -0400
Received: by mail-lb0-f179.google.com with SMTP id w20so4947810lbh.38
        for <git@vger.kernel.org>; Tue, 09 Jul 2013 12:07:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=Z9tHkwJtRiAImgnLT4vX8uUpsoCavEHnMxNVBciMM0s=;
        b=onveCscvSe6AyGCHPLzI0zXn5JLeQgVHkt10W6iW1uLV7s7eMyaugskZVfSAU+IcQO
         44QDyrqJaSS/nUXbXZ3Aj9mck6Xk0no+A/BQTkWIqPVqHLdmuDxDN8UH+IHSvSQ5Re7R
         ix2MIqyW/+MkGxqW7HSZwSdqZ5Kv0WZk0P+G264ie6DTh79jq9MNmCUXY5ROLdoK9YH0
         K9MAgMdrMDj6jAuLsTOMXvePkSy38w3OfOdwANh4rYJ9mLZRL45W1koiQSzXC2P5hu08
         NKDoZk0MZM5ZAW8o0VkcZ/Pa7V3uUzb7UGtpvPLvklqQvctMilY90UqXIm9IX3DIsySs
         pJIQ==
X-Received: by 10.112.77.164 with SMTP id t4mr13271035lbw.52.1373396820488;
 Tue, 09 Jul 2013 12:07:00 -0700 (PDT)
Received: by 10.114.187.78 with HTTP; Tue, 9 Jul 2013 12:07:00 -0700 (PDT)
In-Reply-To: <7vy59fv9zr.fsf@alter.siamese.dyndns.org>
X-Google-Sender-Auth: 8118amPs3pgQbYATUOXgl085hV0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229980>

On Tue, Jul 9, 2013 at 2:55 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Eric Sunshine <sunshine@sunshineco.com> writes:
>
>> On Tue, Jul 9, 2013 at 1:42 PM, Thomas Rast <trast@inf.ethz.ch> wrote:
>>> Junio C Hamano <gitster@pobox.com> writes:
>>>
>>>>  (2) In the ranges "-L <anything>,/B/ -L /C/,<anything>", the
>>>>      beginning of the second range is found by choosing C that comes
>>>>      _after_ the end of the previous range (/B/ may choose either
>>>>      the second or the 4th line, and the only C that comes after
>>>>      either of them is the 5th line and that is where the second
>>>>      range should begin, not at the beginning of the file).  The
>>>>      same for "-L 1,3 -L /C/" (only C that comes after 3 is eligible
>>>>      to be the beginning of the second range).
>>>
>>> So passing several -L arguments does not blame the union of what each
>>> argument would blame individually?  Doesn't that make it rather harder
>>> to explain?
>>
>> I don't think Junio meant to imply that. Collecting the blame ranges
>> can/should be a distinct step from coalescing them. Junio is saying
>> that an -L /re/ range search should start after the maximum line
>> number already specified by any preceding range.
>
> I am not sure if I want "maximum specified so far". I meant "start
> searching at the last location", e.g.
>
>         -L 100,200 -L 4,6 -L /A/,+20
>
> would want to find the first A after line 6, not after line 200.

Okay.

>
>> Once all input ranges
>> are collected, they can be coalesced. (If a -L /re/ range happens to
>> be coalesced with or into some other range, that's fine: you're still
>> seeing blame output for the requested lines.)
>
> Yes.
