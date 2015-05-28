From: Paul Tan <pyokagan@gmail.com>
Subject: Re: [PATCH 1/3] t4150-am: refactor and clean common setup
Date: Thu, 28 May 2015 21:10:11 +0800
Message-ID: <CACRoPnQEJHPfoz0LjSs2X1CrW-TdVGb54XSrg6VWXP2tdyu5Uw@mail.gmail.com>
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
X-From: git-owner@vger.kernel.org Thu May 28 15:10:22 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YxxZi-0000DG-FA
	for gcvg-git-2@plane.gmane.org; Thu, 28 May 2015 15:10:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752733AbbE1NKO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 May 2015 09:10:14 -0400
Received: from mail-lb0-f170.google.com ([209.85.217.170]:34561 "EHLO
	mail-lb0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752299AbbE1NKM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 May 2015 09:10:12 -0400
Received: by lbcmx3 with SMTP id mx3so27866924lbc.1
        for <git@vger.kernel.org>; Thu, 28 May 2015 06:10:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=vqznVptZjhvqVl7JU3IGYScKNojAMa8NssEAAIcLpuY=;
        b=WyM3nWLqGZz5HkCtPwp/jher4t74Qfxdc1SiUs586T5QGEUVbpc7wguA1O/a/oGSj9
         2pC+uTzJ8VR40xF17LOyJJE7/xvSF4TGQzQ+noMEz8W+z6xLLS2Ehtk1xZYF7hWzWZZI
         8sbBd+e9OmxBjcITpEhhgbN/juEUS+dOTKAKU4WS1Mdi34Lf0qpMybzmdmpDb9tXBrwD
         Vx9p0C0dURIAyQdGQJAlXPIuFxBZQUdgJz0MiqaiWoB592VLC6RhSXf9fFIO/V/lcWcv
         MFLlOL2rVqTwxNsXXDqWmtfhPLmEAF1dhVWUZql64brIVVOTm9BnjzUjAaeiA2eUzNQN
         Ev6w==
X-Received: by 10.112.93.230 with SMTP id cx6mr2713637lbb.65.1432818611364;
 Thu, 28 May 2015 06:10:11 -0700 (PDT)
Received: by 10.112.74.133 with HTTP; Thu, 28 May 2015 06:10:11 -0700 (PDT)
In-Reply-To: <1432675975-11020-1-git-send-email-remi.lespinet@ensimag.grenoble-inp.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270147>

Hi,

Take these comments/suggestions with a pinch of salt because I'm not
that experienced with the code base as well ;-).

On Wed, May 27, 2015 at 5:32 AM, Remi Lespinet
<remi.lespinet@ensimag.grenoble-inp.fr> wrote:
> Add new functions to keep the setup cleaner:
>  - setup_temporary_branch: creates a new branch, check it out
>    and automatically delete it after the test is over

Agreed. This removes a lot of boilerplate from the tests. Another
positive effect is that we can be sure that any commits made on that
throwaway branch will not affect the other parts of the test suite,
which makes understanding and editing the test suite much easier.

>  - setup_fixed_branch: creates a fixed branch, which can be re-used
>    in later tests

Looking at the patch, I see that setup_fixed_branch() is only used in
2 places, so I don't think it is a common pattern that would require
its own function. Also, see below.

> Signed-off-by: Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>
> ---
>  t/t4150-am.sh | 138 ++++++++++++++++++++--------------------------------------
>  1 file changed, 47 insertions(+), 91 deletions(-)
>
> diff --git a/t/t4150-am.sh b/t/t4150-am.sh
> index 306e6f3..8370951 100755
> --- a/t/t4150-am.sh
> +++ b/t/t4150-am.sh
> @@ -4,6 +4,20 @@ test_description='git am running'
>
>  . ./test-lib.sh
>
> +setup_temporary_branch () {

Maybe name this checkout_temp_branch() or something, since it more or
less is just a wrapper around git-checkout.

> +       tmp_name=${2-"temporary"}

I don't think the quotes are required. Also, I don't feel good about
swapping the order of the arguments to git-checkout. (or making $2 an
optional argument). As the patch stands, if I see

setup_temporary_branch lorem

I will think: so we are creating a temporary branch "lorem". But nope,
we are creating a temporary branch "temporary" that branches from
"lorem". I don't think writing setup_temporary_branch "temporary"
"lorem" explicitly is that bad.

This is just personal preference though.

> +       git reset --hard &&
> +       rm -fr .git/rebase-apply &&
> +       test_when_finished "git checkout $1 && git branch -D $tmp_name" &&

I think you should use "git checkout -f $1" as if the working tree is
dirty the test will fail at cleanup with no error message at all,
which is annoying for debugging. Furthermore, the test_when_finished
should be shifted below the git checkout -b below, as git branch -D
will fail if the branch does not exist.

> +       git checkout -b "$tmp_name" "$1"

If you use git checkout -f here then there's no need for the git reset
--hard above.

> +}
> +
> +setup_fixed_branch () {
> +       git reset --hard &&
> +       rm -fr .git/rebase-apply &&
> +       git checkout -b "$1" "$2"

Again, by using git checkout -f we can drop the git reset --hard. But
that reduces the function to 2 lines, and thus I don't think that this
usage pattern needs its own function.

> +}
> +
>  test_expect_success 'setup: messages' '
>         cat >msg <<-\EOF &&
>         second
> @@ -143,9 +157,7 @@ test_expect_success setup '
>  '

I haven't looked at the rest of the patch in detail because I'm not
that well-acquainted with t4150 yet, but it looks okay.

Thanks,
Paul
