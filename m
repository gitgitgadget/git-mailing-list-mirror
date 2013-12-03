From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH] mv: let 'git mv file no-such-dir/' error out
Date: Tue, 3 Dec 2013 17:06:08 +0700
Message-ID: <CACsJy8CfvdT2LgRHax3P6k94C3S9ScB4fuNRm7bZWGXRW=NqKA@mail.gmail.com>
References: <1386059524-14442-1-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Tue Dec 03 11:06:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VnmsP-0002rM-Uk
	for gcvg-git-2@plane.gmane.org; Tue, 03 Dec 2013 11:06:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752678Ab3LCKGm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Dec 2013 05:06:42 -0500
Received: from mail-qa0-f48.google.com ([209.85.216.48]:58165 "EHLO
	mail-qa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752027Ab3LCKGj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Dec 2013 05:06:39 -0500
Received: by mail-qa0-f48.google.com with SMTP id w5so5482814qac.0
        for <git@vger.kernel.org>; Tue, 03 Dec 2013 02:06:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=e5XC7fpjUwFaCuUu0aArf+B+7BBVr29qVosuX/ACZOo=;
        b=dB6jgR6HfLWYVrel90dtOcYikzYVPtbhZ6oZZdOG97AjhpVLV2CbE1BkEFr8hY2m2f
         ACpGBvHWj3urpy7D31uIGvFk5m3QcpXg3apC5T7Ckze3EJYXNZjS9NKA/C+4IcAQ0xIX
         aOLjk6HGmKIewsXnmBijH1uois8Yxhu8fS6He/8TWCu2/t40CD33qFa21kPHrHFmRw/L
         tvq+aDy9y3/R7lVf4aaooYElFnVG5IFU73NHwN1wrDU5OWCythAiAjGEA7Yx8KdMVMfP
         MER7tAENqythwXtPIz89DB2sMvi7mUjdYyXltFWt7hTgBr0TwTEb0wFJrHTs63TqgB8f
         BHmA==
X-Received: by 10.229.137.135 with SMTP id w7mr123044028qct.14.1386065198946;
 Tue, 03 Dec 2013 02:06:38 -0800 (PST)
Received: by 10.96.124.101 with HTTP; Tue, 3 Dec 2013 02:06:08 -0800 (PST)
In-Reply-To: <1386059524-14442-1-git-send-email-Matthieu.Moy@imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238681>

On Tue, Dec 3, 2013 at 3:32 PM, Matthieu Moy <Matthieu.Moy@imag.fr> wrote:
> Git used to trim the trailing slash, and make the command equivalent to
> 'git mv file no-such-dir', which created the file no-such-dir (while the
> trailing slash explicitly stated that it could only be a directory).
>
> This patch skips the trailing slash removal for the destination path. The
> path with its trailing slash is passed to rename(2), which errors out
> with the appropriate message:
>
>   $ git mv file no-such-dir/
>   fatal: renaming 'file' failed: Not a directory

There's something we probably should check. In d78b0f3 ([PATCH]
git-mv: add more path normalization - 2006-08-16), it mentions about

git mv something/ somewhere/

there's no test in that commit so I don't know the actual input and
expected outcome. If "somewhere" is a directory, it errors out with
this patch and works without it. If "somewhere" does not exist, it
seems to work like Linux "mv" with or without the patch.

> Original-patch-by: Duy Nguyen <pclouds@gmail.com>
> Tests, tweaks and commit message by: Matthieu Moy <Matthieu.Moy@imag.fr>
>
> Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
> ---
>  builtin/mv.c  | 23 ++++++++++++++++-------
>  t/t7001-mv.sh | 10 ++++++++++
>  2 files changed, 26 insertions(+), 7 deletions(-)
>
> diff --git a/builtin/mv.c b/builtin/mv.c
> index 2e0e61b..08fbc03 100644
> --- a/builtin/mv.c
> +++ b/builtin/mv.c
> @@ -16,9 +16,12 @@ static const char * const builtin_mv_usage[] = {
>         NULL
>  };
>
> +#define DUP_BASENAME 1
> +#define KEEP_TRAILING_SLASH 2
> +
>  static const char **internal_copy_pathspec(const char *prefix,
>                                            const char **pathspec,
> -                                          int count, int base_name)
> +                                          int count, unsigned flags)
>  {
>         int i;
>         const char **result = xmalloc((count + 1) * sizeof(const char *));
> @@ -27,11 +30,12 @@ static const char **internal_copy_pathspec(const char *prefix,
>         for (i = 0; i < count; i++) {
>                 int length = strlen(result[i]);
>                 int to_copy = length;
> -               while (to_copy > 0 && is_dir_sep(result[i][to_copy - 1]))
> +               while (!(flags & KEEP_TRAILING_SLASH) &&
> +                      to_copy > 0 && is_dir_sep(result[i][to_copy - 1]))
>                         to_copy--;
> -               if (to_copy != length || base_name) {
> +               if (to_copy != length || flags & DUP_BASENAME) {
>                         char *it = xmemdupz(result[i], to_copy);
> -                       if (base_name) {
> +                       if (flags & DUP_BASENAME) {
>                                 result[i] = xstrdup(basename(it));
>                                 free(it);
>                         } else
> @@ -87,16 +91,21 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
>
>         source = internal_copy_pathspec(prefix, argv, argc, 0);
>         modes = xcalloc(argc, sizeof(enum update_mode));
> -       dest_path = internal_copy_pathspec(prefix, argv + argc, 1, 0);
> +       /*
> +        * Keep trailing slash, needed to let
> +        * "git mv file no-such-dir/" error out.
> +        */
> +       dest_path = internal_copy_pathspec(prefix, argv + argc, 1,
> +                                          KEEP_TRAILING_SLASH);
>         submodule_gitfile = xcalloc(argc, sizeof(char *));
>
>         if (dest_path[0][0] == '\0')
>                 /* special case: "." was normalized to "" */
> -               destination = internal_copy_pathspec(dest_path[0], argv, argc, 1);
> +               destination = internal_copy_pathspec(dest_path[0], argv, argc, DUP_BASENAME);
>         else if (!lstat(dest_path[0], &st) &&
>                         S_ISDIR(st.st_mode)) {
>                 dest_path[0] = add_slash(dest_path[0]);
> -               destination = internal_copy_pathspec(dest_path[0], argv, argc, 1);
> +               destination = internal_copy_pathspec(dest_path[0], argv, argc, DUP_BASENAME);
>         } else {
>                 if (argc != 1)
>                         die("destination '%s' is not a directory", dest_path[0]);
> diff --git a/t/t7001-mv.sh b/t/t7001-mv.sh
> index b90e985..e5c8084 100755
> --- a/t/t7001-mv.sh
> +++ b/t/t7001-mv.sh
> @@ -72,6 +72,16 @@ rm -f idontexist untracked1 untracked2 \
>       .git/index.lock
>
>  test_expect_success \
> +    'moving to target with trailing slash' \
> +    'test_must_fail git mv path0/COPYING no-such-dir/ &&
> +     test_must_fail git mv path0/COPYING no-such-dir// &&
> +     git mv path0/ no-such-dir/'
> +
> +test_expect_success \
> +    'clean up' \
> +    'git reset --hard'
> +
> +test_expect_success \
>      'adding another file' \
>      'cp "$TEST_DIRECTORY"/../README path0/README &&
>       git add path0/README &&
> --
> 1.8.5.rc3.4.g8bd3721
>



-- 
Duy
