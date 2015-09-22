From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v7 2/3] worktree: move/refactor find_shared_symref from branch.c
Date: Mon, 21 Sep 2015 21:07:31 -0400
Message-ID: <CAPig+cQ6pH=NzUybg-y_0-=9BoHQNJf8Kx+fos=d+PkB97gcwg@mail.gmail.com>
References: <1441402769-35897-1-git-send-email-rappazzo@gmail.com>
	<1441402769-35897-3-git-send-email-rappazzo@gmail.com>
	<CAPig+cT6JLzPPpJKPxAZGGduEQTRzwa57pHtGOJjPYPxCwJV=w@mail.gmail.com>
	<CANoM8SVJr_B83vU43MFmDiL8phRcTqG3=5krk9iquuH3w5dN_Q@mail.gmail.com>
	<CAPig+cTP_Vgtm=D1ESrPMs=r44OpGNUdEBjYMQgnQrtG-WsiaQ@mail.gmail.com>
	<CANoM8SUTOgqOsPxO1NYgjPbwSkC=odeRKfbMtds65CZitSqxsA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	David Turner <dturner@twopensource.com>,
	Git List <git@vger.kernel.org>
To: Mike Rappazzo <rappazzo@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 22 03:07:38 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZeC3V-0000GW-Mf
	for gcvg-git-2@plane.gmane.org; Tue, 22 Sep 2015 03:07:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757432AbbIVBHd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Sep 2015 21:07:33 -0400
Received: from mail-vk0-f47.google.com ([209.85.213.47]:34382 "EHLO
	mail-vk0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756290AbbIVBHc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Sep 2015 21:07:32 -0400
Received: by vkhf67 with SMTP id f67so76521565vkh.1
        for <git@vger.kernel.org>; Mon, 21 Sep 2015 18:07:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=qaDPjVnsYgRMlthRWy2d3rLWVoItObdhCToG0c2bd6k=;
        b=pRZ14wFYOT0SqPqNqAqINZYvO0Wtk8hJNbrvXwXXVKX/ICorl7RAFeq6lMHS3dIupO
         sAfqjhc8QiTbc4WzvoAuOGBhsYn0rgG1jtvNnoIoMX+CrK/bADc48mNbdT4ErzC0rkLc
         kMXUvSynWJdmlM5SLhX+UPYHU9U8TUBn99M9Gx3gKwqCZYISI2xwz8SN2qGjdgnz+OHp
         WQrh8HckJ7DsTw8WiOux/xKnlNyqePPNjmh954QG/K7BlMVDLbfUefcEScruHr1sZ0NL
         5Ulj/rzR8esU9tW6/1oDEHpXZHbDKqfWv3S9q8F+TAkiYY7Z2pH9+yAcWH4TCDX3WHTJ
         JlJA==
X-Received: by 10.31.178.3 with SMTP id b3mr7525053vkf.19.1442884052021; Mon,
 21 Sep 2015 18:07:32 -0700 (PDT)
Received: by 10.31.224.68 with HTTP; Mon, 21 Sep 2015 18:07:31 -0700 (PDT)
In-Reply-To: <CANoM8SUTOgqOsPxO1NYgjPbwSkC=odeRKfbMtds65CZitSqxsA@mail.gmail.com>
X-Google-Sender-Auth: 7GlzHD-pj1o0C7usoeXczwX3tFM
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278371>

On Wed, Sep 16, 2015 at 5:36 PM, Mike Rappazzo <rappazzo@gmail.com> wrote:
> On Wed, Sep 16, 2015 at 5:09 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
>> On Mon, Sep 14, 2015 at 1:44 PM, Mike Rappazzo <rappazzo@gmail.com> wrote:
>>> On Sat, Sep 12, 2015 at 11:19 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
>>>> The original code in branch.c, which this patch removes, did not need
>>>> to make a special case of HEAD, so it's not immediately clear why this
>>>> replacement code does so. This is the sort of issue which argues in
>>>> favor of mutating the existing code (slowly) over the course of
>>>> several patches into the final form, rather than having the final form
>>>> come into existence out of thin air. When the changes are made
>>>> incrementally, it is easier for reviewers to understand why such
>>>> modifications are needed, which (hopefully) should lead to fewer
>>>> questions such as this one.
>>>
>>> I reversed the the check here; it is intended to check if the symref
>>> is _not_ the head, since the head
>>> ref has already been parsed.  This is used in notes.c to find
>>> "NOTES_MERGE_REF".
>>
>> I'm probably being dense, but I still don't understand why the code
>> now needs a special case for HEAD, whereas the original didn't. But,
>> my denseness my be indicative of this change not being well-described
>> (or described at all) by the commit message. Hopefully, when this is
>> refactored into finer changes, the purpose will become clear.
>
> The special case for HEAD is because the HEAD is already included in
> the worktree struct.  This block is intended to save from re-parsing.
> If you think the code would be easier to read, the HEAD check could be
> removed, and the ref will just be parsed always.

I'm unable to judge whether the code would be easier to read since I
still don't understand the purpose of the special case. (But, as
noted, it may just be that I'm being dense, though not intentionally.)
