From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 1/3] t4150-am: refactor and clean common setup
Date: Thu, 28 May 2015 15:09:52 -0400
Message-ID: <CAPig+cQ_PrY8=-iP-FJm_HZ+XKOVoc4NfDu6rtuBj8zfM5oG+w@mail.gmail.com>
References: <1432675975-11020-1-git-send-email-remi.lespinet@ensimag.grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Remi Galan <remi.galan-alfonso@ensimag.grenoble-inp.fr>,
	Guillaume Pages <guillaume.pages@ensimag.grenoble-inp.fr>,
	Louis-Alexandre Stuber 
	<louis--alexandre.stuber@ensimag.grenoble-inp.fr>,
	Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>,
	Matthieu Moy <matthieu.moy@grenoble-inp.fr>
To: Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Thu May 28 21:10:00 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yy3Bn-0005x9-BD
	for gcvg-git-2@plane.gmane.org; Thu, 28 May 2015 21:09:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753895AbbE1TJz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 May 2015 15:09:55 -0400
Received: from mail-ie0-f178.google.com ([209.85.223.178]:36282 "EHLO
	mail-ie0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751020AbbE1TJx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 May 2015 15:09:53 -0400
Received: by iepj10 with SMTP id j10so45880181iep.3
        for <git@vger.kernel.org>; Thu, 28 May 2015 12:09:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=cXVTPg0i9NQU4kicgE8PEcxxN7cnfp7PSE2TZPx2qoo=;
        b=wJzt4V+EljqiW3paO1bZ7wc88SGNx2SRPXJFOHjGsJ09HKq0CUPtCrTK9LfhwLlVe0
         i2cEgr2faCv0rdYhREPRbMU9vucW3Hm7V8lC17xw2XD975I30aCsJ2RTbsM7V3iLzny4
         4b9txK3GvN1E9wVQSYR80GBaPl1vUsf4JQg64j5B2T26Y5h23eR7SNcS7ugF2Igkrrl9
         yngCGWjmIXmyE6I2/bJA/EJe8+ajhikytFpEu0YNJ8D9Ce0om2tt8UlEFtQ2FZWPmpPm
         9MzGo6MfX8RwQS81KBymJrbLKEaTYGyBo1l5wcokwgiDex/GezobHy80rugtUhH+yWBN
         lmNA==
X-Received: by 10.50.79.202 with SMTP id l10mr13304486igx.7.1432840193131;
 Thu, 28 May 2015 12:09:53 -0700 (PDT)
Received: by 10.107.28.132 with HTTP; Thu, 28 May 2015 12:09:52 -0700 (PDT)
In-Reply-To: <1432675975-11020-1-git-send-email-remi.lespinet@ensimag.grenoble-inp.fr>
X-Google-Sender-Auth: CSH7-hyB_4-d5Qa5FTGJWTwCS0s
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270180>

On Tue, May 26, 2015 at 5:32 PM, Remi Lespinet
<remi.lespinet@ensimag.grenoble-inp.fr> wrote:
> Add new functions to keep the setup cleaner:
>  - setup_temporary_branch: creates a new branch, check it out
>    and automatically delete it after the test is over
>  - setup_fixed_branch: creates a fixed branch, which can be re-used
>    in later tests

See below for review comments beyond those already provided by Paul...

> Signed-off-by: Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>
> ---
> diff --git a/t/t4150-am.sh b/t/t4150-am.sh
> index 306e6f3..8370951 100755
> --- a/t/t4150-am.sh
> +++ b/t/t4150-am.sh
> @@ -4,6 +4,20 @@ test_description='git am running'
>
>  . ./test-lib.sh
>
> +setup_temporary_branch () {
> +       tmp_name=${2-"temporary"}
> +       git reset --hard &&
> +       rm -fr .git/rebase-apply &&
> +       test_when_finished "git checkout $1 && git branch -D $tmp_name" &&
> +       git checkout -b "$tmp_name" "$1"
> +}
> +
> +setup_fixed_branch () {
> +       git reset --hard &&
> +       rm -fr .git/rebase-apply &&
> +       git checkout -b "$1" "$2"
> +}
> +
>  test_expect_success 'setup: messages' '
>         cat >msg <<-\EOF &&
>         second
> @@ -143,9 +157,7 @@ test_expect_success setup '
>  '
>
>  test_expect_success 'am applies patch correctly' '
> -       rm -fr .git/rebase-apply &&
> -       git reset --hard &&
> -       git checkout first &&
> +       setup_temporary_branch first &&

This is confusing. The commit message seems to advertise this patch as
primarily a refactoring change (pulling boilerplate out of tests and
into a new function), but the operation of that new function is
surprisingly different from the boilerplate it's replacing: The old
code did not create a branch, the new function does.

If your intention really is to create new branches in tests which
previously did not need throwaway branches, then the commit message
should state that as its primary purpose and explain why doing so is
desirable, since it is not clear from this patch what you gain from
doing so.

Moreover, typically, you should only either refactor or change
behavior in a single patch, not both. For instance, patch 1 would add
the new function and update tests to call it in place of the
boilerplate; and patch 2 would change behavior (such as creating a
temporary branch).

On the other hand, if these tests really don't benefit from having a
throw-away branch, then this change seems suspect and obscures the
intent of the test rather than clarifying or simplifying.

>         test_tick &&
>         git am <patch1 &&
>         test_path_is_missing .git/rebase-apply &&
> @@ -275,9 +273,7 @@ test_expect_success 'am --keep-non-patch really keeps the non-patch part' '
>  '
>
>  test_expect_success 'am -3 falls back to 3-way merge' '
> -       rm -fr .git/rebase-apply &&
> -       git reset --hard &&
> -       git checkout -b lorem2 master2 &&
> +       setup_fixed_branch lorem2 master2 &&
>         sed -n -e "3,\$p" msg >file &&
>         head -n 9 msg >>file &&
>         git add file &&
> @@ -289,9 +285,7 @@ test_expect_success 'am -3 falls back to 3-way merge' '
>  '
>
>  test_expect_success 'am -3 -p0 can read --no-prefix patch' '
> -       rm -fr .git/rebase-apply &&
> -       git reset --hard &&
> -       git checkout -b lorem3 master2 &&
> +       setup_temporary_branch lorem2 &&

Unlike the test prior to this one which creates a "fixed" branch (via
setup_fixed_branch) named 'lorem2' which is used by other tests, the
'lorem3' branch in this test is never used elsewhere, so
setup_temporary_branch is used instead. Makes sense.

>         sed -n -e "3,\$p" msg >file &&
>         head -n 9 msg >>file &&
>         git add file &&
> @@ -303,10 +297,8 @@ test_expect_success 'am -3 -p0 can read --no-prefix patch' '
>  '
>
>  test_expect_success 'am can rename a file' '
> +       setup_temporary_branch lorem &&
>         grep "^rename from" rename.patch &&
> -       rm -fr .git/rebase-apply &&
> -       git reset --hard &&
> -       git checkout lorem^0 &&

In other cases, you insert the setup_temporary_branch() invocation
where the old code resided. Why the difference in this test (and
others following)?

>         git am rename.patch &&
>         test_path_is_missing .git/rebase-apply &&
>         git update-index --refresh &&
> @@ -349,11 +335,9 @@ test_expect_success 'am -3 -q is quiet' '
>  '
>
>  test_expect_success 'am pauses on conflict' '
> -       rm -fr .git/rebase-apply &&
> -       git reset --hard &&
> -       git checkout lorem2^^ &&
> +       setup_temporary_branch lorem2^^ &&
>         test_must_fail git am lorem-move.patch &&
> -       test -d .git/rebase-apply
> +       test_path_is_dir .git/rebase-apply

Sneaking in unrelated change. This sort of cleanup should go in a
patch of its own.

>  '
>
>  test_expect_success 'am --skip works' '
