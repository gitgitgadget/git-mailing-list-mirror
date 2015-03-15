From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH/RFC][GSoC] make "git diff --no-index $directory $file"
 DWIM better.
Date: Sun, 15 Mar 2015 14:04:02 -0400
Message-ID: <CAPig+cQgvwd=5hLGeOpY1r_476HbpUarumsu_QDU4HwB7ynXmw@mail.gmail.com>
References: <CAHLaBN+93mp6PQmtfjOHSvfW7iwDXwPitGQ5W1am9KBm9EZV2Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Yurii Shevtsov <ungetch@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 15 19:04:12 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YXCtU-000819-NY
	for gcvg-git-2@plane.gmane.org; Sun, 15 Mar 2015 19:04:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752097AbbCOSEF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Mar 2015 14:04:05 -0400
Received: from mail-yk0-f176.google.com ([209.85.160.176]:36079 "EHLO
	mail-yk0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751512AbbCOSED (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Mar 2015 14:04:03 -0400
Received: by ykcn8 with SMTP id n8so10296343ykc.3
        for <git@vger.kernel.org>; Sun, 15 Mar 2015 11:04:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=/0BdR3F+r+ToCTmmGrOR67ZM8/ktt26xA3G3IfxKiKA=;
        b=z4p1xtMhM21NjlnFMPaITJUNJTcpVWIZM4U/lJc0MpZaz+9A23jtNxKPRYV3EqjExK
         QD5X5L4yQ/2ECd4/y5Zf5gIImqxQ5iS9Ue270SXB/fy0VqCPC/euDj2uFV9iIME+lXYp
         wf8jzrTK/SoRe93dYL8wH1SKsfKdiKQtDC7Gh8QmxTkqNpbScma15pGMoWEEft/UQIlA
         bsZyWXR/iv1yHjvuv/XG71YwHqMp4VkXTE5KW8FscYZdFjQOYqh5gDZe/eOCIEa0hFru
         PmmYsDXhOiNGP8PiPQhXeg67JpCcUB11xvxTxmOWgQAslIdUv5MYE3VuJbrJyK2WHAS/
         yQSw==
X-Received: by 10.170.41.16 with SMTP id 16mr63108930ykj.85.1426442642611;
 Sun, 15 Mar 2015 11:04:02 -0700 (PDT)
Received: by 10.170.73.7 with HTTP; Sun, 15 Mar 2015 11:04:02 -0700 (PDT)
In-Reply-To: <CAHLaBN+93mp6PQmtfjOHSvfW7iwDXwPitGQ5W1am9KBm9EZV2Q@mail.gmail.com>
X-Google-Sender-Auth: UqIjh17ejtUX9NrgWJHWrc1UWV8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265507>

In addition to the points raised by Matthieu and Thomas...

On Sun, Mar 15, 2015 at 11:35 AM, Yurii Shevtsov <ungetch@gmail.com> wrote:
> make "git diff --no-index $directory $file" DWIM better.

Specify the area affected by the change, followed by a colon, followed
by the change summary. Drop the period at the end. So, something like:

    diff: improve '--no-index <directory> <file>' DWIMing

> Changes 'git diff --no-index $directory $file' behaviour.
> Now it is transformed to 'git diff --no-index $directory/&file $file'
> instead of throwing an error.

Write in imperative mood, so "Change" rather than "Changes". By
itself, the first sentence isn't saying much; it would read better if
you combined the two sentences into one.

> Signed-off-by: Yurii Shevtsov <ungetch <at> gmail.com>
> ---
> diff --git a/diff-no-index.c b/diff-no-index.c
> index 265709b..4e71b36 100644
> --- a/diff-no-index.c
> +++ b/diff-no-index.c
> @@ -97,8 +97,25 @@ static int queue_diff(struct diff_options *o,
>         if (get_mode(name1, &mode1) || get_mode(name2, &mode2))
>                 return -1;
>
> -       if (mode1 && mode2 && S_ISDIR(mode1) != S_ISDIR(mode2))
> -               return error("file/directory conflict: %s, %s", name1, name2);
> +       if (mode1 && mode2 && S_ISDIR(mode1) != S_ISDIR(mode2)) {
> +               struct strbuf dirnfile;

Is this name supposed to stand for "dir'n'file", a shorthand for
"dir-and-file"? Perhaps a simpler more idiomatic name such as "path"
would suffice. Also, you can initialize the strbuf here at point of
declaration:

    struct strbuf path = STRBUF_INIT;

> +               const char *dir, *file;
> +               char *filename;
> +               int ret = 0;
> +
> +               dir = S_ISDIR(mode1) ? name1 : name2;
> +               file = (dir == name1) ? name2 : name1;
> +               strbuf_init(&dirnfile, strlen(name1) + strlen(name2) + 2);

Unless this is a performance critical loop where you want to avoid
multiple re-allocations, it's customary to pass 0 for the second
argument. Doing so makes the code a bit easier to read and understand,
and avoids questions like this one: Why are you adding 2 to the
requested length? I presume that you're taking the "/" and NUL into
account, however, strbuf takes NUL into account on its own as part of
its contract, so you probably wanted to add only 1.

> +               strbuf_addstr(&dirnfile, dir);
> +               if (dirnfile.buf[dirnfile.len - 1] != '/')

I don't know how others feel about it, but it makes me a bit
uncomfortable to see potential access of array item -1. I suppose, in
this case, neither name will be zero-length, however, I'd still feel
more comfortable seeing that documented formally, either via assert():

    assert(dirnfile.len > 0);
    if (dirnfile.buf[dirnfile.len - 1] != '/')

or:

    if (dirnfile.len > 0 && dirnfile.buf[dirnfile.len - 1] != '/')

> +                       strbuf_addch(&dirnfile, '/');
> +               filename = strrchr(file, '/');
> +               strbuf_addstr(&dirnfile, filename ? (filename + 1) : file);
> +               ret = queue_diff(o, dirnfile.buf, file);
> +               strbuf_release(&dirnfile);
> +
> +               return ret;
> +       }
>
>         if (S_ISDIR(mode1) || S_ISDIR(mode2)) {
>                 struct strbuf buffer1 = STRBUF_INIT;
> --
>
> I hope I understood task correct. I think this patch requires writing
> additional tests, so that's what I'm going to do now.
> --
