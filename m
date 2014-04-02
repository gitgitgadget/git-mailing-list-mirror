From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 21/22] lockfile: extract a function reset_lock_file()
Date: Wed, 2 Apr 2014 03:06:54 -0400
Message-ID: <CAPig+cTEC6kgmgCcpcjaRNMf3gQVQGzBQx5i5A+EuDppH9VQxg@mail.gmail.com>
References: <1396367910-7299-1-git-send-email-mhagger@alum.mit.edu>
	<1396367910-7299-22-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
	Jeff King <peff@peff.net>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Thu Apr 03 13:37:45 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WVeJG-0006sp-5P
	for gcvg-git-2@plane.gmane.org; Thu, 03 Apr 2014 11:51:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758014AbaDBHGz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Apr 2014 03:06:55 -0400
Received: from mail-yh0-f43.google.com ([209.85.213.43]:64324 "EHLO
	mail-yh0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757330AbaDBHGz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Apr 2014 03:06:55 -0400
Received: by mail-yh0-f43.google.com with SMTP id b6so10079102yha.16
        for <git@vger.kernel.org>; Wed, 02 Apr 2014 00:06:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=PX0ki8HSsOOfPw7QFCw9dCUIpOS7w4LkxhhROAfnK64=;
        b=i9k4HOyLDugOFH0XspmOAcQOvEvzEOXYCOPrQgppBqZUx9JD6GTzCArTte2UYsOUBu
         3vqjmynHCLMs3HkSmLzfT5747vyBGkYQNhBmWIuDDPwGj+idFGc2G2jOKgLEvSgE5MIE
         rKR2Xz5VepWx28kBKb88N6g6fum06FVhyh6+d/PfPaVQJQXgnez3un2uYpRmV0D3kLPA
         vD8arw1YPST0HCeXrY9REjBwmUOC8w/U+pSHn9gGSSIWsddYc+BZ0yGHx0XaSFfk33+A
         UxC6h3M4HgW8jYMEDNMM5zLdqhPVahlt1IxcLJSf/qHEU33Es9T+OJGb3tjqRd6Y38lX
         DdZA==
X-Received: by 10.236.119.169 with SMTP id n29mr50768276yhh.62.1396422414628;
 Wed, 02 Apr 2014 00:06:54 -0700 (PDT)
Received: by 10.170.180.134 with HTTP; Wed, 2 Apr 2014 00:06:54 -0700 (PDT)
In-Reply-To: <1396367910-7299-22-git-send-email-mhagger@alum.mit.edu>
X-Google-Sender-Auth: 58ejeAPfwTckMW_UcvNzOGd9_08
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245720>

On Tue, Apr 1, 2014 at 11:58 AM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
> ---
>  lockfile.c | 31 ++++++++++++++++---------------
>  1 file changed, 16 insertions(+), 15 deletions(-)
>
> diff --git a/lockfile.c b/lockfile.c
> index 852d717..c06e134 100644
> --- a/lockfile.c
> +++ b/lockfile.c
> @@ -85,6 +85,14 @@ static void remove_lock_file_on_signal(int signo)
>         raise(signo);
>  }
>
> +static void reset_lock_file(struct lock_file *lk)
> +{
> +       lk->fd = -1;
> +       strbuf_setlen(&lk->filename, 0);
> +       strbuf_setlen(&lk->staging_filename, 0);

strbuf_reset() perhaps?

> +       lk->flags = LOCK_FLAGS_ON_LIST;
> +}
> +
>  /*
>   * path = absolute or relative path name
>   *
> @@ -185,8 +193,7 @@ static int lock_file(struct lock_file *lk, const char *path, int flags)
>
>         lk->fd = open(lk->staging_filename.buf, O_RDWR | O_CREAT | O_EXCL, 0666);
>         if (lk->fd < 0) {
> -               strbuf_setlen(&lk->filename, 0);
> -               strbuf_setlen(&lk->staging_filename, 0);
> +               reset_lock_file(lk);
>                 return -1;
>         }
>         if (adjust_shared_perm(lk->staging_filename.buf)) {
> @@ -273,17 +280,12 @@ int close_lock_file(struct lock_file *lk)
>
>  int commit_lock_file(struct lock_file *lk)
>  {
> -       int err = 0;
> -
>         if (lk->fd >= 0 && close_lock_file(lk))
>                 return -1;
> -       if (rename(lk->staging_filename.buf, lk->filename.buf)) {
> -               err = -1;
> -       } else {
> -               strbuf_setlen(&lk->filename, 0);
> -               strbuf_setlen(&lk->staging_filename, 0);
> -       }
> -       return err;
> +       if (rename(lk->staging_filename.buf, lk->filename.buf))
> +               return -1;
> +       reset_lock_file(lk);
> +       return 0;
>  }
>
>  int hold_locked_index(struct lock_file *lk, int die_on_error)
> @@ -306,8 +308,8 @@ int commit_locked_index(struct lock_file *lk)
>                         return -1;
>                 if (rename(lk->staging_filename.buf, alternate_index_output))
>                         return -1;
> -               strbuf_setlen(&lk->filename, 0);
> -               strbuf_setlen(&lk->staging_filename, 0);
> +
> +               reset_lock_file(lk);
>                 return 0;
>         } else {
>                 return commit_lock_file(lk);
> @@ -320,7 +322,6 @@ void rollback_lock_file(struct lock_file *lk)
>                 if (lk->fd >= 0)
>                         close_lock_file(lk);
>                 unlink_or_warn(lk->staging_filename.buf);
> -               strbuf_setlen(&lk->filename, 0);
> -               strbuf_setlen(&lk->staging_filename, 0);
> +               reset_lock_file(lk);
>         }
>  }
> --
> 1.9.0
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
