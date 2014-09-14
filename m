From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH/RFC 1/2] submodule: add ability to shallowly clone any
 branch in a repo as a submodule
Date: Sun, 14 Sep 2014 19:41:43 -0400
Message-ID: <CAPig+cSdJGzbwWGQTTO1JJpHSk9gfZcdCqFmG4DeSDewDbgbXQ@mail.gmail.com>
References: <ede7b63c6028591281a7eefea5e9cd45cccd0a93.1410691049.git.cole.minnaar@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Jens Lehmann <Jens.Lehmann@web.de>
To: Cole Minnaar <cole.minnaar@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 15 01:42:03 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XTJQg-00039p-JE
	for gcvg-git-2@plane.gmane.org; Mon, 15 Sep 2014 01:42:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752949AbaINXlq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Sep 2014 19:41:46 -0400
Received: from mail-yk0-f174.google.com ([209.85.160.174]:56024 "EHLO
	mail-yk0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752934AbaINXlo (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Sep 2014 19:41:44 -0400
Received: by mail-yk0-f174.google.com with SMTP id q200so1669267ykb.5
        for <git@vger.kernel.org>; Sun, 14 Sep 2014 16:41:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=GI18jIYGSlBX7p+KeGNHU/stWegYD74FYS8MzpkceqU=;
        b=kRS2G071LQpyZyVBMTYkRCO84IPp2cc3y6+6Ny156n1E7WOAzoFIqvuxayWcmwON1h
         qjY1rHAD6vtEe60rBfD6UsPxQUPPmhIWjOkpQQi1hnWNJdPQEB7rJZx4/cWxH2N7V6FQ
         kP2AMAXF32GrCWp2HgmGy3b43zOkZosbYtoqz5Ep9mm1SYAIu+LZiIpmWpRefFqAvh2J
         OvT154vTshVJqMOk8JZFDJXgEHKZxpJMy0nrQW4hU9tL6GDSkuA89ZyZK154bDDcdPCB
         Il53KnwSyH52aO2u669OUUMOR5tVU3b2/l0lRRVbdPAYmMgXzHwzM4qwab8yC2WkKOmj
         d+Jg==
X-Received: by 10.236.127.140 with SMTP id d12mr26952243yhi.37.1410738103296;
 Sun, 14 Sep 2014 16:41:43 -0700 (PDT)
Received: by 10.170.163.5 with HTTP; Sun, 14 Sep 2014 16:41:43 -0700 (PDT)
In-Reply-To: <ede7b63c6028591281a7eefea5e9cd45cccd0a93.1410691049.git.cole.minnaar@gmail.com>
X-Google-Sender-Auth: N_whMJAC8IY5zxZuMTH5IvSb7RA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257033>

On Sun, Sep 14, 2014 at 6:38 AM, Cole Minnaar <cole.minnaar@gmail.com> wrote:
> Currently when specifying the `--depth` option to the 'submodule add'
> command, it can only create a shallow submodule clone of the currently
> active branch from the cloned repository. If a branch is specified using
> the `--branch` option, and the `--depth` option is also specified, the
> 'submodule add' command will result in an error as the branch will not
> be present in the cloned repository. If a repository is shallowly cloned
> as a submodule, there is no way to specify that the shallowly cloned
> submodule should setup remote-tracking branches.
>
> Added the ability to shallowly clone any branch as a submodule, not just
> the current active branch in the cloned repository.
> Added support to the 'submodule add' and 'submodule update' commands to
> handle `--no-single-branch` option, which is in turn passed to the clone
> command in order to setup remote-tracking branches in the shallowly
> cloned submodule.
>
> Signed-off-by: Cole Minnaar <cole.minnaar@gmail.com>
> ---
> diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
> index 7c88245..81c05ae 100755
> --- a/t/t7400-submodule-basic.sh
> +++ b/t/t7400-submodule-basic.sh
> @@ -136,7 +136,6 @@ test_expect_success 'submodule add --branch' '
>         echo "refs/heads/initial" >expect-head &&
>         cat <<-\EOF >expect-heads &&
>         refs/heads/initial
> -       refs/heads/master
>         EOF
>         >empty &&
>
> @@ -982,5 +981,37 @@ test_expect_success 'submodule add clone shallow submodule' '
>         )
>  '
>
> +test_expect_success 'submodule add --branch --depth' '
> +       (
> +               cd addtest2 &&
> +               git submodule add -b initial --depth 1 -- file://"$submodurl" submod-branch-depth &&
> +               test "initial" = "$(git config -f .gitmodules submodule.submod-branch-depth.branch)" &&
> +               (
> +                       cd submod-branch-depth &&
> +                       test 1 = $(git log --oneline | wc -l)
> +               )
> +       )
> +'
> +
> +cat >remote <<\EOF
> +  origin/HEAD -> origin/second
> +  origin/initial
> +  origin/master
> +  origin/second
> +EOF
> +
> +test_expect_success 'submodule add --branch --depth --no-single-branch' '
> +       (
> +               cd addtest2 &&
> +               git submodule add -b initial --depth 1 --no-single-branch -- file://"$submodurl" submod-branch-depth-all &&
> +               test "initial" = "$(git config -f .gitmodules submodule.submod-branch-depth-all.branch)" &&
> +               (
> +                       cd submod-branch-depth-all &&
> +                       test 1 = $(git log --oneline | wc -l)

Broken &&-chain.

> +                       git branch -r >../../remote-out
> +               )
> +       ) &&
> +       test_cmp remote remote-out
> +'
>
>  test_done
> --
> 2.1.0.238.gce1d3a9.dirty
