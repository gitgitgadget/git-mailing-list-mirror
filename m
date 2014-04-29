From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v4 08/27] refs.c: change ref_transaction_update() to do
 error checking and return status
Date: Mon, 28 Apr 2014 20:51:41 -0400
Message-ID: <CAPig+cQM-5_N5caoJVRY0+VcPXO0qhnv7hetdanOoqRQJkm3jQ@mail.gmail.com>
References: <1398725682-30782-1-git-send-email-sahlberg@google.com>
	<1398725682-30782-9-git-send-email-sahlberg@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Ronnie Sahlberg <sahlberg@google.com>
X-From: git-owner@vger.kernel.org Tue Apr 29 02:51:47 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WewGw-0005Sq-EX
	for gcvg-git-2@plane.gmane.org; Tue, 29 Apr 2014 02:51:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756186AbaD2Avn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Apr 2014 20:51:43 -0400
Received: from mail-yk0-f173.google.com ([209.85.160.173]:51992 "EHLO
	mail-yk0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753706AbaD2Avm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Apr 2014 20:51:42 -0400
Received: by mail-yk0-f173.google.com with SMTP id 131so1513520ykp.32
        for <git@vger.kernel.org>; Mon, 28 Apr 2014 17:51:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=qqQ7eTNS9ebXTPo885Arva/uNeg56PWVmmXyu+9cdBE=;
        b=Uo+ce2bd4DahNLe2vG3lh38U7DM4i7dmHCX18l69qZp+3blPuFEWoFE/XARi5Ij6do
         2rsM4sVAFj5N1C1wSTX2ZGT8CgANODfutRaKs+FKb2YmuL82CQeLnLmyeD84GOR0Lmp6
         bzV7gM0mL4dosc8VEiLTc4akFfCDc/yBcYjSlh8GaXI1RpnhrHOzLUj0ECbNON+fAimI
         wuSMmw7l6u5PBtPCS5p10pWIp06d6qjkwPW1VaZQ2OmnUFWGZmjfO4BwQEzv+E13AVY2
         hw3pZSn8CuGTFkfS8l7Si31CxSEWIzbk8m3li45iTRRz30TKV9ZwRVnnppvX68+Ky8SB
         WfJw==
X-Received: by 10.236.60.162 with SMTP id u22mr8964460yhc.93.1398732701603;
 Mon, 28 Apr 2014 17:51:41 -0700 (PDT)
Received: by 10.170.163.66 with HTTP; Mon, 28 Apr 2014 17:51:41 -0700 (PDT)
In-Reply-To: <1398725682-30782-9-git-send-email-sahlberg@google.com>
X-Google-Sender-Auth: DJaKf31OODHt9TskLsorDnfMdLU
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247504>

On Mon, Apr 28, 2014 at 6:54 PM, Ronnie Sahlberg <sahlberg@google.com> wrote:
> Update ref_transaction_update() do some basic error checking and return
> true on error. Update all callers to check ref_transaction_update() for error.
>
> Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
> ---
>  builtin/update-ref.c | 10 ++++++----
>  refs.c               |  9 +++++++--
>  refs.h               | 10 +++++-----
>  3 files changed, 18 insertions(+), 11 deletions(-)
>
> diff --git a/builtin/update-ref.c b/builtin/update-ref.c
> index 2bef2a0..59c4d6b 100644
> --- a/builtin/update-ref.c
> +++ b/builtin/update-ref.c
> @@ -197,8 +197,9 @@ static const char *parse_cmd_update(struct strbuf *input, const char *next)
>         if (*next != line_termination)
>                 die("update %s: extra input: %s", refname, next);
>
> -       ref_transaction_update(transaction, refname, new_sha1, old_sha1,
> -                              update_flags, have_old);
> +       if (ref_transaction_update(transaction, refname, new_sha1, old_sha1,
> +                                  update_flags, have_old))
> +               die("update %s: failed", refname);
>
>         update_flags = 0;
>         free(refname);
> @@ -286,8 +287,9 @@ static const char *parse_cmd_verify(struct strbuf *input, const char *next)
>         if (*next != line_termination)
>                 die("verify %s: extra input: %s", refname, next);
>
> -       ref_transaction_update(transaction, refname, new_sha1, old_sha1,
> -                              update_flags, have_old);
> +       if (ref_transaction_update(transaction, refname, new_sha1, old_sha1,
> +                                  update_flags, have_old))
> +               die("failed transaction update for %s", refname);
>
>         update_flags = 0;
>         free(refname);
> diff --git a/refs.c b/refs.c
> index 308e13e..1a903fb 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -3333,19 +3333,24 @@ static struct ref_update *add_update(struct ref_transaction *transaction,
>         return update;
>  }
>
> -void ref_transaction_update(struct ref_transaction *transaction,
> +int ref_transaction_update(struct ref_transaction *transaction,
>                             const char *refname,
>                             const unsigned char *new_sha1,
>                             const unsigned char *old_sha1,
>                             int flags, int have_old)
>  {
> -       struct ref_update *update = add_update(transaction, refname);
> +       struct ref_update *update;
> +
> +       if (have_old && !old_sha1)
> +               die("have_old is true but old_sha1 is NULL");
>
> +       update = add_update(transaction, refname);
>         hashcpy(update->new_sha1, new_sha1);
>         update->flags = flags;
>         update->have_old = have_old;
>         if (have_old)
>                 hashcpy(update->old_sha1, old_sha1);
> +       return 0;

Am I misreading? The commit message talks about returning true on
error, but this code seems to only ever die() or return 0 (false).

>  }
>
>  void ref_transaction_create(struct ref_transaction *transaction,
> diff --git a/refs.h b/refs.h
> index bc7715e..0364a3e 100644
> --- a/refs.h
> +++ b/refs.h
> @@ -237,11 +237,11 @@ void ref_transaction_rollback(struct ref_transaction *transaction);
>   * that the reference should have had before the update, or zeros if
>   * it must not have existed beforehand.
>   */
> -void ref_transaction_update(struct ref_transaction *transaction,
> -                           const char *refname,
> -                           const unsigned char *new_sha1,
> -                           const unsigned char *old_sha1,
> -                           int flags, int have_old);
> +int ref_transaction_update(struct ref_transaction *transaction,
> +                          const char *refname,
> +                          const unsigned char *new_sha1,
> +                          const unsigned char *old_sha1,
> +                          int flags, int have_old);
>
>  /*
>   * Add a reference creation to transaction.  new_sha1 is the value
> --
> 1.9.1.528.g98b8868.dirty
