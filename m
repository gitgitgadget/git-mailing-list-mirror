From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] pull: Allow pull to preserve merges when rebasing.
Date: Sun, 11 Aug 2013 02:16:56 -0400
Message-ID: <CAPig+cQ2NhMJGTBLHNH2zcfqKUv_ZNF4zGEiXjvHz-LS307kqw@mail.gmail.com>
References: <1376110736-11748-1-git-send-email-stephen@exigencecorp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	avarab@gmail.com
To: Stephen Haberman <stephen@exigencecorp.com>
X-From: git-owner@vger.kernel.org Sun Aug 11 08:17:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V8Oy1-00027M-4x
	for gcvg-git-2@plane.gmane.org; Sun, 11 Aug 2013 08:17:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752059Ab3HKGRU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Aug 2013 02:17:20 -0400
Received: from mail-lb0-f173.google.com ([209.85.217.173]:42420 "EHLO
	mail-lb0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751774Ab3HKGQ6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Aug 2013 02:16:58 -0400
Received: by mail-lb0-f173.google.com with SMTP id 10so4100981lbf.4
        for <git@vger.kernel.org>; Sat, 10 Aug 2013 23:16:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=NuNDaLpd01ST6YR0Heukj1WUer75H/geGdlBmNI1t1I=;
        b=znxW9ZXKdS0GO/JGBuoZMjqOQRZYTT0E/HJECQDkt/i35fe5hnYh6rGzEObkac9duD
         Ile2WzwiTDM0/7G6HiZa+1utm1T6g3GIvYps0wMD3XJSSyarCiJiBHZ0cMJYO6FhMxJK
         015IdlyUHvTdBaef0CPLeTqX6Sj3lLur3qipWtMTB3SQ4aLPfT6ka6cQaEMYZsXUc2bW
         U2JX52PKGBjEPlXiH7XLt3wWK41WRFpSzQg2louEnDPD1enWisVpTcdLQj8W3IkoNkUF
         Hv3B+R+d2alkz8sxu2uelpigRWnYwCNitaaerH7X6r/p2ztLGTAXLZSM2A+g58vXvEGv
         ZsmQ==
X-Received: by 10.112.29.147 with SMTP id k19mr7442061lbh.9.1376201816939;
 Sat, 10 Aug 2013 23:16:56 -0700 (PDT)
Received: by 10.114.182.236 with HTTP; Sat, 10 Aug 2013 23:16:56 -0700 (PDT)
In-Reply-To: <1376110736-11748-1-git-send-email-stephen@exigencecorp.com>
X-Google-Sender-Auth: KQEHukSM6Q14PrlH2R61P2N5aO4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232123>

On Sat, Aug 10, 2013 at 12:58 AM, Stephen Haberman
<stephen@exigencecorp.com> wrote:
> If a user is working on master, and has merged in their feature branch, but now
> has to "git pull" because master moved, with pull.rebase their feature branch
> will be flattened into master.
>
> This is because "git pull" currently does not know about rebase's preserve
> merges flag, which would avoid this behavior, as it would instead replay just
> the merge commit of the feature branch onto the new master, and not replay each
> individual commit in the feature branch.
>
> Add a --rebase=preserve option, which will pass along --preserve-merges to
> rebase.
>
> Also add 'preserve' to the allowed values for the pull.rebase config setting.
>
> Signed-off-by: Stephen Haberman <stephen@exigencecorp.com>
> ---
> Hey,
>
> This is version 2 of my previous patch--I changed over to the --rebase=preserve
> syntax as suggested by Johannes and Junio.

It is helpful to mention a link to the previous submission [1] in
order to make it easier for people to refer to the associated
discussion.

[1]: http://thread.gmane.org/gmane.comp.version-control.git/231909

More comments below.

> I also updated the documentation.
>
> I believe it is ready for serious consideration. Please let me know if I'm
> missing anything subtle or obvious.
>
> Thanks,
> Stephen
>
> diff --git a/Documentation/git-pull.txt b/Documentation/git-pull.txt
> index 6ef8d59..87ff938 100644
> --- a/Documentation/git-pull.txt
> +++ b/Documentation/git-pull.txt
> @@ -102,12 +102,18 @@ include::merge-options.txt[]
>  :git-pull: 1
>
>  -r::
> ---rebase::
> -       Rebase the current branch on top of the upstream branch after
> -       fetching.  If there is a remote-tracking branch corresponding to
> -       the upstream branch and the upstream branch was rebased since last
> -       fetched, the rebase uses that information to avoid rebasing
> -       non-local changes.
> +--rebase[=false|true|preserve]::
> +       When true, rebase the current branch on top of the upstream
> +       branch after fetching. If there is a remote-tracking branch
> +       corresponding to the upstream branch and the upstream branch
> +       was rebased since last fetched, the rebase uses that information
> +       to avoid rebasing non-local changes.
> ++
> +When preserve, also rebase the current branch on top of the upstream
> +branch, but pass `--preserve-merges` along to `git rebase` so that
> +locally created merge commits will not be flatten.

s/flatten/flattened/

Also, it's not clear from the documentation how one would override
pull.rebase=preserve in order to do a normal non-preserving rebase.
From reading the code, one can see that --preserve=true (or
--no-rebase followed by --rebase) will override pull.rebase=preserve,
but it would be hard for someone to guess this. One could imagine
people thinking that --rebase alone would intuitively override
pull.rebase=preserve, or that --preserve=no-preserve would do so, but
that's getting ugly.

> ++
> +When false, merge the current branch into the upstream branch.
>  +
>  See `pull.rebase`, `branch.<name>.rebase` and `branch.autosetuprebase` in
>  linkgit:git-config[1] if you want to make `git pull` always use
> diff --git a/git-pull.sh b/git-pull.sh
> index f0df41c..d142b38 100755
> --- a/git-pull.sh
> +++ b/git-pull.sh
> @@ -111,7 +111,14 @@ do
>                 merge_args="$merge_args$xx "
>                 ;;
>         -r|--r|--re|--reb|--reba|--rebas|--rebase)
> -               rebase=true
> +               # if the value is already non-false, like preserve, leave it alone
> +               if test -z "$rebase" -o false = "$rebase"

