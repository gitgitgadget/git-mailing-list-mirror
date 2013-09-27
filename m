From: Phil Hord <phil.hord@gmail.com>
Subject: Re: [PATCH 1/3] for-each-ref: introduce %C(...) for color
Date: Fri, 27 Sep 2013 09:16:08 -0400
Message-ID: <CABURp0r-hbULajmeM=xGB1EW=8JG54Gbh69+drQiyBgqyKZp7w@mail.gmail.com>
References: <1380283828-25420-1-git-send-email-artagnon@gmail.com> <1380283828-25420-2-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 27 15:16:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VPXuS-0006cE-OQ
	for gcvg-git-2@plane.gmane.org; Fri, 27 Sep 2013 15:16:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752005Ab3I0NQh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Sep 2013 09:16:37 -0400
Received: from mail-wi0-f179.google.com ([209.85.212.179]:64645 "EHLO
	mail-wi0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751860Ab3I0NQg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Sep 2013 09:16:36 -0400
Received: by mail-wi0-f179.google.com with SMTP id hm2so810985wib.0
        for <git@vger.kernel.org>; Fri, 27 Sep 2013 06:16:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=qYPLh8Di/KL4VdrLuOdWIKb/dTKI8omnwDaEfkeHb/A=;
        b=Zv3rCcNUfND9vJjJGtIg/qoA7MzqH/h+nGIYauU8dBRD00oTNII8qCJvOWEsPigD3x
         QEeYEAIDTlHqciw/u8InR+NQ1bqoIxToGmxHhq4rlkcXi1+lG/6MuDN3YfZLC6VUIOLN
         dYyvda5SA/5G0sdOE7QaKyDrrR3fX+mb5+4MhI/I6e9tZNo5XQ9px6BOXuripdp+sHTH
         XO1WMK3VMD+YF/1Wu13usjrdoaUg4rsLuE8GFxlm8ollumgweF/EslqqSP2yrvGputqg
         xBKA89E0VaN2oU57/iKemanVjfxIoLRMkOv2WQ7Vw8FWD1EAQegJGn9tORwOzLoMCmET
         KVCQ==
X-Received: by 10.194.200.100 with SMTP id jr4mr5562345wjc.37.1380287794956;
 Fri, 27 Sep 2013 06:16:34 -0700 (PDT)
Received: by 10.227.145.73 with HTTP; Fri, 27 Sep 2013 06:16:08 -0700 (PDT)
In-Reply-To: <1380283828-25420-2-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235458>

On Fri, Sep 27, 2013 at 8:10 AM, Ramkumar Ramachandra
<artagnon@gmail.com> wrote:
> Enhance 'git for-each-ref' with color formatting options.  You can now
> use the following format in for-each-ref:
>
>   %C(green)%(refname:short)%C(reset)
>
> Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
> ---
>  Documentation/git-for-each-ref.txt |  4 +++-
>  builtin/for-each-ref.c             | 23 +++++++++++++++++++----
>  2 files changed, 22 insertions(+), 5 deletions(-)
>
> diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for-each-ref.txt
> index f2e08d1..078a116 100644
> --- a/Documentation/git-for-each-ref.txt
> +++ b/Documentation/git-for-each-ref.txt
> @@ -45,7 +45,9 @@ OPTIONS
>         It also interpolates `%%` to `%`, and `%xx` where `xx`
>         are hex digits interpolates to character with hex code
>         `xx`; for example `%00` interpolates to `\0` (NUL),
> -       `%09` to `\t` (TAB) and `%0a` to `\n` (LF).
> +       `%09` to `\t` (TAB) and `%0a` to `\n` (LF). Additionally,
> +       colors can be specified using `%C(colorname)`. Use
> +       `%C(reset)` to reset the color.

Reduce the color explanation here and refer to the config page.
Something like pretty-formats does:

    '%C(...)': color specification, as described in color.branch.*
config option;

>
>  <pattern>...::
>         If one or more patterns are given, only refs are shown that
> diff --git a/builtin/for-each-ref.c b/builtin/for-each-ref.c
> index 1d4083c..a1ca186 100644
> --- a/builtin/for-each-ref.c
> +++ b/builtin/for-each-ref.c
> @@ -9,6 +9,7 @@
>  #include "quote.h"
>  #include "parse-options.h"
>  #include "remote.h"
> +#include "color.h"
>
>  /* Quoting styles */
>  #define QUOTE_NONE 0
> @@ -155,10 +156,13 @@ static const char *find_next(const char *cp)
>         while (*cp) {
>                 if (*cp == '%') {
>                         /*
> +                        * %C( is the start of a color;
>                          * %( is the start of an atom;
>                          * %% is a quoted per-cent.
>                          */
> -                       if (cp[1] == '(')
> +                       if (cp[1] == 'C' && cp[2] == '(')
> +                               return cp;
> +                       else if (cp[1] == '(')
>                                 return cp;
>                         else if (cp[1] == '%')
>                                 cp++; /* skip over two % */
> @@ -180,8 +184,11 @@ static int verify_format(const char *format)
>                 const char *ep = strchr(sp, ')');
>                 if (!ep)
>                         return error("malformed format string %s", sp);
> -               /* sp points at "%(" and ep points at the closing ")" */
> -               parse_atom(sp + 2, ep);
> +               /* Ignore color specifications: %C(
> +                * sp points at "%(" and ep points at the closing ")"
> +                */
> +               if (prefixcmp(sp, "%C("))
> +                       parse_atom(sp + 2, ep);
>                 cp = ep + 1;
>         }
>         return 0;
> @@ -933,12 +940,20 @@ static void emit(const char *cp, const char *ep)
>  static void show_ref(struct refinfo *info, const char *format, int quote_style)
>  {
>         const char *cp, *sp, *ep;
> +       char color[COLOR_MAXLEN];
>
>         for (cp = format; *cp && (sp = find_next(cp)); cp = ep + 1) {
>                 ep = strchr(sp, ')');
>                 if (cp < sp)
>                         emit(cp, sp);
> -               print_value(info, parse_atom(sp + 2, ep), quote_style);
> +
> +               /* Do we have a color specification? */
> +               if (!prefixcmp(sp, "%C("))
> +                       color_parse_mem(sp + 3, ep - sp - 3, "--format", color);
> +               else {
> +                       printf("%s", color);

'color' used uninitialized here?

> +                       print_value(info, parse_atom(sp + 2, ep), quote_style);
> +               }
>         }
>         if (*cp) {
>                 sp = cp + strlen(cp);
> --
> 1.8.4.478.g55109e3
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
