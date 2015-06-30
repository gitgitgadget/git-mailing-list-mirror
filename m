From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v6 6/7] git-reflog: add create and exists functions
Date: Tue, 30 Jun 2015 14:20:58 -0400
Message-ID: <CAPig+cQ7tQV6uG0sVMsPJX=8V3g+zufRCYcdfDo4ixwwUp5hZA@mail.gmail.com>
References: <1435609076-8592-1-git-send-email-dturner@twopensource.com>
	<1435609076-8592-7-git-send-email-dturner@twopensource.com>
	<CAPig+cROJJNTcZnZfMP0meA8ZWGcSHcQCMTCkuC+kn_+OQZ-zA@mail.gmail.com>
	<xmqqbnfx89iz.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: David Turner <dturner@twopensource.com>,
	Git List <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 30 20:21:09 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZA09b-0003Zp-KD
	for gcvg-git-2@plane.gmane.org; Tue, 30 Jun 2015 20:21:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751548AbbF3SVB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Jun 2015 14:21:01 -0400
Received: from mail-yk0-f169.google.com ([209.85.160.169]:34349 "EHLO
	mail-yk0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750821AbbF3SU7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Jun 2015 14:20:59 -0400
Received: by ykfy125 with SMTP id y125so16846208ykf.1
        for <git@vger.kernel.org>; Tue, 30 Jun 2015 11:20:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=PE5yMAuLFhYqDKOrvycx2nw8xh2HX7jPjWDqnT327ps=;
        b=1HrCXXD4vVOp2Iq7y0BOkaVjDZNEHmhSsdtJy8l5qXABgP1dLQ18ozpuHJhyoxki8L
         KAV8FH7Ebf9uUl8ol+LovltcGK2gXOVH3oqpY2vejDduptYy2mPx31Loi8Ai8aDyugE1
         O/6gmj33W6M/c4RGqcG4hsmy4Ik+M5v85Vgi/LwU2J/frOXg5mp/X+JSVmNnld7tFkCI
         CNo1nh1X5ScCZX6WS6NjX1EVHLrPGrhDfLtevR7d/tz/V2HtHeC+RX8gAeZqaKj4bS9A
         Tq6iUVvMTuMfknEVox+qFPbSrGP90qTcPNHZC2Z4YDu8UZuZbROBhLyr0ALKO3xVloKo
         svRg==
X-Received: by 10.170.63.196 with SMTP id f187mr26896024ykf.82.1435688458821;
 Tue, 30 Jun 2015 11:20:58 -0700 (PDT)
Received: by 10.37.12.129 with HTTP; Tue, 30 Jun 2015 11:20:58 -0700 (PDT)
In-Reply-To: <xmqqbnfx89iz.fsf@gitster.dls.corp.google.com>
X-Google-Sender-Auth: wu397XC4ftC6IWM4WL3ffweespw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273094>

On Tue, Jun 30, 2015 at 12:07 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Eric Sunshine <sunshine@sunshineco.com> writes:
>
>>> +       for (i = start; i < argc; i++) {
>>> +               if (safe_create_reflog(argv[i], &err, 1)) {
>>> +                       error("could not create reflog %s: %s", argv[i],
>>> +                             err.buf);
>>> +                       status = 1;
>>> +                       strbuf_release(&err);
>>
>> This feels a bit dirty.
>
> Hmm, I do not share that feeling.  I wouldn't be surprised if you
> found a lot of existing codepaths that run _init() a strbuf once,
> work on it and then _release() once a section of code is done with
> it, reuse it for further (unrelated) processing, knowing that
> _release() implicitly did _init() and the strbuf is ready to use
> after that.  I thought that was a very well established pattern.

That could the case, and I may not be familiar with code doing that.

I have, however, seen plenty of code which uses strbuf_reset() in the
way you describe.

>> While it's true that the current
>> implementation of strbuf_release() re-initializes the strbuf (so
>> you're not technically wrong by re-using it), that's an implementation
>> detail; and indeed, the strbuf_release() documentation says:
>>
>>     Release a string buffer and the memory it used. You should not
>>     use the string buffer after using this function, unless you
>>     initialize it again.
>
> Hmph. Perhaps the doc is wrong? ;-)

Perhaps. I always interpreted the documentation as meaning that the
project reserved the right to change the underlying implementation.

>> Alternatives would be strbuf_reset() or declaring and releasing the
>> strbuf within the for-loop scope.
>
> Because _reset() just rewinds the .len pointer without deallocating,
> you would need an extra _release() before it goes out of scope. If
> it is expected that the strbuf will be reused for a number of times,
> the length of the string each iteration uses is similar, and you
> will iterate the loop many times, "_reset() each time and _release()
> to clean-up" pattern would save many calls to realloc/free.

Yep, that's why I suggested strbuf_reset() as an alternative (and
likely would have chosen it myself).
