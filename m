From: Ronnie Sahlberg <sahlberg@google.com>
Subject: Re: [PATCH v11 39/41] refs.c: propagate any errno==ENOTDIR from
 _commit back to the callers
Date: Tue, 3 Jun 2014 11:21:37 -0700
Message-ID: <CAL=YDWm9UtD0fLS0RjaQYxAk5OMGcDmoC4QK5NrzMQjXOGuWjQ@mail.gmail.com>
References: <1401222360-21175-1-git-send-email-sahlberg@google.com>
	<1401222360-21175-40-git-send-email-sahlberg@google.com>
	<20140531002230.GL12314@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 03 20:21:44 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WrtLD-0002De-Sj
	for gcvg-git-2@plane.gmane.org; Tue, 03 Jun 2014 20:21:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754275AbaFCSVk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Jun 2014 14:21:40 -0400
Received: from mail-vc0-f169.google.com ([209.85.220.169]:55914 "EHLO
	mail-vc0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753924AbaFCSVj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jun 2014 14:21:39 -0400
Received: by mail-vc0-f169.google.com with SMTP id il7so3627219vcb.0
        for <git@vger.kernel.org>; Tue, 03 Jun 2014 11:21:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=HHQ/7RUHjrWUzX7Udxn/srOEcCL/r4emp4sou1ZpWTk=;
        b=Vv5QmkVoADINOUAKJL0P5EHs9/+5qFHr+S71SIDnUJedE1U/Dg9qW8JTkr0r2dXZ8k
         dq0Vyu5L6eD+9a1PEfDlsU6VM+EVHs1t7/H4LXgbdGIZgE7rMaKhcMugrkr1GhdkicJU
         es0ghDbA//33Fc1v6Qr/tZ0iHVJsAAvzNsh+4BbYY4hw7K443427w4Y49g63wzGcj2dc
         vY6BfOYZcU1jVVVHnkNz2iM48hhGJ7C48kYgRxf6ohTXnigw3aP4Tba40BgQ7VutUa9e
         VExfjzvaX4UMuSwNTfhsUA/Hnt5jq6djs7YkJCYFYJzhkeQ2NtCgO8v3nhTxxRMdFn/6
         0rrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=HHQ/7RUHjrWUzX7Udxn/srOEcCL/r4emp4sou1ZpWTk=;
        b=M6aZeGiZ/feH17Tz1Zfj1yqhO0gvYqmpftlGoCvAyrrcvHyU3RcO0YmZeclqperFS+
         hwj/cH1V/8CcjlR6VQn3ovJzfppgmGRRr3Vof8g2q4AEwOVF+sNYqoIH5W03Po/vhdWb
         nELLmd6UyWX3BKZOwi8QjYg7hBalqX2U2g7rAOCvEM5n9UJWttk1fBPrydqJsLk3YJnn
         vmPo4wefK2EK0TmfiXGbCVJgHcND4Q4fpkz9Oe76DSaR5HwfriQ8771SS3HmQQi1DwQS
         01bDC4eLVZB9+1BXbXePDNYkBaV7rqoL44CAsWEAB1BvuNbM3/SlQ4e8NDaZRT2NLS6Z
         dUjw==
X-Gm-Message-State: ALoCoQnLU/JHiT4OJ7NrGebNyvZzI9PWUqNv8QeM/6YOEvhoDcRYdEaiDQ/oHLOk5SoOrcUILpL6
X-Received: by 10.58.56.71 with SMTP id y7mr38984185vep.24.1401819697920; Tue,
 03 Jun 2014 11:21:37 -0700 (PDT)
Received: by 10.52.255.65 with HTTP; Tue, 3 Jun 2014 11:21:37 -0700 (PDT)
In-Reply-To: <20140531002230.GL12314@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250634>

On Fri, May 30, 2014 at 5:22 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> Hi,
>
> Ronnie Sahlberg wrote:
>
>> For these cases, save the errno value and abort and make sure that the caller
>> can see errno==ENOTDIR.
>>
>> Also start defining specific return codes for _commit, assign -1 as a generic
>> error and -2 as the error that refers to a name conflict. Callers can (and
>> should) use that return value inspecting errno directly.
>
> Heh.  Here's a patch on top to hopefully finish that part of the job.

Thanks. Updated.

>
> Unfortunately, the value of errno after calling lock_ref_sha1_basic is
> not reliable.

I have changed the patch for lock_ref_sha1_basic so it now does :
  if (check_refname_format(refname, REFNAME_ALLOW_ONELEVEL)) {
    errno = EINVAL;
    return NULL;
  }

so this function should no longer fail without changing errno to a,
hopefully, sane value.


> http://thread.gmane.org/gmane.comp.version-control.git/249159/focus=249407
> lists the error paths that are broken (marked with "[!]" in that
> message).
>
> diff --git i/builtin/fetch.c w/builtin/fetch.c
> index b13e8f9..0a01cda 100644
> --- i/builtin/fetch.c
> +++ w/builtin/fetch.c
> @@ -377,6 +377,7 @@ static int s_update_ref(const char *action,
>         char *rla = getenv("GIT_REFLOG_ACTION");
>         struct ref_transaction *transaction;
>         struct strbuf err = STRBUF_INIT;
> +       int ret, df_conflict = 0;
>
>         if (dry_run)
>                 return 0;
> @@ -387,16 +388,22 @@ static int s_update_ref(const char *action,
>         transaction = ref_transaction_begin(&err);
>         if (!transaction ||
>             ref_transaction_update(transaction, ref->name, ref->new_sha1,
> -                                  ref->old_sha1, 0, check_old, msg, &err) ||
> -           ref_transaction_commit(transaction, &err)) {
> -               ref_transaction_free(transaction);
> -               error("%s", err.buf);
> -               strbuf_release(&err);
> -               return errno == ENOTDIR ? STORE_REF_ERROR_DF_CONFLICT :
> -                                         STORE_REF_ERROR_OTHER;
> -       }
> +                                  ref->old_sha1, 0, check_old, msg, &err))
> +               goto fail;
> +
> +       ret = ref_transaction_commit(transaction, &err);
> +       if (ret == UPDATE_REFS_NAME_CONFLICT)
> +               df_conflict = 1;
> +       if (ret)
> +               goto fail;
>         ref_transaction_free(transaction);
>         return 0;
> +fail:
> +       ref_transaction_free(transaction);
> +       error("%s", err.buf);
> +       strbuf_release(&err);
> +       return df_conflict ? STORE_REF_ERROR_DF_CONFLICT
> +                          : STORE_REF_ERROR_OTHER;
>  }
>
>  #define REFCOL_WIDTH  10
> diff --git i/refs.c w/refs.c
> index dbaabba..b22b99b 100644
> --- i/refs.c
> +++ w/refs.c
> @@ -3499,7 +3499,7 @@ static int ref_update_reject_duplicates(struct ref_update **updates, int n,
>  int ref_transaction_commit(struct ref_transaction *transaction,
>                            struct strbuf *err)
>  {
> -       int ret = 0, delnum = 0, i, save_errno = 0;
> +       int ret = 0, delnum = 0, i, df_conflict = 0;
>         const char **delnames;
>         int n = transaction->nr;
>         struct ref_update **updates = transaction->updates;
> @@ -3535,7 +3535,7 @@ int ref_transaction_commit(struct ref_transaction *transaction,
>                                                    delnames, delnum);
>                 if (!update->lock) {
>                         if (errno == ENOTDIR)
> -                               save_errno = errno;
> +                               df_conflict = 1;
>                         if (err)
>                                 strbuf_addf(err, "Cannot lock the ref '%s'.",
>                                             update->refname);
> @@ -3590,8 +3590,7 @@ cleanup:
>                 if (updates[i]->lock)
>                         unlock_ref(updates[i]->lock);
>         free(delnames);
> -       errno = save_errno;
> -       if (save_errno == ENOTDIR)
> +       if (df_conflict)
>                 ret = -2;
>         return ret;
>  }
> diff --git i/refs.h w/refs.h
> index 88732a1..1583097 100644
> --- i/refs.h
> +++ w/refs.h
> @@ -325,9 +325,11 @@ int ref_transaction_delete(struct ref_transaction *transaction,
>   * problem.
>   * If the transaction is already in failed state this function will return
>   * an error.
> - * Function returns 0 on success, -1 for generic failures and -2 if the
> - * failure was due to a name collision (ENOTDIR).
> + * Function returns 0 on success, -1 for generic failures and
> + * UPDATE_REFS_NAME_CONFLICT (-2) if the failure was due to a name
> + * collision (ENOTDIR).
>   */
> +#define UPDATE_REFS_NAME_CONFLICT -2
>  int ref_transaction_commit(struct ref_transaction *transaction,
>                            struct strbuf *err);
>
