From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v4 1/2] worktrees: add find_shared_symref
Date: Fri, 31 Jul 2015 18:20:34 -0400
Message-ID: <CAPig+cRWQDAB5AMPy4GUyckKr+4eqra_DiZGbfj1L2BnUfBNrA@mail.gmail.com>
References: <1438380669-11012-1-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Johan Herland <johan@herland.net>
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Sat Aug 01 00:20:41 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZLIfQ-0001gB-I0
	for gcvg-git-2@plane.gmane.org; Sat, 01 Aug 2015 00:20:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752639AbbGaWUf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 Jul 2015 18:20:35 -0400
Received: from mail-yk0-f171.google.com ([209.85.160.171]:34472 "EHLO
	mail-yk0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752077AbbGaWUe (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Jul 2015 18:20:34 -0400
Received: by ykax123 with SMTP id x123so70492703yka.1
        for <git@vger.kernel.org>; Fri, 31 Jul 2015 15:20:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=ctW8c33y+k+EhDbRUtfqR2Y7QuzQonj+2Mr5xT4CIvg=;
        b=ZrMmrKyRnulvmGzB//SQC8fNahs4duaVLpWcMQNm3PyLU8ihtolZuCK170AfqS4sKp
         ZdpNaiePoOpl8+2RXxre/R8XqDtpu8UgK6kCMWPLkVtvx7q7dGaG6p+8w0fRncwu03Xg
         /YVvFhjmJQ6SKS0c9r3hq4W0Ok/JLCWnKGAlGo921wOsbxEspbAnMEbGxBJdFgFTNoKt
         AuqnwWMsxDglh/5MtDehupGZZOuc6zca97w82GSOcZN3DEgnpsGYWT//HJld+0D3yx4z
         4G2ogDvmAVe5NkzglMHnNY7z4KxQicHURgVOHZHTnwBc/Y39qevWNl1B0RlYYpMgfUQh
         Ex/A==
X-Received: by 10.13.221.213 with SMTP id g204mr4133841ywe.48.1438381234193;
 Fri, 31 Jul 2015 15:20:34 -0700 (PDT)
Received: by 10.37.12.129 with HTTP; Fri, 31 Jul 2015 15:20:34 -0700 (PDT)
In-Reply-To: <1438380669-11012-1-git-send-email-dturner@twopensource.com>
X-Google-Sender-Auth: oqfAB8isxV53JapbBKBW4Ucb0iw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275087>

On Fri, Jul 31, 2015 at 6:11 PM, David Turner <dturner@twopensource.com> wrote:
> Add a new function, find_shared_symref, which contains the heart of
> die_if_checked_out, but works for all symrefs.  Refactor

Slightly more explanatory:

    ..., but works for any symref, not just HEAD. Refactor

More below.

> die_if_checked_out to use the same infrastructure as
> find_shared_symref.
>
> Soon, we will use find_shared_symref to protect notes merges in
> worktrees.
>
> Signed-off-by: David Turner <dturner@twopensource.com>
> ---
> diff --git a/branch.c b/branch.c
> index c85be07..9b5e3b3 100644
> --- a/branch.c
> +++ b/branch.c
> @@ -349,31 +350,47 @@ static void check_linked_checkout(const char *branch, const char *id)
>                 strbuf_addstr(&gitdir, get_git_common_dir());
>         skip_prefix(branch, "refs/heads/", &branch);
>         strbuf_strip_suffix(&gitdir, ".git");
> -       die(_("'%s' is already checked out at '%s'"), branch, gitdir.buf);
> +       return strbuf_detach(&gitdir, NULL);

By returning here, you're now leaking 'path' and 'sb' (see the 'done'
label below).

>  done:
>         strbuf_release(&path);
>         strbuf_release(&sb);
>         strbuf_release(&gitdir);
> +
> +       return NULL;
>  }
>
> -void die_if_checked_out(const char *branch)
> +char *find_shared_symref(const char *symref, const char *target)
>  {
>         struct strbuf path = STRBUF_INIT;
>         DIR *dir;
>         struct dirent *d;
> +       char *existing;
>
> -       check_linked_checkout(branch, NULL);
> +       if ((existing = find_linked_symref(symref, target, NULL)))
> +               return existing;
>
>         strbuf_addf(&path, "%s/worktrees", get_git_common_dir());
>         dir = opendir(path.buf);
>         strbuf_release(&path);
>         if (!dir)
> -               return;
> +               return NULL;
>
>         while ((d = readdir(dir)) != NULL) {
>                 if (!strcmp(d->d_name, ".") || !strcmp(d->d_name, ".."))
>                         continue;
> -               check_linked_checkout(branch, d->d_name);
> +               if ((existing = find_linked_symref(symref, target, d->d_name)))
> +                       return existing;

By returning here, you're leaking the open 'dir'.

>         }
>         closedir(dir);
> +
> +       return NULL;
> +}
> +
> +void die_if_checked_out(const char *branch)
> +{
> +       char *existing;
> +
> +       existing = find_shared_symref("HEAD", branch);
> +       if (existing)
> +               die(_("'%s' is already checked out at '%s'"), branch, existing);
>  }
> diff --git a/branch.h b/branch.h
> index 58aa45f..0f466c7 100644
> --- a/branch.h
> +++ b/branch.h
> @@ -59,4 +59,12 @@ extern int read_branch_desc(struct strbuf *, const char *branch_name);
>   */
>  extern void die_if_checked_out(const char *branch);
>
> +/*
> + * Check if a per-worktree symref points to a ref in the main worktree
> + * or any linked worktree, and return the path to the exising worktree
> + * if it is.  Returns NULL if there is no existing ref.  The caller is
> + * responsible for freeing the returned path.
> + */
> +extern char *find_shared_symref(const char *symref, const char *branch);

I think you meant s/branch/target/.

>  #endif
> --
> 2.0.4.315.gad8727a-twtrsrc
