From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 1/2] builtin/mv: remove get_pathspec()
Date: Thu, 6 Aug 2015 14:46:06 -0400
Message-ID: <CAPig+cRREzwRJV-az-p-r1E7JyDqDZ4GPvM1cQQzXXNyLjGPUQ@mail.gmail.com>
References: <CAPig+cT_YB=HY9dBo5eRNu4qvCqCXRwwXgpxCA8YjxagP+sHfA@mail.gmail.com>
	<1438885632-26470-1-git-send-email-sbeller@google.com>
	<1438885632-26470-2-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Thu Aug 06 20:46:15 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZNQBB-0000Gq-At
	for gcvg-git-2@plane.gmane.org; Thu, 06 Aug 2015 20:46:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755966AbbHFSqJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Aug 2015 14:46:09 -0400
Received: from mail-yk0-f171.google.com ([209.85.160.171]:34814 "EHLO
	mail-yk0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755851AbbHFSqH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Aug 2015 14:46:07 -0400
Received: by ykax123 with SMTP id x123so70543724yka.1
        for <git@vger.kernel.org>; Thu, 06 Aug 2015 11:46:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=xltwRZeITMH4VtZoaqZHw7UVu0MhJqDJdbj8zOc5V+0=;
        b=lPBt9QuTL4sdX5sI15JEhuJdtjIXsl6MRf66zuDPK/00eWdyql+lNGyxghN2asGbQa
         bvEY/JSrymr8QK4g0G7gMt0XqiUWi01v5hd8715RZEBD4KrgsjGOkqXFjUQyFpt1yd3Q
         d0/62WAqdziRcl0LR/KshmLYDFTqFFqcCK8n747RPZtZT3EKwDcKpcQkROR9edDGvMXG
         Ll2IuD8Vd6iDkNeajexibDmrOuyWY+mZTZSYhuAXHLZbmDGZq8pCeaIXgcP1/WsIoidf
         gZVeiEwnm6+BuYzEimH1vEkCIpcky+O+sCBmKx8+Ns9SMonOhQLEU95RqlJEXZ0wNJiV
         rHVw==
X-Received: by 10.129.91.87 with SMTP id p84mr3715804ywb.95.1438886766432;
 Thu, 06 Aug 2015 11:46:06 -0700 (PDT)
Received: by 10.37.12.129 with HTTP; Thu, 6 Aug 2015 11:46:06 -0700 (PDT)
In-Reply-To: <1438885632-26470-2-git-send-email-sbeller@google.com>
X-Google-Sender-Auth: yOyQ4eLnbqeraWW808O1idX1994
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275436>

On Thu, Aug 6, 2015 at 2:27 PM, Stefan Beller <sbeller@google.com> wrote:
>  builtin/mv: remove get_pathspec()

Misleading. Perhaps rephrase as:

    mv: drop dependency upon deprecated get_pathspec

> `get_pathspec` is deprecated and builtin/mv.c is its last caller, so
> reimplement `get_pathspec` literally in builtin/mv.c

Curious. Since this is just moving code around, rather than doing the
actual work to complete the final step as stated by the NEEDSWORK
comment, isn't it just moving the "problem" from one location to
another? Is it worth the code churn?

> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
> diff --git a/builtin/mv.c b/builtin/mv.c
> index d1d4316..99e9b3c 100644
> --- a/builtin/mv.c
> +++ b/builtin/mv.c
> @@ -10,6 +10,7 @@
>  #include "string-list.h"
>  #include "parse-options.h"
>  #include "submodule.h"
> +#include "pathspec.h"
>
>  static const char * const builtin_mv_usage[] = {
>         N_("git mv [<options>] <source>... <destination>"),
> @@ -20,13 +21,16 @@ static const char * const builtin_mv_usage[] = {
>  #define KEEP_TRAILING_SLASH 2
>
>  static const char **internal_copy_pathspec(const char *prefix,
> -                                          const char **pathspec,
> +                                          const char **argv,

What is this change about? It doesn't seem to be related to anything
else in the patch or to its stated purpose, and makes the argument's
purpose less clear, so it's not obvious why it is a good change.

>                                            int count, unsigned flags)
>  {
>         int i;
> +       struct pathspec ps;
>         const char **result = xmalloc((count + 1) * sizeof(const char *));
> -       memcpy(result, pathspec, count * sizeof(const char *));
> +       memcpy(result, argv, count * sizeof(const char *));
>         result[count] = NULL;
> +
> +       /* NEEDSWORK: Move these preprocessing steps into parse_pathspec */
>         for (i = 0; i < count; i++) {
>                 int length = strlen(result[i]);
>                 int to_copy = length;
> @@ -42,7 +46,13 @@ static const char **internal_copy_pathspec(const char *prefix,
>                                 result[i] = it;
>                 }
>         }
> -       return get_pathspec(prefix, result);
> +
> +       parse_pathspec(&ps,
> +                      PATHSPEC_ALL_MAGIC &
> +                      ~(PATHSPEC_FROMTOP | PATHSPEC_LITERAL),
> +                      PATHSPEC_PREFER_CWD,
> +                      prefix, result);
> +       return ps._raw;
>  }
>
>  static const char *add_slash(const char *path)
> --
> 2.5.0.239.g9728e1d.dirty
