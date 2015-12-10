From: Michael Blume <blume.mike@gmail.com>
Subject: Re: [PATCH 2/2] rebase: fix preserving commits with --keep-empty
Date: Thu, 10 Dec 2015 14:58:06 -0800
Message-ID: <CAO2U3QiFXaOCb114NMgGxDOV3FqHN6HyNDJBWT6ZeqTvQ+i0Zg@mail.gmail.com>
References: <1448021080-4994-1-git-send-email-ps@pks.im> <1448021080-4994-3-git-send-email-ps@pks.im>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Patrick Steinhardt <ps@pks.im>
X-From: git-owner@vger.kernel.org Thu Dec 10 23:58:33 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a7AAR-0008DX-OG
	for gcvg-git-2@plane.gmane.org; Thu, 10 Dec 2015 23:58:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752972AbbLJW61 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Dec 2015 17:58:27 -0500
Received: from mail-io0-f179.google.com ([209.85.223.179]:34032 "EHLO
	mail-io0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752024AbbLJW60 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Dec 2015 17:58:26 -0500
Received: by ioir85 with SMTP id r85so109122183ioi.1
        for <git@vger.kernel.org>; Thu, 10 Dec 2015 14:58:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=aMWmf19DxGR0X8aSdfhugIYQLw28cR24tQi7cU884DI=;
        b=lr3XeBzhKGif/JznO+5z20+WyR6THqocxW+8KBEqEbmuuyG/Qm6ONhGoKBV6k/iPej
         nW8jGJJXk3xY9iEJfpIg1PMIU46djr/4iodzGDgayjfqAmkNWq3iOIITB3Bi2xcfq32g
         dxFms0dWA92tKi7Q35eRExatLMomAnN+EwGS2q08ZWWh59MTVvy+4JH9jRg31tpbsZkq
         L76d1LW8lIzxwH58bMUD3x7i0xUC3XsVvAlxFLNnGlrOsXONCCDYMCz/7GTIAoYOnTqr
         2wBVaI99z2eAVtkRzb3UqXdz+W4ylpLfnPwOfjjHEYwF4WuIP3szxf5sfuQltoIwmVrr
         B0fQ==
X-Received: by 10.107.160.11 with SMTP id j11mr13844285ioe.153.1449788305492;
 Thu, 10 Dec 2015 14:58:25 -0800 (PST)
Received: by 10.36.15.201 with HTTP; Thu, 10 Dec 2015 14:58:06 -0800 (PST)
In-Reply-To: <1448021080-4994-3-git-send-email-ps@pks.im>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282238>

This test does not seem to pass on my mac.

I've placed the verbose output here:
https://gist.github.com/MichaelBlume/db7ba222be001d502e57

On Fri, Nov 20, 2015 at 4:04 AM, Patrick Steinhardt <ps@pks.im> wrote:
> When rebasing commits where one or several commits are redundant
> to commits on the branch that is being rebased upon we error out.
> This is due to the usage of `--allow-empty` for the invoked
> cherry-pick command, which will only cause _empty_ commits to be
> picked instead of also allowing redundant commits. As
> git-rebase(1) mentions, though, we also want to keep commits that
> do not change anything from its parents, that is also redundant
> commits.
>
> Fix this by invoking `git cherry-pick --keep-redundant-commits`
> instead, which will cause redundant commits to be rebased
> correctly.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  git-rebase--am.sh | 2 +-
>  t/t3400-rebase.sh | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/git-rebase--am.sh b/git-rebase--am.sh
> index 9ae898b..ea7b897 100644
> --- a/git-rebase--am.sh
> +++ b/git-rebase--am.sh
> @@ -44,7 +44,7 @@ then
>         # empty commits and even if it didn't the format doesn't really lend
>         # itself well to recording empty patches.  fortunately, cherry-pick
>         # makes this easy
> -       git cherry-pick ${gpg_sign_opt:+"$gpg_sign_opt"} --allow-empty \
> +       git cherry-pick ${gpg_sign_opt:+"$gpg_sign_opt"} --keep-redundant-commits \
>                 --right-only "$revisions" \
>                 ${restrict_revision+^$restrict_revision}
>         ret=$?
> diff --git a/t/t3400-rebase.sh b/t/t3400-rebase.sh
> index 6cca319..f43b202 100755
> --- a/t/t3400-rebase.sh
> +++ b/t/t3400-rebase.sh
> @@ -255,7 +255,7 @@ test_expect_success 'rebase commit with an ancient timestamp' '
>         grep "author .* 34567 +0600$" actual
>  '
>
> -test_expect_failure 'rebase duplicated commit with --keep-empty' '
> +test_expect_success 'rebase duplicated commit with --keep-empty' '
>         git reset --hard &&
>         git checkout master &&
>
> --
> 2.6.3
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
