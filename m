From: Edmundo Carmona Antoranz <eantoranz@gmail.com>
Subject: Re: [PATCH v6] blame: add support for --[no-]progress option
Date: Sat, 12 Dec 2015 18:30:24 -0600
Message-ID: <CAOc6etar5DU0w_RFRgUAzK39R43cP=eSwT_=0u2NbgKhdPi8Sg@mail.gmail.com>
References: <1449964625-27737-1-git-send-email-eantoranz@gmail.com>
	<CAPig+cQq2Y0m0UJVCMb-9B8qrGNXV7ecf5hDETdgX5w4oUuAvw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j6t@kdbg.org>,
	=?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Sun Dec 13 01:30:34 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a7uYY-0001pX-D8
	for gcvg-git-2@plane.gmane.org; Sun, 13 Dec 2015 01:30:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751269AbbLMAaZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Dec 2015 19:30:25 -0500
Received: from mail-pa0-f47.google.com ([209.85.220.47]:34016 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751187AbbLMAaZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Dec 2015 19:30:25 -0500
Received: by pacwq6 with SMTP id wq6so84251791pac.1
        for <git@vger.kernel.org>; Sat, 12 Dec 2015 16:30:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=PrDJI9y9wDnYB9WIb09rNYG0raDVYLDekiFDsX9s+28=;
        b=vhCW12HBKVmIckR3HmJatYXdvYvV4j/OwZpIzMJoz1M43/Fe1T7cU4FlvxFLbgoRBN
         BkRia/qW2TsZKDUNjCsaysPsjcooXauroAKKERaOY0lpwX1OgUpKykw+GpWx3njeO1Cm
         Cgd+uAEtyNNAmmWDbmz9u4RLMuG7nvQOYRpZs8arTLHPA+9RFh2Ky93QBJ+FF+sgClk0
         E24hP0A/7yLqxEj/CGzvyCRJrr7oTi4vK8Bx5V+/z9OZ4cVuQI4dvIIPAZgrsA+fV4mv
         Lu4XGtiPLbeU7i1ta5uCDcSWHyUIGlrVUr8vP//4C33p8eEKbe9gF5OUU0A6C9WejZEZ
         BnqA==
X-Received: by 10.67.14.104 with SMTP id ff8mr35400843pad.92.1449966624663;
 Sat, 12 Dec 2015 16:30:24 -0800 (PST)
Received: by 10.66.89.42 with HTTP; Sat, 12 Dec 2015 16:30:24 -0800 (PST)
In-Reply-To: <CAPig+cQq2Y0m0UJVCMb-9B8qrGNXV7ecf5hDETdgX5w4oUuAvw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282308>

On Sat, Dec 12, 2015 at 6:17 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> Right here below the "---" line would be a good place to explain what
> changed since the previous version. As an aid for reviewers, it's also
> helpful to provide a link to the previous round, like this[1].
>
> [1]: http://thread.gmane.org/gmane.comp.version-control.git/281677
>

Ok... learning the tricks.

>> @@ -69,6 +69,13 @@ include::line-range-format.txt[]
>> +--[no-]progress::
>> +       Progress status is reported on the standard error stream
>> +       by default when it is attached to a terminal. This flag
>> +       enables progress reporting even if not attached to a
>> +       terminal. Progress information won't be displayed if using
>> +       `--porcelain` or `--incremental`.
>
> The actual implementation (below) actively forbids --progress with
> --porcelain or --incremental, so the final sentence is misleading.
> Perhaps say instead that "--progress is incompatible with --porcelain
> and --incremental".
>
> More below...
>

Absolutely right.... didn't reflect the 'policy change' in the
documentation. Will update for next patch version.

>> +
>> +       if (pi.progress)
>> +               stop_progress(&pi.progress);
>
> As noted in the v5 review[2], stop_progress() itself handles NULL
> 'struct progress' gracefully, so the 'if (pi.progress)' conditional is
> unnecessary, thus the code can be simplified further to merely:
>
>     stop_progress(&pi.progress);
>

You are right!

>
> The 'show_progress = 0' seems unnecessary. What if you did something
> like this instead?
>
>     if (show_progress > 0 && (incremental ||
>             (output_option & OUTPUT_PORCELAIN)))
>         die("--progress can't be used with...");
>     else if (show_progress < 0)
>         show_progress = isatty(2);
>
>>         if (0 < abbrev)
>>                 /* one more abbrev length is needed for the boundary commit */
>>                 abbrev++;

Because, if the user didn't provide --[no-]progress option, then the
value in show_progress will move forward being -1 and then in
assign_blame, there will be progress output if you chose --incremental
or porcelain. So, if you chose --incremental or porcelain, we better
set the value to 0 to make sure there will be _no_ progress. Agree?

Cheers!
