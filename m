From: Antoine Pelisse <apelisse@gmail.com>
Subject: Re: [PATCH] merge: Honor prepare-commit-msg return code
Date: Wed, 2 Jan 2013 22:02:30 +0100
Message-ID: <CALWbr2wWjwUnHFq1icMRuW=vjQDhTO1e_chffqUvDWY5za1Kiw@mail.gmail.com>
References: <1357152170-5511-1-git-send-email-apelisse@gmail.com>
	<7v623f2uam.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>, Jay Soffian <jaysoffian@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 02 22:02:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TqVSd-000508-8E
	for gcvg-git-2@plane.gmane.org; Wed, 02 Jan 2013 22:02:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752753Ab3ABVCd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Jan 2013 16:02:33 -0500
Received: from mail-ea0-f179.google.com ([209.85.215.179]:40880 "EHLO
	mail-ea0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752737Ab3ABVCb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Jan 2013 16:02:31 -0500
Received: by mail-ea0-f179.google.com with SMTP id i12so5885154eaa.10
        for <git@vger.kernel.org>; Wed, 02 Jan 2013 13:02:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=cwt8RHzvqhgx6D0KCzcCMzOIsTQrX422oUUvhuzIHf0=;
        b=0cDobAV2wcA3R4DJmUUNOXCSrsuWL6/8aX35Gx/LPdJWYKnEAQk3rBWKHnDCitPR/U
         Hp5r/FUQZuDxQeLQi4xyV1eFyFHTgw5PaKe1qpjoeNEgZRI5pIKlf/fMXzbMOmeFpjE5
         OOmCo5vNc361Fb4wXS6tMIFtDv4hUB8sWpQktk+xbe753TaNWJIVwqd0tBKOIl+2AE/P
         ZW+61x87bIDvYo8EVQVA1/3YJzUEvAAiimefn5Yqs7MGQ/hpmiHssxLk8NImwsrAH8D6
         mae6YwElOY+CaiLYCh6M2DRL2TLMnAhaAHU9sBfW2OfDEVZr9kCH6yedRUl9sFwAA21F
         nzrA==
Received: by 10.14.178.196 with SMTP id f44mr128465797eem.14.1357160550212;
 Wed, 02 Jan 2013 13:02:30 -0800 (PST)
Received: by 10.14.187.6 with HTTP; Wed, 2 Jan 2013 13:02:30 -0800 (PST)
In-Reply-To: <7v623f2uam.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212541>

>> prepare-commit-msg hook is run when committing to prepare the log
>> message. If the exit-status is non-zero, the commit should be aborted.
>
> I was scratching my head why you CC'ed Jay, until I dug up 65969d4
> (merge: honor prepare-commit-msg hook, 2011-02-14).

I did as suggested in "SubmittingPatches" :)

>> +test_expect_success 'with failing hook (merge)' '
>> +
>> +     git checkout -B other HEAD@{1} &&
>> +     echo "more" >> file &&
>> +     git add file &&
>> +     chmod -x $HOOK &&
>
> I have a feeling that this will break folks without POSIXPERM
> prerequisite.

It felt wrong when I did it, but kept it consistent within the file.
It indeed looks older than other test files I've seen so far but I
don't feel like I know the test general-style-and-policy enough to fix
it myself either.

> diff --git a/t/t7505-prepare-commit-msg-hook.sh b/t/t7505-prepare-commit-msg-hook.sh
> index bc497bc..3573751 100755
> --- a/t/t7505-prepare-commit-msg-hook.sh
> +++ b/t/t7505-prepare-commit-msg-hook.sh
> @@ -172,11 +172,12 @@ test_expect_success 'with failing hook (merge)' '
>         git checkout -B other HEAD@{1} &&
>         echo "more" >> file &&
>         git add file &&
> -       chmod -x $HOOK &&
> +       rm -f "$HOOK" &&
>         git commit -m other &&
> -       chmod +x $HOOK &&
> +       write_script "$HOOK" <<-EOF
> +       exit 1
> +       EOF
>         git checkout - &&
> -       head=`git rev-parse HEAD` &&
>         test_must_fail git merge other
>
>  '

What about moving the hook file then ? Not very important to me, just
a suggestion as it would keep the shebang.

Cheers,
