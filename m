From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3 3/4] Provide a dirname() function when NO_LIBGEN_H=YesPlease
Date: Mon, 11 Jan 2016 15:33:49 -0500
Message-ID: <CAPig+cQmhc=DmptyYWy1p3z4rz7_h-3XRrtFH7XxoW77z5Mz-A@mail.gmail.com>
References: <cover.1452270051.git.johannes.schindelin@gmx.de>
	<cover.1452536924.git.johannes.schindelin@gmx.de>
	<0bab11634c8f05751b2ed5879bc4100441bba4b9.1452536924.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Jan 11 21:34:34 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aIjAf-0005Jf-0s
	for gcvg-git-2@plane.gmane.org; Mon, 11 Jan 2016 21:34:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932792AbcAKUe2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Jan 2016 15:34:28 -0500
Received: from mail-vk0-f67.google.com ([209.85.213.67]:33547 "EHLO
	mail-vk0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759567AbcAKUdu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jan 2016 15:33:50 -0500
Received: by mail-vk0-f67.google.com with SMTP id n1so5011380vkb.0
        for <git@vger.kernel.org>; Mon, 11 Jan 2016 12:33:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=t6prEF7RJ0CBbJYAKZXWFUvx1FjCOnL8bWY1l4993DI=;
        b=RmQHcCQ6wgLdWNXb4a2Xi2gzVr7ESFKH0+D9ks3jGntVS+V3QNuoB5lRoNIJgtzvGS
         gk8oK+2yEc4eWMWznLxpCDdYM3QEgQ8Rk2Vqrf5yhUQFd0I3lQ/HmfXH3wLwwaFIom8f
         eVOeFK5N1oNvK48nlBnMymc9xz0xmMMCO3f9LvEtLOm+sICGf/Cg8jucyK0mybpToCKP
         XshwZr6PUGFek5gmtD0y/bnDwHOnhEg4qmqTcmrFDqVIFl84L4Gupp0/2UsWCwBHdsJ6
         7fUwS4HiQPbnCkUWJS/qa7TXOT2GkPc3Iabm1qCpe1kAppX3EYhZvmTaMSbLrDDa/3SR
         tzDA==
X-Received: by 10.31.141.2 with SMTP id p2mr65888031vkd.37.1452544429131; Mon,
 11 Jan 2016 12:33:49 -0800 (PST)
Received: by 10.31.62.203 with HTTP; Mon, 11 Jan 2016 12:33:49 -0800 (PST)
In-Reply-To: <0bab11634c8f05751b2ed5879bc4100441bba4b9.1452536924.git.johannes.schindelin@gmx.de>
X-Google-Sender-Auth: ah_7u99x9PJXQMItBlPrO8xtF5o
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283714>

On Mon, Jan 11, 2016 at 1:30 PM, Johannes Schindelin
<johannes.schindelin@gmx.de> wrote:
> When there is no `libgen.h` to our disposal, we miss the `dirname()`
> function.
>
> So far, we only had one user of that function: credential-cache--daemon
> (which was only compiled when Unix sockets are available, anyway). But
> now we also have `builtin/am.c` as user, so we need it.
>
> Since `dirname()` is a sibling of `basename()`, we simply put our very
> own `gitdirname()` implementation next to `gitbasename()` and use it
> if `NO_LIBGEN_H` has been set.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
> diff --git a/compat/basename.c b/compat/basename.c
> @@ -25,3 +26,46 @@ char *gitbasename (char *path)
> +char *gitdirname(char *path)
> +{
> +       char *p = path, *slash = NULL, c;
> +       int dos_drive_prefix;
> +
> +       if (!p)
> +               return ".";
> +
> +       if ((dos_drive_prefix = skip_dos_drive_prefix(&p)) && !*p) {
> +               static struct strbuf buf = STRBUF_INIT;
> +
> +dot:
> +               strbuf_reset(&buf);
> +               strbuf_addf(&buf, "%.*s.", dos_drive_prefix, path);
> +               return buf.buf;
> +       }
> +
> +       /*
> +        * POSIX.1-2001 says dirname("/") should return "/", and dirname("//")
> +        * should return "//", but dirname("///") should return "/" again.
> +        */
> +       if (is_dir_sep(*p)) {
> +               if (!p[1] || (is_dir_sep(p[1]) && !p[2]))
> +                       return path;
> +               slash = ++p;
> +       }
> +       while ((c = *(p++)))
> +               if (is_dir_sep(c)) {
> +                       char *tentative = p - 1;
> +
> +                       /* POSIX.1-2001 says to ignore trailing slashes */
> +                       while (is_dir_sep(*p))
> +                               p++;
> +                       if (*p)
> +                               slash = tentative;
> +               }
> +
> +       if (!slash)
> +               goto dot;
> +       *slash = '\0';
> +       return path;
> +}

I wonder if this would be a bit easier to follow if it was structured
something like this:

    static struct strbuf buf = STRBUF_INIT;

    if ((dos_drive_prefix = skip_dos_drive_prefix(&p)) && !*p)
        goto dot;

    ...
    if (is_dir_sep(*p)) {
        ...
    }
    ...
    while ((c = *(p++)))
        ...

    if (slash) {
        *slash = '\0';
        return path;
    }

    dot:
    strbuf_reset(&buf);
    strbuf_addf(&buf, "%.*s.", dos_drive_prefix, path);
    return buf.buf;
