From: Phil Hord <phil.hord@gmail.com>
Subject: Re: [PATCH 1/2] pull: respect rebase.autostash
Date: Fri, 14 Jun 2013 08:12:56 -0400
Message-ID: <CABURp0pVzQ2rVB-B2L+uCMtPV7QFPSgkZnHitCsrPCrR9LJOVA@mail.gmail.com>
References: <1371200178-9927-1-git-send-email-artagnon@gmail.com> <1371200178-9927-2-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 14 14:13:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UnSsc-00080D-4P
	for gcvg-git-2@plane.gmane.org; Fri, 14 Jun 2013 14:13:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752499Ab3FNMNS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Jun 2013 08:13:18 -0400
Received: from mail-ve0-f173.google.com ([209.85.128.173]:58986 "EHLO
	mail-ve0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752461Ab3FNMNR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Jun 2013 08:13:17 -0400
Received: by mail-ve0-f173.google.com with SMTP id jw11so398340veb.18
        for <git@vger.kernel.org>; Fri, 14 Jun 2013 05:13:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=XFxZa54NZLYeRbBdvJswB9jOElv+YV0+KRMbIcbApO4=;
        b=d1l5PXT4a+eykDCyLR4Gtn0FvVxLz2tugu07PppteXTDqIxHYSq240+/RbKlcIZRkz
         eYmoV+IDh09SoXSZa81MPKKmX2kVVqfplbQLmJ96w91SUxiEKdVVdfapgXXIIWez4pKE
         vhioXqbvU5UXVrBprQft5pkgmY60pFA6nEglBNbfVAkWVi4k6wL9gzUUoMp3HNC1J9dR
         SC+zC4LGrR4m1u8tmZL79Ab7alKydmgf4/p3dFJMDHfSAyA4jUgF9h90Ktgz0nlhsSjI
         W9RTC3EKoo8V703rfPQRNFvbwMegYs27M7zutSIkjWh0NpvrFp9RY5R805dKZdeAY6sC
         IPlQ==
X-Received: by 10.58.219.68 with SMTP id pm4mr809006vec.49.1371211996930; Fri,
 14 Jun 2013 05:13:16 -0700 (PDT)
Received: by 10.58.243.34 with HTTP; Fri, 14 Jun 2013 05:12:56 -0700 (PDT)
In-Reply-To: <1371200178-9927-2-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227813>

On Fri, Jun 14, 2013 at 4:56 AM, Ramkumar Ramachandra
<artagnon@gmail.com> wrote:
> If a rebasing pull is requested, pull unconditionally runs
> require_clean_worktree() resulting in:
>
>   # dirty worktree or index
>   $ git pull
>   Cannot pull with rebase: Your index contains uncommitted changes.
>   Please commit or stash them.
>
> It does this to inform the user early on that a rebase cannot be run on
> a dirty worktree, and that a stash is required.  However,
> rr/rebase-autostash lifts this limitation on rebase by providing a way
> to automatically stash using the rebase.autostash configuration
> variable.  Read this variable in pull, and take advantage of this
> feature.

This commit message does not tell me what this commit does.  It mostly
describes the current situation.  Then it refers to something called
"rr/rebase-autostash" which will lose meaning in the future when this
commit is no longer current on the list.  A better way to refer to
this commit is to say "this commit".  However, even this is not the
norm for this project.  The norm here is to avoid such noise by
speaking in the imperative mood.  That is, do not tell me what this
commit does; instead, tell the code what to do.  See
Documentation/SubmittingPatches:

  Describe your changes in imperative mood, e.g. "make xyzzy do frotz"
  instead of "[This patch] makes xyzzy do frotz" or "[I] changed xyzzy
  to do frotz", as if you are giving orders to the codebase to change
  its behaviour.  Try to make sure your explanation can be understood
  without external resources. Instead of giving a URL to a mailing list
  archive, summarize the relevant points of the discussion.



>
> Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
> ---
>  git-pull.sh     |  2 ++
>  t/t5520-pull.sh | 11 +++++++++++
>  2 files changed, 13 insertions(+)
>
> diff --git a/git-pull.sh b/git-pull.sh
> index 638aabb..fb01763 100755
> --- a/git-pull.sh
> +++ b/git-pull.sh
> @@ -44,6 +44,7 @@ merge_args= edit=
>  curr_branch=$(git symbolic-ref -q HEAD)
>  curr_branch_short="${curr_branch#refs/heads/}"
>  rebase=$(git config --bool branch.$curr_branch_short.rebase)
> +autostash=$(git config --bool rebase.autostash)
>  if test -z "$rebase"
>  then
>         rebase=$(git config --bool pull.rebase)
> @@ -203,6 +204,7 @@ test true = "$rebase" && {
>                         die "$(gettext "updating an unborn branch with changes added to the index")"
>                 fi
>         else
> +               test true = "$autostash" ||
>                 require_clean_work_tree "pull with rebase" "Please commit or stash them."
>         fi

This commit does not seem useful on its own.  All it does is prevent
the safety check for a clean work tree when the autostash flag is set.
 I understand that this is necessary for the rest of the change to be
useful, but I do not see any reason for it to be split into two
commits like this.  I think it would be more understandable if this
were squashed together with the rest of the change, both now for
reviews and in the future when someone tries to understand this change
in retrospect.

In particular, the commit message suggests that this commit will
perform the autostash if this variable is set, but it does not do that
yet.  I think if you squash these two together it will be more concise
and understandable.

Thanks,
Phil
