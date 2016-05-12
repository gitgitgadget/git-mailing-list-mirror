From: Mikael Magnusson <mikachu@gmail.com>
Subject: Re: [PATCH 2/2] am: plug FILE * leak in split_mail_conv()
Date: Thu, 12 May 2016 07:23:02 +0200
Message-ID: <CAHYJk3Q90MrV_hxF+xxbFnJtL6_OLqTRoekwjc9-_LJuFc-aTg@mail.gmail.com>
References: <20160511233546.13090-1-gitster@pobox.com>
	<20160511233546.13090-2-gitster@pobox.com>
	<20160512044730.GA5436@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu May 12 07:23:10 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b0j5Z-0002GA-Mm
	for gcvg-git-2@plane.gmane.org; Thu, 12 May 2016 07:23:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751769AbcELFXF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 May 2016 01:23:05 -0400
Received: from mail-qk0-f195.google.com ([209.85.220.195]:34622 "EHLO
	mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751647AbcELFXE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 May 2016 01:23:04 -0400
Received: by mail-qk0-f195.google.com with SMTP id i7so4638203qkd.1
        for <git@vger.kernel.org>; Wed, 11 May 2016 22:23:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=JVG2RWITWNrBIyeiwJGcvep9V9aBGYV2Gj47WYo5iCw=;
        b=ZVoTZC8l8HoNqHrboYHf0K6V1t1s5uzORHFNx3Jqce1kmLTR5vGgvd9h66ZhXvG0Wk
         aQnvlvWozu5cjy2zVWke7AG+WU7rDQPSKI/xqmzGmi0xU9DUzUWozS4MzSU8ZIQgCNXn
         LWQV6BnMoyP/9WUdy+zsKprMyBqM129p4w69a/ieu/RiQs+lJtlwMJwYNV+ubDS4GrdX
         jpWvpwijYqxJ6Wq2s3sblItSpKs65A52V0Fh9tYKb0NIMtRU6nXnU15bXvAmZA8S1u2f
         2jS3KfLU6D/iWMnAP0IB4o/5VIoaCLscVWgOyVhJv61ir2C0SM9G9wBAKsofOYC8PeAc
         Y9Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=JVG2RWITWNrBIyeiwJGcvep9V9aBGYV2Gj47WYo5iCw=;
        b=JMYM9XkDBTLgPaouaZkNJeYFL+OuXtMe924OtpbF6XqVY/Rtp4hwvJhLdlCi+OXKzM
         oAVsLluMw4DmUrEflaMZdoV3Ue70C6n3xD8imsZsiufZRQg4ORoESVLR911Uc58GeMex
         iUWzoqmz7c6tDye3pjY5zkOWUs0tVEnp7smD0CRUKZyZuTm6YhYQV4va2GkdaaZDAGbg
         OtMClGtUXnS2o2begY6KRYzavAoLxG8G00IPuc5+FGgVQsf0sZr9LKmSNjYuD/AMETUD
         iYYqO3NZPcdSK3YzeKk0qiYXRblEls9QZUBsbR0RtRQzx/D47+HjYLQGzqkUnY9fVVsN
         hc9g==
X-Gm-Message-State: AOPr4FXcl108xn0jGpt+9ICgJwjWhlvQMPcyrsLfCqVRyh9GCcODqFR41bqNz28ihC2nccx3cI3E5LXOSQt9JA==
X-Received: by 10.55.99.214 with SMTP id x205mr7880286qkb.3.1463030582846;
 Wed, 11 May 2016 22:23:02 -0700 (PDT)
Received: by 10.55.177.194 with HTTP; Wed, 11 May 2016 22:23:02 -0700 (PDT)
In-Reply-To: <20160512044730.GA5436@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294385>

On Thu, May 12, 2016 at 6:47 AM, Jeff King <peff@peff.net> wrote:
> On Wed, May 11, 2016 at 04:35:46PM -0700, Junio C Hamano wrote:
>
>> Signed-off-by: Junio C Hamano <gitster@pobox.com>
>> ---
>>  builtin/am.c | 4 +++-
>>  1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/builtin/am.c b/builtin/am.c
>> index f1a84c6..a373928 100644
>> --- a/builtin/am.c
>> +++ b/builtin/am.c
>> @@ -761,9 +761,11 @@ static int split_mail_conv(mail_conv_fn fn, struct am_state *state,
>>               mail = mkpath("%s/%0*d", state->dir, state->prec, i + 1);
>>
>>               out = fopen(mail, "w");
>> -             if (!out)
>> +             if (!out) {
>> +                     fclose(in);
>>                       return error(_("could not open '%s' for writing: %s"),
>>                                       mail, strerror(errno));
>> +             }
>
> Presumably `fclose` doesn't ever overwrite errno in practice, but I
> guess it could in theory.

It probably does pretty often in general, but not when the file is
opened for input only.

-- 
Mikael Magnusson
