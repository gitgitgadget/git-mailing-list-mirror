From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 3/5] sha1_name.c: simplify @-parsing in get_sha1_basic()
Date: Thu, 2 May 2013 00:06:27 +0530
Message-ID: <CALkWK0nTSMYvh8VMgQ6Q0EoPMmRa2vyodz+tDmpPp1d6KYmq8w@mail.gmail.com>
References: <1367425235-14998-1-git-send-email-artagnon@gmail.com>
 <1367425235-14998-4-git-send-email-artagnon@gmail.com> <CAMP44s1tHC+i+Wug_UuPnprZNvaPgLMNBX9MZi49SFv4iO62SQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>, Duy Nguyen <pclouds@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 01 20:37:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UXbtx-0002oe-U7
	for gcvg-git-2@plane.gmane.org; Wed, 01 May 2013 20:37:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754616Ab3EAShK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 May 2013 14:37:10 -0400
Received: from mail-ia0-f181.google.com ([209.85.210.181]:44119 "EHLO
	mail-ia0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753369Ab3EAShI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 May 2013 14:37:08 -0400
Received: by mail-ia0-f181.google.com with SMTP id k38so1566920iah.40
        for <git@vger.kernel.org>; Wed, 01 May 2013 11:37:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=nC7iYQDg4mLNy/y/vNs0MEsHZ69d0ZigJasgzq3foEA=;
        b=D/PjetTcfgtxWNAyNem00/0/svkLFtP5XN1DugHH6/9+YjUMDoUbkX9ZW4AlPLBnTV
         RKRTpEmIOcCh0Z0KCjuyBYahtAQgjzEE0gg0BJU1SNKGVp7o4rZkionp7lhxRqd2THf7
         dZ1DP9tCFDoobW29aEBYk/fWRlj+2WwILZtPIUVFhoN4aMwkWTo7m5PSvgP4d4o5Sbp5
         zf38EWZp0zqZHNcwO5utzdRx9DAHkdPzoYQCtoURyezbTu+cOsGX7BKrwm8IWo5HNS0Y
         O3S4w1/Za8RdxIlcjhueBTDGYTJw/Btx7XXVqVKzWsAP1EkWHFPAKQzK3BbJRohkYeZ8
         bXgA==
X-Received: by 10.43.125.199 with SMTP id gt7mr1901114icc.48.1367433428038;
 Wed, 01 May 2013 11:37:08 -0700 (PDT)
Received: by 10.64.46.1 with HTTP; Wed, 1 May 2013 11:36:27 -0700 (PDT)
In-Reply-To: <CAMP44s1tHC+i+Wug_UuPnprZNvaPgLMNBX9MZi49SFv4iO62SQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223117>

Felipe Contreras wrote:
> On Wed, May 1, 2013 at 11:20 AM, Ramkumar Ramachandra
> <artagnon@gmail.com> wrote:
>> +                       refs_found = dwim_log(str, len, sha1, &real_ref);
>> +
>> +                       if (!refs_found && str[2] == '-') {
>
> You are changing the behavior, there's no need for that in this
> reorganization patch.

This is not a reorganization patch.  I said "simplify": not refactor.

>> +                               /* The @{-N} case that resolves to a
>> +                                * detached HEAD (ie. not a ref)
>> +                                */
>
> This is not true, it resolves to a ref.
>
> git rev-parse --symbolic-full-name @{-1}

> git co @~1; git co -; git rev-parse --symbolic-full-name @{-1}

If it did resolve to a ref, dwim_log() would have found it.  The
constraint guarding this `if (!refs_found && str[2] == '-')` wouldn't
have been satisfied, and we wouldn't be here.

> Also, you removed a useful comment:
>
> /* try the @{-N} syntax for n-th checkout */

I've changed the entire logic and written expensive comments; and I'm
not allowed to remove one comment which I didn't find helpful?

>> +                               struct strbuf buf = STRBUF_INIT;
>> +                               if (interpret_branch_name(str, &buf) > 0) {
>> +                                       get_sha1_hex(buf.buf, sha1);
>> +                                       refs_found = 1;
>> +                                       reflog_len = 0;
>> +                               }
>> +                               strbuf_release(&buf);
>
> I'm pretty sure this is doing something totally different now. This is
> certainly not "no functional changes".

I'm claiming that there is no functional change at the program level,
with the commenting*.  If you want to disprove my claim, you have to
write a test that breaks after this patch.

* And even if there is, it's probably an accidental corner case with
the wrong behavior.  The new logic is a straightforward implementation
of the rules.

>> +                       }
>>                 }
>> -               /* allow "@{...}" to mean the current branch reflog */
>> -               refs_found = dwim_ref("HEAD", 4, sha1, &real_ref);
>> -       } else if (reflog_len)
>> -               refs_found = dwim_log(str, len, sha1, &real_ref);
>> -       else
>> +       } else
>> +               /* The @{u[pstream]} case */
>
> It's not true, there might not be any @{u} in there.

This entire structure is a success-filter.  At the end of this, if
!refs_found, then there has been a failure.

> Some of these changes might be good, but I would do them truly without
> introducing functional changes, without removing useful comments, and
> without adding paragraphs of explanation for what you are doing.

The functional changes part is for you to prove.  And it's not even
worth proving, because I'm claiming that the new logic is an obviously
correct implementation of the rules.

> With the principle of self-documenting code, if you need paragraphs to
> explain what you are doing, you already lost.

The Git project is already suffering from a severe shortage of
comments [1], and you're complaining about too many comments?

Have you tried to read and understand the old version?  Some shining
example of self-documenting code you've brought up.

[1]: https://www.ohloh.net/p/git/factoids#FactoidCommentsLow
