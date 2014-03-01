From: Brian Gesiak <modocache@gmail.com>
Subject: Re: [PATCH 3/3] branch: die when setting branch as own upstream
Date: Sat, 1 Mar 2014 21:26:44 +0900
Message-ID: <CAN7MxmWERiHeZuudtzTSdCbJMemJBDa4mF0PS=FJNB0em6nvOA@mail.gmail.com>
References: <1393676356-67203-1-git-send-email-modocache@gmail.com>
	<1393676624-67687-1-git-send-email-modocache@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 01 13:26:51 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WJj0D-0004O4-V1
	for gcvg-git-2@plane.gmane.org; Sat, 01 Mar 2014 13:26:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752585AbaCAM0q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Mar 2014 07:26:46 -0500
Received: from mail-ig0-f182.google.com ([209.85.213.182]:61010 "EHLO
	mail-ig0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752318AbaCAM0p (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Mar 2014 07:26:45 -0500
Received: by mail-ig0-f182.google.com with SMTP id uy17so3809173igb.3
        for <git@vger.kernel.org>; Sat, 01 Mar 2014 04:26:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type;
        bh=HJLFcFSj+pztqTIr9GYscVXRpaHCLPIKEV8zJsJXRPs=;
        b=YYelHiSJNwDch+YsSmJ4VcZ41enSKzUd/YwfsTpS1/mc+mDlkXZ+yjsuDOpYyyj2mz
         Fg9hJ0u7RwoE+DGFdUZu5nkmO7tRRIJlgrxKQ4R8wUqQXJwLHTqm76vrtaWNNB9S2Kp6
         tUwqCoH5oC2knoCwKitxFMt4Vo9vj7SPPx+Ekm8l0TCyr8klfnb+hLZhu+CgmmLJLsqi
         2CG/D8HXLBbSDCaeDEbvqEF1CnfQGJ5OUKsI5leEiiZgaTaEgcEhmf5H4fWTWUMiy2Bm
         2LUA6dOK522YsBtRPYuTh5PvdIbxshJm8tq1AKWR7x3Ic7/7SmhszzWgs3T5gsf/D2VA
         cZZA==
X-Received: by 10.50.111.79 with SMTP id ig15mr10350986igb.14.1393676804990;
 Sat, 01 Mar 2014 04:26:44 -0800 (PST)
Received: by 10.64.55.161 with HTTP; Sat, 1 Mar 2014 04:26:44 -0800 (PST)
In-Reply-To: <1393676624-67687-1-git-send-email-modocache@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243094>

Sorry for the multiple patches--I noticed the commit author was off in
the first one.

This patch converts the warning to an error, should it be decided that
it's prudent to do so (I'm in favor of doing so). If not, I think the
other two patches I submitted are good to merge.

Thanks for all the feedback so far!

- Brian Gesiak


On Sat, Mar 1, 2014 at 9:23 PM, Brian Gesiak <modocache@gmail.com> wrote:
> Branch set as own upstream using one of the following commands returns
> immediately with an exit code of 0:
>
> - `git branch --set-upstream-to foo refs/heads/foo`
> - `git branch --force --track foo foo`
>
> Since neither of these actions currently set the upstream, an exit code
> of 0 is misleading. Instead, exit with a status code indicating failure
> by using the die function.
>
> Signed-off-by: Brian Gesiak <modocache@gmail.com>
> ---
>  branch.c          | 9 ++-------
>  t/t3200-branch.sh | 6 +++---
>  2 files changed, 5 insertions(+), 10 deletions(-)
>
> diff --git a/branch.c b/branch.c
> index e163f3c..9bac8b5 100644
> --- a/branch.c
> +++ b/branch.c
> @@ -54,13 +54,8 @@ void install_branch_config(int flag, const char *local, const char *origin, cons
>         struct strbuf key = STRBUF_INIT;
>         int rebasing = should_setup_rebase(origin);
>
> -       if (shortname
> -           && !strcmp(local, shortname)
> -           && !origin) {
> -               warning(_("Not setting branch %s as its own upstream."),
> -                       local);
> -               return;
> -       }
> +       if (shortname && !strcmp(local, shortname) && !origin)
> +               die(_("Not setting branch %s as its own upstream."), local);
>
>         strbuf_addf(&key, "branch.%s.remote", local);
>         git_config_set(key.buf, origin ? origin : ".");
> diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
> index 6164126..3ac493f 100755
> --- a/t/t3200-branch.sh
> +++ b/t/t3200-branch.sh
> @@ -507,10 +507,10 @@ EOF
>         test_cmp expected actual
>  '
>
> -test_expect_success '--set-upstream-to shows warning if used to set branch as own upstream' '
> -       git branch --set-upstream-to refs/heads/my13 my13 2>actual &&
> +test_expect_success '--set-upstream-to fails if used to set branch as own upstream' '
> +       test_must_fail git branch --set-upstream-to refs/heads/my13 my13 2>actual &&
>         cat >expected <<EOF &&
> -warning: Not setting branch my13 as its own upstream.
> +fatal: Not setting branch my13 as its own upstream.
>  EOF
>         test_i18ncmp expected actual
>  '
> --
> 1.8.3.4 (Apple Git-47)
>
