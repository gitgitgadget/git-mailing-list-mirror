From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] notes: handle multiple worktrees
Date: Tue, 28 Jul 2015 18:17:18 -0400
Message-ID: <CAPig+cRjXjWPrvFdY081HRLPEjdX4kePBgZn+akWGNkycM2Z7w@mail.gmail.com>
References: <xmqqegjsdq3n.fsf@gitster.dls.corp.google.com>
	<1438118624-26107-1-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Wed Jul 29 00:17:26 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZKDBd-0002Eu-Ct
	for gcvg-git-2@plane.gmane.org; Wed, 29 Jul 2015 00:17:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751534AbbG1WRU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Jul 2015 18:17:20 -0400
Received: from mail-yk0-f169.google.com ([209.85.160.169]:33981 "EHLO
	mail-yk0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750927AbbG1WRT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Jul 2015 18:17:19 -0400
Received: by ykax123 with SMTP id x123so108448594yka.1
        for <git@vger.kernel.org>; Tue, 28 Jul 2015 15:17:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=ho4b0owbnkxeh3V0kAi2CE4lfXRoBT/AL5aNYAgPlEk=;
        b=yg5gY7kuiPABNXxWIgDpxANr6LzCcodJnvkym6pv2lRMqbwFZgnc6uKi4knSD7ajDb
         v/BDSAf6hiDDx+coDrSKZmLaPKz05D2zyo+d2eoeET6B/mAfwtN3o2JfZXG80dxUSnZ6
         F3XC7x50kmU7BAgYrkaoSHw+tFS7+hBGrE2a7WBqmvccEbXtas6UPLBCMe6+AFfRnF1U
         w6f0of3OmhogWJG6r2Ogn7rJphLZ+yFLJ/e8bydxDjGNDhHLSmq13Wz2u//2bhKi0CUi
         mTPiXLO1WeYljDOv0XQubUlyL85ppBWByTzpXECfjIs5xAJw3TB+kmbuxIGnBew1mSUl
         9N1Q==
X-Received: by 10.170.97.9 with SMTP id o9mr40118980yka.84.1438121839023; Tue,
 28 Jul 2015 15:17:19 -0700 (PDT)
Received: by 10.37.12.129 with HTTP; Tue, 28 Jul 2015 15:17:18 -0700 (PDT)
In-Reply-To: <1438118624-26107-1-git-send-email-dturner@twopensource.com>
X-Google-Sender-Auth: yudX35Eg9LYa624LnSFxOpVlWFc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274860>

On Tue, Jul 28, 2015 at 5:23 PM, David Turner <dturner@twopensource.com> wrote:
> Prevent merges to the same notes branch from different worktrees.
> Before creating NOTES_MERGE_REF, check NOTES_MERGE_REF using the same
> code we use to check that two HEADs in different worktrees don't point
> to the same branch.  Modify that code, die_if_checked_out, to take a
> "head" ref to examine; previously, it just looked at HEAD.

die_if_checked_out() seems to be grossly misnamed following this
change since a branch (or detached head) can be "checked out", but
asking it if a HEAD or NOTES_MERGE_REF is "checked out" sounds weird.
Perhaps rename it to die_if_symref_shared() or something?

The new argument order, die_if_checked_out("HEAD", "branchname"), also
seems backward to me, at least with the current function name
(die_if_checked_out). With a better function name, maybe it wouldn't
be so bad.

I could also see die_if_checked_out() being refactored to move the
underlying logic to a new (better named) function for checking the
value of a particular file (HEAD, NOTES_MERGE_REF) in each linked
worktree. And then die_if_checked_out() would be a thin wrapper over
that new function. A reason for preferring this approach and keeping
die_if_checked_out() as a convenience wrapper is that it's likely that
it's going to be needed in more places in the future.

> Reported-by: Junio C Hamano <gitster@pobox.com>
> Signed-off-by: David Turner <dturner@twopensource.com>
> ---
> diff --git a/branch.c b/branch.c
> index c85be07..60eadc6 100644
> --- a/branch.c
> +++ b/branch.c
> @@ -311,21 +311,22 @@ void remove_branch_state(void)
>         unlink(git_path("SQUASH_MSG"));
>  }
>
> -static void check_linked_checkout(const char *branch, const char *id)
> +static void check_linked_checkout(const char *head, const char *branch,
> +                                 const char *id)
>  {
>         struct strbuf sb = STRBUF_INIT;
>         struct strbuf path = STRBUF_INIT;
>         struct strbuf gitdir = STRBUF_INIT;
>
>         /*
> -        * $GIT_COMMON_DIR/HEAD is practically outside
> +        * $GIT_COMMON_DIR/$head is practically outside
>          * $GIT_DIR so resolve_ref_unsafe() won't work (it
>          * uses git_path). Parse the ref ourselves.
>          */
>         if (id)
> -               strbuf_addf(&path, "%s/worktrees/%s/HEAD", get_git_common_dir(), id);
> +               strbuf_addf(&path, "%s/worktrees/%s/%s", get_git_common_dir(), id, head);
>         else
> -               strbuf_addf(&path, "%s/HEAD", get_git_common_dir());
> +               strbuf_addf(&path, "%s/%s", get_git_common_dir(), head);
>
>         if (!strbuf_readlink(&sb, path.buf, 0)) {
>                 if (!starts_with(sb.buf, "refs/") ||
> @@ -356,13 +357,13 @@ done:
>         strbuf_release(&gitdir);
>  }
>
> -void die_if_checked_out(const char *branch)
> +void die_if_checked_out(const char *head, const char *branch)
>  {
>         struct strbuf path = STRBUF_INIT;
>         DIR *dir;
>         struct dirent *d;
>
> -       check_linked_checkout(branch, NULL);
> +       check_linked_checkout(head, branch, NULL);
>
>         strbuf_addf(&path, "%s/worktrees", get_git_common_dir());
>         dir = opendir(path.buf);
> @@ -373,7 +374,7 @@ void die_if_checked_out(const char *branch)
>         while ((d = readdir(dir)) != NULL) {
>                 if (!strcmp(d->d_name, ".") || !strcmp(d->d_name, ".."))
>                         continue;
> -               check_linked_checkout(branch, d->d_name);
> +               check_linked_checkout(head, branch, d->d_name);
>         }
>         closedir(dir);
>  }
> diff --git a/branch.h b/branch.h
> index 58aa45f..3577fe5 100644
> --- a/branch.h
> +++ b/branch.h
> @@ -57,6 +57,6 @@ extern int read_branch_desc(struct strbuf *, const char *branch_name);
>   * worktree and die (with a message describing its checkout location) if
>   * it is.
>   */
> -extern void die_if_checked_out(const char *branch);
> +extern void die_if_checked_out(const char *head, const char *branch);
>
>  #endif
