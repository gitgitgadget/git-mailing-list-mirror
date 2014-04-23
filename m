From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 2/3] fetch.c: change s_update_ref to use a ref transaction
Date: Wed, 23 Apr 2014 16:12:54 -0400
Message-ID: <CAPig+cQUAVK7O7yRJGjvRmuPg06C1ZEi876gMsihFpGLgVa=Mg@mail.gmail.com>
References: <1398192327-21302-1-git-send-email-sahlberg@google.com>
	<1398192327-21302-3-git-send-email-sahlberg@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Ronnie Sahlberg <sahlberg@google.com>
X-From: git-owner@vger.kernel.org Wed Apr 23 22:13:05 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wd3XS-0007ua-VW
	for gcvg-git-2@plane.gmane.org; Wed, 23 Apr 2014 22:13:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757989AbaDWUM5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Apr 2014 16:12:57 -0400
Received: from mail-yk0-f177.google.com ([209.85.160.177]:63963 "EHLO
	mail-yk0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757962AbaDWUMz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Apr 2014 16:12:55 -0400
Received: by mail-yk0-f177.google.com with SMTP id q200so1257487ykb.36
        for <git@vger.kernel.org>; Wed, 23 Apr 2014 13:12:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=FL52qcGLyG9Mr08rmxJ84yTYDBrfjURbNp9uFsC2DBc=;
        b=aO7gn8XL78bmnY8MC34Dyhitd30mcUVqUNPmAsM3YJA8px4sMUYt0eCE0eO+mTPETW
         3w3drHCJquHVjWpu5WOAbCe/ggXN0t06fEJV7bCqbkpu1tFo6u1s8bLDPaOGG37SbEot
         0awhr3uxOobyifc0p0RAsHeDP/Z59YfN19qYHgZpubKBmwPXu9ZflJ1Mxip691y34XrG
         l0bRB2eqnlc+yYLYiojuSf5IwWXubdRLws7SMkGbM+PlALsS7MeL1QPBbr1iwBUnbAyg
         AhXyYBil+30sdn5/llWK0mD9gWfjI75qivpYhwlt9YVPTXrxyKmgyVB89keKUj+CW8sx
         pUWA==
X-Received: by 10.236.194.169 with SMTP id m29mr14840326yhn.121.1398283974837;
 Wed, 23 Apr 2014 13:12:54 -0700 (PDT)
Received: by 10.170.163.66 with HTTP; Wed, 23 Apr 2014 13:12:54 -0700 (PDT)
In-Reply-To: <1398192327-21302-3-git-send-email-sahlberg@google.com>
X-Google-Sender-Auth: KLZjyirjohsmfvLeKWuOQExhrSs
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246884>

On Tue, Apr 22, 2014 at 2:45 PM, Ronnie Sahlberg <sahlberg@google.com> wrote:
> Change s_update_ref to use a ref transaction for the ref update.
> Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
>
> Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>

Doubled sign-off.

> ---
>  builtin/fetch.c | 15 +++++++--------
>  1 file changed, 7 insertions(+), 8 deletions(-)
>
> diff --git a/builtin/fetch.c b/builtin/fetch.c
> index a93c893..5c15584 100644
> --- a/builtin/fetch.c
> +++ b/builtin/fetch.c
> @@ -375,7 +375,7 @@ static int s_update_ref(const char *action,
>  {
>         char msg[1024];
>         char *rla = getenv("GIT_REFLOG_ACTION");
> -       static struct ref_lock *lock;
> +       struct ref_transaction *transaction;
>
>         if (dry_run)
>                 return 0;
> @@ -384,15 +384,14 @@ static int s_update_ref(const char *action,
>         snprintf(msg, sizeof(msg), "%s: %s", rla, action);
>
>         errno = 0;
> -       lock = lock_any_ref_for_update(ref->name,
> -                                      check_old ? ref->old_sha1 : NULL,
> -                                      0, NULL);
> -       if (!lock)
> -               return errno == ENOTDIR ? STORE_REF_ERROR_DF_CONFLICT :
> -                                         STORE_REF_ERROR_OTHER;
> -       if (write_ref_sha1(lock, ref->new_sha1, msg) < 0)
> +       transaction = ref_transaction_begin();
> +       if (!transaction ||
> +           ref_transaction_update(transaction, ref->name, ref->new_sha1,
> +                                  ref->old_sha1, 0, check_old) ||
> +           ref_transaction_commit(transaction, msg, UPDATE_REFS_QUIET_ON_ERR))
>                 return errno == ENOTDIR ? STORE_REF_ERROR_DF_CONFLICT :
>                                           STORE_REF_ERROR_OTHER;
> +
>         return 0;
>  }
>
> --
> 1.9.1.518.g16976cb.dirty
