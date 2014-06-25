From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [RFC/PATCH] notes-util.c: replace git_config with git_config_get_string
Date: Wed, 25 Jun 2014 03:54:57 -0400
Message-ID: <CAPig+cRcbamkpeaoCMQ9yXtYeMEEL-ve--VWKg4MAWeS08Lqyg@mail.gmail.com>
References: <1403520105-23250-1-git-send-email-tanayabh@gmail.com>
	<1403520105-23250-4-git-send-email-tanayabh@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Tanay Abhra <tanayabh@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 25 09:55:02 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wzi2o-0008Bn-54
	for gcvg-git-2@plane.gmane.org; Wed, 25 Jun 2014 09:55:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755219AbaFYHy6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Jun 2014 03:54:58 -0400
Received: from mail-yk0-f172.google.com ([209.85.160.172]:50624 "EHLO
	mail-yk0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755223AbaFYHy5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jun 2014 03:54:57 -0400
Received: by mail-yk0-f172.google.com with SMTP id 142so887305ykq.3
        for <git@vger.kernel.org>; Wed, 25 Jun 2014 00:54:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=d91+fJZElZaYuV2XROc+dnw6A0z1ZPtHbDQE/jDbZIg=;
        b=N3WPxWUf11qgQ8tA1Bk9EC3mox8ellXWvZsUhivUK+CHYA+63p1/owzIcSOk01Xd5y
         atTTOozvpVoLO0HdXNmQYCLZdBHdAUxCdfD7Yj8iQ7xrprlRtUoDQR4unuJP9JcuoU76
         J/4tLv9lx4qPWFvf0K9bXm+xTzMrofxNAMUPyOO2ZT1qOLf3jIfKbfKbviw7iLICJw0B
         mcxjEiH+8cX1n3r1wPddan/7JzMwOCIndS06CusCl3DcjSOPjI5Eoj8nlo46lnWlH48c
         PNE2fTUwL51H4dT8jbCOdTX3tciY5bmEbvUd0/oEbMn9tD3I8WA3dk3709jAuM3ibWEH
         4jGA==
X-Received: by 10.236.39.109 with SMTP id c73mr8949489yhb.139.1403682897292;
 Wed, 25 Jun 2014 00:54:57 -0700 (PDT)
Received: by 10.170.120.69 with HTTP; Wed, 25 Jun 2014 00:54:57 -0700 (PDT)
In-Reply-To: <1403520105-23250-4-git-send-email-tanayabh@gmail.com>
X-Google-Sender-Auth: oyS-b3CYYcIIKY3_2qnKvMGAOMw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252437>

On Mon, Jun 23, 2014 at 6:41 AM, Tanay Abhra <tanayabh@gmail.com> wrote:
> Use git_config_get_string instead of git_config to take advantage of
> the config hash-table api which provides a cleaner control flow.
>
> Signed-off-by: Tanay Abhra <tanayabh@gmail.com>
> ---
>  notes-utils.c | 31 +++++++++++++++----------------
>  1 file changed, 15 insertions(+), 16 deletions(-)
>
> diff --git a/notes-utils.c b/notes-utils.c
> index a0b1d7b..fdc9912 100644
> --- a/notes-utils.c
> +++ b/notes-utils.c
> @@ -68,22 +68,23 @@ static combine_notes_fn parse_combine_notes_fn(const char *v)
>                 return NULL;
>  }
>
> -static int notes_rewrite_config(const char *k, const char *v, void *cb)
> +static void notes_rewrite_config(struct notes_rewrite_cfg *c)
>  {
> -       struct notes_rewrite_cfg *c = cb;
> -       if (starts_with(k, "notes.rewrite.") && !strcmp(k+14, c->cmd)) {
> -               c->enabled = git_config_bool(k, v);
> -               return 0;
> -       } else if (!c->mode_from_env && !strcmp(k, "notes.rewritemode")) {
> +       struct strbuf key = STRBUF_INIT;
> +       const char *v;
> +       strbuf_addf(&key, "notes.rewrite.%s", c->cmd);
> +
> +       if (!git_config_get_string(key.buf, &v))
> +               c->enabled = git_config_bool(key.buf, v);
> +
> +       if (!c->mode_from_env && !git_config_get_string("notes.rewritemode", &v)) {
>                 if (!v)
> -                       return config_error_nonbool(k);
> +                       config_error_nonbool("notes.rewritemode");

There's a behavior change here. In the original code, the callback
function would return -1, which would cause the program to die() if
the config.c:die_on_error flag was set. The new code merely emits an
error.

>                 c->combine = parse_combine_notes_fn(v);

Worse: Though you correctly emit an error when 'v' is NULL, you then
(incorrectly) invoke parse_combine_notes_fn() with that NULL value,
which will result in a crash.

> -               if (!c->combine) {
> +               if (!c->combine)
>                         error(_("Bad notes.rewriteMode value: '%s'"), v);
> -                       return 1;
> -               }
> -               return 0;
> -       } else if (!c->refs_from_env && !strcmp(k, "notes.rewriteref")) {
> +       }
> +       if (!c->refs_from_env && !git_config_get_string("notes.rewriteref", &v)) {
>                 /* note that a refs/ prefix is implied in the
>                  * underlying for_each_glob_ref */
>                 if (starts_with(v, "refs/notes/"))
> @@ -91,10 +92,8 @@ static int notes_rewrite_config(const char *k, const char *v, void *cb)
>                 else
>                         warning(_("Refusing to rewrite notes in %s"
>                                 " (outside of refs/notes/)"), v);
> -               return 0;
>         }
> -
> -       return 0;
> +       strbuf_release(&key);

It would be better to release the strbuf immediately after its final
use rather than waiting until the end of function. Not only does that
reduce cognitive load on people reading the code, but it also reduces
likelihood of 'key' being leaked if some future programmer inserts an
early 'return' into the function for some reason.

>  }
>
>
> @@ -123,7 +122,7 @@ struct notes_rewrite_cfg *init_copy_notes_for_rewrite(const char *cmd)
>                 c->refs_from_env = 1;
>                 string_list_add_refs_from_colon_sep(c->refs, rewrite_refs_env);
>         }
> -       git_config(notes_rewrite_config, c);
> +       notes_rewrite_config(c);
>         if (!c->enabled || !c->refs->nr) {
>                 string_list_clear(c->refs, 0);
>                 free(c->refs);
> --
> 1.9.0.GIT
