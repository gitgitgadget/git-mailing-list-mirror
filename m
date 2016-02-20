From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 06/21] convert manual allocations to argv_array
Date: Sat, 20 Feb 2016 03:07:00 -0500
Message-ID: <CAPig+cQsFAd4WEoHP-eoz9HCcVzY2uVcDH+_rvkoNjSe-Fg0oA@mail.gmail.com>
References: <20160219111941.GA31906@sigill.intra.peff.net>
	<20160219112324.GF9319@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Feb 20 09:07:11 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aX2ZJ-0002zA-5H
	for gcvg-git-2@plane.gmane.org; Sat, 20 Feb 2016 09:07:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1949380AbcBTIHD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Feb 2016 03:07:03 -0500
Received: from mail-vk0-f41.google.com ([209.85.213.41]:35861 "EHLO
	mail-vk0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1949035AbcBTIHA (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Feb 2016 03:07:00 -0500
Received: by mail-vk0-f41.google.com with SMTP id c3so93613653vkb.3
        for <git@vger.kernel.org>; Sat, 20 Feb 2016 00:07:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=s0E+GxGyM0DxKC6xci90eC4XL88nfRWwunUQRcZ4aE0=;
        b=uGUfj/BF48KWtMHg8xUIdnpZXf9c6NmVUtq0/XbOmnGyK7xI/Cn3BdDip3p4k/wG49
         Acx5gZ3hBDRZYn8QS3C2wb2rymcUTq5LCC9DREMuVa8vBw8yVa5iO2i00uOudriV630I
         HraEPTkcEAxBDGmeK9QPMGRpsfBlkTdNBP95wPsrz5KQfwP5koIJHgHlwpd+jI7yU80d
         XnOqd+wP+z32gvlrPEYBN66RIhmSpwomK+w3VooAzh7BIUVB8iId6qusBkxmJuHi4oh9
         vm+GOouc6n2S95ATT4YCc3qufnLQi0+sjuOlKRt1fDkFrRG+USBjtPvcj9te9KmJYlNR
         nsUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=s0E+GxGyM0DxKC6xci90eC4XL88nfRWwunUQRcZ4aE0=;
        b=ZEQhwCmEFchrHfv8Zm0xFrVd3lkLcr0WldN4Kkj4bN8KCMgbbdcnwUPipp6SWABcvn
         oX5WyOFUFw83pPkjWUDyTkBN2XRCeStCXyuHLm3Wl9WNTLHL8Ommy78kmjGlbXOz7HbZ
         S0ntHKWfGH5W+Fzpd4JZHoM+8nNqx6QuM/O/qejPDN6641vCfn1yPBn9kIFSOlqcLuWS
         XfQK/Ay3NBlxdzZqid90VfWdCnusG2io8IUu9G5o87a3kCghf0Oz/Oc+3z7Jdu+9IUgF
         3VVKCL886Q28q8wV5iF3tXS0lewJSQCHid5VM2ZfUYzp53m5PhKa5LI7NPlUoJBEkvU9
         IzxA==
X-Gm-Message-State: AG10YORTctygKwCH1nreQrvhXJj4Yd2oORNWg59cjfSvD5tnNnM9/unLJ0clcJwShHU6i010pfp45s8KFUmzSg==
X-Received: by 10.31.182.143 with SMTP id g137mr14475680vkf.45.1455955620091;
 Sat, 20 Feb 2016 00:07:00 -0800 (PST)
Received: by 10.31.62.203 with HTTP; Sat, 20 Feb 2016 00:07:00 -0800 (PST)
In-Reply-To: <20160219112324.GF9319@sigill.intra.peff.net>
X-Google-Sender-Auth: NiIyCWSrUwgW1I66hOLFP0PO9cY
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286766>

On Fri, Feb 19, 2016 at 6:23 AM, Jeff King <peff@peff.net> wrote:
> There are many manual argv allocations that predate the
> argv_array API. Switching to that API brings a few
> advantages:
>
>   1. We no longer have to manually compute the correct final
>      array size (so it's one less thing we can screw up).
>
>   2. In many cases we had to make a separate pass to count,
>      then allocate, then fill in the array. Now we can do it
>      in one pass, making the code shorter and easier to
>      follow.
>
>   3. argv_array handles memory ownership for us, making it
>      more obvious when things should be free()d and and when
>      not.
>
> Most of these cases are pretty straightforward. In some, we
> switch from "run_command_v" to "run_command" which lets us
> directly use the argv_array embedded in "struct
> child_process".
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> diff --git a/line-log.c b/line-log.c
> @@ -746,23 +747,16 @@ void line_log_init(struct rev_info *rev, const char *prefix, struct string_list
>         if (!rev->diffopt.detect_rename) {
> -               int i, count = 0;
> -               struct line_log_data *r = range;
> -               const char **paths;
> -               while (r) {
> -                       count++;
> -                       r = r->next;
> -               }
> -               paths = xmalloc((count+1)*sizeof(char *));
> -               r = range;
> -               for (i = 0; i < count; i++) {
> -                       paths[i] = xstrdup(r->path);
> -                       r = r->next;
> -               }
> -               paths[count] = NULL;
> +               struct line_log_data *r;
> +               struct argv_array paths = ARGV_ARRAY_INIT;
> +
> +               for (r = range; r; r = r->next)
> +                       argv_array_push(&paths, r->path);
>                 parse_pathspec(&rev->diffopt.pathspec, 0,
> -                              PATHSPEC_PREFER_FULL, "", paths);
> -               free(paths);
> +                              PATHSPEC_PREFER_FULL, "", paths.argv);
> +               /* argv strings are now owned by pathspec */
> +               paths.argc = 0;
> +               argv_array_clear(&paths);

This overly intimate knowledge of the internal implementation of
argv_array_clear() is rather ugly.

>         }
>  }
