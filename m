From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH/RFC][GSoC] diff-no-index: transform "$directory $file"
 args to "$directory/$file $file"
Date: Sat, 21 Mar 2015 22:39:02 -0400
Message-ID: <CAPig+cShOv0TQ2x_22j8rXyp+kNbBVwAs8E1U==9qkijvffxoA@mail.gmail.com>
References: <CAHLaBN+x3SVL9+jDzeSEMapVd2BVrwQuVx_7ENspjbUPrium_A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Yurii Shevtsov <ungetch@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 22 03:39:12 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YZVnA-0002e4-Gy
	for gcvg-git-2@plane.gmane.org; Sun, 22 Mar 2015 03:39:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751769AbbCVCjE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Mar 2015 22:39:04 -0400
Received: from mail-yk0-f172.google.com ([209.85.160.172]:34127 "EHLO
	mail-yk0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751585AbbCVCjC (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Mar 2015 22:39:02 -0400
Received: by ykfc206 with SMTP id c206so58253152ykf.1
        for <git@vger.kernel.org>; Sat, 21 Mar 2015 19:39:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=MybxWmVmLrxEdYk08TvWHZ5zU+cup/U2W6BnwmgZ30I=;
        b=u53UYxlB0NWx2xASKEJqV416+ZaFFviHiECJgVKhtiKrXWd1v0YU/HKVK33h/urXT9
         WGlQ1Nl7AdS0u6o4llNEASpsezFxrdpkX52ao5ycvFh4BTLakM/pfuzu5sjyYk6rNgEe
         rZ++7giqs7g7NjYyHKCg+FgAend1GLLSWq/3JUexVZ0NyV7Z/oTqMNsdEf4bNlr4AY6j
         W/9LoaN3/4UwWnk1Jbn0lNAGuZ2/sEQCflh5AqWro0dmUQ+sgBWRBfPF6Bv5RC6Wubgn
         EupX/CGfhK5WUrrR6TI0/3Mxd27UYGLLzublG6iaBmtMzQKwzCKQhOuqgc4wRMiLBDNV
         Cs9Q==
X-Received: by 10.170.126.204 with SMTP id s195mr328235ykb.22.1426991942129;
 Sat, 21 Mar 2015 19:39:02 -0700 (PDT)
Received: by 10.170.73.7 with HTTP; Sat, 21 Mar 2015 19:39:02 -0700 (PDT)
In-Reply-To: <CAHLaBN+x3SVL9+jDzeSEMapVd2BVrwQuVx_7ENspjbUPrium_A@mail.gmail.com>
X-Google-Sender-Auth: iRL4mZh3ZW6QcD9jOCC2Exha2fY
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266040>

On Sat, Mar 21, 2015 at 8:50 AM, Yurii Shevtsov <ungetch@gmail.com> wrote:
> Signed-off-by: Yurii Shevtsov <ungetch@gmail.com>
> ---
> diff --git a/diff-no-index.c b/diff-no-index.c
> index 265709b..9a3439a 100644
> --- a/diff-no-index.c
> +++ b/diff-no-index.c
> @@ -97,8 +97,39 @@ static int queue_diff(struct diff_options *o,
>      if (get_mode(name1, &mode1) || get_mode(name2, &mode2))
>          return -1;

Somehow, you lost all the tabs in the patch, and everything is instead
indented with spaces (including context lines).

> -    if (mode1 && mode2 && S_ISDIR(mode1) != S_ISDIR(mode2))
> -        return error("file/directory conflict: %s, %s", name1, name2);
> +    if (mode1 && mode2 && S_ISDIR(mode1) != S_ISDIR(mode2)) {
> +        struct strbuf path;
> +        const char *dir, *file;
> +        char *filename, *dirname = 0;
> +        int i, ret = 0;
> +
> +        dir = S_ISDIR(mode1) ? name1 : name2;
> +        file = (dir == name1) ? name2 : name1;
> +        strbuf_init(&path, strlen(name1) + strlen(name2) + 1);
> +        strbuf_addstr(&path, dir);
> +        filename = strrchr(file, '/');
> +        if (path.len && path.buf[path.len - 1] != '/')
> +            strbuf_addch(&path, '/');
> +        for (i = path.len - 2; i >= 0; i--)
> +            if (path.buf[i] == '/') {
> +                dirname = &path.buf[i];
> +                break;
> +            }
> +        if (dirname == 0)
> +            dirname = path.buf;
> +
> +        if (!strncmp(dirname, filename, strlen(filename)))
> +            return error("file/directory conflict: %s, %s", name1, name2);

Leaking 'path' strbuf.

> +
> +        strbuf_addstr(&path, filename ? (filename + 1) : file);
> +        if (file == name1)
> +            ret = queue_diff(o, file, path.buf);
> +        else
> +            ret = queue_diff(o, path.buf, file);
> +        strbuf_release(&path);
> +
> +        return ret;
> +    }
>
>      if (S_ISDIR(mode1) || S_ISDIR(mode2)) {
>          struct strbuf buffer1 = STRBUF_INIT;
> --
