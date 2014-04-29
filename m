From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v4 15/27] fast-import.c: change update_branch to use ref transactions
Date: Mon, 28 Apr 2014 22:18:18 -0400
Message-ID: <CAPig+cTE9+XHYfnynMykbYf=0kMivj5wFu0Lovnr8XbxyEpsyA@mail.gmail.com>
References: <1398725682-30782-1-git-send-email-sahlberg@google.com>
	<1398725682-30782-16-git-send-email-sahlberg@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Ronnie Sahlberg <sahlberg@google.com>
X-From: git-owner@vger.kernel.org Tue Apr 29 04:18:29 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wexcm-0005Dw-Ee
	for gcvg-git-2@plane.gmane.org; Tue, 29 Apr 2014 04:18:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754497AbaD2CSU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Apr 2014 22:18:20 -0400
Received: from mail-yk0-f170.google.com ([209.85.160.170]:57698 "EHLO
	mail-yk0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752255AbaD2CST (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Apr 2014 22:18:19 -0400
Received: by mail-yk0-f170.google.com with SMTP id 79so3749136ykr.1
        for <git@vger.kernel.org>; Mon, 28 Apr 2014 19:18:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=Vezs+In0o2bwOqjC/T3wbH2kbDKUp4HoOfGU1uj2A18=;
        b=Cx89AkMZxrwkng3BmeJo9rBVzpWOUPZ0wMEPYyAdF9lkShnYe/2xQXHpaBbe6rzd02
         R1AQ6SLZnH8wL+xtjrQdicEEejDmWiBUvkf9ocmLFW0qMd9bY98x4EueSMw1CMhOrmqu
         XRk8Wdyuw4ULaaGubcIQRxhHcFgXjJdYoFhcPdvjoCxPd0yWDkGGqyxYcdBsFpzIfKUr
         NidjrHjaaJ+Z5RqPYxrJI1NXXBVcwbQBIjBqN20AQnJ2daOfL1gZKhZn2GHueJcpPym4
         dXA2aGRS7i5K8Bjxvh4/ZU6/MWzX5TAjsrHHfsszkph1VUzXMhYk8tHTuqC+J2zWwJX0
         tfqw==
X-Received: by 10.236.81.6 with SMTP id l6mr43705550yhe.29.1398737898668; Mon,
 28 Apr 2014 19:18:18 -0700 (PDT)
Received: by 10.170.163.66 with HTTP; Mon, 28 Apr 2014 19:18:18 -0700 (PDT)
In-Reply-To: <1398725682-30782-16-git-send-email-sahlberg@google.com>
X-Google-Sender-Auth: FYuYcHqcygsRCl2wSIfhXE7Imtk
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247509>

On Mon, Apr 28, 2014 at 6:54 PM, Ronnie Sahlberg <sahlberg@google.com> wrote:
> Change update_branch() to use ref transactions for updates.
>
> Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
> ---
>  fast-import.c | 20 ++++++++++++--------
>  1 file changed, 12 insertions(+), 8 deletions(-)
>
> diff --git a/fast-import.c b/fast-import.c
> index fb4738d..300c8dc 100644
> --- a/fast-import.c
> +++ b/fast-import.c
> @@ -1678,36 +1678,40 @@ found_entry:
>  static int update_branch(struct branch *b)
>  {
>         static const char *msg = "fast-import";
> -       struct ref_lock *lock;
> +       struct ref_transaction *transaction;
>         unsigned char old_sha1[20];
> +       struct strbuf err = STRBUF_INIT;
>
>         if (is_null_sha1(b->sha1))
>                 return 0;
>         if (read_ref(b->name, old_sha1))
>                 hashclr(old_sha1);
> -       lock = lock_any_ref_for_update(b->name, old_sha1, 0, NULL);
> -       if (!lock)
> -               return error("Unable to lock %s", b->name);
>         if (!force_update && !is_null_sha1(old_sha1)) {
>                 struct commit *old_cmit, *new_cmit;
>
>                 old_cmit = lookup_commit_reference_gently(old_sha1, 0);
>                 new_cmit = lookup_commit_reference_gently(b->sha1, 0);
>                 if (!old_cmit || !new_cmit) {
> -                       unlock_ref(lock);
>                         return error("Branch %s is missing commits.", b->name);
>                 }
>
>                 if (!in_merge_bases(old_cmit, new_cmit)) {
> -                       unlock_ref(lock);
>                         warning("Not updating %s"
>                                 " (new tip %s does not contain %s)",
>                                 b->name, sha1_to_hex(b->sha1), sha1_to_hex(old_sha1));
>                         return -1;
>                 }
>         }
> -       if (write_ref_sha1(lock, b->sha1, msg) < 0)
> -               return error("Unable to update %s", b->name);
> +       transaction = ref_transaction_begin();
> +       if ((!transaction ||
> +           ref_transaction_update(transaction, b->name, b->sha1, old_sha1,
> +                                  0, 1)) ||
> +           (ref_transaction_commit(transaction, msg, &err) &&
> +            !(transaction = NULL))) {
> +               ref_transaction_rollback(transaction);
> +               return error("Unable to update branch %s: %s", b->name,
> +                            strbuf_detach(&err, NULL));

Iffy strbuf handling. The strbuf content is being leaked here whether
detached or not.

> +       }
>         return 0;
>  }
>
> --
> 1.9.1.528.g98b8868.dirty
