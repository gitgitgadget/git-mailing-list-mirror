From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v5 1/2] worktrees: add find_shared_symref
Date: Mon, 3 Aug 2015 19:06:11 -0400
Message-ID: <CAPig+cTFWn6mWtmmG9KrDhK1++r7fgXM_mK4BvCktThoErnBzA@mail.gmail.com>
References: <1438627706-6743-1-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Johan Herland <johan@herland.net>
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Tue Aug 04 01:06:18 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZMOoD-0004yR-G5
	for gcvg-git-2@plane.gmane.org; Tue, 04 Aug 2015 01:06:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932472AbbHCXGN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Aug 2015 19:06:13 -0400
Received: from mail-yk0-f172.google.com ([209.85.160.172]:36453 "EHLO
	mail-yk0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932308AbbHCXGM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Aug 2015 19:06:12 -0400
Received: by ykeo23 with SMTP id o23so26799604yke.3
        for <git@vger.kernel.org>; Mon, 03 Aug 2015 16:06:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=ADevwJ8nnY9S6vhzB0f4RLbJW1l+ArQEIZ2jF7ryBgU=;
        b=yqDIThnixM6iHmtsRFpr2piTLY4hVOu9RBCIdSNcnuBoNJvTcjMpjWqutewwaRT/Jk
         /cZtcLts4D89f/umkiX5IGsKYgviajqvu0+Ege87rShKISQvgf3/D9enTnydFTFl0r38
         beX4ZWWtZqc3V/EeN/cIByiahEmcuWfMVbOsG9O+9pQTpcNg5DyJ0NXKvIznv9uY3C4d
         /V0KWOMgfsoqq7Bluzh91hV5eqg66thl00PySTDlL6eGP1LE7GnDYqAbM7oPsL9laRYd
         90cmR1zKJUFA4HoGiLZrtYfUZuUYrpnM+ZLTKJGJgKXPSTPDhgIkjDoROAa3z0X+BsbZ
         38Mg==
X-Received: by 10.170.112.208 with SMTP id e199mr508978ykb.69.1438643171810;
 Mon, 03 Aug 2015 16:06:11 -0700 (PDT)
Received: by 10.37.12.129 with HTTP; Mon, 3 Aug 2015 16:06:11 -0700 (PDT)
In-Reply-To: <1438627706-6743-1-git-send-email-dturner@twopensource.com>
X-Google-Sender-Auth: NP9oyomu7qUUSRZLh9sxiGfv5uY
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275226>

On Mon, Aug 3, 2015 at 2:48 PM, David Turner <dturner@twopensource.com> wrote:
> Add a new function, find_shared_symref, which contains the heart of
> die_if_checked_out, but works for any symref, not just HEAD.  Refactor
> die_if_checked_out to use the same infrastructure as
> find_shared_symref.
>
> Soon, we will use find_shared_symref to protect notes merges in
> worktrees.

A couple comments below. The first may be worth a re-roll; the second
is more a taste thing. Neither is blocking if you don't happen to
re-roll.

> Signed-off-by: David Turner <dturner@twopensource.com>
> ---
> diff --git a/branch.c b/branch.c
> index c85be07..d2b3586 100644
> --- a/branch.c
> +++ b/branch.c
> @@ -349,31 +350,53 @@ static void check_linked_checkout(const char *branch, const char *id)
>                 strbuf_addstr(&gitdir, get_git_common_dir());
>         skip_prefix(branch, "refs/heads/", &branch);
>         strbuf_strip_suffix(&gitdir, ".git");
> -       die(_("'%s' is already checked out at '%s'"), branch, gitdir.buf);
> +
> +       strbuf_release(&path);
> +       strbuf_release(&sb);
> +       return strbuf_detach(&gitdir, NULL);
>  done:
>         strbuf_release(&path);
>         strbuf_release(&sb);
>         strbuf_release(&gitdir);
> +
> +       return NULL;
>  }

This would be cleaner and less redundant if you assign the existing
location to a variable and just fall through to the 'done' label:

    char *existing = NULL;
    ...
        skip_prefix(branch, "refs/heads/", &branch);
        strbuf_strip_suffix(&gitdir, ".git");
        existing = strbuf_detach(&gitdir, NULL);
    done:
        strbuf_release(&path);
        strbuf_release(&sb);
        strbuf_release(&gitdir);
        return existing;

There's no worry that the "existing" path will be clobbered by
strbuf_release(&gitdir) since it's been detached already (and it's
safe to release the strbuf without affecting what has been detached
from it).

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
> +               existing = find_linked_symref(symref, target, d->d_name);
> +               if (existing) {
> +                       closedir(dir);
> +                       return existing;

For consistency with code nearby, this could have been handled by
adding a 'done' label above the closedir() below and jumping to it
from here, and then 'return existing'.

> +               }
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
