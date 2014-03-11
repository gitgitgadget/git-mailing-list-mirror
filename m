From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [RFC memory leak?] Minor memory leak fix
Date: Tue, 11 Mar 2014 18:58:11 +0700
Message-ID: <CACsJy8Bp6rpe4hLg0eMBCjPjL5uDwXj-7ZVmZtUZvR26unAuoQ@mail.gmail.com>
References: <1394534706-28987-1-git-send-email-iveqy@iveqy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Fredrik Gustafsson <iveqy@iveqy.com>
X-From: git-owner@vger.kernel.org Tue Mar 11 12:58:47 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WNLKZ-0000pp-29
	for gcvg-git-2@plane.gmane.org; Tue, 11 Mar 2014 12:58:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754757AbaCKL6m (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Mar 2014 07:58:42 -0400
Received: from mail-qa0-f44.google.com ([209.85.216.44]:56742 "EHLO
	mail-qa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754025AbaCKL6l (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Mar 2014 07:58:41 -0400
Received: by mail-qa0-f44.google.com with SMTP id f11so8315253qae.31
        for <git@vger.kernel.org>; Tue, 11 Mar 2014 04:58:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=hSn8w5KK6ueA/PdgabdGEBGcT/lZQM7oh0hAT0LsT2w=;
        b=jjLOgF40069Ci8b9QgF5BWijQvrcCijb11+PHVGxje8Rt498kKaE5SYunXkdTv7zxi
         ltf/bXKljYVHV0fX3oseiH/t9GDjeci+zmqgoEUWwz+CkfMp3x5HzuVfGWQJ2eIaDaL6
         BcWwcUKUuIeQeiDdCi6KqMj9l9pxwt8jgLjSIUv41itYKyDdRXDwe/F8yVW0n/fXqDHS
         ZxrpoMpF9EOYQ5hYBHWZ1d6IbFknB0eD2Etmra1Go1VtG3uXOIw9Lw5j4rN0fo1+cZRj
         C6qj0NpNHXaYsOZ3LZArOG56Ofb60x4SAzSfn0hicDDdfApwIKXLkN5mjRPA02RPT8yz
         KG4A==
X-Received: by 10.140.40.5 with SMTP id w5mr44785121qgw.65.1394539121242; Tue,
 11 Mar 2014 04:58:41 -0700 (PDT)
Received: by 10.96.215.102 with HTTP; Tue, 11 Mar 2014 04:58:11 -0700 (PDT)
In-Reply-To: <1394534706-28987-1-git-send-email-iveqy@iveqy.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243859>

On Tue, Mar 11, 2014 at 5:45 PM, Fredrik Gustafsson <iveqy@iveqy.com> wrote:
> Strbuf needs to be released even if it's locally declared.

"path" is declared static. So yes it's a leak but the leak is minimum.
Your patch would make more sense if "static" is gone and it's leaked
after every write_archive_entry call.

>
> Signed-off-by: Fredrik Gustafsson <iveqy@iveqy.com>
> ---
>  archive.c | 21 +++++++++++++++------
>  1 file changed, 15 insertions(+), 6 deletions(-)
>
> diff --git a/archive.c b/archive.c
> index 346f3b2..d6d56e6 100644
> --- a/archive.c
> +++ b/archive.c
> @@ -113,6 +113,7 @@ static int write_archive_entry(const unsigned char *sha1, const char *base,
>         struct git_attr_check check[2];
>         const char *path_without_prefix;
>         int err;
> +       int to_ret = 0;
>
>         args->convert = 0;
>         strbuf_reset(&path);
> @@ -126,8 +127,10 @@ static int write_archive_entry(const unsigned char *sha1, const char *base,
>
>         setup_archive_check(check);
>         if (!git_check_attr(path_without_prefix, ARRAY_SIZE(check), check)) {
> -               if (ATTR_TRUE(check[0].value))
> -                       return 0;
> +               if (ATTR_TRUE(check[0].value)) {
> +                       to_ret = 0;
> +                       goto cleanup;
> +               }

to_ret is already 0 so I think "goto cleanup;" is enough.

>                 args->convert = ATTR_TRUE(check[1].value);
>         }
>
> @@ -135,14 +138,20 @@ static int write_archive_entry(const unsigned char *sha1, const char *base,
>                 if (args->verbose)
>                         fprintf(stderr, "%.*s\n", (int)path.len, path.buf);
>                 err = write_entry(args, sha1, path.buf, path.len, mode);
> -               if (err)
> -                       return err;
> -               return (S_ISDIR(mode) ? READ_TREE_RECURSIVE : 0);
> +               if (err) {
> +                       to_ret = err;
> +                       goto cleanup;
> +               }
> +               to_ret = (S_ISDIR(mode) ? READ_TREE_RECURSIVE : 0);
> +               goto cleanup;

Maybe if (err) to_ret = ...; else to_ret = ...; so we only need one
"goto cleanup" statement. Going even further:

to_ret = write_entry(...);
if (!to_ret) to_ret = (S_ISDIR(...));
goto cleanup;

>         }
>
>         if (args->verbose)
>                 fprintf(stderr, "%.*s\n", (int)path.len, path.buf);
> -       return write_entry(args, sha1, path.buf, path.len, mode);
> +       to_ret = write_entry(args, sha1, path.buf, path.len, mode);
> +cleanup:
> +       strbuf_release(&path);
> +       return to_ret;
>  }
>
>  int write_archive_entries(struct archiver_args *args,
> --
> 1.8.3.1.490.g39d9b24.dirty
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Duy
