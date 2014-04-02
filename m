From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 22/22] lockfile: allow new file contents to be written
 while retaining lock
Date: Wed, 2 Apr 2014 03:20:46 -0400
Message-ID: <CAPig+cQLsK_X_5_LPj8YfBhr4CQJWZCq52A+E5shZoHMvvwyzw@mail.gmail.com>
References: <1396367910-7299-1-git-send-email-mhagger@alum.mit.edu>
	<1396367910-7299-23-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
	Jeff King <peff@peff.net>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Thu Apr 03 12:29:31 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WVeJO-0006sp-Ql
	for gcvg-git-2@plane.gmane.org; Thu, 03 Apr 2014 11:51:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757993AbaDBHUr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Apr 2014 03:20:47 -0400
Received: from mail-yk0-f173.google.com ([209.85.160.173]:49561 "EHLO
	mail-yk0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757986AbaDBHUq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Apr 2014 03:20:46 -0400
Received: by mail-yk0-f173.google.com with SMTP id 10so8550746ykt.32
        for <git@vger.kernel.org>; Wed, 02 Apr 2014 00:20:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=pzleWirkRO93ZUEefr2XG8Osm6ZVBzk9G4MZPmkfcnM=;
        b=nnRyrUJCxGkUBvINC4MamN2Xk/PSoro1L8lLnP+J3VyF29BVV/kFhizL6f8VeJ5o1k
         xYOs+wyAEirkSjbL3VyYq4wjB62EVv3Tli17ioefq2/u+mbh/Qm4QRENKNuVWmd3gBz+
         kHJxAXqkj/rdXZW0GpBOKiAvi9espYjM5+SDa6WtPV0i9iBuh5KKHBBp206l8sewImMX
         79P5Egpjkj+hhB8x75p+DS5YVlFLoJjRn8IysebBcq6NEjwAz7E7EvYRODU9Kmd0P81x
         jkIEoMnTJe3Sl16EcrpvjLgRc6nnL2nSAtyD/mDArFuCfhoGwFsY2hYGM0FFSujVKFo8
         20PA==
X-Received: by 10.236.220.72 with SMTP id n68mr469610yhp.102.1396423246198;
 Wed, 02 Apr 2014 00:20:46 -0700 (PDT)
Received: by 10.170.180.134 with HTTP; Wed, 2 Apr 2014 00:20:46 -0700 (PDT)
In-Reply-To: <1396367910-7299-23-git-send-email-mhagger@alum.mit.edu>
X-Google-Sender-Auth: a3dup4QuA2YyI7oSrDXqA_t1rt8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245679>

On Tue, Apr 1, 2014 at 11:58 AM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
> Add a new option flag, LOCK_SEPARATE_STAGING_FILE, that can be passed
> to hold_lock_file_for_update() or hold_lock_file_for_append() to use a
> staging file that is independent of the lock file.
>
> Add a new function activate_staging_file() that activates the contents
> that have been written to the staging file without releasing the lock.
>
> This functionality can be used to ensure that changes to two files are
> seen by other processes in one order even if correctness requires the
> locks to be released in another order.
>
> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
> ---
> diff --git a/lockfile.c b/lockfile.c
> index c06e134..336b914 100644
> --- a/lockfile.c
> +++ b/lockfile.c
> @@ -271,19 +325,54 @@ int hold_lock_file_for_append(struct lock_file *lk, const char *path, int flags)
>         return fd;
>  }
>
> -int close_lock_file(struct lock_file *lk)
> +static int close_staging_file(struct lock_file *lk)
>  {
>         int fd = lk->fd;
> +
>         lk->fd = -1;
>         return close(fd);
>  }
>
> -int commit_lock_file(struct lock_file *lk)
> +int close_lock_file(struct lock_file *lk)
>  {
> -       if (lk->fd >= 0 && close_lock_file(lk))
> -               return -1;
> -       if (rename(lk->staging_filename.buf, lk->filename.buf))
> +       assert(!(lk->flags & LOCK_FLAGS_SEPARATE_STAGING_FILE));
> +       return close_staging_file(lk);
> +}
> +
> +int activate_staging_file(struct lock_file *lk)
> +{
> +       int err;
> +
> +       assert(lk->flags & LOCK_FLAGS_SEPARATE_STAGING_FILE);
> +       assert(lk->fd >= 0);
> +       assert(lk->staging_filename.len);
> +
> +       if (close_staging_file(lk))
>                 return -1;
> +
> +       err = rename(lk->staging_filename.buf, lk->filename.buf);
> +       strbuf_setlen(&lk->staging_filename, 0);

strbuf_reset()?

> +
> +       return err;
> +}
> +
> +int commit_lock_file(struct lock_file *lk)
> +{
> +       if (lk->flags & LOCK_FLAGS_SEPARATE_STAGING_FILE) {
> +               if (lk->staging_filename.len) {
> +                       assert(lk->fd >= 0);
> +                       if (activate_staging_file(lk))
> +                               return -1;
> +               }
> +               strbuf_addbuf(&lk->staging_filename, &lk->filename);
> +               strbuf_addstr(&lk->staging_filename, ".lock");
> +               unlink_or_warn(lk->staging_filename.buf);
> +       } else {
> +               if (lk->fd >= 0 && close_lock_file(lk))
> +                       return -1;
> +               if (rename(lk->staging_filename.buf, lk->filename.buf))
> +                       return -1;
> +       }
>         reset_lock_file(lk);
>         return 0;
>  }
> @@ -318,10 +407,21 @@ int commit_locked_index(struct lock_file *lk)
>
>  void rollback_lock_file(struct lock_file *lk)
>  {
> -       if (lk->filename.len) {
> -               if (lk->fd >= 0)
> -                       close_lock_file(lk);
> -               unlink_or_warn(lk->staging_filename.buf);
> -               reset_lock_file(lk);
> +       if (!lk->filename.len)
> +               return;
> +
> +       if (lk->fd >= 0)
> +               close_staging_file(lk);
> +
> +       if (lk->flags & LOCK_FLAGS_SEPARATE_STAGING_FILE) {
> +               if (lk->staging_filename.len) {
> +                       unlink_or_warn(lk->staging_filename.buf);
> +                       strbuf_setlen(&lk->staging_filename, 0);

strbuf_reset()?

> +               }
> +               strbuf_addbuf(&lk->staging_filename, &lk->filename);
> +               strbuf_addstr(&lk->staging_filename, ".lock");
>         }
> +
> +       unlink_or_warn(lk->staging_filename.buf);
> +       reset_lock_file(lk);
>  }
> --
> 1.9.0
