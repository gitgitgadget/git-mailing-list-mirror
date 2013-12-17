From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 1/3] prune-packed: fix a possible buffer overflow
Date: Tue, 17 Dec 2013 20:57:29 +0700
Message-ID: <CACsJy8DVc4soBrS1RbTLv93b5rere3htyL1DjRw=UcT4zVN9FA@mail.gmail.com>
References: <1387287838-25779-1-git-send-email-mhagger@alum.mit.edu> <1387287838-25779-2-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Tue Dec 17 14:58:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VsvAG-0007CN-F7
	for gcvg-git-2@plane.gmane.org; Tue, 17 Dec 2013 14:58:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754133Ab3LQN6B (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Dec 2013 08:58:01 -0500
Received: from mail-qa0-f53.google.com ([209.85.216.53]:58213 "EHLO
	mail-qa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754124Ab3LQN57 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Dec 2013 08:57:59 -0500
Received: by mail-qa0-f53.google.com with SMTP id j5so2627402qaq.12
        for <git@vger.kernel.org>; Tue, 17 Dec 2013 05:57:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=imnpaaozwVF3PpRLbntVFrS8/81M21u3XBJzEcz2Jt0=;
        b=z6DB7CdS+a7v05blT2Mb0duzm+csrJuupc8aZT/sSgle68DuIKPoMfTl2120PuUxVA
         GFZvg6tuifG5Mz8yH2TPOeu61yhwlS6tJcaS1DmyqGbWMKSEbRJhZ1lvQpKK1bE3EaJN
         o/6avd8zUs3I4qz92LcXkn56gsTTgZN+UeERrTrRHpx5Cep2R8AMTacbgqslFoAiVz5s
         lbIlYmDZ+H5qfYlyIAf5/zfUfSBJ5gz0FDHBJ2az03v4SY2QEFfzivyCzge1zlyTbyGW
         dIKgTzG2FLKHILfqopQP1xXc2+Rb8Vs6ZC5J27V7yLee4u9mYYqAf+/qzy9VZleWCdVy
         OFog==
X-Received: by 10.49.15.227 with SMTP id a3mr43250450qed.66.1387288679120;
 Tue, 17 Dec 2013 05:57:59 -0800 (PST)
Received: by 10.96.124.101 with HTTP; Tue, 17 Dec 2013 05:57:29 -0800 (PST)
In-Reply-To: <1387287838-25779-2-git-send-email-mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239387>

On Tue, Dec 17, 2013 at 8:43 PM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
> The pathname character array might hold:
>
>     strlen(pathname) -- the pathname argument
>     '/'              -- a slash, if not already present in pathname
>     %02x/            -- the first two characters of the SHA-1 plus slash
>     38 characters    -- the last 38 characters of the SHA-1
>     NUL              -- terminator
>     ---------------------
>     strlen(pathname) + 43
>
> (Actually, the NUL character is not written explicitly to pathname;
> rather, the code relies on pathname being initialized to zeros and the
> zero following the pathname still being there after the other
> characters are written to the array.)
>
> But the old pathname variable was PATH_MAX characters long, whereas
> the check was (len > PATH_MAX - 42).  So there might have been one
> byte too many stored in pathname.  This would have resulted in it's
> not being NUL-terminated.
>
> So, increase the size of the pathname variable by one byte to avoid
> this possibility.

Why don't we take this opportunity to replace that array with a
strbuf? The conversion looks simple with this function.

>
> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
> ---
>  builtin/prune-packed.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/builtin/prune-packed.c b/builtin/prune-packed.c
> index fa6ce42..81bc786 100644
> --- a/builtin/prune-packed.c
> +++ b/builtin/prune-packed.c
> @@ -37,7 +37,7 @@ static void prune_dir(int i, DIR *dir, char *pathname, int len, int opts)
>  void prune_packed_objects(int opts)
>  {
>         int i;
> -       static char pathname[PATH_MAX];
> +       static char pathname[PATH_MAX + 1];
>         const char *dir = get_object_directory();
>         int len = strlen(dir);
>
> @@ -45,7 +45,7 @@ void prune_packed_objects(int opts)
>                 progress = start_progress_delay("Removing duplicate objects",
>                         256, 95, 2);
>
> -       if (len > PATH_MAX - 42)
> +       if (len + 42 > PATH_MAX)
>                 die("impossible object directory");
>         memcpy(pathname, dir, len);
>         if (len && pathname[len-1] != '/')
> --
-- 
Duy
