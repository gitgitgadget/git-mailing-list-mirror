From: Michael Blume <blume.mike@gmail.com>
Subject: Re: [PATCH v2 34/43] refs.c: make struct ref_transaction generic
Date: Tue, 6 Oct 2015 10:43:00 -0700
Message-ID: <CAO2U3QhdzLfx8qfnOHgXTWit5x7+TQNn0=xozouA4m-0+B1rtw@mail.gmail.com>
References: <1443477738-32023-1-git-send-email-dturner@twopensource.com> <1443477738-32023-35-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, mhagger@alum.mit.edu
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Tue Oct 06 19:43:29 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZjWGu-0000HW-GG
	for gcvg-git-2@plane.gmane.org; Tue, 06 Oct 2015 19:43:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752909AbbJFRnY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Oct 2015 13:43:24 -0400
Received: from mail-io0-f182.google.com ([209.85.223.182]:32845 "EHLO
	mail-io0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752770AbbJFRnU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Oct 2015 13:43:20 -0400
Received: by iofh134 with SMTP id h134so230789968iof.0
        for <git@vger.kernel.org>; Tue, 06 Oct 2015 10:43:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=ST4eBf6tx1q34yBlh88TgYzVeJJqmDFQY7dSv4QrpJc=;
        b=ye1AojtohJ8lex0EUHbDTeF5BQFEffnBcMXxKIv+F15epKUsQHDykXPuvex8Z91THa
         KSf0dQwndHD807S0tDMC0IctDpVvTYGfIZEhtKdqsDK4mpsFgUwrJFEdczPsbKnfukWy
         Eu+nrZx9mJsnh2G4WMSGwJv3CFyOhRBmhGjgI4L8kjO4Qf5HeR4rWBLWWp7JVKcuB4mv
         HWu9Wx7CHA2eTLGVsutACqJ2RSdd08GYb6n9uTjSsLquunDy01TpOobWGgPCVtPhKhJq
         RgOpiB94g4mAvG/v/6zTeij5ml1ZPBQFAQPJ1JT8lgkX93PIAQNU13D0ueRwi2vIYDes
         MDYQ==
X-Received: by 10.107.135.218 with SMTP id r87mr35546886ioi.153.1444153399412;
 Tue, 06 Oct 2015 10:43:19 -0700 (PDT)
Received: by 10.36.62.65 with HTTP; Tue, 6 Oct 2015 10:43:00 -0700 (PDT)
In-Reply-To: <1443477738-32023-35-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279155>

This triggers a lot of build warnings on my mac, basically in every
file that uses refs.h:

    CC archive.o
In file included from archive.c:2:
./refs.h:635:16: warning: redefinition of typedef
'ref_transaction_free_fn' is a C11 feature [-Wtypedef-redefinition]
typedef void (*ref_transaction_free_fn)(struct ref_transaction *transaction);
               ^
./refs.h:613:16: note: previous definition is here
typedef void (*ref_transaction_free_fn)(struct ref_transaction *transaction);
               ^
1 warning generated.

On Mon, Sep 28, 2015 at 3:02 PM, David Turner <dturner@twopensource.com> wrote:
> Alternate ref backends might need different data for transactions.  Make
> struct ref_transaction an empty struct, and let backends define their
> own structs which extend it.
>
> Signed-off-by: David Turner <dturner@twopensource.com>
> ---
>  refs-be-files.c | 24 +++++++++++++++++-------
>  refs.h          |  8 ++++++--
>  2 files changed, 23 insertions(+), 9 deletions(-)
>
> diff --git a/refs-be-files.c b/refs-be-files.c
> index 0a76c8e..3f2d194 100644
> --- a/refs-be-files.c
> +++ b/refs-be-files.c
> @@ -3218,7 +3218,8 @@ enum ref_transaction_state {
>   * consist of checks and updates to multiple references, carried out
>   * as atomically as possible.  This structure is opaque to callers.
>   */
> -struct ref_transaction {
> +struct files_ref_transaction {
> +       struct ref_transaction base;
>         struct ref_update **updates;
>         size_t alloc;
>         size_t nr;
> @@ -3229,13 +3230,16 @@ static struct ref_transaction *files_transaction_begin(struct strbuf *err)
>  {
>         assert(err);
>
> -       return xcalloc(1, sizeof(struct ref_transaction));
> +       return xcalloc(1, sizeof(struct files_ref_transaction));
>  }
>
> -static void files_transaction_free(struct ref_transaction *transaction)
> +static void files_transaction_free(struct ref_transaction *trans)
>  {
>         int i;
>
> +       struct files_ref_transaction *transaction =
> +               (struct files_ref_transaction *)trans;
> +
>         if (!transaction)
>                 return;
>
> @@ -3247,7 +3251,7 @@ static void files_transaction_free(struct ref_transaction *transaction)
>         free(transaction);
>  }
>
> -static struct ref_update *add_update(struct ref_transaction *transaction,
> +static struct ref_update *add_update(struct files_ref_transaction *transaction,
>                                      const char *refname)
>  {
>         size_t len = strlen(refname) + 1;
> @@ -3259,7 +3263,7 @@ static struct ref_update *add_update(struct ref_transaction *transaction,
>         return update;
>  }
>
> -static int files_transaction_update(struct ref_transaction *transaction,
> +static int files_transaction_update(struct ref_transaction *trans,
>                                   const char *refname,
>                                   const unsigned char *new_sha1,
>                                   const unsigned char *old_sha1,
> @@ -3267,6 +3271,8 @@ static int files_transaction_update(struct ref_transaction *transaction,
>                                   struct strbuf *err)
>  {
>         struct ref_update *update;
> +       struct files_ref_transaction *transaction =
> +               (struct files_ref_transaction *)trans;
>
>         assert(err);
>
> @@ -3350,10 +3356,12 @@ static int ref_update_reject_duplicates(struct string_list *refnames,
>         return 0;
>  }
>
> -static int files_transaction_commit(struct ref_transaction *transaction,
> +static int files_transaction_commit(struct ref_transaction *trans,
>                                   struct strbuf *err)
>  {
>         int ret = 0, i;
> +       struct files_ref_transaction *transaction =
> +               (struct files_ref_transaction *)trans;
>         int n = transaction->nr;
>         struct ref_update **updates = transaction->updates;
>         struct string_list refs_to_delete = STRING_LIST_INIT_NODUP;
> @@ -3517,10 +3525,12 @@ static int ref_present(const char *refname,
>         return string_list_has_string(affected_refnames, refname);
>  }
>
> -static int files_initial_transaction_commit(struct ref_transaction *transaction,
> +static int files_initial_transaction_commit(struct ref_transaction *trans,
>                                             struct strbuf *err)
>  {
>         int ret = 0, i;
> +       struct files_ref_transaction *transaction =
> +               (struct files_ref_transaction *)trans;
>         int n = transaction->nr;
>         struct ref_update **updates = transaction->updates;
>         struct string_list affected_refnames = STRING_LIST_INIT_NODUP;
> diff --git a/refs.h b/refs.h
> index 64dba64..02001ef 100644
> --- a/refs.h
> +++ b/refs.h
> @@ -130,7 +130,7 @@ extern int dwim_log(const char *str, int len, unsigned char *sha1, char **ref);
>   *
>   * Calling sequence
>   * ----------------
> - * - Allocate and initialize a `struct ref_transaction` by calling
> + * - Allocate and initialize a transaction by calling
>   *   `ref_transaction_begin()`.
>   *
>   * - List intended ref updates by calling functions like
> @@ -156,7 +156,10 @@ extern int dwim_log(const char *str, int len, unsigned char *sha1, char **ref);
>   * The message is appended to err without first clearing err.
>   * err will not be '\n' terminated.
>   */
> -struct ref_transaction;
> +
> +struct ref_transaction {
> +       /* ref backends should extend this */
> +};
>
>  /*
>   * Bit values set in the flags argument passed to each_ref_fn():
> @@ -629,6 +632,7 @@ typedef int (*reflog_expire_fn)(const char *refname, const unsigned char *sha1,
>                                 void *policy_cb_data);
>
>  /* resolution functions */
> +typedef void (*ref_transaction_free_fn)(struct ref_transaction *transaction);
>  typedef const char *(*resolve_ref_unsafe_fn)(const char *ref,
>                                              int resolve_flags,
>                                              unsigned char *sha1, int *flags);
> --
> 2.4.2.644.g97b850b-twtrsrc
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
