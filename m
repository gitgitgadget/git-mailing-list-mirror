From: Paul Tan <pyokagan@gmail.com>
Subject: Re: [PATCH] pull: allow dirty tree when rebase.autostash enabled
Date: Wed, 3 Jun 2015 12:50:03 +0800
Message-ID: <CACRoPnQ=5sdWpnebv0OKPHPBh4iyMZ1H47cix6KFh7i5fYomNA@mail.gmail.com>
References: <1433282157-8171-1-git-send-email-me@ikke.info>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "Junio C. Hamano" <gitster@pobox.com>,
	Git List <git@vger.kernel.org>
To: Kevin Daudt <me@ikke.info>
X-From: git-owner@vger.kernel.org Wed Jun 03 06:50:28 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z00d2-0006ya-0M
	for gcvg-git-2@plane.gmane.org; Wed, 03 Jun 2015 06:50:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751647AbbFCEuH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Jun 2015 00:50:07 -0400
Received: from mail-lb0-f173.google.com ([209.85.217.173]:34228 "EHLO
	mail-lb0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751023AbbFCEuF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Jun 2015 00:50:05 -0400
Received: by lbcmx3 with SMTP id mx3so117340730lbc.1
        for <git@vger.kernel.org>; Tue, 02 Jun 2015 21:50:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=niVvyTkNMDXxUunD7VW2tJvkf1gpuphe7sm0enk8zJw=;
        b=kC6bHrkVxePYLwrmS9sl4qcTRH4Qe1yAsd/OblYTMD/7IBqVybSzmkcjOFfQVeGyn7
         Hl6Atb+yuNUyxT5uYCiKth90V7/WGResWmsTeflWCJMDKrImzfIZr5W/VmCCdtClqiko
         GJnO/Gn+JNWzIm/duQRKG1zytWhmPfMWdUtBVzZ2AE2Thr2wPTbOUkD0BSbimoP6Ek50
         nUNSZtL2XaidbWRo9qpDmEQHZeuT/t3qyej45ym3yXRiAEz2iiTGeawC/q+PwEXDZb+M
         +5QhxQjqPMTJYGyn+Ctj7DBHhLVgiEJtY/Ns0O/wHGPGpAP8CR2fJMJxhpuZLYfK8uGU
         ObSg==
X-Received: by 10.152.164.193 with SMTP id ys1mr646325lab.65.1433307003897;
 Tue, 02 Jun 2015 21:50:03 -0700 (PDT)
Received: by 10.112.74.133 with HTTP; Tue, 2 Jun 2015 21:50:03 -0700 (PDT)
In-Reply-To: <1433282157-8171-1-git-send-email-me@ikke.info>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270626>

Hi,

Some comments which may not necessarily be correct.

On Wed, Jun 3, 2015 at 5:55 AM, Kevin Daudt <me@ikke.info> wrote:
> rebase learned to stash changes when it encounters a dirty work tree, but
> git pull --rebase does not.
>
> Only verify if the working tree is dirty when rebase.autostash is not
> enabled.
> ---

Missing sign-off.

>  git-pull.sh     |  5 ++++-
>  t/t5520-pull.sh | 17 +++++++++++++++++
>  2 files changed, 21 insertions(+), 1 deletion(-)
>
> diff --git a/git-pull.sh b/git-pull.sh
> index 0917d0d..6b9e8a3 100755
> --- a/git-pull.sh
> +++ b/git-pull.sh
> @@ -239,7 +239,10 @@ test true = "$rebase" && {
>                         die "$(gettext "updating an unborn branch with changes added to the index")"
>                 fi
>         else
> -               require_clean_work_tree "pull with rebase" "Please commit or stash them."
> +               if [ $(git config --bool --get rebase.autostash || echo false) = "false" ]

"false" doesn't need to be quoted.

> +               then
> +                       require_clean_work_tree "pull with rebase" "Please commit or stash them."
> +               fi
>         fi
>         oldremoteref= &&
>         test -n "$curr_branch" &&
> diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
> index 7efd45b..d849a19 100755
> --- a/t/t5520-pull.sh
> +++ b/t/t5520-pull.sh
> @@ -297,6 +297,23 @@ test_expect_success 'pull --rebase dies early with dirty working directory' '
>
>  '
>
> +test_expect_success 'pull --rebase succeeds with dirty working directory and rebase.autostash set' '
> +

I know the surrounding old tests use a newline, but I think that all
new tests should use the modern style of not having a newline, since
t5520 already consists of a mix of old and modern styles anyway.

> +       test_when_finished "git rm -f file4" &&

There is trailing whitespace here.

Furthermore, git rm -f will fail if "file4" does not exist in the
index. Perhaps it should be moved below the "git add" below.

> +       git checkout to-rebase &&
> +       git update-ref refs/remotes/me/copy copy^ &&
> +       COPY=$(git rev-parse --verify me/copy) &&

$COPY is not used anywhere in the test.

> +       git rebase --onto $COPY copy &&
> +       test_config branch.to-rebase.remote me &&
> +       test_config branch.to-rebase.merge refs/heads/copy &&
> +       test_config branch.to-rebase.rebase true &&
> +       test_config rebase.autostash true &&
> +       echo dirty >> file4 &&

file4 does not exist, so we don't need to append to it. I know the
above few tests do not adhere to it, but CodingGuidelines says that
redirection operators do not have a space after

> +       git add file4 &&
> +       git pull

I think we should check for file contents to ensure that
git-pull/git-stash/git-rebase is doing its job properly.

> +

Same as above, no need the newline.

> +'
> +

With all that said, I wonder if this test, and the test above ("pull
--rebase dies early with dirty working directory") could be vastly
simplified, since we are not testing if we can handle a rebased
upstream.

E.g., my simplified version for the above test would be something like:

    git checkout -f to-rebase &&
    git rebase --onto copy^ copy &&
    test_config rebase.autostash true &&
    echo dirty >file4 &&
    git add file4 &&
    test_when_finished "git rm -f file4" &&
    git pull --rebase . me/copy &&
    test "$(cat file4)" = dirty &&
    test "$(cat file2)" = file

It's still confusing though, because we cannot take advantage of the
'before-rebase' tag introduced in the above tests. I would much prefer
if this test and the ("pull --rebase dies with dirty working
directory") test could be moved to the --rebase tests at lines 214+.
Also, this section in the t5520 test suite always gives me a headache
trying to decipher what it is trying to do ><

Thanks,
Paul
