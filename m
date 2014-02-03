From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v5 5/5] setup: Don't dereference in-tree symlinks for
 absolute paths
Date: Mon, 3 Feb 2014 11:15:57 +0700
Message-ID: <CACsJy8DX8bh2cAx+a_cJafAOYB7Ly=y28jAGo1L8NEmkWaZv=Q@mail.gmail.com>
References: <1391306351-13237-1-git-send-email-martinerikwerner@gmail.com>
 <1391358940-17373-1-git-send-email-martinerikwerner@gmail.com> <1391358940-17373-6-git-send-email-martinerikwerner@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>, richih@debian.org,
	=?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
	Junio C Hamano <gitster@pobox.com>,
	David Kastrup <dak@gnu.org>
To: Martin Erik Werner <martinerikwerner@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 03 05:16:44 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WAAxf-0004sZ-3u
	for gcvg-git-2@plane.gmane.org; Mon, 03 Feb 2014 05:16:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752800AbaBCEQg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Feb 2014 23:16:36 -0500
Received: from mail-qa0-f47.google.com ([209.85.216.47]:36649 "EHLO
	mail-qa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752695AbaBCEQ1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Feb 2014 23:16:27 -0500
Received: by mail-qa0-f47.google.com with SMTP id j5so9417472qaq.34
        for <git@vger.kernel.org>; Sun, 02 Feb 2014 20:16:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=7cyYaP09VyyViAJCGfYj1MIbxmTKbMPfR3mmMgZ0jCI=;
        b=q+ybKpwDGb61O3YPLvxSb+jzuIonbigrF+vNFjdKQRDiXWQ7D7flfPsLqOtUul04nE
         xCCGbT4+mjcnNNEkyf1uXS5MaUxTc6GumKmRod9VvWWKJr9aOTAwxd7ljcPmMrdzNfXW
         toFdJGLsEIAQ53ZoUIsu8i6G/DsePApNCn4TWbOSbIHUwAByQqvDMkDxX4pe7srU7hXF
         DWQZSwr+nuTd0BKU1aUaD83spFTbAFe9bQBGLh6IbyqQQlCThm88i3aK55HxftpO1Y5A
         Y9mT/xHmdwvjHXYPoNbKhIAKRkbDNzGx8ySB3WLa+1GcXgbdtbK4pWvaGcBnV39hjbBJ
         S5qg==
X-Received: by 10.140.47.212 with SMTP id m78mr49696819qga.21.1391400987092;
 Sun, 02 Feb 2014 20:16:27 -0800 (PST)
Received: by 10.96.136.98 with HTTP; Sun, 2 Feb 2014 20:15:57 -0800 (PST)
In-Reply-To: <1391358940-17373-6-git-send-email-martinerikwerner@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241394>

On Sun, Feb 2, 2014 at 11:35 PM, Martin Erik Werner
<martinerikwerner@gmail.com> wrote:
> diff --git a/setup.c b/setup.c
> index a2e60ab..230505c 100644
> --- a/setup.c
> +++ b/setup.c
> @@ -86,11 +86,23 @@ char *prefix_path_gently(const char *prefix, int len,
>         const char *orig = path;
>         char *sanitized;
>         if (is_absolute_path(orig)) {
> -               const char *temp = real_path(path);
> -               sanitized = xmalloc(len + strlen(temp) + 1);
> -               strcpy(sanitized, temp);
> +               char *npath;
> +
> +               npath = xmalloc(strlen(path) + 1);
>                 if (remaining_prefix)
>                         *remaining_prefix = 0;
> +               if (normalize_path_copy_len(npath, path, remaining_prefix)) {
> +                       free(npath);
> +                       return NULL;
> +               }
> +               if (abspath_part_inside_repo(npath)) {
> +                       free(npath);
> +                       return NULL;
> +               }
> +
> +               sanitized = xmalloc(strlen(npath) + 1);
> +               strcpy(sanitized, npath);
> +               free(npath);

We could replace these three lines with "sanitized = npath;". But it's
not a big deal imo. The rest of the series looks good.

Reviewed-by: Duy Nguyen <pclouds@gmail.com>

>         } else {
>                 sanitized = xmalloc(len + strlen(path) + 1);
>                 if (len)
-- 
Duy
