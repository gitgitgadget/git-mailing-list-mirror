From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] blame: add blame.showemail config option
Date: Mon, 27 Apr 2015 15:23:25 -0400
Message-ID: <CAPig+cRTfB9aiinhSJp=jY7-__6dRvfAqhWZYVN3+Ut=Y79LcQ@mail.gmail.com>
References: <1429841612-5131-1-git-send-email-qneill@quicinc.com>
	<CAPig+cQrUPHOaKjNhsmLho+bFdAOQxb0NK2YK2QsFmdDBF6h4g@mail.gmail.com>
	<CACfD1vvaAGkx2P3yMfZPOZrRvG3-H96zQVOCevnd-O0rBJ7wjw@mail.gmail.com>
	<xmqqwq0xwige.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Quentin Neill <quentin.neill@gmail.com>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 27 21:23:38 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ymoct-0003X9-KZ
	for gcvg-git-2@plane.gmane.org; Mon, 27 Apr 2015 21:23:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964867AbbD0TX1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Apr 2015 15:23:27 -0400
Received: from mail-ig0-f181.google.com ([209.85.213.181]:38261 "EHLO
	mail-ig0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751359AbbD0TX0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Apr 2015 15:23:26 -0400
Received: by igbhj9 with SMTP id hj9so2356238igb.1
        for <git@vger.kernel.org>; Mon, 27 Apr 2015 12:23:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=zz+Q1Yyao1pRWTHzLurkI+XwCSwVXT0+Kjd4vgOKrlI=;
        b=r6Ac0S0ye/H1nV/Z8RZSGfKwCESE0LuIZVyjAACOHDhHMn8uWXxvkGRekN0dWMzws+
         NwqPiOwInE11VRkSbWLJH/ScbMSnAH65VzerlJzcP8L0B+1FT2xokixTFqZMsyiMslxs
         gCf0M68gwtLOVqsHqTnKR6s3Tr1u9SJisBWh98KzstWWF7hZPeRUknOcje3xgkHT8x2M
         FIFvTGv1WC2iQph1xA7ReUed80SUKkLWGtMTSvAxiA0v8u0LbVZeNPZWXsw+t880V6XR
         /2mzHQSCXjbTYuzAG3Fj/3RSaO6eXJ2Lgb869ldGmpfLrVY/ll7gItOiecRsaJfmzOwx
         hs2A==
X-Received: by 10.50.85.43 with SMTP id e11mr15203023igz.15.1430162605735;
 Mon, 27 Apr 2015 12:23:25 -0700 (PDT)
Received: by 10.107.28.132 with HTTP; Mon, 27 Apr 2015 12:23:25 -0700 (PDT)
In-Reply-To: <xmqqwq0xwige.fsf@gitster.dls.corp.google.com>
X-Google-Sender-Auth: OmldgZ0qVrc4jSHnbS6eoE_Nd_o
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267875>

On Mon, Apr 27, 2015 at 2:10 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Quentin Neill <quentin.neill@gmail.com> writes:
>> Eric Sunshine <sunshine@sunshineco.com> writes:
>>> Quentin Neill <quentin.neill@gmail.com> writes:
>>>> -                       if (opt & OUTPUT_SHOW_EMAIL)
>>>> +                       if ((opt & OUTPUT_SHOW_EMAIL) || show_email)
>>>
>>> The desired behavior is for a configuration setting to provide a
>>> fallback, and for a command-line option to override the fallback. So,
>>> for instance, if blame.showemail is "true", then --no-show-email
>>> should countermand that. Unfortunately, the way this patch is
>>> implemented, it's impossible to override the setting from the
>>> command-line since show_email==true will always win (when
>>> blame.showemail is "true").
>>>
>> I followed the code for blame.showRoot and blame.blankboundary.
>
> If you truly followed this code pattern, I would expect that there
> will not be a separate show_email variable introduced to support
> this new configuration variable.  The OUTPUT_SHOW_EMAIL bit in the
> opt flag word corresponds to show_root and blank_boundary variables,
> so the code to read configuration variable would set that bit in the
> opt flag word before the command line parser would kick in.  And the
> code that checks "opt & OUTPUT_SHOW_EMAIL" currently does not have
> to change at all.

Right. Rather than having a separate global 'show_email' variable and
consulting that variable in parallel with OUTPUT_SHOW_EMAIL throughout
the code, instead set the OUTPUT_SHOW_EMAIL bit in git_blame_config().
To do this, take advantage of the "callback data" argument of
git_config(), which will arrive in git_blame_config() as its 'void
*cb' argument. So, for instance, something like this:

    static int git_blame_config(var, value, void *cb)
    {
        ...
        if (!strcmp(var, "blame.showemail")) {
            if (git_config_bool(var, value)) {
                int *output_options = cb;
               *output_options |= OUTPUT_SHOW_EMAIL;
            }
            return 0;
        }
        ...
    }

    int cmd_blame(...)
    {
        ...
        git_config(git_blame_config, &output_options);
        ...
        parse_options(...);
        ...
    }
