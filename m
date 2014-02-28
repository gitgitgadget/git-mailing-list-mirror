From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] Problem in bulk-checkin.c:finish_bulk_checkin() Unable to fix
Date: Fri, 28 Feb 2014 00:10:55 -0500
Message-ID: <CAPig+cTMLEw0hkd2fvixyXbszMGrSd2xCa5qm6=cNfcE4fv9yA@mail.gmail.com>
References: <1393545849-26775-1-git-send-email-faiz.off93@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Faiz Kothari <faiz.off93@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 28 06:11:01 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WJFiu-0002Az-5T
	for gcvg-git-2@plane.gmane.org; Fri, 28 Feb 2014 06:11:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751247AbaB1FK4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Feb 2014 00:10:56 -0500
Received: from mail-yh0-f46.google.com ([209.85.213.46]:38052 "EHLO
	mail-yh0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750750AbaB1FKz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Feb 2014 00:10:55 -0500
Received: by mail-yh0-f46.google.com with SMTP id v1so207232yhn.19
        for <git@vger.kernel.org>; Thu, 27 Feb 2014 21:10:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=StcWo3ezSfht0J42M4R6MXJq90fwlglhFJ3gmmfck4g=;
        b=YLA/sYK3FxFoBAu1Y4+nN5cJCI3TfwUNrLTWc8hsd7E96+JJ/zsb1r0wQi+p3unMeQ
         pnoX6MSGLW3H6HVHs663+rFyEl87DOQ4Y6cVeQ5Q0R+j2egiwONsVtOvU4g4QEoGsnbq
         CPKIHYm6aZGzxt5nx5fwtD1HazcpjDgHdNrBxS5rNI99Xl7Mcsb1a5YH43ywweC8QS94
         o6fwg45xvoHyEv3dqjYUfuv9WoJKZ7G1BxL6Eacs/dHUDyc1DI2eSi5MQUVR8pNQAkbD
         Z2UGx9Do0KvWe0GaK0nn2xfr5IpTnFm+MzsJZn1I8brqrj0yY3xp8w7wTipsIhInORoy
         pz1A==
X-Received: by 10.236.8.68 with SMTP id 44mr36947yhq.39.1393564255085; Thu, 27
 Feb 2014 21:10:55 -0800 (PST)
Received: by 10.170.180.195 with HTTP; Thu, 27 Feb 2014 21:10:55 -0800 (PST)
In-Reply-To: <1393545849-26775-1-git-send-email-faiz.off93@gmail.com>
X-Google-Sender-Auth: CsOrRjfGz2suEsUzwCSY42ntflM
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242885>

On Thu, Feb 27, 2014 at 7:04 PM, Faiz Kothari <faiz.off93@gmail.com> wrote:
> Signed-off-by: Faiz Kothari <faiz.off93@gmail.com>
> ---
> Compiles without errors.
> Fails in test t/t1050-large.sh ,fails 12/15 tests. Dumps memory map and backtrace.
> Somewhere its not able to free(): invalid pointer.
> Please somone pointout where I am doing it wrong.
> Help is really appreciated.
> Thanks.

Hint: Pay close attention to the second sentence of the microproject
you've undertaken:

    Rewrite bulk-checkin.c:finish_bulk_checkin() to use a strbuf for
    handling packname, and explain why this is useful. Also check if
    the first argument of pack-write.c:finish_tmp_packfile() can be
    made const.

It's the clue to understanding the crash.

>  bulk-checkin.c |    8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/bulk-checkin.c b/bulk-checkin.c
> index 118c625..c76cd6b 100644
> --- a/bulk-checkin.c
> +++ b/bulk-checkin.c
> @@ -23,7 +23,7 @@ static struct bulk_checkin_state {
>  static void finish_bulk_checkin(struct bulk_checkin_state *state)
>  {
>         unsigned char sha1[20];
> -       char packname[PATH_MAX];
> +       struct strbuf packname = STRBUF_INIT;
>         int i;
>
>         if (!state->f)
> @@ -42,9 +42,8 @@ static void finish_bulk_checkin(struct bulk_checkin_state *state)
>                                          state->offset);
>                 close(fd);
>         }
> -
> -       sprintf(packname, "%s/pack/pack-", get_object_directory());
> -       finish_tmp_packfile(packname, state->pack_tmp_name,
> +       strbuf_addf(&packname, "%s/pack/pack-", get_object_directory());
> +       finish_tmp_packfile(packname.buf, state->pack_tmp_name,
>                             state->written, state->nr_written,
>                             &state->pack_idx_opts, sha1);
>         for (i = 0; i < state->nr_written; i++)
> @@ -53,6 +52,7 @@ static void finish_bulk_checkin(struct bulk_checkin_state *state)
>  clear_exit:
>         free(state->written);
>         memset(state, 0, sizeof(*state));
> +       strbuf_release(&packname);
>
>         /* Make objects we just wrote available to ourselves */
>         reprepare_packed_git();
> --
> 1.7.9.5
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
