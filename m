From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH v2 07/24] expire_reflog(): use a lock_file for rewriting
 the reflog file
Date: Fri, 12 Dec 2014 10:57:27 -0800
Message-ID: <CAGZ79kaPzMPcxMqsTeW5LjYNc7LbpjHE5eBPHWKvUkBU3NvGJw@mail.gmail.com>
References: <1418374623-5566-1-git-send-email-mhagger@alum.mit.edu>
	<1418374623-5566-8-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Fri Dec 12 19:57:35 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XzVPB-0004qh-1c
	for gcvg-git-2@plane.gmane.org; Fri, 12 Dec 2014 19:57:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755627AbaLLS52 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Dec 2014 13:57:28 -0500
Received: from mail-ie0-f178.google.com ([209.85.223.178]:64860 "EHLO
	mail-ie0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752471AbaLLS52 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Dec 2014 13:57:28 -0500
Received: by mail-ie0-f178.google.com with SMTP id tp5so7276752ieb.23
        for <git@vger.kernel.org>; Fri, 12 Dec 2014 10:57:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=IGlKQfkybmkgJQqgowpHTre4BOtyzqFYYdfcpfiwyNM=;
        b=VKnHNSMD10QhK6lxgd9CnLRjAKIgJdGIIamuudGEK7enxqAHPZZG1uvk9kUNelzKf5
         gxy2MZ9FOAE1FVSXx8vAMD8om4OUthpufb/Xexiflo9vV5D2nuPwSKkEhErhBL6JdZ4r
         z8+HWU5aambG7yU5XChyw5kolfdByzZei7vtox8qsvSLUOlWJnJWT0vUR8HC04EBUV23
         w41iow1jrIv4TiHJhGJqB4y3YRwEIu/LW0i1rNIfy4WPBctBIx6+wyoVGXWRU6D6klP3
         pV1ViiTGqLI9KbHnsDn+Xo29+Cp/Emg/F/lvlIzp+6NLSYS3yCwuNGKvaPdYt5ruyRg0
         kWzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=IGlKQfkybmkgJQqgowpHTre4BOtyzqFYYdfcpfiwyNM=;
        b=cbsjKYSlKYE+22VYMd0nHoz+mjfDhakXCCmX1XQkx8fL7F9Sjhd86+jwO4ZWJEgi1S
         LPOY3zb78RU0vxcwACfUrir5Sk+9CFW7yL/JxhMeejNYfffdgNrv/Xash3vCGH+3sLia
         vAdF/uJh07t991CQNjk6dE+X9wHwEuGkghw6kHmWudJnJl4w6wvoOmyG5i4ib81Eu//p
         Pc2m0VRXznYFPbcD07uvx0wn8Z5q+zwOqXQE998+AUGVfAB2qQVQBBC/6Uo3+xksrhu9
         khmb9EP4h2Ag2qa9iri+w6IF31ofr29zBEAQoG5QaJCtI1or8JgwtHryQ3EEjM0ke7Un
         QNXA==
X-Gm-Message-State: ALoCoQkx8uCVmd5AhWCKZbia/xRkdMDk51CS0o593TH8CHXRT2tXQgKNDNVaiO9FnQQJWu3PbTYm
X-Received: by 10.50.137.65 with SMTP id qg1mr6107707igb.37.1418410647261;
 Fri, 12 Dec 2014 10:57:27 -0800 (PST)
Received: by 10.107.31.8 with HTTP; Fri, 12 Dec 2014 10:57:27 -0800 (PST)
In-Reply-To: <1418374623-5566-8-git-send-email-mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261357>

On Fri, Dec 12, 2014 at 12:56 AM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
> We don't actually need the locking functionality, because we already
> hold the lock on the reference itself, which is how the reflog file is
> locked. But the lock_file code can do some of the bookkeeping for us,
> and it is more careful than the old code here was. For example:
>
> * It correctly handles the case that the reflog lock file already
>   exists for some reason or cannot be opened.
>
> * It correctly cleans up the lockfile if the program dies.
>
> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
> ---
>  builtin/reflog.c | 60 ++++++++++++++++++++++++++++++++++++++------------------
>  1 file changed, 41 insertions(+), 19 deletions(-)
>
> diff --git a/builtin/reflog.c b/builtin/reflog.c
> index 37b33c9..ba5b3d3 100644
> --- a/builtin/reflog.c
> +++ b/builtin/reflog.c
> @@ -352,9 +352,10 @@ static int push_tip_to_list(const char *refname, const unsigned char *sha1, int
>  static int expire_reflog(const char *refname, const unsigned char *sha1,
>                          struct cmd_reflog_expire_cb *cmd)
>  {
> +       static struct lock_file reflog_lock;
>         struct expire_reflog_cb cb;
>         struct ref_lock *lock;
> -       char *log_file, *newlog_path = NULL;
> +       char *log_file;
>         struct commit *tip_commit;
>         struct commit_list *tips;
>         int status = 0;
> @@ -362,8 +363,9 @@ static int expire_reflog(const char *refname, const unsigned char *sha1,
>         memset(&cb, 0, sizeof(cb));
>
>         /*
> -        * we take the lock for the ref itself to prevent it from
> -        * getting updated.
> +        * The reflog file is locked by holding the lock on the
> +        * reference itself, plus we might need to update the
> +        * reference if --updateref was specified:
>          */
>         lock = lock_any_ref_for_update(refname, sha1, 0, NULL);
>         if (!lock)
> @@ -372,10 +374,29 @@ static int expire_reflog(const char *refname, const unsigned char *sha1,
>                 unlock_ref(lock);
>                 return 0;
>         }
> +
>         log_file = git_pathdup("logs/%s", refname);
>         if (!cmd->dry_run) {
> -               newlog_path = git_pathdup("logs/%s.lock", refname);
> -               cb.newlog = fopen(newlog_path, "w");
> +               /*
> +                * Even though holding $GIT_DIR/logs/$reflog.lock has
> +                * no locking implications, we use the lock_file
> +                * machinery here anyway because it does a lot of the
> +                * work we need, including cleaning up if the program
> +                * exits unexpectedly.
> +                */
> +               if (hold_lock_file_for_update(&reflog_lock, log_file, 0) < 0) {
> +                       struct strbuf err = STRBUF_INIT;
> +                       unable_to_lock_message(log_file, errno, &err);
> +                       error("%s", err.buf);
> +                       strbuf_release(&err);
> +                       goto failure;
> +               }
> +               cb.newlog = fdopen_lock_file(&reflog_lock, "w");
> +               if (!cb.newlog) {
> +                       error("cannot fdopen %s (%s)",
> +                             reflog_lock.filename.buf, strerror(errno));
> +                       goto failure;
> +               }
>         }
>
>         cb.cmd = cmd;
> @@ -423,32 +444,33 @@ static int expire_reflog(const char *refname, const unsigned char *sha1,
>         }
>
>         if (cb.newlog) {
> -               if (fclose(cb.newlog)) {
> -                       status |= error("%s: %s", strerror(errno),
> -                                       newlog_path);
> -                       unlink(newlog_path);
> +               if (close_lock_file(&reflog_lock)) {
> +                       status |= error("couldn't write %s: %s", log_file,
> +                                       strerror(errno));
>                 } else if (cmd->updateref &&
>                         (write_in_full(lock->lock_fd,
>                                 sha1_to_hex(cb.last_kept_sha1), 40) != 40 ||

optional nit:
While being here, you may fix the indentation of the sha1_to_hex to align to the
opening parentheses of write_in_full the line before.

>                          write_str_in_full(lock->lock_fd, "\n") != 1 ||
>                          close_ref(lock) < 0)) {
> -                       status |= error("Couldn't write %s",
> +                       status |= error("couldn't write %s",
>                                         lock->lk->filename.buf);
> -                       unlink(newlog_path);
> -               } else if (rename(newlog_path, log_file)) {
> -                       status |= error("cannot rename %s to %s",
> -                                       newlog_path, log_file);
> -                       unlink(newlog_path);
> +                       rollback_lock_file(&reflog_lock);
> +               } else if (commit_lock_file(&reflog_lock)) {
> +                       status |= error("unable to commit reflog '%s' (%s)",
> +                                       log_file, strerror(errno));
>                 } else if (cmd->updateref && commit_ref(lock)) {
> -                       status |= error("Couldn't set %s", lock->ref_name);
> -               } else {
> -                       adjust_shared_perm(log_file);

So we don't need adjust_shared_perm anymore?

I have been looking at this excerpt for a while now and I am confused by the
first and third statement in the origin/master state as well as after
your changes.
So it's essentially:
  * write out the reflog lock file
  * update ref in the lock file
  * rename the reflog lock into place
  * rename the ref lock into place
  * (in origin/master) if everything went fine, call adjust_shared_perm.
  * In your patch we actually don't need it as on locking the lock
file there is a call
    to  adjust_shared_perm already.

So I think it's clear to me now and looks good. It took me sometime to
understand
it. Maybe that's because I just got up or it's in fact hard to
understand. Would comments
help in laying out the sequence of actions beforehand?

I think the most confusing thing was the close_lock_file as a first
statement in the if chain.
close_lock_file is primarily used here to have the file written out to
disk, but the function
name suggests that the primary functionality is the closing of the fd.


> +                       status |= error("couldn't set %s", lock->ref_name);
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
