From: ronnie sahlberg <ronniesahlberg@gmail.com>
Subject: Re: [PATCH 07/23] expire_reflog(): use a lock_file for rewriting the
 reflog file
Date: Thu, 4 Dec 2014 18:59:01 -0800
Message-ID: <CAN05THTH2XDaUmchehF0gY0-GSgD_O9rJH7F5Gc3dHLCPz3GsA@mail.gmail.com>
References: <1417734515-11812-1-git-send-email-mhagger@alum.mit.edu>
	<1417734515-11812-8-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Stefan Beller <sbeller@google.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Fri Dec 05 03:59:15 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xwj6u-0005zC-R0
	for gcvg-git-2@plane.gmane.org; Fri, 05 Dec 2014 03:59:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933462AbaLEC7F (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Dec 2014 21:59:05 -0500
Received: from mail-lb0-f181.google.com ([209.85.217.181]:51030 "EHLO
	mail-lb0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932378AbaLEC7E (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Dec 2014 21:59:04 -0500
Received: by mail-lb0-f181.google.com with SMTP id l4so5770910lbv.12
        for <git@vger.kernel.org>; Thu, 04 Dec 2014 18:59:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=APpvsrtZNZEpr01djnGZUGJuk9Wuka1esiBZfV948j8=;
        b=omxvkdBU34CJpCab2tteAHa+FnzTs/PDmNfB9lWaySneMK9J6Dfnb8noDm/l67+Eqi
         tQrKPRoTWhSlPIlKGeJK9Mi6t+rUvUbh4yfCyvS24yHfuOSXbAETSJOQGJUo4XOFUvLA
         KIcvyL6MUOFnnHELz2EubC5D9J7LTXnzvF+bd+L9iqiRig2iF6Pin2/PuAp1pGbGyY/Z
         GkV7FS8N5FXcoPmcyTBmx15ne7r04ogaQsCswVzHG/vgLieOQDS7cZ0u0VDNdSD2VtT3
         V9yrR1ToLsMmYEGgZcanNoQOcghJ5GK37Pc4fwMZd996yP+1XMxiUixMuqetBy2I2WZF
         wMBQ==
X-Received: by 10.152.21.66 with SMTP id t2mr600333lae.27.1417748341825; Thu,
 04 Dec 2014 18:59:01 -0800 (PST)
Received: by 10.25.15.207 with HTTP; Thu, 4 Dec 2014 18:59:01 -0800 (PST)
In-Reply-To: <1417734515-11812-8-git-send-email-mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260855>

On Thu, Dec 4, 2014 at 3:08 PM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
> We don't actually need the locking functionality, because we already
> hold the lock on the reference itself,

No. You do need the lock.
The ref is locked only during transaction_commit()

If you don't want to lock the reflog file and instead rely on the lock
on the ref itself you will need to
rework your patches so that the lock on the ref is taken already
during, for example, transaction_update_ref() instead.

But without doing those changes and moving the ref locking from
_commit() to _update_ref() you will risk reflog corruption/surprises
if two operations collide and both rewrite the reflog without any lock held.


> which is how the reflog file is
> locked. But the lock_file code still does some of the bookkeeping for
> us and is more careful than the old code here was.
>
> For example:
>
> * Correctly handle the case that the reflog lock file already exists
>   for some reason or cannot be opened.
>
> * Correctly clean up the lockfile if the program dies.
>
> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
> ---
>  builtin/reflog.c | 37 ++++++++++++++++++++++---------------
>  1 file changed, 22 insertions(+), 15 deletions(-)
>
> diff --git a/builtin/reflog.c b/builtin/reflog.c
> index a282e60..d344d45 100644
> --- a/builtin/reflog.c
> +++ b/builtin/reflog.c
> @@ -349,12 +349,14 @@ static int push_tip_to_list(const char *refname, const unsigned char *sha1, int
>         return 0;
>  }
>
> +static struct lock_file reflog_lock;
> +
>  static int expire_reflog(const char *refname, const unsigned char *sha1, void *cb_data)
>  {
>         struct cmd_reflog_expire_cb *cmd = cb_data;
>         struct expire_reflog_cb cb;
>         struct ref_lock *lock;
> -       char *log_file, *newlog_path = NULL;
> +       char *log_file;
>         struct commit *tip_commit;
>         struct commit_list *tips;
>         int status = 0;
> @@ -372,10 +374,14 @@ static int expire_reflog(const char *refname, const unsigned char *sha1, void *c
>                 unlock_ref(lock);
>                 return 0;
>         }
> +
>         log_file = git_pathdup("logs/%s", refname);
>         if (!cmd->dry_run) {
> -               newlog_path = git_pathdup("logs/%s.lock", refname);
> -               cb.newlog = fopen(newlog_path, "w");
> +               if (hold_lock_file_for_update(&reflog_lock, log_file, 0) < 0)
> +                       goto failure;
> +               cb.newlog = fdopen_lock_file(&reflog_lock, "w");
> +               if (!cb.newlog)
> +                       goto failure;
>         }
>
>         cb.cmd = cmd;
> @@ -423,10 +429,9 @@ static int expire_reflog(const char *refname, const unsigned char *sha1, void *c
>         }
>
>         if (cb.newlog) {
> -               if (fclose(cb.newlog)) {
> -                       status |= error("%s: %s", strerror(errno),
> -                                       newlog_path);
> -                       unlink(newlog_path);
> +               if (close_lock_file(&reflog_lock)) {
> +                       status |= error("Couldn't write %s: %s", log_file,
> +                                       strerror(errno));
>                 } else if (cmd->updateref &&
>                         (write_in_full(lock->lock_fd,
>                                 sha1_to_hex(cb.last_kept_sha1), 40) != 40 ||
> @@ -434,21 +439,23 @@ static int expire_reflog(const char *refname, const unsigned char *sha1, void *c
>                          close_ref(lock) < 0)) {
>                         status |= error("Couldn't write %s",
>                                         lock->lk->filename.buf);
> -                       unlink(newlog_path);
> -               } else if (rename(newlog_path, log_file)) {
> -                       status |= error("cannot rename %s to %s",
> -                                       newlog_path, log_file);
> -                       unlink(newlog_path);
> +                       rollback_lock_file(&reflog_lock);
> +               } else if (commit_lock_file(&reflog_lock)) {
> +                       status |= error("cannot rename %s.lock to %s",
> +                                       log_file, log_file);
>                 } else if (cmd->updateref && commit_ref(lock)) {
>                         status |= error("Couldn't set %s", lock->ref_name);
> -               } else {
> -                       adjust_shared_perm(log_file);
>                 }
>         }
> -       free(newlog_path);
>         free(log_file);
>         unlock_ref(lock);
>         return status;
> +
> + failure:
> +       rollback_lock_file(&reflog_lock);
> +       free(log_file);
> +       unlock_ref(lock);
> +       return -1;
>  }
>
>  static int collect_reflog(const char *ref, const unsigned char *sha1, int unused, void *cb_data)
> --
> 2.1.3
>
