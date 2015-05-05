From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v10 3/4] cat-file: teach cat-file a '--allow-unknown-type' option
Date: Mon, 4 May 2015 21:29:16 -0400
Message-ID: <CAPig+cSw_AAQ+sdUu2-64z+u9SEDS_sU2ObATP4puM5GD1VOyA@mail.gmail.com>
References: <55463094.9040204@gmail.com>
	<1430663402-26717-1-git-send-email-karthik.188@gmail.com>
	<1430663402-26717-3-git-send-email-karthik.188@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 05 03:30:25 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YpRgn-0002xL-Bm
	for gcvg-git-2@plane.gmane.org; Tue, 05 May 2015 03:30:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752633AbbEEB3V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 May 2015 21:29:21 -0400
Received: from mail-ig0-f172.google.com ([209.85.213.172]:38750 "EHLO
	mail-ig0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752405AbbEEB3R (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 May 2015 21:29:17 -0400
Received: by igbhj9 with SMTP id hj9so98836260igb.1
        for <git@vger.kernel.org>; Mon, 04 May 2015 18:29:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=Bckp4BDCODl8b2X5RNfSGc7f+DyslhBDf4hyXbeawPw=;
        b=sTP9U2bBOwyc4gjXXAT44VF08JKn6wAz7G+w4v9DQV+yPh2t3WtOyPkYX6U2PPcHwq
         gZBhU0wvPsNb5aa4POpJ+8z5bXpPKwUsIwM58uWpts+JLyby4GlTWqoKUovAnmbH0U5O
         Zv4/gNX7meutFHme4NsMzKacSFmq4V0+zrpJujXVn2uhNlnctqKGpLy5I1FnyeVKTYIQ
         GQiexAtgWgH66251uKrhPR45xFwF7vw+4/NC+6q3o4RKCAMuNrwsAamSUGRKbTW1mIWm
         8u2KXNuUWvPNrG0M9xEIdsWtIC7Vyi0O3JhYYdnvfsw121ZK3id0Fc7Kgu1PztUQa5TK
         bwkA==
X-Received: by 10.107.31.134 with SMTP id f128mr31542012iof.19.1430789356500;
 Mon, 04 May 2015 18:29:16 -0700 (PDT)
Received: by 10.107.28.132 with HTTP; Mon, 4 May 2015 18:29:16 -0700 (PDT)
In-Reply-To: <1430663402-26717-3-git-send-email-karthik.188@gmail.com>
X-Google-Sender-Auth: _ourbfD4GW2XTIy6XICmXSRnWF4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268377>

On Sun, May 3, 2015 at 10:30 AM, Karthik Nayak <karthik.188@gmail.com> wrote:
> 'git cat-file' throws an error while trying to print the type or
> size of a broken/corrupt object. This is because these objects are
> usually of unknown types.
>
> Teach git cat-file a '--allow-unknown-type' option where it prints
> the type or size of a broken/corrupt object without throwing
> an error.
>
> Modify '-t' and '-s' options to call sha1_object_info_extended()
> directly to support the '--allow-unknown-type' option.
>
> Add documentation for 'cat-file --allow-unknown-type'.

This round is looking much better than earlier rounds. Just a few very
minor comments below...

> Helped-by: Junio C Hamano <gitster@pobox.com>
> Helped-by: Eric Sunshine <sunshine@sunshineco.com>
> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
>
> cat-file: add documentation for '--allow-unknown-type' option.
>
> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>

This got botched when you folded the documentation patch into this
one. Drop the redundant "cat-file: add documentation..." line and your
extra sign-off.

> ---
> diff --git a/builtin/cat-file.c b/builtin/cat-file.c
> index 53b5376..ecb4888 100644
> --- a/builtin/cat-file.c
> +++ b/builtin/cat-file.c
> @@ -9,13 +9,20 @@
>  #include "userdiff.h"
>  #include "streaming.h"
>
> -static int cat_one_file(int opt, const char *exp_type, const char *obj_name)
> +static int cat_one_file(int opt, const char *exp_type, const char *obj_name,
> +                       int unknown_type)
>  {
>         unsigned char sha1[20];
>         enum object_type type;
>         char *buf;
>         unsigned long size;
>         struct object_context obj_context;
> +       struct object_info oi = {NULL};
> +       struct strbuf sb = STRBUF_INIT;
> +       unsigned flags = LOOKUP_REPLACE_OBJECT;
> +
> +       if (unknown_type)
> +               flags |= LOOKUP_UNKNOWN_OBJECT;

Nit: 'allow_unknown' (or perhaps 'allow_unknown_type') would be a more
informative variable name than 'unknown_type', and would make this
conditional easier to understand.

>         if (get_sha1_with_context(obj_name, 0, sha1, &obj_context))
>                 die("Not a valid object name %s", obj_name);
> @@ -359,6 +368,7 @@ int cmd_cat_file(int argc, const char **argv, const char *prefix)
>         int opt = 0;
>         const char *exp_type = NULL, *obj_name = NULL;
>         struct batch_options batch = {0};
> +       int unknown_type = 0;

Ditto: s/unknown_type/allow_unknown/

>         const struct option options[] = {
>                 OPT_GROUP(N_("<type> can be one of: blob, tree, commit, tag")),
> @@ -369,6 +379,8 @@ int cmd_cat_file(int argc, const char **argv, const char *prefix)
>                 OPT_CMDMODE('p', NULL, &opt, N_("pretty-print object's content"), 'p'),
>                 OPT_CMDMODE(0, "textconv", &opt,
>                             N_("for blob objects, run textconv on object's content"), 'c'),
> +               OPT_BOOL( 0, "allow-unknown-type", &unknown_type,
> +                         N_("allow -s and -t to work with broken/corrupt objects")),
>                 { OPTION_CALLBACK, 0, "batch", &batch, "format",
>                         N_("show info and content of objects fed from the standard input"),
>                         PARSE_OPT_OPTARG, batch_option_callback },
> @@ -402,5 +414,7 @@ int cmd_cat_file(int argc, const char **argv, const char *prefix)
>         if (batch.enabled)
>                 return batch_objects(&batch);
>
> -       return cat_one_file(opt, exp_type, obj_name);
> +       if (unknown_type && opt != 't' && opt != 's')
> +               die("git cat-file --allow-unknown-type: use with -s or -t");
> +       return cat_one_file(opt, exp_type, obj_name, unknown_type);
>  }
> --
> 2.4.0.rc1.250.gfbd73bd
