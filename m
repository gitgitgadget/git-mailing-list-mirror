From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCHv3 3/6] send-pack.c: add --atomic command line argument
Date: Thu, 18 Dec 2014 20:22:38 -0500
Message-ID: <CAPig+cSHp+4Q3yM8EeG-b3VqofuuhAjaKRMrjJ=5jGutY2eKhw@mail.gmail.com>
References: <xmqqzjaobl0q.fsf@gitster.dls.corp.google.com>
	<1418841177-12152-1-git-send-email-sbeller@google.com>
	<1418841177-12152-4-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: ronnie sahlberg <ronniesahlberg@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git List <git@vger.kernel.org>,
	Ronnie Sahlberg <sahlberg@google.com>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Fri Dec 19 02:22:45 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y1mHE-0002LS-PY
	for gcvg-git-2@plane.gmane.org; Fri, 19 Dec 2014 02:22:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751844AbaLSBWk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Dec 2014 20:22:40 -0500
Received: from mail-yk0-f180.google.com ([209.85.160.180]:48020 "EHLO
	mail-yk0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751822AbaLSBWj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Dec 2014 20:22:39 -0500
Received: by mail-yk0-f180.google.com with SMTP id 9so9465ykp.25
        for <git@vger.kernel.org>; Thu, 18 Dec 2014 17:22:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=ZBfG1sNGurpHXz0rrK6vmFMPViJNju0peZe/4NfWADw=;
        b=uynUlaq7sPa0ibGo1SnFCgrO+MYkwKKX3Ln/vnTxZLub1XKlziEPSKPSODZxM4xyz9
         PGZ+OtNd7HbDbvpMmlhVdfJHYiSUBUasLSDQw3VID390M/UxEwe8kfqsIj5J/cv+GSFe
         goGqgZANEJGdNAZvJJYKm+6XUmx42L4VQ6vLV+xMY2GFwUhtkoOIxY2gQZprMGqKuOTf
         IOTv9ziLPN7oMLl0zMBB4LdTBB4riChDfxkPAxmtx6paSYtYJ6aFIKFoNN+nfhxLBykA
         jkSA9wy5bEZ/S8QBiWyQ9P7Yg7Fq11wwr+nxQIkNFBJ7mGsSzGvEYTxnM9RpXFFh62e3
         cuzw==
X-Received: by 10.170.78.130 with SMTP id u124mr4844030yku.91.1418952158752;
 Thu, 18 Dec 2014 17:22:38 -0800 (PST)
Received: by 10.170.79.215 with HTTP; Thu, 18 Dec 2014 17:22:38 -0800 (PST)
In-Reply-To: <1418841177-12152-4-git-send-email-sbeller@google.com>
X-Google-Sender-Auth: JF61azqmOs3qb8d9ddAsSQPTP6k
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261545>

On Wed, Dec 17, 2014 at 1:32 PM, Stefan Beller <sbeller@google.com> wrote:
> From: Ronnie Sahlberg <sahlberg@google.com>
>
> This adds support to send-pack to negotiate and use atomic pushes
> iff the server supports it. Atomic pushes are activated by a new command
> line flag --atomic.
>
> Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
> diff --git a/send-pack.c b/send-pack.c
> index 77e4201..a696d5c 100644
> --- a/send-pack.c
> +++ b/send-pack.c
> @@ -282,6 +282,30 @@ free_return:
>         return update_seen;
>  }
>
> +
> +static int atomic_push_failure(struct send_pack_args *args,
> +                              struct ref *remote_refs,
> +                              struct ref *failing_ref)
> +{
> +       struct ref *ref;
> +       /* Mark other refs as failed */
> +       for (ref = remote_refs; ref; ref = ref->next) {
> +               if (!ref->peer_ref && !args->send_mirror)
> +                       continue;
> +
> +               switch (ref->status) {
> +               case REF_STATUS_EXPECTING_REPORT:
> +                       ref->status = REF_STATUS_ATOMIC_PUSH_FAILED;
> +                       continue;
> +               default:
> +                       ; /* do nothing */
> +               }
> +       }
> +       error("atomic push failed for ref %s. "
> +             "status: %d\n", failing_ref->name, failing_ref->status);
> +       return -1;

error() returns -1, so:

    return error(...);

Also, why split the string literal like that? It's not warranted by
the indentation level. Instead:

    return error("atomic push failed for ref %s. status: %d\n",
        failing_ref->name, failing_ref->status);

> +}
> +
>  int send_pack(struct send_pack_args *args,
>               int fd[], struct child_process *conn,
>               struct ref *remote_refs,
> @@ -373,9 +397,21 @@ int send_pack(struct send_pack_args *args,
>          * the pack data.
>          */
>         for (ref = remote_refs; ref; ref = ref->next) {
> -               if (check_to_send_update(ref, args) < 0)
> +               switch (check_to_send_update(ref, args)) {
> +               case 0: /* no error */
> +                       break;
> +               case -CHECK_REF_STATUS_REJECTED:

I realize that Junio said that this could wait for cleanup patch by
someone later, but I'd argue that defining these constants now with
their proper negative values would be beneficial:

First, it is a potential maintenance burden that each person working
on the code later must remember to negate the constants each time they
are used. Forgetting to do so will lead to incorrect behavior.

Second, negating these constants at point-of-use implies incorrectly
that there is some valid use-case for the non-negated forms. It's
misleading and confusing.

> +                       /*
> +                        * When we know the server would reject a ref update if
> +                        * we were to send it and we're trying to send the refs
> +                        * atomically, abort the whole operation.
> +                        */
> +                       if (use_atomic)
> +                               return atomic_push_failure(args, remote_refs, ref);
> +                       /* Fallthrough for non atomic case. */
> +               default:
>                         continue;
> -
> +               }
>                 if (!ref->deletion)
>                         need_pack_data = 1;
