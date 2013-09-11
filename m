From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 2/2] rm: re-use parse_pathspec's trailing-slash removal
Date: Wed, 11 Sep 2013 14:48:51 +0700
Message-ID: <CACsJy8Dw+RJor-XfjFQC5U5Pt39TZ656fEnkFxpDnx=kTqvADQ@mail.gmail.com>
References: <cover.1378840318.git.john@keeping.me.uk> <b16901cdc3d433a8e0f7078475cb06f90b4590dd.1378840318.git.john@keeping.me.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Wed Sep 11 09:49:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VJfB1-0006z8-4s
	for gcvg-git-2@plane.gmane.org; Wed, 11 Sep 2013 09:49:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752380Ab3IKHtX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Sep 2013 03:49:23 -0400
Received: from mail-oa0-f49.google.com ([209.85.219.49]:51028 "EHLO
	mail-oa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751797Ab3IKHtW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Sep 2013 03:49:22 -0400
Received: by mail-oa0-f49.google.com with SMTP id i7so8943645oag.8
        for <git@vger.kernel.org>; Wed, 11 Sep 2013 00:49:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=hNHIYce7cXZmqLhaEwJAgkK23Qrp4eAN/PJda9vJCq4=;
        b=bOGxzDxbLAf9ayrsoyYNzjqWj1+ucTknF92LoM2C4Kzga8lebNKWpfhPMb8r/vhszh
         bVV6P7S6ffGKhdc/ONRzcUgmDIqk9HpT4aDmJ7OOlIk6S+H1jDTOM9EikW15N8WPthZC
         51rAXt7MUYtFUhhzVuQ/u205Kl+FcNyVtbe0SwwWpnyeWaQUACUJCC5V/CvDyyeaxHCA
         e0c802xEZyyViRiIeKpMVbV59ZMBHJc8UKm4b9+BS6VRboxfFFDaWX3rerlh/Ng2q7xJ
         ABwU7o6HD1hPUEi35mqhk46eddM8xhv+U2KPFzgD3UzQsJ1oAD/c66bLXr2hejLJTmMr
         Bmbw==
X-Received: by 10.182.233.198 with SMTP id ty6mr160938obc.31.1378885762054;
 Wed, 11 Sep 2013 00:49:22 -0700 (PDT)
Received: by 10.182.49.233 with HTTP; Wed, 11 Sep 2013 00:48:51 -0700 (PDT)
In-Reply-To: <b16901cdc3d433a8e0f7078475cb06f90b4590dd.1378840318.git.john@keeping.me.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234548>

On Wed, Sep 11, 2013 at 2:13 AM, John Keeping <john@keeping.me.uk> wrote:
> Instead of re-implementing the "remove trailing slashes" loop in
> builtin/rm.c just pass PATHSPEC_STRIP_SUBMODULE_SLASH_CHEAP to
> parse_pathspec.
>
> Signed-off-by: John Keeping <john@keeping.me.uk>
> ---
>  builtin/rm.c | 20 ++++----------------
>  1 file changed, 4 insertions(+), 16 deletions(-)
>
> diff --git a/builtin/rm.c b/builtin/rm.c
> index 9b59ab3..3a0e0ea 100644
> --- a/builtin/rm.c
> +++ b/builtin/rm.c
> @@ -298,22 +298,10 @@ int cmd_rm(int argc, const char **argv, const char *prefix)
>         if (read_cache() < 0)
>                 die(_("index file corrupt"));
>
> -       /*
> -        * Drop trailing directory separators from directories so we'll find
> -        * submodules in the index.
> -        */
> -       for (i = 0; i < argc; i++) {
> -               size_t pathlen = strlen(argv[i]);
> -               if (pathlen && is_dir_sep(argv[i][pathlen - 1]) &&
> -                   is_directory(argv[i])) {
> -                       do {
> -                               pathlen--;
> -                       } while (pathlen && is_dir_sep(argv[i][pathlen - 1]));
> -                       argv[i] = xmemdupz(argv[i], pathlen);
> -               }
> -       }
> -
> -       parse_pathspec(&pathspec, 0, PATHSPEC_PREFER_CWD, prefix, argv);
> +       parse_pathspec(&pathspec, 0,
> +                      PATHSPEC_PREFER_CWD |
> +                      PATHSPEC_STRIP_SUBMODULE_SLASH_CHEAP,

I notice that _CHEAP implementation and the removed code are not
exactly the same. But I think they have the same purpose so it's
probably ok even there are some subtle behavioral changes.

You may want to improve _CHEAP to remove consecutive trailing slashes
(i.e. foo//// -> foo) too. And maybe is is_dir_sep() instead of
explicit == '/' comparison in there.

> +                      prefix, argv);
>         refresh_index(&the_index, REFRESH_QUIET, &pathspec, NULL, NULL);
>
>         seen = xcalloc(pathspec.nr, 1);
-- 
Duy
