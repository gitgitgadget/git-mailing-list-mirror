From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 2/7] submodule foreach: correct path computation in
 recursive submodules
Date: Tue, 29 Mar 2016 12:21:21 -0700
Message-ID: <CAGZ79ka5_C0HcWGyYThT7O2ts-B1dTkBWEt1MUsbEN-AciE15g@mail.gmail.com>
References: <1459207703-1635-1-git-send-email-sbeller@google.com>
	<1459207703-1635-3-git-send-email-sbeller@google.com>
	<xmqq60w525yd.fsf@gitster.mtv.corp.google.com>
	<xmqqk2klxg6b.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Jacob Keller <jacob.keller@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 29 21:21:30 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1akzCi-00008m-6m
	for gcvg-git-2@plane.gmane.org; Tue, 29 Mar 2016 21:21:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754035AbcC2TVX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Mar 2016 15:21:23 -0400
Received: from mail-ig0-f169.google.com ([209.85.213.169]:38106 "EHLO
	mail-ig0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751990AbcC2TVW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Mar 2016 15:21:22 -0400
Received: by mail-ig0-f169.google.com with SMTP id ui10so13924670igc.1
        for <git@vger.kernel.org>; Tue, 29 Mar 2016 12:21:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=WyErLIG4vKblT9BgbH91cWoPfIYpbmF4ydjK3qWF7sc=;
        b=gK2NbJ82pPvWpFLJo9wR21zx9fisGRFQ/mG5UGIKGZcKh+wZHqo3fIG9/rfGtoeEF9
         8c03rVGwI4SAKGO/c2ZBusZ8udAvZKOkclNJa8t1V4FdTXeUA5YGzTWprAPer711Z8Xz
         yjG+ATIO50SyhOuUJjqAGP8aN9AOwl0VfWAJh+X+FiPfRZHcANXr7WxL3IQjpeNJp98M
         se3hB1wvD5HVZqqenLahXA5QZwHrfead3J0Ygv1xTvxyqslxpud0TnOnvStcu1Q4FKcV
         xa3ZQDOYbe+Tz15WSeIO/JOcnbAYaf7c5TqCwmvVUxsFelm3Z/JPswaoKc1evjDx57az
         FjGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=WyErLIG4vKblT9BgbH91cWoPfIYpbmF4ydjK3qWF7sc=;
        b=Z6C85S5m+KXphn8B3gMrkmIPs1ozayawM3GgwyV1wc7jsE99SIVDOZiEEqSC0X9CEM
         TgRHFZY3+4y8+NAo6xKjTH2jv+1Xg3uiLH+8DswFUChcFffbyErUyvEc7AvQhysLgq0K
         esRVYEDvjvyAPZ6Yvk048x3vKLduu2KXLLGxKPTDTrFgfGx6aKUGHLBnqo2VjgcpsZO1
         cyLY4Wbq1ra6FOriBSxvuZ+szDnLzrU4+LmdWA+izLKvaX6lJOIn1ySxbN7jegB5n7c1
         vzMvr/in1yEEN4Im5/zkrqwOAxqPY6FzTFvBDUF0s99f8RwkqP6ouLwge2XYlUekhEaV
         llmQ==
X-Gm-Message-State: AD7BkJKFTlX517p39GLBA11kd2b4m1tkx4zhqT8uBJf6IfHAfPm+ZecRqjIxIipoxtA69UDrFYQ3lWqLyRDO/nql
X-Received: by 10.50.43.226 with SMTP id z2mr5168031igl.94.1459279281488; Tue,
 29 Mar 2016 12:21:21 -0700 (PDT)
Received: by 10.107.132.101 with HTTP; Tue, 29 Mar 2016 12:21:21 -0700 (PDT)
In-Reply-To: <xmqqk2klxg6b.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290168>

On Tue, Mar 29, 2016 at 12:00 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>
>> Stefan Beller <sbeller@google.com> writes:
>>
>>> The test which is fixed by this patch would report
>>>     Entering 'nested1/nested2/../nested3'
>>> instead of the expected
>>>     Entering '../nested1/nested2/nested3'
>>>
>>> because the prefix is put unconditionally in front and after that a
>>> computed display path with is affected by `wt_prefix`. This is wrong as
>>> any relative path computation would need to be at the front. By emptying
>>> the `wt_prefix` in recursive submodules and adding the information of any
>>> relative path into the `prefix` this is fixed.
>>>
>>> Signed-off-by: Stefan Beller <sbeller@google.com>
>>> ---
>>
>> Nicely explained and executed.
>
> Interestingly, this breakage, as 1/7 shows, only affects the
> "Entering $there" message--I somehow expected from reading the
> description above that the command given to "foreach" is run
> in a wrong submodule directory, but there is no such bug that
> is fixed by this change, as far as "foreach" is concerned.

foreach is a special beast as it is the only submodule command that
ignores the current directory, i.e.
    cd repo/plugins && git submodule foreach ...
also affects submodules in repo/other-submodules.

So yeah this is only about the displaypath being relative to
the users cwd, internally we operate from the toplevel
directory. :/

>
> Which might be an indication that it wasn't so "Nicely explained"
> after all X-<.  Are there codepaths that use the same incorrect
> information (which was fixed by this patch) for things other than
> the message and chdir to an incorrect place?  Then this change is
> fixing more than "just a bug in foreach message".

Each submodule command does its own chdir and computation
of the prefix and displaypath. The common thing is the name and
the meaning of the variables. Currently I am redoing the other patches
to follow this patch. Apparently I still need to hone the commit message
to actually transport the message that this only affects the display path.

>
> The explanation does not make it clear what the extent of the fix
> is, in other words.
>
> Nevertheless, it is a good fix for "foreach message".  Thanks.  It
> just needs to clarify if that is the only change, or if it fixes
> other things.
>

Thanks,
Stefan
