From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH/WIP 1/8] wrapper: implement xopen()
Date: Wed, 27 May 2015 10:52:16 -0700
Message-ID: <CAGZ79kYqfgj6A_2GV3xY-j16KM0GAGEmnxSHjZXrC=WJ7=HRaQ@mail.gmail.com>
References: <1432733618-25629-1-git-send-email-pyokagan@gmail.com>
	<1432733618-25629-2-git-send-email-pyokagan@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Paul Tan <pyokagan@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 27 19:53:38 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YxfWH-00012d-Ls
	for gcvg-git-2@plane.gmane.org; Wed, 27 May 2015 19:53:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751991AbbE0Rx0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 May 2015 13:53:26 -0400
Received: from mail-qk0-f175.google.com ([209.85.220.175]:33047 "EHLO
	mail-qk0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751939AbbE0RwR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 May 2015 13:52:17 -0400
Received: by qkhg32 with SMTP id g32so10226525qkh.0
        for <git@vger.kernel.org>; Wed, 27 May 2015 10:52:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=M3Af47ppL0diA5EP0EhQHAvcyrpqHv3KpBZoXKag8wU=;
        b=bXfe6gVfec9NzcjVCyNrD/ADSBMBHRVjiW3hqfKEdBg6Ct1ZD/yFX3/gQFrpm1VAA1
         9mUZbHnnX6v1wvKrY+K/aAnfZpqiT+3Xtfu8GI6Z1/QkENfK37kNrchyGZ8X/hBNWBc/
         ncTd/LgbIQtqgkxfh9XnMlIYGQuMGPo4031KkeVz5uBbfaKKG4HLJZ1P0NY9yRhZG/u4
         sNIhFWiC9hGLQdQyx3f6zBB19AeDYhOv1afm0LskGeoQqcbcEcKe9xfGVixHebK9MkIo
         lP5vQVP5XVkR8zubjLs7ue63rnWbB5tcISsTZ9i2xzpQjZ2Rszr7pTZIrW063V3YR7D8
         GSpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=M3Af47ppL0diA5EP0EhQHAvcyrpqHv3KpBZoXKag8wU=;
        b=bvV8fqMmgfhcW//JAqyY9yg45t+HBgLm8wKjnLF+TK6rpre4u3frIc7GKCf3yy2S6v
         ASFlwYwTYq1q7sMr/Z1xTMCZXmhbMKU7vFsrEQy+f6C90NYlDTcSkAqQ4My1dwt6ioO2
         /L29f3ewjwEJr1qVOSeMMkLsFkCbcOad4InP7eJXKrEt3sdEnt/yZucqPkcCJ2Ft0gY8
         4PDYloV0HNYcHHVmrAHzpPfxRp/MsK++DhLpIGxuSjpAugv9E8FX/If9Vc85HFoTAaZy
         nmoeM1mQKQvbl4wlumFbjnQ8QX7bNYQRkbJ7BqiRNXrMeJq8LmyHVO6YBv3bjdnhQ1mY
         6EIw==
X-Gm-Message-State: ALoCoQlPgqY47b/YECLREXjaQVACiU37PIq4FDr7yrwXz2tbdPHBN9S5yavY+FBpnI4Xghfn93J/
X-Received: by 10.55.42.82 with SMTP id q79mr22793137qkh.84.1432749136188;
 Wed, 27 May 2015 10:52:16 -0700 (PDT)
Received: by 10.140.43.117 with HTTP; Wed, 27 May 2015 10:52:16 -0700 (PDT)
In-Reply-To: <1432733618-25629-2-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270063>

On Wed, May 27, 2015 at 6:33 AM, Paul Tan <pyokagan@gmail.com> wrote:
> A common usage pattern of open() is to check if it was successful, and
> die() if it was not:
>
>         int fd = open(path, O_WRONLY | O_CREAT, 0777);
>         if (fd < 0)
>                 die_errno(_("Could not open '%s' for writing."), path);
>
> Implement a wrapper function xopen() that does the above so that we can
> save a few lines of code, and make the die() messages consistent.

As a mental todo note for whomever wants to pick up some work: This patch
series indicates to only touch git-am. The first 2 patches introduce
new x-wrappers,
so maybe we'd need to grep through the whole code base and convert the all
these file opening code to the new wrapper.

>
> Signed-off-by: Paul Tan <pyokagan@gmail.com>
> ---
>  git-compat-util.h |  1 +
>  wrapper.c         | 18 ++++++++++++++++++
>  2 files changed, 19 insertions(+)
>
> diff --git a/git-compat-util.h b/git-compat-util.h
> index 17584ad..9745962 100644
> --- a/git-compat-util.h
> +++ b/git-compat-util.h
> @@ -718,6 +718,7 @@ extern char *xstrndup(const char *str, size_t len);
>  extern void *xrealloc(void *ptr, size_t size);
>  extern void *xcalloc(size_t nmemb, size_t size);
>  extern void *xmmap(void *start, size_t length, int prot, int flags, int fd, off_t offset);
> +extern int xopen(const char *path, int flags, mode_t mode);
>  extern ssize_t xread(int fd, void *buf, size_t len);
>  extern ssize_t xwrite(int fd, const void *buf, size_t len);
>  extern ssize_t xpread(int fd, void *buf, size_t len, off_t offset);
> diff --git a/wrapper.c b/wrapper.c
> index c1a663f..971665a 100644
> --- a/wrapper.c
> +++ b/wrapper.c
> @@ -189,6 +189,24 @@ void *xcalloc(size_t nmemb, size_t size)
>  # endif
>  #endif
>
> +/**
> + * xopen() is the same as open(), but it die()s if the open() fails.
> + */
> +int xopen(const char *path, int flags, mode_t mode)
> +{
> +       int fd;
> +
> +       assert(path);
> +       fd = open(path, flags, mode);
> +       if (fd < 0) {
> +               if ((flags & O_WRONLY) || (flags & O_RDWR))
> +                       die_errno(_("could not open '%s' for writing"), path);
> +               else
> +                       die_errno(_("could not open '%s' for reading"), path);
> +       }
> +       return fd;
> +}
> +
>  /*
>   * xread() is the same a read(), but it automatically restarts read()
>   * operations with a recoverable error (EAGAIN and EINTR). xread()
> --
> 2.1.4
>
