From: "krzf83@gmail.com " <krzf83@gmail.com>
Subject: Re: hooks scripts and noexec partition
Date: Sun, 14 Dec 2014 02:44:35 +0100
Message-ID: <CAJ1PRS=KmiQJG91nxG5pQXPHX2XruoyL9c4yzzPeYayw+UAjPw@mail.gmail.com>
References: <CAJ1PRS=96aSp3GE+wj=zHX=JGfZbjUeiUuiDDvfJNuRhrbK_Yg@mail.gmail.com>
	<20140115091609.GC14335@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Dec 14 02:44:43 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XzyEl-0008SI-3J
	for gcvg-git-2@plane.gmane.org; Sun, 14 Dec 2014 02:44:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752569AbaLNBoi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Dec 2014 20:44:38 -0500
Received: from mail-lb0-f175.google.com ([209.85.217.175]:35844 "EHLO
	mail-lb0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751905AbaLNBoh (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Dec 2014 20:44:37 -0500
Received: by mail-lb0-f175.google.com with SMTP id u10so7752964lbd.34
        for <git@vger.kernel.org>; Sat, 13 Dec 2014 17:44:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=HfyRYV+bDT656n/tbGL+VuNHH0TMemJokbO+WxWYH48=;
        b=vgQLkz6014vruumUnI8k2FQasYuH4Yb+MvUF123yGUA17R10V7Xvlv7i1IjD6xPwk/
         5NM6yu3S1wvPfJUGIEECWld0IKOGka2x9fC6sUgaMEfTNQQqN8Oa3Z0BKDEV95Yauf8D
         Ik5tkwZchq33USdT+N5RKT4V7Vmc0TPhWJe5yZXR9kQiXv6himh2z04t4xhbxnko0B06
         Nths3WhhLLlG8RsU1WK9oT1fMk49paDkg7gVrqebd2S7c3Cuhgf3SkXTS1j5fSPUZiVp
         frPj6EZBztdq2VUBM9JO6kBE0RTPNl2R7+5xpj0sw9GjndXmj8W6yFxXle3i9S4LdJgb
         JTZg==
X-Received: by 10.152.5.165 with SMTP id t5mr18474938lat.62.1418521475626;
 Sat, 13 Dec 2014 17:44:35 -0800 (PST)
Received: by 10.152.206.4 with HTTP; Sat, 13 Dec 2014 17:44:35 -0800 (PST)
In-Reply-To: <20140115091609.GC14335@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261397>

Thanks for the patch, however it is not working (no change, hooks
still dont work on noexec partition). Since I see that you are fluent
in git code and C can you by any chance tell me how to modify
run-command.c to make git run hooks as: /bin/sh <hook_path> ?

2014-01-15 10:16 GMT+01:00 Jeff King <peff@peff.net>:
> On Tue, Jan 14, 2014 at 04:41:03PM +0100, krzf83@gmail.com  wrote:
>
>> git can't execute hooks no partitions mounted with noexec - even if
>> those are just scripts with shebang line
>
> Right. Git does not know that they are shell (or other) scripts; they
> could be anything, and the advertised interface is that git will run
> exec on them (and it is explicitly OK for them to exist but not be
> executable, and git takes this as a sign that they are inactive).
>
>> and they actualy work by
>> hooks/./post-comit (because I use small patch on kernel that allows
>> running scripts that way on noexec partition)
>
> If you are suggesting that git always execute them as "hooks/./$hook",
> that might make sense if such behavior is widespread. But it sounds like
> you are running a custom kernel patch to get around the noexec setting.
> Here is the custom git patch to match it. :)
>
> diff --git a/run-command.c b/run-command.c
> index 3914d9c..ae84e87 100644
> --- a/run-command.c
> +++ b/run-command.c
> @@ -753,7 +753,7 @@ int finish_async(struct async *async)
>
>  char *find_hook(const char *name)
>  {
> -       char *path = git_path("hooks/%s", name);
> +       char *path = git_path("hooks/./%s", name);
>         if (access(path, X_OK) < 0)
>                 path = NULL;
>
>
> -Peff
