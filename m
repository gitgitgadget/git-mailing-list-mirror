From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 04/14] shortlog: use skip_prefix_icase to parse "Author" lines
Date: Thu, 31 Dec 2015 01:47:21 -0500
Message-ID: <CAPig+cTxRbASyLhQH_WZDLX_RTY4t=F-QJeo5Uc5zWUxF1jvZw@mail.gmail.com>
References: <20151229071847.GA8726@sigill.intra.peff.net>
	<20151229072746.GD8842@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Dec 31 07:48:03 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aEX1m-0000Uy-08
	for gcvg-git-2@plane.gmane.org; Thu, 31 Dec 2015 07:48:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751247AbbLaGrX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Dec 2015 01:47:23 -0500
Received: from mail-vk0-f53.google.com ([209.85.213.53]:33404 "EHLO
	mail-vk0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750704AbbLaGrW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Dec 2015 01:47:22 -0500
Received: by mail-vk0-f53.google.com with SMTP id a188so214505082vkc.0
        for <git@vger.kernel.org>; Wed, 30 Dec 2015 22:47:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=uryszsn2UrbjsYkkBV2JGaR10rs74VZkrf7LEKzMvhM=;
        b=FpAtUoHJwDFC+xgUxf0j6UX012MEhcxot438ekVJutTp84v04AC6jIWcSQ3BAbUGnH
         s36IYiBm16WKHUsQYnhSPjb0E6oIA3vhzVjkqp+oQCgqvi9rGpqS4Do30ndT5M2TyeBA
         egqQv6w5ueb9jEWSm7PBZQBHlgg2v7hdh7BTMttbaOfT5iI2ZvJv7dI0gvRwLWWdR6V1
         65fRi5nBqGQOvvBxWlJMDmLdA/xqucrViRMzEbVd1fVcOMQDcFb5Tt0poS90ileO6d4f
         mvKIclbDEeJKzytyPG3dLoKWARKkV9y9/51Oexnja9pYk+Wt7WoXAuJlol6F6uvweh8G
         12gg==
X-Received: by 10.31.58.142 with SMTP id h136mr45169801vka.115.1451544441580;
 Wed, 30 Dec 2015 22:47:21 -0800 (PST)
Received: by 10.31.62.203 with HTTP; Wed, 30 Dec 2015 22:47:21 -0800 (PST)
In-Reply-To: <20151229072746.GD8842@sigill.intra.peff.net>
X-Google-Sender-Auth: VzOcqK-3Qx2vhO4MPwFwu5tg7Fs
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283231>

On Tue, Dec 29, 2015 at 2:27 AM, Jeff King <peff@peff.net> wrote:
> Because we must match both "Author" and "author" here, we
> could not use skip_prefix, and had to hand-code a partial
> case-insensitive match. Now that we have skip_prefix_case,

s/skip_prefix_case/skip_prefix_icase/

> we can use it. This is technically more liberal in what it
> matches (e.g., it will match AUTHOR), but in this particular
> case that that's OK (we are matching git-log output, so we

s/that that's/that's/

> expect arbitrary data like commit headers to be indented).
>
> In addition to being easier to read, this will make the code
> easier to adapt for matching other lines.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> diff --git a/builtin/shortlog.c b/builtin/shortlog.c
> @@ -94,8 +94,8 @@ static void read_from_stdin(struct shortlog *log)
>         char author[1024], oneline[1024];
>
>         while (fgets(author, sizeof(author), stdin) != NULL) {
> -               if (!(author[0] == 'A' || author[0] == 'a') ||
> -                   !starts_with(author + 1, "uthor: "))
> +               const char *v;
> +               if (!skip_prefix_icase(author, "Author: ", &v))
>                         continue;
>                 while (fgets(oneline, sizeof(oneline), stdin) &&
>                        oneline[0] != '\n')
> @@ -103,7 +103,7 @@ static void read_from_stdin(struct shortlog *log)
>                 while (fgets(oneline, sizeof(oneline), stdin) &&
>                        oneline[0] == '\n')
>                         ; /* discard blanks */
> -               insert_one_record(log, author + 8, oneline);
> +               insert_one_record(log, v, oneline);
>         }
>  }
>
> --
> 2.7.0.rc3.367.g09631da
