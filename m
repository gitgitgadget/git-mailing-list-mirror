From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v4 12/27] replace.c: use the ref transaction functions for updates
Date: Mon, 28 Apr 2014 20:44:56 -0400
Message-ID: <CAPig+cSWMK_kyVvaD8QCfZmPu4JVT+nOJZJLteHhDao0umHLbA@mail.gmail.com>
References: <1398725682-30782-1-git-send-email-sahlberg@google.com>
	<1398725682-30782-13-git-send-email-sahlberg@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Ronnie Sahlberg <sahlberg@google.com>
X-From: git-owner@vger.kernel.org Tue Apr 29 02:45:03 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WewAQ-00060N-UC
	for gcvg-git-2@plane.gmane.org; Tue, 29 Apr 2014 02:45:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754280AbaD2Ao5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Apr 2014 20:44:57 -0400
Received: from mail-yh0-f48.google.com ([209.85.213.48]:62633 "EHLO
	mail-yh0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751400AbaD2Ao4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Apr 2014 20:44:56 -0400
Received: by mail-yh0-f48.google.com with SMTP id v1so3308089yhn.7
        for <git@vger.kernel.org>; Mon, 28 Apr 2014 17:44:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=z3AYX2LJdJ6Hch1QVrQH0JxkdOrbUciWOEYQxsgeqok=;
        b=sE7oVRI0lQ+d/f+EV1qcArj/FJ5WFQ9TR3U2pZb4MXZEUxJW7uAn3osU3u8r/3KBXm
         gM7nnDaf+K2J4/K9xu5rMqmJBGGtDE+K/5p/a4gklNoZOXM5/It+q5ofqvD+d7O8tdLL
         KstgoVvDR2Anplv4UrMKA9napid39RApu016+saqODfosOhAmECpWSUQLkVRPhUIfc0d
         Qfv2o42PC4gEjAdWc/GSB9Id89eow/0uwT03n5xR+mMo+igHj0FwPlBrXUa8OqoviZby
         0TAmBkbDKEmRruGD6qSygzbFyItLuX8YKaK5uTCg+nWbwVeY4BkIJGaxVNCOWYT6cnQ5
         +HWQ==
X-Received: by 10.236.39.242 with SMTP id d78mr41196628yhb.36.1398732296115;
 Mon, 28 Apr 2014 17:44:56 -0700 (PDT)
Received: by 10.170.163.66 with HTTP; Mon, 28 Apr 2014 17:44:56 -0700 (PDT)
In-Reply-To: <1398725682-30782-13-git-send-email-sahlberg@google.com>
X-Google-Sender-Auth: oQZ5O1BqTUktcXEsAXiXZDEFWCg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247502>

On Mon, Apr 28, 2014 at 6:54 PM, Ronnie Sahlberg <sahlberg@google.com> wrote:
> Update replace.c to use ref transactions for updates.
>
> Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
> ---
>  builtin/replace.c | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)
>
> diff --git a/builtin/replace.c b/builtin/replace.c
> index b62420a..b037b29 100644
> --- a/builtin/replace.c
> +++ b/builtin/replace.c
> @@ -129,7 +129,8 @@ static int replace_object(const char *object_ref, const char *replace_ref,
>         unsigned char object[20], prev[20], repl[20];
>         enum object_type obj_type, repl_type;
>         char ref[PATH_MAX];
> -       struct ref_lock *lock;
> +       struct ref_transaction *transaction;
> +       struct strbuf err = STRBUF_INIT;
>
>         if (get_sha1(object_ref, object))
>                 die("Failed to resolve '%s' as a valid ref.", object_ref);
> @@ -157,11 +158,12 @@ static int replace_object(const char *object_ref, const char *replace_ref,
>         else if (!force)
>                 die("replace ref '%s' already exists", ref);
>
> -       lock = lock_any_ref_for_update(ref, prev, 0, NULL);
> -       if (!lock)
> -               die("%s: cannot lock the ref", ref);
> -       if (write_ref_sha1(lock, repl, NULL) < 0)
> -               die("%s: cannot update the ref", ref);
> +       transaction = ref_transaction_begin();
> +       if (!transaction ||
> +           ref_transaction_update(transaction, ref, repl, prev,
> +                                  0, !is_null_sha1(prev)) ||
> +           ref_transaction_commit(transaction, NULL, &err))
> +               die(_("%s: failed to replace ref: %s"), ref, err.buf);

Even though 'err' will be empty after this conditional, would
strbuf_release(&err) here be warranted to future-proof it? Today's
implementation of strbuf will not have allocated any memory, but
perhaps a future change might pre-allocate (unlikely though that is),
which would leak here.

>         return 0;
>  }
> --
> 1.9.1.528.g98b8868.dirty
