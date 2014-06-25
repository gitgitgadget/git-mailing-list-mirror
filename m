From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [RFC/PATCH] pager.c: replace git_config with git_config_get_string
Date: Tue, 24 Jun 2014 23:59:19 -0400
Message-ID: <CAPig+cTwBB8bmKDtdv8zPojR+6Kyu6fYB7Sw0-UJoSHFLQX+fQ@mail.gmail.com>
References: <1403520105-23250-1-git-send-email-tanayabh@gmail.com>
	<1403520105-23250-6-git-send-email-tanayabh@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Tanay Abhra <tanayabh@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 25 06:00:40 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WzeNz-0002zc-Bn
	for gcvg-git-2@plane.gmane.org; Wed, 25 Jun 2014 06:00:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752955AbaFYD7W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jun 2014 23:59:22 -0400
Received: from mail-yh0-f53.google.com ([209.85.213.53]:43922 "EHLO
	mail-yh0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752612AbaFYD7V (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jun 2014 23:59:21 -0400
Received: by mail-yh0-f53.google.com with SMTP id b6so830293yha.12
        for <git@vger.kernel.org>; Tue, 24 Jun 2014 20:59:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=c6bXSfQfgVrvp7msH2aLTKDwKdwqcdRfJayCN7SnROM=;
        b=w90sC2QpFQkDif1YO8ucJrumww7ZvIdjc2TrHSNKSSWiEHctgjycuL7sZU6NjvqlNe
         Kf0thFA/fCvuqkhINi6vg/2Fj450IZyuSZbThIs/9M2Itsx9f1p0jauYkjMzPlh2qpzf
         U5bGdSLGREt7+Ptc0Dlj8CR7sJhrohODYG+NksorUZX/0ClFEkRF01lHI7H6az84qxaG
         OrE+KnYNftD2IkFzEiBq1MUxg86PgmcBawnu8XnswPD32j632ipyKEzFrHcEhL6nmWbn
         qT08SmfPHABBJEzM5w3alkVHFkXW2E1LU4bI4peoi+9MDi6g7s4M2DIN6fzv1bf2ZAWL
         htaA==
X-Received: by 10.236.137.242 with SMTP id y78mr1100784yhi.152.1403668759046;
 Tue, 24 Jun 2014 20:59:19 -0700 (PDT)
Received: by 10.170.120.69 with HTTP; Tue, 24 Jun 2014 20:59:19 -0700 (PDT)
In-Reply-To: <1403520105-23250-6-git-send-email-tanayabh@gmail.com>
X-Google-Sender-Auth: pKjYNA-q6BiTmfPYPHkuT9gXdkw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252432>

On Mon, Jun 23, 2014 at 6:41 AM, Tanay Abhra <tanayabh@gmail.com> wrote:
> Use git_config_get_string instead of git_config to take advantage of
> the config hash-table api which provides a cleaner control flow.
>
> Signed-off-by: Tanay Abhra <tanayabh@gmail.com>
> ---
>  pager.c | 44 +++++++++++++++-----------------------------
>  1 file changed, 15 insertions(+), 29 deletions(-)
>
> diff --git a/pager.c b/pager.c
> index 8b5cbc5..96abe6d 100644
> --- a/pager.c
> +++ b/pager.c
> @@ -6,12 +6,6 @@
>  #define DEFAULT_PAGER "less"
>  #endif
>
> -struct pager_config {
> -       const char *cmd;
> -       int want;
> -       char *value;
> -};
> -
>  /*
>   * This is split up from the rest of git so that we can do
>   * something different on Windows.
> @@ -155,30 +149,22 @@ int decimal_width(int number)
>         return width;
>  }
>
> -static int pager_command_config(const char *var, const char *value, void *data)
> -{
> -       struct pager_config *c = data;
> -       if (starts_with(var, "pager.") && !strcmp(var + 6, c->cmd)) {
> -               int b = git_config_maybe_bool(var, value);
> -               if (b >= 0)
> -                       c->want = b;
> -               else {
> -                       c->want = 1;
> -                       c->value = xstrdup(value);
> -               }
> -       }
> -       return 0;
> -}
> -
>  /* returns 0 for "no pager", 1 for "use pager", and -1 for "not specified" */
>  int check_pager_config(const char *cmd)
>  {
> -       struct pager_config c;
> -       c.cmd = cmd;
> -       c.want = -1;
> -       c.value = NULL;
> -       git_config(pager_command_config, &c);
> -       if (c.value)
> -               pager_program = c.value;
> -       return c.want;
> +       struct strbuf key = STRBUF_INIT;
> +       int want = -1;
> +       const char *value = NULL;
> +       strbuf_addf(&key, "pager.%s", cmd);
> +       if (!git_config_get_string(key.buf, &value)) {
> +               int b = git_config_maybe_bool(key.buf, value);
> +               if (b >= 0)
> +                       want = b;
> +               else
> +                       want = 1;
> +       }
> +       if (value)
> +               pager_program = value;

Two issues:

First, why is 'if(value)' standing by itself? Although this works, it
seems to imply that 'value' might be able to become non-NULL by some
mechanism other than the get_config_maybe_bool() call, which means
that people reading this code have to spend extra time trying to
understand the overall logic. If you follow the example of the
original code, where 'value' is only ever set when 'b < 0', then it is
obvious even to the most casual reader that 'pager_program' is
assigned only for that one condition.

Second, don't you want to xstrdup(value) when assigning to
'pager_program'? If you don't, then 'pager_program' will become a
dangling pointer when config_cache_free() is invoked.

> +       strbuf_release(&key);
> +       return want;
>  }
> --
> 1.9.0.GIT
