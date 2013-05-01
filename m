From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 3/5] sha1_name.c: simplify @-parsing in get_sha1_basic()
Date: Wed, 1 May 2013 14:23:55 -0500
Message-ID: <CAMP44s0sRqsmhbv-GA5x0FPc5msouSoGaU_Wg51E0F9bNsmkjg@mail.gmail.com>
References: <1367425235-14998-1-git-send-email-artagnon@gmail.com>
	<1367425235-14998-4-git-send-email-artagnon@gmail.com>
	<CAMP44s1tHC+i+Wug_UuPnprZNvaPgLMNBX9MZi49SFv4iO62SQ@mail.gmail.com>
	<CALkWK0nTSMYvh8VMgQ6Q0EoPMmRa2vyodz+tDmpPp1d6KYmq8w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>, Duy Nguyen <pclouds@gmail.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 01 21:24:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UXcdF-0002mI-89
	for gcvg-git-2@plane.gmane.org; Wed, 01 May 2013 21:24:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754695Ab3EATX6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 May 2013 15:23:58 -0400
Received: from mail-lb0-f169.google.com ([209.85.217.169]:61060 "EHLO
	mail-lb0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752263Ab3EATX4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 May 2013 15:23:56 -0400
Received: by mail-lb0-f169.google.com with SMTP id z5so1734850lbh.28
        for <git@vger.kernel.org>; Wed, 01 May 2013 12:23:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=wFCffKO6/Ej6fDk20qOHdl/1Voy83fkM4yyGOAn09Q0=;
        b=k0B0KyiT0UqNMGk5JZiJU3cA1mPA7ZqBVydxs0X0N5uiiSegRC5gWxtS2QWikROQ02
         0NhwdCra9+uXzGH9Bt1e7BGam3m8B6l7U5iP3Jf6idSaOC6iAcg+pfoLIPsmb3OTzR8j
         DO60f8WSkR14GKIkKb3HBhQLX95Rl/9jEvY0B7D5W93k3bicm0axN6Pn/i7ZCetsinSb
         Uk2PKeogHUptpP23iyMQW5RYpDSfu0JnhMaB3dRtKoR8LyRQsaObBiONvuxlMrOJXhhR
         F2pOFYTJgCp4OY5+COTvJ2w4HMu5ZAtjEr2pm2tlkf+w4wJUiQ0GC/3xg0t31y0WvRPs
         viuw==
X-Received: by 10.112.154.98 with SMTP id vn2mr1625865lbb.8.1367436235280;
 Wed, 01 May 2013 12:23:55 -0700 (PDT)
Received: by 10.114.83.167 with HTTP; Wed, 1 May 2013 12:23:55 -0700 (PDT)
In-Reply-To: <CALkWK0nTSMYvh8VMgQ6Q0EoPMmRa2vyodz+tDmpPp1d6KYmq8w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223127>

On Wed, May 1, 2013 at 1:36 PM, Ramkumar Ramachandra <artagnon@gmail.com> wrote:
> Felipe Contreras wrote:
>> On Wed, May 1, 2013 at 11:20 AM, Ramkumar Ramachandra
>> <artagnon@gmail.com> wrote:
>>> +                       refs_found = dwim_log(str, len, sha1, &real_ref);
>>> +
>>> +                       if (!refs_found && str[2] == '-') {
>>
>> You are changing the behavior, there's no need for that in this
>> reorganization patch.
>
> This is not a reorganization patch.  I said "simplify": not refactor.

I'd say you should start with a reorganization, and then a simplification.

>>> +                               /* The @{-N} case that resolves to a
>>> +                                * detached HEAD (ie. not a ref)
>>> +                                */
>>
>> This is not true, it resolves to a ref.
>>
>> git rev-parse --symbolic-full-name @{-1}
>
>> git co @~1; git co -; git rev-parse --symbolic-full-name @{-1}
>
> If it did resolve to a ref, dwim_log() would have found it.  The
> constraint guarding this `if (!refs_found && str[2] == '-')` wouldn't
> have been satisfied, and we wouldn't be here.

I see.

>> Also, you removed a useful comment:
>>
>> /* try the @{-N} syntax for n-th checkout */
>
> I've changed the entire logic and written expensive comments; and I'm
> not allowed to remove one comment which I didn't find helpful?

But it is helpful.

>>> +                               struct strbuf buf = STRBUF_INIT;
>>> +                               if (interpret_branch_name(str, &buf) > 0) {
>>> +                                       get_sha1_hex(buf.buf, sha1);
>>> +                                       refs_found = 1;
>>> +                                       reflog_len = 0;
>>> +                               }
>>> +                               strbuf_release(&buf);
>>
>> I'm pretty sure this is doing something totally different now. This is
>> certainly not "no functional changes".
>
> I'm claiming that there is no functional change at the program level,
> with the commenting*.  If you want to disprove my claim, you have to
> write a test that breaks after this patch.

The burden of proof resides in the one that makes the claim, I don't
need to prove that there are functional changes, merely that you
haven't met your burden of proof.

That being said, perhaps there are no _behavioral_ changes, because
you are relegating some of the current functionality to dwim_log, but
the code most certainly is doing something completely different.
Before, get_sha1_basic recursively called itself when @{-N} resolved
to a branch name, now, you rely on dwim_log to do this for you without
recursion, which is nice, but functionally different.

>>> +                       }
>>>                 }
>>> -               /* allow "@{...}" to mean the current branch reflog */
>>> -               refs_found = dwim_ref("HEAD", 4, sha1, &real_ref);
>>> -       } else if (reflog_len)
>>> -               refs_found = dwim_log(str, len, sha1, &real_ref);
>>> -       else
>>> +       } else
>>> +               /* The @{u[pstream]} case */
>>
>> It's not true, there might not be any @{u} in there.
>
> This entire structure is a success-filter.  At the end of this, if
> !refs_found, then there has been a failure.

That's irrelevant, this 'else' case is for !reflog_len, there might or
might not be @{u} in there.

>> With the principle of self-documenting code, if you need paragraphs to
>> explain what you are doing, you already lost.
>
> The Git project is already suffering from a severe shortage of
> comments [1], and you're complaining about too many comments?

Irrelevant conclusion fallacy; let's suppose that the Git project is
indeed suffering from a shortage of comments, that doesn't imply that
*these* comments in their present form are any good.

-- 
Felipe Contreras
