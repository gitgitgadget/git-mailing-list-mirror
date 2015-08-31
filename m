From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v6 2/2] worktree: add 'list' command
Date: Mon, 31 Aug 2015 02:23:18 -0400
Message-ID: <CAPig+cQ0oJbKV1PFPvDfjejyUfHmxzJmmYH3Wf0muNoiTU7Dew@mail.gmail.com>
References: <1440961839-40575-1-git-send-email-rappazzo@gmail.com>
	<1440961839-40575-3-git-send-email-rappazzo@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	David Turner <dturner@twopensource.com>,
	Git List <git@vger.kernel.org>
To: Michael Rappazzo <rappazzo@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 31 08:23:26 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZWIV3-0002Gd-D0
	for gcvg-git-2@plane.gmane.org; Mon, 31 Aug 2015 08:23:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752487AbbHaGXV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Aug 2015 02:23:21 -0400
Received: from mail-yk0-f178.google.com ([209.85.160.178]:34767 "EHLO
	mail-yk0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751233AbbHaGXT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Aug 2015 02:23:19 -0400
Received: by ykfw127 with SMTP id w127so17551297ykf.1
        for <git@vger.kernel.org>; Sun, 30 Aug 2015 23:23:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=4PVdu7QoomDxFdN81m2RHCE/UaLEk1KzBRH0KlMU0Gs=;
        b=RHH3BLVX3fMIJnIi0K2KjXywjofvGl9A30pvyKhLcBqCyVOJdow4hPLH5MlBZbIT08
         tHAC+rmhwGO0BLrani3+QXdRw8iEMkvtwpPoIqlflLf8wuMVH54Lnw6i3Uehkuac/J83
         Ct1023HsFb1TVPFVoks6KRfahhtHi7hMexVilxZpDo+b8iEZk3flSZfM1wBclzGoCW3R
         s/X4Yb77oR4Vy7yDi2xUwl96nr5D8KsFWe/if2vkIDtuAwTBkGF9zLkNd3l8FAk4P/5g
         AqIrSX7Xc2s0w+eZEgRv1DNvXC+Sqb1s3OGdat0voRfKgT+ZZisSuuNkv3DOV42SOS1z
         YJAA==
X-Received: by 10.129.92.8 with SMTP id q8mr19101616ywb.163.1441002198975;
 Sun, 30 Aug 2015 23:23:18 -0700 (PDT)
Received: by 10.37.36.145 with HTTP; Sun, 30 Aug 2015 23:23:18 -0700 (PDT)
In-Reply-To: <1440961839-40575-3-git-send-email-rappazzo@gmail.com>
X-Google-Sender-Auth: oPPvvaw3BP278FZr0sx9RaWYnYg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276848>

On Sun, Aug 30, 2015 at 3:10 PM, Michael Rappazzo <rappazzo@gmail.com> wrote:
> 'git worktree list' uses the for_each_worktree function to iterate,
> and outputs the worktree dir.  With the verbose option set, it also
> shows the branch or revision currently checked out in that worktree.
>
> Signed-off-by: Michael Rappazzo <rappazzo@gmail.com>
> ---
> diff --git a/Documentation/git-worktree.txt b/Documentation/git-worktree.txt
> index fb68156..867a24a 100644
> --- a/Documentation/git-worktree.txt
> +++ b/Documentation/git-worktree.txt
> @@ -11,6 +11,7 @@ SYNOPSIS
>  [verse]
>  'git worktree add' [-f] [--detach] [-b <new-branch>] <path> [<branch>]
>  'git worktree prune' [-n] [-v] [--expire <expire>]
> +'git worktree list' [-v|--verbose]

For conciseness and consistency with the "git worktree prune"
synopsis, this should mention only -v (and omit --verbose).

>  DESCRIPTION
>  -----------
> @@ -88,11 +93,13 @@ OPTIONS
>
>  -v::
>  --verbose::
> -       With `prune`, report all removals.
> +       With `prune`, report all removals.
> +       With `list` show the branch or revision currently checked out in that worktree.

Add a comma after "With `list`".
Also: s/in that/in each/
This new line is overly long; wrapping it over a couple lines would help.

>  --expire <time>::
>         With `prune`, only expire unused working trees older than <time>.
> diff --git a/builtin/worktree.c b/builtin/worktree.c
> index 7b3cb96..6d96cdf 100644
> --- a/builtin/worktree.c
> +++ b/builtin/worktree.c
> +static int print_worktree_details(const char *path, const char *git_dir, void *cb_data)
> +{
> +       printf("%s", path);
> +       if (verbose) {
> +               enter_repo(git_dir, 1);
> +               printf("  [");
> +               unsigned char sha1[20];
> +               int flag;
> +
> +               const char *refname = resolve_ref_unsafe("HEAD", 0, sha1, &flag);

Declarations after statement. Move the declarations of 'sha1', 'flag',
and 'refname' above the statements (enter_repo() and printf()).

 > +               if (!(flag & REF_ISSYMREF)) {
> +                       printf("%s", find_unique_abbrev(sha1, DEFAULT_ABBREV));
> +               } else {
> +                       refname = shorten_unambiguous_ref(refname, 0);
> +                       printf("%s", refname);
> +               }

As mentioned in my review[1] of patch 1/2, it would be better for this
sort of logic to be handled by the worktree iterator itself so that
all callers can benefit, rather than having to repeat the work in each
caller. This information would be encapsulated in a 'struct worktree'
along with 'path' and 'git_dir' and other interesting information
vended by the the iterator function.

> +               printf("]");

Rather than dropping printf()'s here and there to compose the output
piecemeal, it would be cleaner, and facilitate future changes, to
assign the refname/sha1 to a variable, and interpolate that variable
into an all-encompasing printf(), like this:

    printf("  [%s]", branch_or_sha1);

> +       }
> +       printf("\n");
> +
> +       return 0;
> +}

[1]: http://article.gmane.org/gmane.comp.version-control.git/276847
