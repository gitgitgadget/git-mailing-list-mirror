From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v13 00/12] port tag.c to use ref-filter APIs
Date: Thu, 27 Aug 2015 23:30:41 +0530
Message-ID: <CAOLa=ZT7VpMaMvxaMeSLJOr3BYv0pcY7dDPR-g2LvDVXCOs1YQ@mail.gmail.com>
References: <1440214788-1309-1-git-send-email-Karthik.188@gmail.com>
 <vpqzj1hkc5q.fsf@anie.imag.fr> <xmqq7fok2u57.fsf@gitster.dls.corp.google.com>
 <xmqqy4h01egr.fsf@gitster.dls.corp.google.com> <CAOLa=ZQwW9hpg4p8+DE2oZA28Av7mLrqAhEdcro=esuqHe35Xg@mail.gmail.com>
 <xmqqzj1fxjpj.fsf@gitster.dls.corp.google.com> <CAOLa=ZSu7XyZhWUL=25dnkiGm2mNDyFhXwS_JqudyfKPE5sisQ@mail.gmail.com>
 <xmqq6142w1xf.fsf@gitster.dls.corp.google.com> <CAOLa=ZS3Fj8EFMp+BXEomeW2PfkBJemoO2-8Tv=RBRb9xGmEyw@mail.gmail.com>
 <xmqq61413iqy.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Git <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 27 20:01:22 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZV1UC-0006jM-7C
	for gcvg-git-2@plane.gmane.org; Thu, 27 Aug 2015 20:01:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751531AbbH0SBM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Aug 2015 14:01:12 -0400
Received: from mail-oi0-f46.google.com ([209.85.218.46]:33467 "EHLO
	mail-oi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751231AbbH0SBL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Aug 2015 14:01:11 -0400
Received: by oigm66 with SMTP id m66so10858757oig.0
        for <git@vger.kernel.org>; Thu, 27 Aug 2015 11:01:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=Wm6ACobaRmOngbgWPihTEGdE6O/uN8GjzS77XxAlfQ4=;
        b=FN3lDUuJCQBCZHcHjNyr5ca3l8nUozuqmnZf2tb+lTqZ6w+jYU97EnrbPViUQ4NmJ7
         tkMZgymZefq/7VDudnWgexpLlBGJLDPk4OrkjbjkVlAWWP01PX/3azWjUpOPL6VUG0cB
         nsFU6F8gSiyZh3cVgHSPHIELGytFK02EBqi1d4Su0/pX62ffmGKC/m+DG6lMFDDll6mD
         vvL5fkU3rbDEhLu2jphUYyg8clhc5qCJCT6992LmQsu1s/bSlDtG1JFI5OzXdds9UE8h
         0uSj+ABHSqh2r1iGm+zL6sj53dKB99jN4CmIp/A0x/0hc+ZEfPsTDYfeuawe/ylkAQMM
         bAeA==
X-Received: by 10.202.92.65 with SMTP id q62mr3166404oib.11.1440698470376;
 Thu, 27 Aug 2015 11:01:10 -0700 (PDT)
Received: by 10.182.59.102 with HTTP; Thu, 27 Aug 2015 11:00:41 -0700 (PDT)
In-Reply-To: <xmqq61413iqy.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276685>

On Thu, Aug 27, 2015 at 1:49 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> On Wed, Aug 26, 2015 at 8:07 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>>
>>> ...  You can give a new format_ref_array_item()
>>> that does not print but fills a strbuf to this caller, make
>>> show_ref_array_item() a thin wrapper that calls it and prints it
>>> with the final LF for other callers.
>>>
>> You're saying remove show_ref_array_item() (even the wrapper you mentioned
>> above) and just have something like format_ref_array_item() which
>> would output to a strbuf. and let the caller worry about the printing?
>
> Among the current callers, the one in builtin/tag.c that wants to
> trigger show_tag_lines() hack embedded in show_ref_array_item()
> function can stop calling show_ref_array_item() and instead can do
>
>         for (i = 0; i < array.nr; i++) {
>                 struct strbuf out = STRBUF_INIT;
>                 format_ref_array_item(&out, ...);
>                 if (filter->lines) {
>                         ... append tag lines to out ...
>                 }
>                 printf("%s\n", out.buf);
>                 strbuf_reset(&out);
>         }
>
> The current and future callers of show_ref_array_item() that do not
> want to trigger the show_tag_liens() hack embedded in there may
> still want it to print the formatted string including the trailing
> LF, so you can keep show_ref_array_item() as a thin wrapper around
> format_ref_array_item() for them to call, e.g.
>
>         show_ref_array_item(...) {
>                 struct strbuf out = STRBUF_INIT;
>                 format_ref_array_item(&out, ...);
>                 printf("%s\n", out.buf);
>                 strbuf_release(&out);
>         }
>
> But if it has only one caller each, you may not even want to have
> show_ref_array_item(), if you are going to do the "output to strbuf"
> variant.
>
>
>

This is exactly what I did at the moment, I'm also trying to get
%(contents:lines=N)
work. Thanks for explaining though.

-- 
Regards,
Karthik Nayak
