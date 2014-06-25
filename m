From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [RFC/PATCH V2] alias.c: replace git_config with git_config_get_string
Date: Tue, 24 Jun 2014 22:12:09 -0400
Message-ID: <CAPig+cQ3hzFFRRhbDTddArBC0nB9gZ7yMXuh35GHe73x-1JDng@mail.gmail.com>
References: <1403520105-23250-1-git-send-email-tanayabh@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Tanay Abhra <tanayabh@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 25 04:12:15 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wzch4-00045d-PX
	for gcvg-git-2@plane.gmane.org; Wed, 25 Jun 2014 04:12:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753189AbaFYCML (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jun 2014 22:12:11 -0400
Received: from mail-yk0-f175.google.com ([209.85.160.175]:62679 "EHLO
	mail-yk0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752417AbaFYCMK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jun 2014 22:12:10 -0400
Received: by mail-yk0-f175.google.com with SMTP id 9so732111ykp.34
        for <git@vger.kernel.org>; Tue, 24 Jun 2014 19:12:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=I8HCT2+XnpF/8b1bpQmMVZY3epMogpIFt6K3LAn9isE=;
        b=ae5RzDfsBVv/Zrk6yv3HX9MtmOtYTciiVFzbQiJQpXH6DzNGMH6MA4ZwwqGoBxV27P
         5mctFVcVW7+SLOAzCmikJoryhwh2tLsCtpA8GFmuaUI/9JUMNfIidnDk5giuPrd8i3HD
         niq9wbfsDdwb0R2iVaoU+jov72sZgqtHxOh4JLNwMx8PslNOGvgBpKKtXHLVHBdg4Fvk
         +onTUDoksxDfZRAPg0kPsYRD9k+me1+1zl0qEJQLiyh13v2KmD2KzKorCzG4bb8EeQ1r
         szvjR+YYA1EdwNde5+f1Ui7ET6dbiloYPyM03QP+WLNxVZWJlkQzt8zDAU+gGjNhwbZu
         VupQ==
X-Received: by 10.236.103.135 with SMTP id f7mr7086203yhg.102.1403662329428;
 Tue, 24 Jun 2014 19:12:09 -0700 (PDT)
Received: by 10.170.120.69 with HTTP; Tue, 24 Jun 2014 19:12:09 -0700 (PDT)
In-Reply-To: <1403520105-23250-1-git-send-email-tanayabh@gmail.com>
X-Google-Sender-Auth: qWcPdjX0zJOcHbyMdymkyf9EQd4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252431>

On Mon, Jun 23, 2014 at 6:41 AM, Tanay Abhra <tanayabh@gmail.com> wrote:
> Use git_config_get_string instead of git_config to take advantage of
> the config hash-table api which provides a cleaner control flow.
>
> Signed-off-by: Tanay Abhra <tanayabh@gmail.com>
> ---
>  alias.c | 28 ++++++++++------------------
>  1 file changed, 10 insertions(+), 18 deletions(-)
>
> diff --git a/alias.c b/alias.c
> index 5efc3d6..0fe32bc 100644
> --- a/alias.c
> +++ b/alias.c
> @@ -1,25 +1,17 @@
>  #include "cache.h"
>
> -static const char *alias_key;
> -static char *alias_val;
> -
> -static int alias_lookup_cb(const char *k, const char *v, void *cb)
> -{
> -       if (starts_with(k, "alias.") && !strcmp(k + 6, alias_key)) {
> -               if (!v)
> -                       return config_error_nonbool(k);
> -               alias_val = xstrdup(v);
> -               return 0;
> -       }
> -       return 0;
> -}
> -
>  char *alias_lookup(const char *alias)
>  {
> -       alias_key = alias;
> -       alias_val = NULL;
> -       git_config(alias_lookup_cb, NULL);
> -       return alias_val;
> +       const char *v;
> +       char *value;
> +       struct strbuf key = STRBUF_INIT;
> +       strbuf_addf(&key, "alias.%s", alias);
> +       git_config_get_string(key.buf, &v);
> +       if (!v)
> +               config_error_nonbool(key.buf);

If 'v' is NULL, you correctly report an error, but then fall through
and invoke xstrdup() with NULL, which invites undefined behavior [1].

[1]: http://pubs.opengroup.org/onlinepubs/009695399/functions/strdup.html

> +       value = xstrdup(v);
> +       strbuf_release(&key);
> +       return value;

You could release the strbuf earlier, which would allow you to 'return
xstrdup(v)' and drop the 'value' variable. Perhaps you want something
like this:

    const char *v;
    struct strbuf key = STRBUF_INIT;
    strbuf_addf(&key, "alias.%s", alias);
    git_config_get_string(key.buf, &v);
    if (v)
        config_error_nonbool(key.buf);
    strbuf_release(&key);
    return v ? xstrdup(v) : NULL;

>  }
>
>  #define SPLIT_CMDLINE_BAD_ENDING 1
> --
> 1.9.0.GIT
