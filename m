From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 15/15] refs.c: allow deleting refs with a broken sha1
Date: Wed, 23 Jul 2014 17:22:32 -0400
Message-ID: <CAPig+cS3JETqxMi7bBvyb=kamWyqvPkLXmwsDd_G+K16EDxotw@mail.gmail.com>
References: <1406135035-26441-1-git-send-email-sahlberg@google.com>
	<1406135035-26441-16-git-send-email-sahlberg@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Ronnie Sahlberg <sahlberg@google.com>
X-From: git-owner@vger.kernel.org Wed Jul 23 23:22:45 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XA3zm-0004wN-38
	for gcvg-git-2@plane.gmane.org; Wed, 23 Jul 2014 23:22:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933918AbaGWVWf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jul 2014 17:22:35 -0400
Received: from mail-yk0-f182.google.com ([209.85.160.182]:57194 "EHLO
	mail-yk0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933568AbaGWVWd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jul 2014 17:22:33 -0400
Received: by mail-yk0-f182.google.com with SMTP id q9so1202514ykb.13
        for <git@vger.kernel.org>; Wed, 23 Jul 2014 14:22:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=RHDF5E4frNrCY81iZcT9iOW0si+fl+l6oXFwJyGiF+Q=;
        b=zYkujR1xWrxGb0WPtgImxailgGlUIiFWysB7nxflOlZDERnRyh1e4NSXFXS8+jaKGv
         yYG7lm1MnZJuBSaypWg10zmY9eUf+eKyY1tjCWcqWJ67JyS8XwRW9tJUCNlOn02pQkGZ
         /5nLWMNHVET0CDbjmpCI36pb8OxIUPhvcZXXlwQM4ziHfmrf0R4zIC3JURznX9nvjpiy
         5Cdmyfdey8VO4Jj9PrkAcPtZ1i66XPbXz0LieboVvg7NKBkef+iDA2RIOJh3DIFCPI74
         fBjz3Uq/fDqFBCa4Ts2Re2O1qTkxvrDUykEeREIOUjD5ZtU5pwEQMGa+l380/3eGKan9
         V67g==
X-Received: by 10.236.99.39 with SMTP id w27mr5077929yhf.109.1406150552525;
 Wed, 23 Jul 2014 14:22:32 -0700 (PDT)
Received: by 10.170.163.5 with HTTP; Wed, 23 Jul 2014 14:22:32 -0700 (PDT)
In-Reply-To: <1406135035-26441-16-git-send-email-sahlberg@google.com>
X-Google-Sender-Auth: POCoWUDaqWslQecpXKaXTJFcJJk
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254123>

On Wed, Jul 23, 2014 at 1:03 PM, Ronnie Sahlberg <sahlberg@google.com> wrote:
> Add (back?) support to make it possible to delete refs that are broken.
>
> Add a new flag REF_ALLOWBROKEN that can be passed to the functions to
> lock a ref. If this flag is set we allow locking the ref even if the
> ref points to a broken sha1. For example a sha1 that is created by :
>
>    echo "Broken ref" > .git/refs/heads/foo-broken-1
>
> Use this flag when calling from branch.c dusing a ref delete so that we

Presumably: s/dusing/doing/

> only allow locking those broken refs IFF when called during a branch
> delete.
>
> Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
> ---
>  builtin/branch.c |  6 ++++--
>  refs.c           | 10 +++++++---
>  refs.h           |  3 ++-
>  3 files changed, 13 insertions(+), 6 deletions(-)
>
> diff --git a/builtin/branch.c b/builtin/branch.c
> index 5c95656..6d70037 100644
> --- a/builtin/branch.c
> +++ b/builtin/branch.c
> @@ -236,6 +236,8 @@ static int delete_branches(int argc, const char **argv, int force, int kinds,
>                 name = mkpathdup(fmt, bname.buf);
>                 target = resolve_ref_unsafe(name, sha1,
>                                             RESOLVE_REF_ALLOW_BAD_NAME, &flags);
> +               if (!target && (flags & REF_ISBROKEN))
> +                       target = name;
>                 if (!target ||
>                     (!(flags & REF_ISSYMREF) && is_null_sha1(sha1))) {
>                         error(remote_branch
> @@ -245,14 +247,14 @@ static int delete_branches(int argc, const char **argv, int force, int kinds,
>                         continue;
>                 }
>
> -               if (!(flags & REF_ISSYMREF) &&
> +               if (!(flags & (REF_ISSYMREF|REF_ISBROKEN)) &&
>                     check_branch_commit(bname.buf, name, sha1, head_rev, kinds,
>                                         force)) {
>                         ret = 1;
>                         continue;
>                 }
>
> -               if (delete_ref(name, sha1, REF_NODEREF)) {
> +               if (delete_ref(name, sha1, REF_NODEREF|REF_ALLOWBROKEN)) {
>                         error(remote_branch
>                               ? _("Error deleting remote branch '%s'")
>                               : _("Error deleting branch '%s'"),
> diff --git a/refs.c b/refs.c
> index 0ead11f..2662ef6 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -2122,12 +2122,12 @@ static struct ref_lock *lock_ref_sha1_basic(const char *refname,
>         int resolve_flags;
>         int missing = 0;
>         int attempts_remaining = 3;
> -       int bad_refname;
> +       int bad_ref;
>
>         lock = xcalloc(1, sizeof(struct ref_lock));
>         lock->lock_fd = -1;
>
> -       bad_refname = check_refname_format(refname, REFNAME_ALLOW_ONELEVEL);
> +       bad_ref = check_refname_format(refname, REFNAME_ALLOW_ONELEVEL);
>
>         resolve_flags = RESOLVE_REF_ALLOW_BAD_NAME;
>         if (mustexist)
> @@ -2150,6 +2150,10 @@ static struct ref_lock *lock_ref_sha1_basic(const char *refname,
>                 refname = resolve_ref_unsafe(orig_refname, lock->old_sha1,
>                                              resolve_flags, &type);
>         }
> +       if (!refname && (flags & REF_ALLOWBROKEN) && (type & REF_ISBROKEN)) {
> +               bad_ref = 1;
> +               refname = orig_refname;
> +       }
>         if (type_p)
>             *type_p = type;
>         if (!refname) {
> @@ -2212,7 +2216,7 @@ static struct ref_lock *lock_ref_sha1_basic(const char *refname,
>                 else
>                         unable_to_lock_index_die(ref_file, errno);
>         }
> -       if (bad_refname)
> +       if (bad_ref)
>                 return lock;
>         return old_sha1 ? verify_lock(lock, old_sha1, mustexist) : lock;
>
> diff --git a/refs.h b/refs.h
> index 712fc32..0172f48 100644
> --- a/refs.h
> +++ b/refs.h
> @@ -174,10 +174,11 @@ extern int peel_ref(const char *refname, unsigned char *sha1);
>   * Flags controlling transaction_update_sha1(), transaction_create_sha1(), etc.
>   * REF_NODEREF: act on the ref directly, instead of dereferencing
>   *              symbolic references.
> - *
> + * REF_ALLOWBROKEN: allow locking refs that are broken.
>   * Flags >= 0x100 are reserved for internal use.
>   */
>  #define REF_NODEREF    0x01
> +#define REF_ALLOWBROKEN 0x02
>
>  /** Reads log for the value of ref during at_time. **/
>  extern int read_ref_at(const char *refname, unsigned long at_time, int cnt,
> --
> 2.0.1.508.g763ab16
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
