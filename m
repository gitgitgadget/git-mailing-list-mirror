From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH/RFC 1/3] Teach mv to move submodules together with their
 work trees
Date: Thu, 11 Apr 2013 14:42:51 +0530
Message-ID: <CALkWK0mWHwTV8dc9F3tyq9HYOnC2S56x_efr1+eRsqJqTFutXA@mail.gmail.com>
References: <515C88FE.9020203@web.de> <515C8958.4080704@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Phil Hord <phil.hord@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	"W. Trevor King" <wking@tremily.us>,
	Peter Collingbourne <peter@pcc.me.uk>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Thu Apr 11 11:13:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UQDZd-0003Kz-AO
	for gcvg-git-2@plane.gmane.org; Thu, 11 Apr 2013 11:13:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934896Ab3DKJNe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Apr 2013 05:13:34 -0400
Received: from mail-ia0-f176.google.com ([209.85.210.176]:42987 "EHLO
	mail-ia0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754066Ab3DKJNc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Apr 2013 05:13:32 -0400
Received: by mail-ia0-f176.google.com with SMTP id i1so1218789iaa.21
        for <git@vger.kernel.org>; Thu, 11 Apr 2013 02:13:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=ySd3TiCgaKCRqUmSpPsXq0LVbr3DQddigR0yLEw8A1w=;
        b=wFishNg0TDu3RKAPYZij3U3tsy/FEg+yIPxv2PTPdj8tIRyffrtkF4PdbhOJZP+6mn
         Qv+4PpFKV5ws3mZNN9t39mP4rXfGl2saSVuXv57h0kmvCtUlWXS4FZaPzDOZZx3rdpzd
         ap1JdwKx2Imi54+JUvgx1nefC8vVrphfZ4SbZLu+p02pEVqzZij6LezOm343aWsiy6G7
         MC88iI++ldtm6eCVT8eTQstWfnlPT9Gi159ofm+FPSjWA9X74nH53lsRb72htPwII+uW
         VAzJc9VKN2jHtYpaQVkCQSTIQcI1G/3NiDLMD1FMtAm8zxRMUiTp//zrt5vawrG5mOqU
         5wCw==
X-Received: by 10.42.50.202 with SMTP id b10mr3466497icg.7.1365671611547; Thu,
 11 Apr 2013 02:13:31 -0700 (PDT)
Received: by 10.64.34.80 with HTTP; Thu, 11 Apr 2013 02:12:51 -0700 (PDT)
In-Reply-To: <515C8958.4080704@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220835>

Jens Lehmann wrote:
> Currently the attempt to use "git mv" on a submodule errors out with:
>   fatal: source directory is empty, source=<src>, destination=<dest>
> The reason is that mv searches for the submodule with a trailing slash in
> the index, which it doesn't find (because it is stored without a trailing
> slash). As it doesn't find any index entries inside the submodule it
> claims the directory would be empty even though it isn't.

Why does it search for a submodule with a trailing slash in the index?
 You make it sound like it's doing something unnatural; in reality, it
does this because it executes lstat() on the filesystem path
specified, and the stat mode matches S_ISDIR (because it _is_ a
directory on the filesystem).  It is stored in the index as an entry
(without a trailing slash) with the mode 160000, gitlink.

What happens if I attempt to git mv oldpath/ newpath/ (with the
literal slashes, probably because I'm using a stupid shell
completion)?

> Fix that by searching for the name without a trailing slash and continue
> if it is a submodule.

So, the correct solution is not to "search for a name without a
trailing slash", but rather to handle the gitlink entry in the index
appropriately.

> Then rename() will move the submodule work tree just
> like it moves a file.

What is this rename() function you're talking about?  I don't see it anywhere.

