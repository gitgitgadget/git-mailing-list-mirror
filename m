From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v3 3/4] setup: Add 'abspath_part_inside_repo' function
Date: Sat, 1 Feb 2014 09:31:26 +0700
Message-ID: <CACsJy8CaA6-4qc3BjNi0BCKPLBzh7Ttu6n7wpcj1ZknmEZW-MA@mail.gmail.com>
References: <1390781250-20389-2-git-send-email-martinerikwerner@gmail.com> <20140131202248.GD9731@mule>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>, richih@debian.org,
	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
To: Martin Erik Werner <martinerikwerner@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 01 03:32:07 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W9QNK-0007N6-DR
	for gcvg-git-2@plane.gmane.org; Sat, 01 Feb 2014 03:32:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754426AbaBACb6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 Jan 2014 21:31:58 -0500
Received: from mail-qc0-f179.google.com ([209.85.216.179]:65246 "EHLO
	mail-qc0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754378AbaBACb5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Jan 2014 21:31:57 -0500
Received: by mail-qc0-f179.google.com with SMTP id e16so8231134qcx.24
        for <git@vger.kernel.org>; Fri, 31 Jan 2014 18:31:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=hN+0qLGi/GzNmk8NcFY7zZW72HYNJAYCpq/7pfUWsbU=;
        b=J3muCF1xhqcfyXGt5wJ7ZXs9xQo9rFoRAjUJrYqSHJKIthwx1DCZSXYKyMkgqBPvjV
         R4a8wtSzg6kDzvxNddBsuXDVthPFJwSRhZCl9WVabgAnA4FVWJgVFrpgELKtLGCPClFy
         vu/4EPhqLdsW32EyexAbGQxDoglFMLv7OyJouqWIzchXbKwZ6zJU5Hiv+K0J8bC5F5X+
         bvsIe5PKZYF7JqAADqkLgVAuMJltaemDx864MUBxfI8Ov6hIfFKSJ0owQtX1pIEmg54F
         /ueULnLnYYQW7ZvJpyOhuho0vY6S9PreVTz7+Hu7Yi5Q+v3iCwqL12cv/U64KtMu9NAO
         Xp1A==
X-Received: by 10.140.107.138 with SMTP id h10mr34727429qgf.30.1391221916830;
 Fri, 31 Jan 2014 18:31:56 -0800 (PST)
Received: by 10.96.136.98 with HTTP; Fri, 31 Jan 2014 18:31:26 -0800 (PST)
In-Reply-To: <20140131202248.GD9731@mule>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241339>

On Sat, Feb 1, 2014 at 3:22 AM, Martin Erik Werner
<martinerikwerner@gmail.com> wrote:
> diff --git a/setup.c b/setup.c
> index 5432a31..e606846 100644
> --- a/setup.c
> +++ b/setup.c
> @@ -77,6 +77,69 @@ int path_inside_repo(const char *prefix, const char *path)
>         return 0;
>  }
>
> +/*
> + * It is ok if dst == src, but they should not overlap otherwise.
> + * No checking if the path is in fact an absolute path is done, and it must
> + * already be normalized.
> + *
> + * Find the part of an absolute path that lies inside the work tree by
> + * dereferencing symlinks outside the work tree, for example:
> + * /dir1/repo/dir2/file   (work tree is /dir1/repo)      -> dir2/file
> + * /dir/file              (work tree is /)               -> dir/file
> + * /dir/symlink1/symlink2 (symlink1 points to work tree) -> symlink2
> + * /dir/repo              (exactly equal to work tree)   -> (empty string)
> + */
> +int abspath_part_inside_repo(char *dst, const char* src)
> +{
> +       size_t len;
> +       char *dst0;
> +       char temp;
> +
> +       const char* work_tree = get_git_work_tree();
> +       if (!work_tree)
> +               return -1;
> +       len = strlen(src);
> +       dst0 = dst;
> +
> +       // check root level

Um.. no C++ style comments. And there should be a test that work_tree
is the prefix of src (common case). If so we can return early and do
not need to do real_path() on every path component.

> +       if (has_dos_drive_prefix(src)) {
> +               *dst++ = *src++;
> +               *dst++ = *src++;
> +               *dst++ = *src++;
> +       } else {
> +               *dst++ = *src++;
> +       }
> +       temp = *dst;
> +       *dst = '\0';
> +       if (strcmp(real_path(dst0), work_tree) == 0) {
> +               *dst = temp;
> +               memmove(dst0, src, len - (dst - dst0) + 1);
> +               return 0;
> +       }
> +       *dst = temp;
> +
> +       // check each level
> +       while (*dst != '\0') {
> +               *dst++ = *src++;
> +               if (*dst == '/') {
> +                       *dst = '\0';
> +                       if (strcmp(real_path(dst0), work_tree) == 0) {
> +                               memmove(dst0, src + 1, len - (dst - dst0));
> +                               return 0;
> +                       }
> +                       *dst = '/';
> +               }
> +       }
> +
> +       // check whole path
> +       if (strcmp(real_path(dst0), work_tree) == 0) {
> +               *dst0 = '\0';
> +               return 0;
> +       }
> +
> +       return -1;
> +}
> +
>  int check_filename(const char *prefix, const char *arg)
>  {
>         const char *name;
> --
> 1.8.5.2



-- 
Duy
