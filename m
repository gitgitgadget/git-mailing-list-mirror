From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH v3 00/34] libify mailinfo and call it directly from am
Date: Tue, 20 Oct 2015 15:01:46 -0700
Message-ID: <CAGZ79kYAW+T+sVz3c_q+P7brf6OvcQgeZEBnkM3U52vNYc0CqA@mail.gmail.com>
References: <1444855557-2127-1-git-send-email-gitster@pobox.com>
	<1445239731-10677-1-git-send-email-gitster@pobox.com>
	<xmqqh9ll6xo8.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 21 00:02:06 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zoeyf-0001z9-PV
	for gcvg-git-2@plane.gmane.org; Wed, 21 Oct 2015 00:01:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932166AbbJTWBs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Oct 2015 18:01:48 -0400
Received: from mail-yk0-f175.google.com ([209.85.160.175]:36325 "EHLO
	mail-yk0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753507AbbJTWBq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Oct 2015 18:01:46 -0400
Received: by ykba4 with SMTP id a4so25113980ykb.3
        for <git@vger.kernel.org>; Tue, 20 Oct 2015 15:01:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=cD+Vm5Eo2cyK43uM5y669Ve+ISgtKp9BxFoqxDfjmhQ=;
        b=gMV2ZzHu6stpGWWOyVQjBzDHzq0dbkhuGaPXnr2IN27IPogqTxmE+IADv4XRPmTg3h
         dUjmBL+0d4VAGm2WlmyDy8hKd+If+Ibj73TMN9QvS0o63uZ0XZTd/DKKSrqyfVWawOzM
         Q29+aKMRV/anNkJqgKxoIfhWUi2hJ7HkrM8dQsBqc84qXb6jphgErs9PAxu3XYXoiAAp
         prL4Va5t8MXEbtml6d6Yx+jJI22IS/B+LkX2nkmEQ4G/FfJ9B1Cd1ptJdYlZsO27rD+3
         SQMSHrgOP6atGzySPlW+5xx1vFefxkG0K+GmndkGGupu8mSl04Sy09tPB5ntzSssyw72
         bYJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=cD+Vm5Eo2cyK43uM5y669Ve+ISgtKp9BxFoqxDfjmhQ=;
        b=OYKs6UredLLiQhFGrd0Ah6m+GN/1/8FwCD8TQhyjh3jFkrjqh2NIM7tpIPHlcFFTXX
         wsmftIR/03+o9q9z9m0Kuumh/WVtG+zOdfQiDYHsUrs5gYeAQL7TbiOiiA5NYY5shJrZ
         1UjfEuPOyQxhPkX4/U9gcEINmXP8tu23txlmqOMMl26SJa2yagvc0hOV+nEjwBry1pYk
         2aqyqVDkAmuewKv/e68cHoff9Xn5dadCfXwj2loJ0iFgyCsrgVZyaeh0IASygS3HJFtD
         JXUxgN3zeSdo/WdIiZSHINJ7KxJznBVFf5GpyOBZ80c0GvBoouDT4k+FJkungMBK7BNF
         Pxrg==
X-Gm-Message-State: ALoCoQk5GBSErCI1bm3thjphNqCOiK0sL0XqpWR+0shNwb1Q3Ms7LHpsP0ELDG5xT/NAu/1Fgzj9
X-Received: by 10.129.91.68 with SMTP id p65mr4088315ywb.252.1445378506072;
 Tue, 20 Oct 2015 15:01:46 -0700 (PDT)
Received: by 10.37.29.213 with HTTP; Tue, 20 Oct 2015 15:01:46 -0700 (PDT)
In-Reply-To: <xmqqh9ll6xo8.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279943>

On Tue, Oct 20, 2015 at 2:24 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>
>> During the discussion on the recent "git am" regression, I noticed
>> that the command reimplemented in C spawns one "mailsplit" and then
>> spawns "mailinfo" followed by "apply --index" to commit the changes
>> described in each message.  As there are platforms where spawning
>> subprocess via run_command() interface is heavy-weight, something
>> that is conceptually very simple like "mailinfo" is better called
>> directly inside the process---something that is lightweight and
>> frequently used is where the overhead of run_command() would be felt
>> most.
>
> Although I still haven't seen any offer to help from those who work
> on the platforms that may benefit from this series the most, I have
> some numbers on my desktop (Dell T3500 2.66GHz Xeon X5650 with 12GB,
> running Ubuntu), where the cost of spawning is not as costly as
> elsewhere, making this series less pressing.

As far as I understand, this only helps for mailing list workflows, which
in my limited view of the world is only found in established infrastructure
projects, who tend to be maintained by people who run some kind of
ab-nomination of unix.
("Are there people in Windows land who heavily use the email workflow?")

>
> Between 'master' and the version with this series (on 'jch'),
> applying this 34-patch series itself on top of 'master' using "git
> am", best of 5 numbers for running:
>
>     time git am mbox >/dev/null
>
> are
>
>       (master)                 (with the series)
>     real    0m0.648s            real    0m0.537s
>     user    0m0.358s            user    0m0.338s
>     sys     0m0.172s            sys     0m0.154s
>
> I haven't re-read the series to catch leaks yet, so in that sense
> the series is still not ready to be merged to 'next' (of course,
> help with fresh set of eyes is very much appreciated here).

I'll take another look after sending out my series.

> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
