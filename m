From: Antoine Pelisse <apelisse@gmail.com>
Subject: Re: [PATCH] merge: Honor prepare-commit-msg return code
Date: Thu, 3 Jan 2013 18:33:29 +0100
Message-ID: <CALWbr2zAWrGBSvMFOYMzhFnPejv6_uU3LH6dfOwimXs_1v1eMg@mail.gmail.com>
References: <1357152170-5511-1-git-send-email-apelisse@gmail.com>
	<7v623f2uam.fsf@alter.siamese.dyndns.org>
	<CALWbr2wWjwUnHFq1icMRuW=vjQDhTO1e_chffqUvDWY5za1Kiw@mail.gmail.com>
	<7vwqvv1dta.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>, Jay Soffian <jaysoffian@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 03 18:33:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tqofx-0006Ly-1A
	for gcvg-git-2@plane.gmane.org; Thu, 03 Jan 2013 18:33:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753503Ab3ACRde (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Jan 2013 12:33:34 -0500
Received: from mail-ea0-f180.google.com ([209.85.215.180]:55542 "EHLO
	mail-ea0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753459Ab3ACRdd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Jan 2013 12:33:33 -0500
Received: by mail-ea0-f180.google.com with SMTP id f13so6298814eai.39
        for <git@vger.kernel.org>; Thu, 03 Jan 2013 09:33:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=TEuWPOns39hl6rmEVMEq34cufBSwegfkJ+pTPgJO9Vs=;
        b=L1LEke318oArOQwSP8p1Ap6QQwyRwhu+OHKPMIymAoem3nMTc9rzHpe0SsNLTJugRT
         6YgFbj/pgzBMswCz0r3lP7VZasBwcFNYfI5h1R3n4UrynCsO1ST1U/bfaBu8jJ3IEouU
         HrodF81OE3z6jeNpXOaxqG/ZqqRFYM+/OgvMz0sf78zEgRqQd/bxEaVk8gAP9Y6So0et
         EP+Te/AW0SjN5755vZRGwSN4nbjU4fESe3GRkFWYp7kJfWwHGB+r4a+Q0jyAk0zus9hc
         6wakFjzl3B6L/iPBBxYHMbrRyqeVC9IJW7A+YTfI8i2U167G00SwcpmZDxqdb9xwkDO1
         9L3g==
Received: by 10.14.1.195 with SMTP id 43mr136141014eed.31.1357234409171; Thu,
 03 Jan 2013 09:33:29 -0800 (PST)
Received: by 10.14.187.6 with HTTP; Thu, 3 Jan 2013 09:33:29 -0800 (PST)
In-Reply-To: <7vwqvv1dta.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212598>

> Oh, that wasn't meant as a complaint.  I am tempted to rewrite the
> log message like so, though:
>
>     65969d4 (merge: honor prepare-commit-msg hook, 2011-02-14) tried to
>     make "git commit" and "git merge" consistent, because a merge that
>     required user assistance has to be concluded with "git commit", but
>     only "git commit" triggered prepare-commit-msg hook.  When it added
>     a call to run the prepare-commit-msg hook, however, it forgot to
>     check the exit code from the hook like "git commit" does, and ended
>     up replacing one inconsistency with another.

That's fine with me

>>> diff --git a/t/t7505-prepare-commit-msg-hook.sh b/t/t7505-prepare-commit-msg-hook.sh
>>> index bc497bc..3573751 100755
>>> --- a/t/t7505-prepare-commit-msg-hook.sh
>>> +++ b/t/t7505-prepare-commit-msg-hook.sh
>>> @@ -172,11 +172,12 @@ test_expect_success 'with failing hook (merge)' '
>>>         git checkout -B other HEAD@{1} &&
>>>         echo "more" >> file &&
>>>         git add file &&
>>> -       chmod -x $HOOK &&
>>> +       rm -f "$HOOK" &&
>>>         git commit -m other &&
>>> -       chmod +x $HOOK &&
>>> +       write_script "$HOOK" <<-EOF
>>> +       exit 1
>>> +       EOF
>>>         git checkout - &&
>>> -       head=`git rev-parse HEAD` &&
>>>         test_must_fail git merge other
>>>
>>>  '
>>
>> What about moving the hook file then ? Not very important to me, just
>> a suggestion as it would keep the shebang.
>
> Strictly speaking, the way $HOOK is prepared in the original is
> wrong.  The script is always run under "#!/bin/sh" instead of the
> shell the user told us to use with $SHELL_PATH.  For a simple one
> liner that only exits with 1, it does not matter, though.
>
> Many test scripts got this wrong and that was the reason we later
> added write_script helper function to the test suite.

So let's keep your suggestion and squash the commit.

Thanks,
