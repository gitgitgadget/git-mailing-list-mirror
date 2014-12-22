From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 3/7] send-pack.c: add --atomic command line argument
Date: Mon, 22 Dec 2014 17:58:18 -0500
Message-ID: <CAPig+cQCLWy8rEqMCMxkvz+jAYwOA2tZE1LagkB5vY-60pe1mQ@mail.gmail.com>
References: <1419017941-7090-1-git-send-email-sbeller@google.com>
	<1419017941-7090-4-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: ronnie sahlberg <ronniesahlberg@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git List <git@vger.kernel.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Mon Dec 22 23:58:24 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y3Bvk-00064I-80
	for gcvg-git-2@plane.gmane.org; Mon, 22 Dec 2014 23:58:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752966AbaLVW6U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Dec 2014 17:58:20 -0500
Received: from mail-yk0-f180.google.com ([209.85.160.180]:54802 "EHLO
	mail-yk0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750845AbaLVW6T (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Dec 2014 17:58:19 -0500
Received: by mail-yk0-f180.google.com with SMTP id 9so2633121ykp.39
        for <git@vger.kernel.org>; Mon, 22 Dec 2014 14:58:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=B0Ebql+DeH247NZFXPDEZPWpT0KiHDSygb2XOoxioQ0=;
        b=pdIOC/2zf5PwLurkGAAjgKXycQHg7FsyLnR5FebNW5vukeJidZrAjOkxIUwBZ8HHG7
         nkO2LX4UtZ7urbfwQ2fhZU9UyDk+72R9lOclvwL2vHcBxfGeHXN6YbpEpcVY6jL0pd1h
         XPAQdPQzxNkSo4RpnbKE3YkqKfzq7lPLOnRAe54oMVxpanwgq/RRiVZ7U7WTD00H7+Uy
         3ihcAtFJjgazHWcXYih6e+zsnox5SxNUWej/l/3HxQ1VwsEkLgg4y8O2UBaO8exyNR50
         GM/91c2PVZ3ZTc5jmB/TUC7b31ogGgDiiXojYTWZPDRinp6gYoJDiwM6FNs+uJRACOlz
         UZ1Q==
X-Received: by 10.236.14.36 with SMTP id c24mr19716931yhc.166.1419289098385;
 Mon, 22 Dec 2014 14:58:18 -0800 (PST)
Received: by 10.170.73.7 with HTTP; Mon, 22 Dec 2014 14:58:18 -0800 (PST)
In-Reply-To: <1419017941-7090-4-git-send-email-sbeller@google.com>
X-Google-Sender-Auth: Trc-Wx6tIT363bSY8C363vpgvXw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261695>

On Fri, Dec 19, 2014 at 2:38 PM, Stefan Beller <sbeller@google.com> wrote:
> From: Ronnie Sahlberg <sahlberg@google.com>
>
> This adds support to send-pack to negotiate and use atomic pushes
> iff the server supports it. Atomic pushes are activated by a new command
> line flag --atomic.
>
> Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
> diff --git a/builtin/send-pack.c b/builtin/send-pack.c
> index b564a77..b961e5a 100644
> --- a/builtin/send-pack.c
> +++ b/builtin/send-pack.c
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
> +       error("atomic push failed for ref %s. status: %d\n",
> +             failing_ref->name, failing_ref->status);
> +       return -1;

Not itself worth a re-send, but if you do re-send for some other reason...

    return error(...);

would be more idiomatic (as mentioned in the previous review).

> +}
> +
>  int send_pack(struct send_pack_args *args,
>               int fd[], struct child_process *conn,
>               struct ref *remote_refs,
