From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3 2/2] t7102: add 'reset -' tests
Date: Fri, 13 Mar 2015 06:27:46 -0400
Message-ID: <CAPig+cSxuS0Khg2a0K1+K3UXH-TTgMREH30qYMt4cs0eCMbjiQ@mail.gmail.com>
References: <CAPig+cSU7X=1Ket8bAXU2JivaSVWw7C_M9ttAhJ_gQur3utsUA@mail.gmail.com>
	<1426025409-18758-1-git-send-email-sudshekhar02@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	David Aguilar <davvid@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Sudhanshu Shekhar <sudshekhar02@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 13 11:27:58 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YWMov-0001Cn-LI
	for gcvg-git-2@plane.gmane.org; Fri, 13 Mar 2015 11:27:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752170AbbCMK1s (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Mar 2015 06:27:48 -0400
Received: from mail-yk0-f176.google.com ([209.85.160.176]:42048 "EHLO
	mail-yk0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750890AbbCMK1r (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Mar 2015 06:27:47 -0400
Received: by ykbq9 with SMTP id q9so10038496ykb.9
        for <git@vger.kernel.org>; Fri, 13 Mar 2015 03:27:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=S2xtwUVc8FPKhA3e47dZtZB5IcyyIhizhDbusIeGWpM=;
        b=dotuM4814yj54bnqSy4JHGhe6BJ+Y+uJ/ASiN040U0waPLvbaL45EANuD4mRGtBxew
         wx2D53fH4Rw+IruwGMoJVRwO8i3P3ojhWVYJrwroOg8ZHhP4CbICvk5N/CSz4cZaCJle
         Wj4Ss+PWo/2geOBbvKHIs3JK5mRVNsMQR5sO57s412wk8bd16FeB2y3WbPc+Rc3QCqzk
         qTeScIng9ikZydaM+J6xX3GJqF/1cRjQs4Oj8CRTO19L5zYD1CMwakjo309oC9N2GfeA
         fbUZI1f9gtT+kQa3Zysr/whUMVQ18n+gdFRa6J2BKfvvcLIk70No62Rdwg74AiNrePOy
         5d8Q==
X-Received: by 10.236.41.78 with SMTP id g54mr32904009yhb.112.1426242466647;
 Fri, 13 Mar 2015 03:27:46 -0700 (PDT)
Received: by 10.170.73.7 with HTTP; Fri, 13 Mar 2015 03:27:46 -0700 (PDT)
In-Reply-To: <1426025409-18758-1-git-send-email-sudshekhar02@gmail.com>
X-Google-Sender-Auth: CNcMyKzBWsQOiCPeynTWFE9lSCA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265412>

On Tue, Mar 10, 2015 at 6:10 PM, Sudhanshu Shekhar
<sudshekhar02@gmail.com> wrote:
> Add following test cases:
>
> 1) Confirm error message when git reset is used with no previous branch
> 2) Confirm git reset - works like git reset @{-1}
> 3) Confirm "-" is always treated as a commit unless the -- file option is specified
> 4) Confirm "git reset -" works normally even when a file named @{-1} is present

Does it concern you that all new tests pass except the last one even
when patch 1/2 is not applied? I would have expected most or all of
these tests to fail without patch 1/2.

> Helped-by: Eric Sunshine <sunshine@sunshineco.com>
> Helped-by: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
> Helped-by: David Aguilar <davvid@gmail.com>
> Signed-off-by: Sudhanshu Shekhar <sudshekhar02@gmail.com>
> ---
> diff --git a/t/t7102-reset.sh b/t/t7102-reset.sh
> index 98bcfe2..d3a5874 100755
> --- a/t/t7102-reset.sh
> +++ b/t/t7102-reset.sh
> @@ -568,4 +568,163 @@ test_expect_success 'reset --mixed sets up work tree' '
>         test_cmp expect actual
>  '
>
> +test_expect_success 'reset - with no previous branch fails' '
> +       git init no_previous &&

I understand the intention of the name "no_previous" in tests for
which there is no @{-1}, however...

> +       test_when_finished rm -rf no_previous &&
> +       (
> +               cd no_previous &&
> +               test_must_fail git reset - 2>actual
> +       ) &&
> +       test_i18ngrep "bad flag" no_previous/actual
> +'
> +
> +test_expect_success 'reset - while having file named - and no previous branch fails' '
> +       git init no_previous &&
> +       test_when_finished rm -rf no_previous &&
> +       (
> +               cd no_previous &&
> +               >- &&
> +               test_must_fail git reset - 2>actual
> +       ) &&
> +       test_i18ngrep "bad flag" no_previous/actual
> +'
> +
> +test_expect_success \
> +       'reset - in the presence of file named - with previous branch resets commit' '
> +       cat >expect <<-\EOF
> +       Unstaged changes after reset:
> +       M       -
> +       M       file
> +       EOF &&
> +       git init no_previous &&

I don't understand the name "no_previous" in tests for which @{-1} can
resolve. It probably would be better to choose a more generic name and
use it for all these tests. For instance, "resetdash" or just "dash"
or something better.

> +       test_when_finished rm -rf no_previous &&
> +       (
> +               cd no_previous &&
> +               >- &&
> +               >file &&
> +               git add file - &&
> +               git commit -m "add base files" &&
> +               git checkout -b new_branch &&
> +               echo "random" >- &&
> +               echo "wow" >file &&
> +               git add file - &&
> +               git reset - >../actual
> +       ) &&
> +       test_cmp expect actual
> +'
> +
> +test_expect_success 'reset - with file named @{-1} succeeds' '

I may be missing something obvious, but why is it necessary to single
out a file named @{-1} at all, particuarly when there are so many
other ways to specify revisions, and there may be files mirroring
those spellings, as well?

> +       cat >expect <<EOF
> +       Unstaged changes after reset:
> +       M       file
> +       M       @{-1}
> +       EOF &&
> +       git init no_previous &&
> +       test_when_finished rm -rf no_previous &&
> +       (
> +               cd no_previous &&
> +               echo "random" >@{-1} &&
> +               echo "random" >file &&
> +               git add @{-1} file &&
> +               git commit -m "base commit" &&
> +               git checkout -b new_branch &&
> +               echo "additional stuff" >>file &&
> +               echo "additional stuff" >>@{-1} &&
> +               git add file @{-1} &&
> +               git reset - >../actual
> +       ) &&
> +       test_cmp expect actual
> +'
> +
>  test_done
> --
> 2.3.1.278.ge5c7b1f.dirty
