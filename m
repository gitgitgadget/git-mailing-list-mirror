From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2] tests: set temp variables using 'env' in test function
 instead of subshell
Date: Tue, 18 Mar 2014 16:52:46 -0400
Message-ID: <CAPig+cS5UDxvCGRm4d840tOfG6pwjHbARuyAWOR+D_Aht79Gzw@mail.gmail.com>
References: <244284@gmane.comp.version-control.git>
	<1395144518-2489-1-git-send-email-unsignedzero@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>
To: David Tran <unsignedzero@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 18 21:52:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WQ10H-0005n2-It
	for gcvg-git-2@plane.gmane.org; Tue, 18 Mar 2014 21:52:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758048AbaCRUws (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Mar 2014 16:52:48 -0400
Received: from mail-yh0-f53.google.com ([209.85.213.53]:50701 "EHLO
	mail-yh0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758040AbaCRUwr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Mar 2014 16:52:47 -0400
Received: by mail-yh0-f53.google.com with SMTP id v1so7489143yhn.26
        for <git@vger.kernel.org>; Tue, 18 Mar 2014 13:52:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=/KPh23sN9MJQgr3t4rMkikiuYbb66i239hjrN0yZt3A=;
        b=Vu+RPtyyMf03l5N/LE9KnFmN6ukDN21Mc9OY/+Ij26CdoWEz1pkIBsueiOgsCVMYJH
         SatSIryrjGJ4DzAfCvlSNb47hgkHeT+uYYEYJDIM9Kpg+Y5jcO1J2uLLejoNJFS5CvhV
         vcB2NBCWDX3nAEcyMXnGXNLcj/iF2eV8eYR9Ocd4lJxL55cc9FPs5o8i418NocZxZcQ1
         Vz6l2MIKs/WRk9gF/BvM31RwCp82h2GJIzJkn5viA9pRQ0smXVYnWJGIa/jySEyxybwW
         5G2MaEmzq/+sPOlKh1bQPy/ACOZ60x/mV/XeoCMPoczM7swZfUdDa399FKeoCnNupQPV
         dk3g==
X-Received: by 10.236.122.99 with SMTP id s63mr21395809yhh.19.1395175966620;
 Tue, 18 Mar 2014 13:52:46 -0700 (PDT)
Received: by 10.170.180.134 with HTTP; Tue, 18 Mar 2014 13:52:46 -0700 (PDT)
In-Reply-To: <1395144518-2489-1-git-send-email-unsignedzero@gmail.com>
X-Google-Sender-Auth: exLpY5Po_sBJVF9sJUTuplgQZ-A
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244383>

On Tue, Mar 18, 2014 at 8:08 AM, David Tran <unsignedzero@gmail.com> wrote:
> Originally, the code used subshells instead of FOO=BAR command because
> the variable would otherwise leak into the surrounding context of the POSIX
> shell when 'command' is a shell function. The subshell was used to hold the
> context for the test. Using 'env' in the test function sets the temp variables
> without leaking, removing the need of a subshell.
>
> Signed-off-by: David Tran <unsignedzero@gmail.com>
> ---
>> Oh, really ;-)?
> Missed that.
>
>> Thanks.  Getting closer, I think.
> Slowly but surely.

Getting better. See below.

> Signed-off-by: David Tran <unsignedzero@gmail.com>
> ---
> diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
> index 50e22b1..4c7364a 100755
> --- a/t/t3404-rebase-interactive.sh
> +++ b/t/t3404-rebase-interactive.sh
> @@ -104,9 +104,7 @@ test_expect_success 'rebase -i with the exec command checks tree cleanness' '
>         git checkout master &&
>         (
>         set_fake_editor &&
> -       FAKE_LINES="exec_echo_foo_>file1 1" &&
> -       export FAKE_LINES &&
> -       test_must_fail git rebase -i HEAD^
> +       test_must_fail env FAKE_LINES="exec_echo_foo_>file1 1" git rebase -i HEAD^
>         ) &&

In a previous review, I asked if this subshell could be dropped or if
it was required for set_fake_editor. I didn't quite understand your
response, so I tested it myself, and found that the subshell can be
eliminated safely without breaking this or later tests.

>         test_cmp_rev master^ HEAD &&
>         git reset --hard &&
> @@ -118,9 +116,8 @@ test_expect_success 'rebase -i with exec of inexistent command' '
>         test_when_finished "git rebase --abort" &&
>         (
>         set_fake_editor &&
> -       FAKE_LINES="exec_this-command-does-not-exist 1" &&
> -       export FAKE_LINES &&
> -       test_must_fail git rebase -i HEAD^ >actual 2>&1
> +       test_must_fail env FAKE_LINES="exec_this-command-does-not-exist 1" \
> +       git rebase -i HEAD^ >actual 2>&1
>         ) &&

Ditto for this subshell.

>         ! grep "Maybe git-rebase is broken" actual
>  '
> @@ -528,11 +509,7 @@ test_expect_success 'aborted --continue does not squash commits after "edit"' '
>         FAKE_LINES="edit 1" git rebase -i HEAD^ &&
>         echo "edited again" > file7 &&
>         git add file7 &&
> -       (
> -               FAKE_COMMIT_MESSAGE=" " &&
> -               export FAKE_COMMIT_MESSAGE &&
> -               test_must_fail git rebase --continue
> -       ) &&
> +       test_must_fail env FAKE_COMMIT_MESSAGE=" " git rebase --continue

Broken &&-chain.

>         test $old = $(git rev-parse HEAD) &&
>         git rebase --abort
>  '
