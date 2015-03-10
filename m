From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [v2 PATCH 2/2] reset: add tests for git reset -
Date: Tue, 10 Mar 2015 13:35:38 -0400
Message-ID: <CAPig+cQekpyaCd45O0NTijUqxvdTyNiZo1bXeuRKsmmYudwHMw@mail.gmail.com>
References: <1426001883-6423-1-git-send-email-dyoucme@gmail.com>
	<1426001883-6423-2-git-send-email-dyoucme@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>
To: Sundararajan R <dyoucme@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 10 18:35:46 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YVO4G-0004Bu-Vw
	for gcvg-git-2@plane.gmane.org; Tue, 10 Mar 2015 18:35:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753343AbbCJRfj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 10 Mar 2015 13:35:39 -0400
Received: from mail-yh0-f50.google.com ([209.85.213.50]:34770 "EHLO
	mail-yh0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752926AbbCJRfj convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 10 Mar 2015 13:35:39 -0400
Received: by yhaf73 with SMTP id f73so1647264yha.1
        for <git@vger.kernel.org>; Tue, 10 Mar 2015 10:35:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=6Br/Jh0Tii5eNkKeBBk7XQ4dK7LTEl0UIxj1OfxU6z0=;
        b=WmzNmZ+/nZsXpeBp2DTn11g3K2+Y9SR5Cl3+TGStGoUppwJJpcLH+uVzcXWkwD5DHK
         pcsrp5f89RT2QUVyRbTPx0SuszUeuL45fJcZFLoqmC4txN6XwsOYwk74o90IosVvOw/z
         Org9pkyhuj1mKIWYk84DgFB614H9Dmr6tJaFDX0M8Fn5dpO+VX1FVnWCcyN9no64H25I
         olJMP09m8I0GuLuXdHIo7Y2yj/qz+GZLEblkzSw8nuCNfHhI718J17jMven7EopkUo9G
         mueRkZFKXfz7zSEHjHLwv8aQyhIYJHCcf+E6u5/VKOC84YmUDxyPTM89B4vty6Qu4CEu
         SPdg==
X-Received: by 10.236.70.100 with SMTP id o64mr32734246yhd.94.1426008938469;
 Tue, 10 Mar 2015 10:35:38 -0700 (PDT)
Received: by 10.170.73.7 with HTTP; Tue, 10 Mar 2015 10:35:38 -0700 (PDT)
In-Reply-To: <1426001883-6423-2-git-send-email-dyoucme@gmail.com>
X-Google-Sender-Auth: SwaUZ_4AY2V6iLb93zBBbjz71Lc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265247>

On Tue, Mar 10, 2015 at 11:38 AM, Sundararajan R <dyoucme@gmail.com> wr=
ote:
> reset: add tests for git reset -

Since this patch is changing the tests rather than 'reset' itself,
you'd likely want to say:

    t7102: add 'reset -' tests

> The failure case which occurs on teaching git is taught the '-' short=
hand
> is when there exists no branch pointed to by '@{-1}'.

ECANNOTPARSE

> The ambiguous cases occur when there exist files named '-' or '@{-1}'=
 in
> the work tree. These are also treated as failure cases but here the u=
ser
> is given advice as to how he can proceed.
>
> Add tests to check the handling of these cases.
> Also add a test to verify that reset - behaves like reset @{-1} when =
none
> of the above cases are true.
>
> Helped-by: Junio C Hamano <gitster@pobox.com>
> Helped-by: Torsten B=C3=83=C2=B6gershausen <tboegi@web.de>

Torsten already pointed out this botch.

> Helped-by: Eric Sunshine <sunshine@sunshineco.com>
> Helped-by: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
> Signed-off-by: Sundararajan R <dyoucme@gmail.com>
> ---
> diff --git a/t/t7102-reset.sh b/t/t7102-reset.sh
> index 98bcfe2..c05dab0 100755
> --- a/t/t7102-reset.sh
> +++ b/t/t7102-reset.sh
> @@ -568,4 +568,94 @@ test_expect_success 'reset --mixed sets up work =
tree' '
>         test_cmp expect actual
>  '
>
> +test_expect_success 'reset - with no @{-1} should fail' '
> +       git init new &&
> +       (
> +               cd new &&
> +               test_must_fail git reset - 2>actual
> +       ) &&
> +       test_i18ngrep "unknown revision" new/actual

Broken &&-chain here and throughout the patch.

> +       test_when_finished rm -rf new

If one of the statements in the test before this point fails, then
test_when_finished() will never be invoked, which means that the "rm
-rf new" cleanup action will never be run. Here, and throughout the
patch, you need to invoke test_when_finished() at the earliest point
possible so that the cleanup is effective even if some other part of
the test fails. In this case, register the cleanup either just before
or just after git-init.

> +'
> +
> +test_expect_success 'reset - with @{-1} and no file named - or @{-1}=
 should succeed' '
> +       git init new &&
> +       (
> +               cd new &&
> +               echo "Hey" >new_file &&
> +               git add new_file &&
> +               git commit -m "first_commit" &&
> +               git checkout -b new_branch &&
> +               >new_file &&
> +               git add new_file &&
> +               git reset - &&
> +               git status -uno >file1 &&
> +               git add new_file &&
> +               git reset @{-1} &&
> +               git status -uno >file2
> +       ) &&
> +       test_cmp new/file1 new/file2

Broken &&-chain.

> +       test_when_finished rm -rf new
> +'
> +
>  test_done
> --
> 2.1.0
