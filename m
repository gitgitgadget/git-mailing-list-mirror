From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 1/2] create_default_files(): don't set u+x bit on $GIT_DIR/config
Date: Sun, 16 Nov 2014 20:40:12 -0500
Message-ID: <CAPig+cQ6j-3_Ng8DVT3FYk8T6DippEbYDhQq5v3DTJhGgBhPDQ@mail.gmail.com>
References: <1416122508-30654-1-git-send-email-mhagger@alum.mit.edu>
	<1416122508-30654-2-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Eric Wong <normalperson@yhbt.net>,
	Karsten Blees <karsten.blees@gmail.com>,
	Stefan Beller <stefanbeller@gmail.com>,
	=?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	Git List <git@vger.kernel.org>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Mon Nov 17 02:40:22 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XqBIj-0003QX-7K
	for gcvg-git-2@plane.gmane.org; Mon, 17 Nov 2014 02:40:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753292AbaKQBkO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Nov 2014 20:40:14 -0500
Received: from mail-yh0-f46.google.com ([209.85.213.46]:52512 "EHLO
	mail-yh0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753285AbaKQBkN (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Nov 2014 20:40:13 -0500
Received: by mail-yh0-f46.google.com with SMTP id t59so4693495yho.33
        for <git@vger.kernel.org>; Sun, 16 Nov 2014 17:40:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=DLomgIvjnf0VZEHSJc5tVty0ta70lWiEb5tj7Ktgm0s=;
        b=NFCeTVMx1pyBHkkS+x5RZV2HTqfcpuGjKJUGfyr4zRKr9HqHpBD+4JqfaLFM0lJ0vB
         uMpjN0HA28uCRuhEBU2cJ7fblk9YfJxIX0fUPwrkGCAr+5NDOzgAhAN+8LJx/kGcHhXq
         9D2XC3jsRakjyobo/7KbTREXe+ALugLxT/8uYEy90qZF/LhZ9/oGVfcZuC9q2zndPo1r
         qCyUWKylySGvz8RtDgVOJAVR6VCHbc+SddOaNmFC5mHm8NGU+qC/7eN07ish93l+h4V7
         FAujXNDgcNyKxpNWuidqrkGO51Afbz8igMqz/cIGJQ/OE15wrPqmreVGezAtEZXm9+0Y
         JMCQ==
X-Received: by 10.236.104.196 with SMTP id i44mr21942753yhg.12.1416188412698;
 Sun, 16 Nov 2014 17:40:12 -0800 (PST)
Received: by 10.170.68.68 with HTTP; Sun, 16 Nov 2014 17:40:12 -0800 (PST)
In-Reply-To: <1416122508-30654-2-git-send-email-mhagger@alum.mit.edu>
X-Google-Sender-Auth: m70WzZg2DhRoazy-C5l1DH0CrF4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Nov 16, 2014 at 2:21 AM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
> Since time immemorial, the test of whether to set "core.filemode" has
> been done by trying to toggle the u+x bit on $GIT_DIR/config and then
> testing whether the change "took". It is somewhat odd to use the
> config file for this test, but whatever.
>
> The test code didn't set the u+x bit back to its original state
> itself, instead relying on the subsequent call to git_config_set() to
> re-write the config file with correct permissions.
>
> But ever since
>
>     daa22c6f8d config: preserve config file permissions on edits (2014-05-06)
>
> git_config_set() copies the permissions from the old config file to
> the new one. This is a good change in and of itself, but it interacts
> badly with create_default_files()'s sloppiness, causing "git init" to
> leave the executable bit set on $GIT_DIR/config.
>
> So change create_default_files() to reset the permissions on
> $GIT_DIR/config after its test.
>
> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
> ---

Should this patch include a test in t1300 to ensure that this bug does
not resurface (and to prove that this patch indeed fixes it)?

>  builtin/init-db.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/builtin/init-db.c b/builtin/init-db.c
> index 56f85e2..4c8021d 100644
> --- a/builtin/init-db.c
> +++ b/builtin/init-db.c
> @@ -255,6 +255,7 @@ static int create_default_files(const char *template_path)
>                 filemode = (!chmod(path, st1.st_mode ^ S_IXUSR) &&
>                                 !lstat(path, &st2) &&
>                                 st1.st_mode != st2.st_mode);
> +               filemode &= !chmod(path, st1.st_mode);
>         }
>         git_config_set("core.filemode", filemode ? "true" : "false");
>
> --
> 2.1.1
