From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH] Extend runtime prefix computation
Date: Fri, 30 Nov 2012 11:20:52 +0100
Message-ID: <CABPQNSYhscHdnTFLye=oif_R84kpdaVsrCK+-174v7Ugrae_yQ@mail.gmail.com>
References: <20121127163004.GC7499@science-computing.de>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Michael Weiser <M.Weiser@science-computing.de>
X-From: git-owner@vger.kernel.org Fri Nov 30 11:29:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TeNqW-0001Lv-S4
	for gcvg-git-2@plane.gmane.org; Fri, 30 Nov 2012 11:29:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757356Ab2K3K3I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Nov 2012 05:29:08 -0500
Received: from mail-vc0-f170.google.com ([209.85.220.170]:35970 "EHLO
	mail-vc0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757349Ab2K3K3G (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Nov 2012 05:29:06 -0500
Received: by mail-vc0-f170.google.com with SMTP id fl11so28242063vcb.1
        for <git@vger.kernel.org>; Fri, 30 Nov 2012 02:29:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=mgj7KtzUfYt1DXewZBxBxWhA1vDwCxCH3yEU0V4NOl8=;
        b=dUiZqVxtH/eDGEv7dbJVGfcPoKsz/OB/dcT+llGxxIlx14HqbsrWNbBars3NhFZOtV
         tv7+G+vRwZYaPV7rC6l4TFDFwWA5FfsUeEhfVEqdWhGt/1Zg1pDkVUa6/vdGv02FxdHG
         VUsB/mDPN0tiMtwRHWc9quRTPJ3exggd2v0Bdd69SD/6Q3ScUbOStIA4xhtRToEgnOQe
         L+KBHCyEw71GArkPPRwCeLXtu7X/ROT38n9t59nY+/pXIz6h/nvJDLic17OgISs2qGhg
         FKfSRwJM0i7YJiKU5jN9i74I4T8rGzkbjYP1VsAQjtvjMEWqa8P6WxIqXP/xsCDYirxN
         2yQQ==
Received: by 10.58.162.130 with SMTP id ya2mr675050veb.2.1354270892419; Fri,
 30 Nov 2012 02:21:32 -0800 (PST)
Received: by 10.58.169.106 with HTTP; Fri, 30 Nov 2012 02:20:52 -0800 (PST)
In-Reply-To: <20121127163004.GC7499@science-computing.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 27, 2012 at 5:30 PM, Michael Weiser
<M.Weiser@science-computing.de> wrote:
> Support determining the binaries' installation path at runtime even if
> called without any path components (i.e. via search path). Implement
> fallback to compiled-in prefix if determination fails or is impossible.
>
> Signed-off-by: Michael Weiser <weiser@science-computing.de>
> ---
> - Has two very minor memory leaks - function is called only once per
>   program execution. Do we care? Alternative: Use static buffer instead.
>
>  exec_cmd.c |   68 ++++++++++++++++++++++++++++++++++++++++++++++-------------
>  1 files changed, 53 insertions(+), 15 deletions(-)
>
> diff --git a/exec_cmd.c b/exec_cmd.c
> index 125fa6f..d50d7f8 100644
> --- a/exec_cmd.c
> +++ b/exec_cmd.c
> @@ -4,28 +4,22 @@
>  #define MAX_ARGS       32
>
>  static const char *argv_exec_path;
> -static const char *argv0_path;
> +static const char *argv0_path = NULL;
>
>  const char *system_path(const char *path)
>  {
> -#ifdef RUNTIME_PREFIX
> -       static const char *prefix;
> -#else
>         static const char *prefix = PREFIX;
> -#endif
>         struct strbuf d = STRBUF_INIT;
>
>         if (is_absolute_path(path))
>                 return path;
>
>  #ifdef RUNTIME_PREFIX
> -       assert(argv0_path);
> -       assert(is_absolute_path(argv0_path));
> -
> -       if (!prefix &&
> -           !(prefix = strip_path_suffix(argv0_path, GIT_EXEC_PATH)) &&
> -           !(prefix = strip_path_suffix(argv0_path, BINDIR)) &&
> -           !(prefix = strip_path_suffix(argv0_path, "git"))) {
> +       if (!argv0_path ||
> +           !is_absolute_path(argv0_path) ||
> +           (!(prefix = strip_path_suffix(argv0_path, GIT_EXEC_PATH)) &&
> +            !(prefix = strip_path_suffix(argv0_path, BINDIR)) &&
> +            !(prefix = strip_path_suffix(argv0_path, "git")))) {
>                 prefix = PREFIX;
>                 trace_printf("RUNTIME_PREFIX requested, "
>                                 "but prefix computation failed.  "
> @@ -41,20 +35,64 @@ const char *system_path(const char *path)
>  const char *git_extract_argv0_path(const char *argv0)
>  {
>         const char *slash;
> +       char *abs_argv0 = NULL;
>
>         if (!argv0 || !*argv0)
>                 return NULL;
>         slash = argv0 + strlen(argv0);
>
> +       /* walk to the first slash from the end */
>         while (argv0 <= slash && !is_dir_sep(*slash))
>                 slash--;
>
> +       /* if there was a slash ... */
>         if (slash >= argv0) {
> -               argv0_path = xstrndup(argv0, slash - argv0);
> -               return slash + 1;
> +               /* ... it's either an absolute path */
> +               if (is_absolute_path(argv0)) {
> +                       /* FIXME: memory leak here */
> +                       argv0_path = xstrndup(argv0, slash - argv0);
> +                       return slash + 1;
> +               }
> +
> +               /* ... or a relative path, in which case we have to make it
> +                * absolute first and do the whole thing again */
> +               abs_argv0 = xstrdup(real_path(argv0));
> +       } else {
> +               /* argv0 is no path at all, just a name. Resolve it into a
> +                * path. Unfortunately, this gets system specific. */
> +#if defined(__linux__)
> +               struct stat st;
> +               if (!stat("/proc/self/exe", &st)) {
> +                       abs_argv0 = xstrdup(real_path("/proc/self/exe"));
> +               }
> +#elif defined(__APPLE__)
> +               /* Mac OS X has realpath, which incidentally allocates its own
> +                * memory, which in turn is why we do all the xstrdup's in the
> +                * other cases. */
> +               abs_argv0 = realpath(argv0, NULL);
> +#endif

...perhaps a "GetModuleFileName(NULL, ...)" for Windows is in place here?
