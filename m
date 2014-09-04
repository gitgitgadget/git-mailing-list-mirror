From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] setup.c: set workdir when gitdir is not default
Date: Thu, 4 Sep 2014 06:44:08 -0400
Message-ID: <CAPig+cQMNyurCB73CzGBLcfXqap5=kZsYq0O8nD29S8QsHtrBA@mail.gmail.com>
References: <1409784120-2228-1-git-send-email-max@max630.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>, Jonathan Nieder <jrnieder@gmail.com>,
	Git List <git@vger.kernel.org>
To: Max Kirillov <max@max630.net>
X-From: git-owner@vger.kernel.org Thu Sep 04 12:45:08 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XPUXI-0006f4-Qt
	for gcvg-git-2@plane.gmane.org; Thu, 04 Sep 2014 12:45:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752826AbaIDKoK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Sep 2014 06:44:10 -0400
Received: from mail-yh0-f42.google.com ([209.85.213.42]:33153 "EHLO
	mail-yh0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750996AbaIDKoJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Sep 2014 06:44:09 -0400
Received: by mail-yh0-f42.google.com with SMTP id v1so6192973yhn.1
        for <git@vger.kernel.org>; Thu, 04 Sep 2014 03:44:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=iHRrtb7OPlipCcWj9EbpFeVDLnd4JDB4rMF+SDEdDB0=;
        b=m3Fv7EZVUtewYTZxjAnIGqWjRc0OkNf1PYearr12s39tr7HbnCUcuEcSlBvl7aOa/0
         uE+/8krV0EJbyInzGEbMq4AJ0BuQpN6KpWyBAEnvdeMLGIKeXP3TWvwn2/RwDLR8HFs3
         urpaapkTHvWEndcl8adCelz3P0TunMIbg5fiF3CEIXGovIL1M2+OpVCY5LflPzgfQDso
         Z+vpZHhvJA1gfoaLZ+/wNkMLjUdNxNmlMgRbx8D6BjAtbJmpZnhQmU5haXPHKDTriB8N
         X+MuF2o6PRLTYLX6VcbGVb/xf30Wgc6a19R9jNRBAmU9K+FvR4z9Dx3dEY0SLgbltgH0
         bnoA==
X-Received: by 10.236.172.161 with SMTP id t21mr4489186yhl.65.1409827448605;
 Thu, 04 Sep 2014 03:44:08 -0700 (PDT)
Received: by 10.170.163.5 with HTTP; Thu, 4 Sep 2014 03:44:08 -0700 (PDT)
In-Reply-To: <1409784120-2228-1-git-send-email-max@max630.net>
X-Google-Sender-Auth: kPyT6C4jNap6EToYvw8y4hhjBF4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 3, 2014 at 6:42 PM, Max Kirillov <max@max630.net> wrote:
> When gitfile is used, git sets GIT_DIR environment variable for
> subsequent commands, and that commands start working in mode "GIT_DIR
> set, workdir current", which is incorrect for the case when git runs
> from subdirectory of repository. This can be observed at least for
> running aliases - git fails with message "internal error: work tree has
> already been set"
>
> Fix by setting GIT_WORK_TREE environment also.
>
> Add test which demonstrates problem with alias.
>
> Signed-off-by: Max Kirillov <max@max630.net>
> ---
>  setup.c            | 4 +++-
>  t/t0002-gitfile.sh | 7 +++++++
>  2 files changed, 10 insertions(+), 1 deletion(-)
>
> diff --git a/setup.c b/setup.c
> index 0a22f8b..bcf4e31 100644
> --- a/setup.c
> +++ b/setup.c
> @@ -508,8 +508,10 @@ static const char *setup_discovered_git_dir(const char *gitdir,
>
>         /* #0, #1, #5, #8, #9, #12, #13 */
>         set_git_work_tree(".");
> -       if (strcmp(gitdir, DEFAULT_GIT_DIR_ENVIRONMENT))
> +       if (strcmp(gitdir, DEFAULT_GIT_DIR_ENVIRONMENT)) {
>                 set_git_dir(gitdir);
> +               setenv(GIT_WORK_TREE_ENVIRONMENT, get_git_work_tree(), 1);
> +       }
>         inside_git_dir = 0;
>         inside_work_tree = 1;
>         if (offset == len)
> diff --git a/t/t0002-gitfile.sh b/t/t0002-gitfile.sh
> index 37e9396..428cfdc 100755
> --- a/t/t0002-gitfile.sh
> +++ b/t/t0002-gitfile.sh
> @@ -99,4 +99,11 @@ test_expect_success 'check rev-list' '
>         test "$SHA" = "$(git rev-list HEAD)"
>  '
>
> +test_expect_success 'check alias call from subdirectory' '
> +       git config alias.testalias "rev-parse HEAD" &&

Perhaps use test_config here?

> +       mkdir -p subdir &&
> +       cd subdir &&
> +       git testalias

If a new test is added following this one, it will be run from within
'subdir', which might come as a surprise as the author of the new
test. Wrapping the 'cd' and following code in a subshell is a good way
to avoid the problem.

    mkdir -p subdir &&
    (
        cd subdir &&
        git testalias
    )

> +'
> +
>  test_done
> --
> 2.0.1.1697.g73c6810