> diff --git a/builtin/mv.c b/builtin/mv.c
> index 034fec9..361028d 100644
> --- a/builtin/mv.c
> +++ b/builtin/mv.c
> @@ -117,55 +117,60 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
>                                 && lstat(dst, &st) == 0)
>                         bad = _("cannot move directory over file");
>                 else if (src_is_dir) {
> -                       const char *src_w_slash = add_slash(src);
> -                       int len_w_slash = length + 1;
> -                       int first, last;
> -
> -                       modes[i] = WORKING_DIRECTORY;
> -
> -                       first = cache_name_pos(src_w_slash, len_w_slash);
> -                       if (first >= 0)
> -                               die (_("Huh? %.*s is in index?"),
> -                                               len_w_slash, src_w_slash);
> -
> -                       first = -1 - first;
> -                       for (last = first; last < active_nr; last++) {
> -                               const char *path = active_cache[last]->name;
> -                               if (strncmp(path, src_w_slash, len_w_slash))
> -                                       break;
> -                       }
> -                       free((char *)src_w_slash);
> -
> -                       if (last - first < 1)
> -                               bad = _("source directory is empty");
> -                       else {
> -                               int j, dst_len;
> -
> -                               if (last - first > 0) {
> -                                       source = xrealloc(source,
> -                                                       (argc + last - first)
> -                                                       * sizeof(char *));
> -                                       destination = xrealloc(destination,
> -                                                       (argc + last - first)
> -                                                       * sizeof(char *));
> -                                       modes = xrealloc(modes,
> -                                                       (argc + last - first)
> -                                                       * sizeof(enum update_mode));
> +                       int first = cache_name_pos(src, length);
> +                       if (first >= 0) {
> +                               if (!S_ISGITLINK(active_cache[first]->ce_mode))
> +                                       die (_("Huh? Directory %s is in index and no submodule?"), src);

I didn't understand this.  Why does it have to be a gitlink if it is
stored at index position >= 0?
I'm assuming the else-case has nothing to do with the actual moving
but rather something specific to directories (enumerating entries in
it?), which is why it doesn't get executed when we find a gitlink.

> +                       } else {
> +                               const char *src_w_slash = add_slash(src);
> +                               int last, len_w_slash = length + 1;
> +
> +                               modes[i] = WORKING_DIRECTORY;
> +
> +                               first = cache_name_pos(src_w_slash, len_w_slash);
> +                               if (first >= 0)
> +                                       die (_("Huh? %.*s is in index?"),
> +                                                       len_w_slash, src_w_slash);
> +
> +                               first = -1 - first;
> +                               for (last = first; last < active_nr; last++) {
> +                                       const char *path = active_cache[last]->name;
> +                                       if (strncmp(path, src_w_slash, len_w_slash))
> +                                               break;
>                                 }

Mostly unchanged, but I didn't understand the line first = -1 - first
in the original.  What is it doing?  So, I'm guessing first is the
cache position of the directory itself, and last stores the index of
the "last" entry in the cache?  What does that even mean?

> -
> -                               dst = add_slash(dst);
> -                               dst_len = strlen(dst);
> -
> -                               for (j = 0; j < last - first; j++) {
> -                                       const char *path =
> -                                               active_cache[first + j]->name;
> -                                       source[argc + j] = path;
> -                                       destination[argc + j] =
> -                                               prefix_path(dst, dst_len,
> -                                                       path + length + 1);
> -                                       modes[argc + j] = INDEX;
> +                               free((char *)src_w_slash);
> +
> +                               if (last - first < 1)
> +                                       bad = _("source directory is empty");

This is exactly what was tripping us up earlier.  Can you explain what
last - first < 1 means?

> +                               else {
> +                                       int j, dst_len;
> +
> +                                       if (last - first > 0) {
> +                                               source = xrealloc(source,
> +                                                               (argc + last - first)
> +                                                               * sizeof(char *));
> +                                               destination = xrealloc(destination,
> +                                                               (argc + last - first)
> +                                                               * sizeof(char *));
> +                                               modes = xrealloc(modes,
> +                                                               (argc + last - first)
> +                                                               * sizeof(enum update_mode));
> +                                       }
> +
> +                                       dst = add_slash(dst);
> +                                       dst_len = strlen(dst);
> +
> +                                       for (j = 0; j < last - first; j++) {
> +                                               const char *path =
> +                                                       active_cache[first + j]->name;
> +                                               source[argc + j] = path;
> +                                               destination[argc + j] =
> +                                                       prefix_path(dst, dst_len,
> +                                                               path + length + 1);
> +                                               modes[argc + j] = INDEX;
> +                                       }
> +                                       argc += last - first;
>                                 }

Mostly unchanged, but hard to review because I can't easily see what
changed and what didn't.

> -                               argc += last - first;

Why did you remove this line?