Unportable use of test -o [2]. Better to say 'test foo || test bar'.
(There is already an -o in git-pull.sh, but no need to add more.)

[2]: http://www.gnu.org/savannah-checkouts/gnu/autoconf/manual/autoconf-2.69/html_node/Limitations-of-Builtins.html#Limitations-of-Builtins

> +               then
> +                       rebase=true
> +               fi
> +               ;;
> +       --rebase=*)
> +               rebase="${1#*=}"
>                 ;;

There are a couple inconsistencies here.

First, short-forms of --rebase are recognized (--r, --re, --reb,
etc.), however only long-form --rebase= is accepted.

Second, it is standard practice to allow the option's argument to
bundled or not. For instance, in git-pull, both '--strategy=foo' and
'--strategy foo' are accepted. --rebase should follow suit.

Additionally, shouldn't the code be checking for valid values of
--rebase's argument ("true", "false", "preserve") and complain if
something other is encountered?

>         --no-r|--no-re|--no-reb|--no-reba|--no-rebas|--no-rebase)
>                 rebase=false
> diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
> index ed4d9c8..29cd45d 100755
> --- a/t/t5520-pull.sh
> +++ b/t/t5520-pull.sh
> @@ -148,6 +148,34 @@ test_expect_success 'branch.to-rebase.rebase should override pull.rebase' '
>         test new = $(git show HEAD:file2)
>  '
>
> +test_expect_success 'pull.rebase=preserve' '
> +       git reset --hard before-rebase &&
> +       test_config pull.rebase preserve &&
> +       git checkout -b keep-merge second^ &&
> +       test_commit file3 &&
> +       git checkout to-rebase &&
> +       git merge keep-merge &&
> +       git tag before-preserve-rebase &&
> +       git pull . copy &&
> +       test $(git rev-parse HEAD^^) = $(git rev-parse copy) &&
> +       test $(git rev-parse HEAD^2) = $(git rev-parse keep-merge)
> +'
> +
> +test_expect_success '--rebase=preserve' '
> +       git reset --hard before-preserve-rebase &&
> +       git pull --rebase=preserve . copy &&
> +       test $(git rev-parse HEAD^^) = $(git rev-parse copy) &&
> +       test $(git rev-parse HEAD^2) = $(git rev-parse keep-merge)
> +'
> +
> +test_expect_success '--rebase respects pull.rebase=preserve' '
> +       git reset --hard before-preserve-rebase &&
> +       test_config pull.rebase preserve &&
> +       git pull --rebase . copy &&
> +       test $(git rev-parse HEAD^^) = $(git rev-parse copy) &&
> +       test $(git rev-parse HEAD^2) = $(git rev-parse keep-merge)
> +'

Since --rebase= now accepts an argument and since only three values
are allowed for that argument, it makes sense to add tests for
--rebase=preserve (already done), --rebase=true, --rebase=false,
--rebase=bogus.

Moreover, there are additional combinations of --rebase=foo and
pull.rebase which can be tested. For instance, --rebase=false
overrides pull.rebase=preserve, --rebase=true overrides
pull.rebase=preserve, --rebase=preserve overrides pull.rebase=true,
etc.

>  test_expect_success '--rebase with rebased upstream' '
>
>         git remote add -f me . &&
> --
> 1.8.1.2
