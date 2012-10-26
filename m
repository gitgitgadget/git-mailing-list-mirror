From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH] replace: parse revision argument for -d
Date: Fri, 26 Oct 2012 17:25:50 +0200
Message-ID: <CAP8UFD3MNwpwzD-eNEHDLRSkLskXfW-tF061U=Nxc-OrTf4znw@mail.gmail.com>
References: <807340e40adb1fc97cd97161fe1fabd292bc79c3.1351258394.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Fri Oct 26 17:26:05 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TRlnQ-0006LT-9T
	for gcvg-git-2@plane.gmane.org; Fri, 26 Oct 2012 17:26:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933811Ab2JZPZw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Oct 2012 11:25:52 -0400
Received: from mail-wg0-f44.google.com ([74.125.82.44]:34982 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933738Ab2JZPZv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Oct 2012 11:25:51 -0400
Received: by mail-wg0-f44.google.com with SMTP id dr13so2190455wgb.1
        for <git@vger.kernel.org>; Fri, 26 Oct 2012 08:25:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=ty+oaNAAU84eDJUzjnlEVjN1oALku04B3q6Ps+/M8W4=;
        b=tPCY0XoELWboWYznCbW4600XzCFbLthjizGttUI+lMCxHLNH2jxoYy9Mk9QgelYgPz
         /ZW9CGoICu+Q4zXx4i37LxKsIe+7ZpzCqyvZXAuhe8nKOfBdEJqcjd9bnAEG66Omdjqn
         QcPx7s5ppnL+KUfwvyZeQiuqq5QKAu50AiZvjGY8vI5/sGdoCls+9F+BurZzSx4PyMiL
         F1leBr9CuH2DKG8aIy5ihQqvqZxNvnKzJoGFpwMNgvNsRrtz8/rg0o2TNdDIHDjMkpn3
         8xU5rIxCawE6fCkZrYJuBE5fsX7ENzIwIdqDfmiSS+vR041v2IYR6Be6MA82wBP6Otlu
         lmGQ==
Received: by 10.216.144.69 with SMTP id m47mr13864294wej.183.1351265150098;
 Fri, 26 Oct 2012 08:25:50 -0700 (PDT)
Received: by 10.194.138.42 with HTTP; Fri, 26 Oct 2012 08:25:50 -0700 (PDT)
In-Reply-To: <807340e40adb1fc97cd97161fe1fabd292bc79c3.1351258394.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208454>

Hi,

On Fri, Oct 26, 2012 at 3:33 PM, Michael J Gruber
<git@drmicha.warpmail.net> wrote:
> 'git replace' parses the revision arguments when it creates replacements
> (so that a sha1 can be abbreviated, e.g.) but not when deleting
> replacements.
>
> This sucks.
>
> Make it parse the argument to 'replace -d' in the same way.

Nit: there could be more than one argument to 'replace -d', so perhaps
"each argument" is better.

> Just in case someone lost the replacement object before deleting the
> replacement, take the argument literally if it can not be resolved to a

Here too.

> full sha1.
>
> Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
> ---
>  builtin/replace.c | 15 ++++++++++-----
>  1 file changed, 10 insertions(+), 5 deletions(-)
>
> diff --git a/builtin/replace.c b/builtin/replace.c
> index e3aaf70..80e2039 100644
> --- a/builtin/replace.c
> +++ b/builtin/replace.c
> @@ -46,24 +46,29 @@ typedef int (*each_replace_name_fn)(const char *name, const char *ref,
>
>  static int for_each_replace_name(const char **argv, each_replace_name_fn fn)
>  {
> -       const char **p;
> +       const char **p, *q;
>         char ref[PATH_MAX];
>         int had_error = 0;
>         unsigned char sha1[20];
>
>         for (p = argv; *p; p++) {
> -               if (snprintf(ref, sizeof(ref), "refs/replace/%s", *p)
> +               q = *p;
> +               if (get_sha1(q, sha1))
> +                       warning("Failed to resolve '%s' as a valid ref; taking it literally.", q);
> +               else
> +                       q = sha1_to_hex(sha1);
> +               if (snprintf(ref, sizeof(ref), "refs/replace/%s", q)
>                                         >= sizeof(ref)) {
> -                       error("replace ref name too long: %.*s...", 50, *p);
> +                       error("replace ref name too long: %.*s...", 50, q);
>                         had_error = 1;
>                         continue;
>                 }
>                 if (read_ref(ref, sha1)) {
> -                       error("replace ref '%s' not found.", *p);
> +                       error("replace ref '%s' not found.", q);
>                         had_error = 1;
>                         continue;
>                 }
> -               if (fn(*p, ref, sha1))
> +               if (fn(q, ref, sha1))
>                         had_error = 1;
>         }
>         return had_error;

Looks good to me.

Thanks,
Christian.
