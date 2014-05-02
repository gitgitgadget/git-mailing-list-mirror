From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v6 40/42] refs.c: pass a skip list to name_conflict_fn
Date: Fri, 2 May 2014 00:22:53 -0400
Message-ID: <CAPig+cQj92paVQDb14Wi602NME4dvJzpVeB_SVeJKVe32kqF4w@mail.gmail.com>
References: <1398976662-6962-1-git-send-email-sahlberg@google.com>
	<1398976662-6962-41-git-send-email-sahlberg@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Ronnie Sahlberg <sahlberg@google.com>
X-From: git-owner@vger.kernel.org Fri May 02 06:23:02 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wg502-0006BD-7N
	for gcvg-git-2@plane.gmane.org; Fri, 02 May 2014 06:23:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750826AbaEBEWz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 May 2014 00:22:55 -0400
Received: from mail-yh0-f48.google.com ([209.85.213.48]:58074 "EHLO
	mail-yh0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750731AbaEBEWy (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 May 2014 00:22:54 -0400
Received: by mail-yh0-f48.google.com with SMTP id v1so3726154yhn.35
        for <git@vger.kernel.org>; Thu, 01 May 2014 21:22:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=pP4xo0eNL/KwBQ93fNBiysTQMTQjJtBPQS+fBVFhxgE=;
        b=J9aJjGPWI4LEqbiSzPS/8MkF0I6tz07vNG+W4mUSFh3pM7+lEGH3vERaWDJPvESuMf
         qVJL72DtOR6ght+LQwA6OSXt95yNm6iE8b8BC9FtpOQ4OrtM+Qjtu/4GMXNw6zfPq2nG
         ZAt6O/Y6CERrMMD/GkipFpMEiSoUrZNTlIPIf9kSQgA3DKY/QdtFn50pVBa76pqtbBef
         7h0ZDm0+YmseocT7suqb1JH6NU6M4UoBUMff1Vs/T+oVEMFe6a4pJH5BUv1XdquBc6uh
         0x0qEyPFAI3/GwxJLDGyhLtm2PM8dMKkjzBS5ZMgpmNDwQnmfj1FD4N8+xemKV0l0BPU
         UZAg==
X-Received: by 10.236.143.229 with SMTP id l65mr20168852yhj.95.1399004574034;
 Thu, 01 May 2014 21:22:54 -0700 (PDT)
Received: by 10.170.163.66 with HTTP; Thu, 1 May 2014 21:22:53 -0700 (PDT)
In-Reply-To: <1398976662-6962-41-git-send-email-sahlberg@google.com>
X-Google-Sender-Auth: 9fvEjGXAe4X41jH1wCF51LF1ApY
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247923>

On Thu, May 1, 2014 at 4:37 PM, Ronnie Sahlberg <sahlberg@google.com> wrote:
> Allow passing a list of refs to ckip checking to name_conflict_fn.

s/ckip/skip/

> There are some conditions where we want to allow a temporary conflict and skip
> checking those refs. For example if we have a transaction that
> 1, guarantees that m is a packed refs and there is no loose ref for m
> 2, the transaction will delete m from the packed ref
> 3, the transaction will create conflicting m/m
>
> For this case we want to be able to lock anc create m/m since we know that the

s/anc/and/

> conflict is only transient. I.e. the conflict will be automatically resolved
> by the transaction when it deletes m.
>
> Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
> ---
>  refs.c | 43 +++++++++++++++++++++++++++++++++----------
>  1 file changed, 33 insertions(+), 10 deletions(-)
>
> diff --git a/refs.c b/refs.c
> index b525076..eb75927 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -789,11 +789,19 @@ struct name_conflict_cb {
>         const char *refname;
>         const char *oldrefname;
>         const char *conflicting_refname;
> +       const char **skip;
> +       int skipnum;
>  };
>
>  static int name_conflict_fn(struct ref_entry *entry, void *cb_data)
>  {
>         struct name_conflict_cb *data = (struct name_conflict_cb *)cb_data;
> +       int i;
> +       for(i = 0; i < data->skipnum; i++) {
> +               if (!strcmp(entry->name, data->skip[i])) {
> +                       return 0;
> +               }
> +       }
>         if (data->oldrefname && !strcmp(data->oldrefname, entry->name))
>                 return 0;
>         if (names_conflict(data->refname, entry->name)) {
> @@ -808,15 +816,21 @@ static int name_conflict_fn(struct ref_entry *entry, void *cb_data)
>   * conflicting with the name of an existing reference in dir.  If
>   * oldrefname is non-NULL, ignore potential conflicts with oldrefname
>   * (e.g., because oldrefname is scheduled for deletion in the same
> - * operation).
> + * operation). skip contains a list of refs we want to skip checking for
> + * conflicts with. Refs may be skipped due to us knowing that it will
> + * be deleted later during a transaction that deletes one reference and then
> + * creates a new conflicting reference. For example a rename from m to m/m.
>   */
>  static int is_refname_available(const char *refname, const char *oldrefname,
> -                               struct ref_dir *dir)
> +                               struct ref_dir *dir,
> +                               const char **skip, int skipnum)
>  {
>         struct name_conflict_cb data;
>         data.refname = refname;
>         data.oldrefname = oldrefname;
>         data.conflicting_refname = NULL;
> +       data.skip = skip;
> +       data.skipnum = skipnum;
>
>         sort_ref_dir(dir);
>         if (do_for_each_entry_in_dir(dir, 0, name_conflict_fn, &data)) {
> @@ -2032,7 +2046,8 @@ int dwim_log(const char *str, int len, unsigned char *sha1, char **log)
>
>  static struct ref_lock *lock_ref_sha1_basic(const char *refname,
>                                             const unsigned char *old_sha1,
> -                                           int flags, int *type_p)
> +                                           int flags, int *type_p,
> +                                           const char **skip, int skipnum)
>  {
>         char *ref_file;
>         const char *orig_refname = refname;
> @@ -2079,7 +2094,9 @@ static struct ref_lock *lock_ref_sha1_basic(const char *refname,
>          * name is a proper prefix of our refname.
>          */
>         if (missing &&
> -            !is_refname_available(refname, NULL, get_packed_refs(&ref_cache))) {
> +            !is_refname_available(refname, NULL,
> +                                  get_packed_refs(&ref_cache),
> +                                  skip, skipnum)) {
>                 last_errno = ENOTDIR;
>                 goto error_return;
>         }
> @@ -2137,7 +2154,7 @@ struct ref_lock *lock_any_ref_for_update(const char *refname,
>                                          const unsigned char *old_sha1,
>                                          int flags, int *type_p)
>  {
> -       return lock_ref_sha1_basic(refname, old_sha1, flags, type_p);
> +       return lock_ref_sha1_basic(refname, old_sha1, flags, type_p, NULL, 0);
>  }
>
>  /*
> @@ -2576,6 +2593,9 @@ int rename_ref(const char *oldrefname, const char *newrefname, const char *logms
>         int log = !lstat(git_path("logs/%s", oldrefname), &loginfo);
>         const char *symref = NULL;
>
> +       if (!strcmp(oldrefname, newrefname))
> +               return 0;
> +
>         if (log && S_ISLNK(loginfo.st_mode))
>                 return error("reflog for %s is a symlink", oldrefname);
>
> @@ -2586,10 +2606,12 @@ int rename_ref(const char *oldrefname, const char *newrefname, const char *logms
>         if (!symref)
>                 return error("refname %s not found", oldrefname);
>
> -       if (!is_refname_available(newrefname, oldrefname, get_packed_refs(&ref_cache)))
> +       if (!is_refname_available(newrefname, oldrefname,
> +                                 get_packed_refs(&ref_cache), NULL, 0))
>                 return 1;
>
> -       if (!is_refname_available(newrefname, oldrefname, get_loose_refs(&ref_cache)))
> +       if (!is_refname_available(newrefname, oldrefname,
> +                                 get_loose_refs(&ref_cache), NULL, 0))
>                 return 1;
>
>         if (log && rename(git_path("logs/%s", oldrefname), git_path(TMP_RENAMED_LOG)))
> @@ -2622,7 +2644,7 @@ int rename_ref(const char *oldrefname, const char *newrefname, const char *logms
>
>         logmoved = log;
>
> -       lock = lock_ref_sha1_basic(newrefname, NULL, 0, NULL);
> +       lock = lock_ref_sha1_basic(newrefname, NULL, 0, NULL, NULL, 0);
>         if (!lock) {
>                 error("unable to lock %s for update", newrefname);
>                 goto rollback;
> @@ -2637,7 +2659,7 @@ int rename_ref(const char *oldrefname, const char *newrefname, const char *logms
>         return 0;
>
>   rollback:
> -       lock = lock_ref_sha1_basic(oldrefname, NULL, 0, NULL);
> +       lock = lock_ref_sha1_basic(oldrefname, NULL, 0, NULL, NULL, 0);
>         if (!lock) {
>                 error("unable to lock %s for rollback", oldrefname);
>                 goto rollbacklog;
> @@ -3483,7 +3505,8 @@ int ref_transaction_commit(struct ref_transaction *transaction,
>                                                     update->old_sha1 :
>                                                     NULL),
>                                                    update->flags,
> -                                                  &update->type);
> +                                                  &update->type,
> +                                                  delnames, delnum);
>                 if (!update->lock) {
>                         if (err)
>                                 strbuf_addf(err ,"Cannot lock the ref '%s'.",
> --
> 2.0.0.rc1.351.g4d2c8e4
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
