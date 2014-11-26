From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 2/2] commit: inform pre-commit that --amend was used
Date: Tue, 25 Nov 2014 20:36:07 -0500
Message-ID: <CAPig+cQXAbh1d1XcnOfvCn6XNYB2OrzBbxz7zNGFPLA-hQbXhA@mail.gmail.com>
References: <cover.1416955873.git.oystwa@gmail.com>
	<cover.1416953772.git.oystwa@gmail.com>
	<b9ef551633329702559e4cee6528b68ab757b531.1416955873.git.oystwa@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>
To: =?UTF-8?Q?=C3=98ystein_Walle?= <oystwa@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 26 02:36:20 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XtRWk-0003pU-QM
	for gcvg-git-2@plane.gmane.org; Wed, 26 Nov 2014 02:36:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752061AbaKZBgM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 25 Nov 2014 20:36:12 -0500
Received: from mail-yk0-f171.google.com ([209.85.160.171]:50234 "EHLO
	mail-yk0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751328AbaKZBgI convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 25 Nov 2014 20:36:08 -0500
Received: by mail-yk0-f171.google.com with SMTP id 142so844262ykq.2
        for <git@vger.kernel.org>; Tue, 25 Nov 2014 17:36:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=+8fa1fmcqM1hPoX11q04TFRnanVWy1RYIllURqu1qJw=;
        b=JV1fJDvRMZfgJH6x/ffERXNH0RnxSnc73wpxj57jD/q0r+VjEpnB0vwnhyzgRgdlw1
         8qvpOf/06HfM9lsWrtJ4vdY2Fa5zfeIZqhDLxwDFx4Tjwgaltwua5U/0cfoHkFbGrI39
         yHxJ1J4VjwhzUI/D+NmRQtbSl2sop6VyEFIRXpdyOixYTnJe4u2kkeyL9HTkGDKbbdln
         6kbBXqcLeHouAMISKfVMb3OVZEiOix6aeVNYRo9IMGT43rPp6Cv8mL9CuTLpvl65cl7a
         9FxgIimTGX6dIUi/4pTRX5iTdBM/jh5aDwiFk+HVVKDjSTxKXu+nzjQ+gV70aKI2zcJq
         MTLw==
X-Received: by 10.170.78.130 with SMTP id u124mr31129005yku.91.1416965767654;
 Tue, 25 Nov 2014 17:36:07 -0800 (PST)
Received: by 10.170.68.68 with HTTP; Tue, 25 Nov 2014 17:36:07 -0800 (PST)
In-Reply-To: <b9ef551633329702559e4cee6528b68ab757b531.1416955873.git.oystwa@gmail.com>
X-Google-Sender-Auth: _KuVZHZtdBnS0XW2su9Y4yT0k4s
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260264>

On Tue, Nov 25, 2014 at 5:51 PM, =C3=98ystein Walle <oystwa@gmail.com> =
wrote:
> When a commit is amended a pre-commit hook that verifies the commit's
> contents might not find what it's looking for if it looks at the
> differences against HEAD when HEAD~1 might be more appropriate. Infor=
m
> the commit hook that --amend is being used so that hook authors can d=
o
> e.g.
>
>     if test "$1" =3D amend; then
>         ...
>     else
>         ...
>     fi
>
> to handle these situations.
>
> Signed-off-by: =C3=98ystein Walle <oystwa@gmail.com>
> ---
> diff --git a/t/t7503-pre-commit-hook.sh b/t/t7503-pre-commit-hook.sh
> index 99ed967..b400afe 100755
> --- a/t/t7503-pre-commit-hook.sh
> +++ b/t/t7503-pre-commit-hook.sh
> @@ -133,4 +133,15 @@ test_expect_success 'check the author in hook' '
>         git show -s
>  '
>
> +# a hook that checks if "amend" is passed as an argument
> +write_script "$HOOK" <<EOF
> +test "\$1" =3D amend
> +EOF
> +
> +test_expect_success 'check that "amend" argument is given' '
> +       git commit --amend --allow-empty
> +'
> +
> +test_must_fail git commit --allow-empty

test_must_fail is a direct replacement for '!' when invoking a git
command which should fail _within_ a test. Your original version of
this test was in the previous round:

    test_expect_success 'check that "amend" argument is NOT given' '
        ! git commit --allow-empty
    '

Just replace '!', like this:

    test_expect_success 'check that "amend" argument is NOT given' '
        test_must_fail git commit --allow-empty
    '

> +
>  test_done
> --
> 2.2.0.rc3
