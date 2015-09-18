From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 57/67] receive-pack: simplify keep_arg computation
Date: Fri, 18 Sep 2015 14:43:56 -0400
Message-ID: <CAPig+cQbVhksrS1T3tep570Rxj9KxX3HmWAYY2SzqoAg35w-EQ@mail.gmail.com>
References: <20150915152125.GA27504@sigill.intra.peff.net>
	<20150915161050.GE29753@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Sep 18 20:44:04 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zd0de-0004YB-0x
	for gcvg-git-2@plane.gmane.org; Fri, 18 Sep 2015 20:44:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751653AbbIRSn5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Sep 2015 14:43:57 -0400
Received: from mail-vk0-f44.google.com ([209.85.213.44]:36263 "EHLO
	mail-vk0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750870AbbIRSn5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Sep 2015 14:43:57 -0400
Received: by vkfp126 with SMTP id p126so35216131vkf.3
        for <git@vger.kernel.org>; Fri, 18 Sep 2015 11:43:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=4t76hxwoZgFPwdd/dsUdzeRiuZzB3C72M5VKU1L2j/g=;
        b=jKiMOexyXOpZQMSYMf8ZuQQQA/ABKXUhuI+1yY+5gF0FfEcafJRWxc7owuZv4mZ6YP
         3p5L6HDSu61vY4UkVuI9tSn4yJzqVk+laQXMfWVnD4bWLQ0nKleXGIc4TALbX59A49ig
         hrcdrRFeQKUUNks2Utk05mR6HRDh/ZF+Q/NBhmJywA2BLcgbvWxZD7vXJ4pYkcSCPoy8
         3+n8+z3P2b3Jw020eW4TKg1AVLvC2cr9XySyrciQcPogjLwZM+B/wdDqapxEQDEepcI5
         cTHrC5ZY4Rt6HbtS05TjQ3ZBMTrzkKar7dMs1HljodIoaWxOTrPrhkwx2NBnfHvjZ3x2
         hAGA==
X-Received: by 10.31.151.84 with SMTP id z81mr4476217vkd.14.1442601836084;
 Fri, 18 Sep 2015 11:43:56 -0700 (PDT)
Received: by 10.31.224.68 with HTTP; Fri, 18 Sep 2015 11:43:56 -0700 (PDT)
In-Reply-To: <20150915161050.GE29753@sigill.intra.peff.net>
X-Google-Sender-Auth: Nz9bdefutzpXCxtQtlOIMMzCyso
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278212>

On Tue, Sep 15, 2015 at 12:10 PM, Jeff King <peff@peff.net> wrote:
> To generate "--keep=receive-pack $pid on $host", we write
> progressively into a single buffer, which requires keeping
> track of how much we've written so far. But since the result
> is destined to go into our argv array, we can simply use
> argv_array_pushf.
>
> Unfortunately we still have to have a static buffer for the

s/static/fixed-size/ maybe?

> gethostname() call, but at least it now doesn't involve any
> extra size computation. And as a bonus, we drop an sprintf
> and a strcpy call.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
> index 8b50e48..2c82274 100644
> --- a/builtin/receive-pack.c
> +++ b/builtin/receive-pack.c
> @@ -1524,15 +1524,18 @@ static const char *unpack(int err_fd, struct shallow_info *si)
>                 if (status)
>                         return "unpack-objects abnormal exit";
>         } else {
> -               int s;
> -               char keep_arg[256];
> -
> -               s = sprintf(keep_arg, "--keep=receive-pack %"PRIuMAX" on ", (uintmax_t) getpid());
> -               if (gethostname(keep_arg + s, sizeof(keep_arg) - s))
> -                       strcpy(keep_arg + s, "localhost");
> +               char hostname[256];
>
>                 argv_array_pushl(&child.args, "index-pack",
> -                                "--stdin", hdr_arg, keep_arg, NULL);
> +                                "--stdin", hdr_arg, NULL);
> +
> +               if (gethostname(hostname, sizeof(hostname)))
> +                       xsnprintf(hostname, sizeof(hostname), "localhost");
> +               argv_array_pushf(&child.args,
> +                                "--keep=receive-pack %"PRIuMAX" on %s",
> +                                (uintmax_t)getpid(),
> +                                hostname);
> +
>                 if (fsck_objects)
>                         argv_array_pushf(&child.args, "--strict%s",
>                                 fsck_msg_types.buf);
> --
> 2.6.0.rc2.408.ga2926b9
