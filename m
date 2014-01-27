From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v2 2/2] setup: Don't dereference in-tree symlinks for
 absolute paths
Date: Mon, 27 Jan 2014 07:49:42 +0700
Message-ID: <CACsJy8AwBXtYTbQhcAfYgwuEGrzbMG9SDo8JOpSVF945O7VPyQ@mail.gmail.com>
References: <52E5439D.7060002@web.de> <1390781250-20389-1-git-send-email-martinerikwerner@gmail.com>
 <1390781250-20389-2-git-send-email-martinerikwerner@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
	Git Mailing List <git@vger.kernel.org>, richih@debian.org
To: Martin Erik Werner <martinerikwerner@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 27 01:50:29 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W7aPB-0007L5-3Z
	for gcvg-git-2@plane.gmane.org; Mon, 27 Jan 2014 01:50:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753277AbaA0AuP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Jan 2014 19:50:15 -0500
Received: from mail-qc0-f176.google.com ([209.85.216.176]:40481 "EHLO
	mail-qc0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753121AbaA0AuN (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Jan 2014 19:50:13 -0500
Received: by mail-qc0-f176.google.com with SMTP id e16so7089993qcx.21
        for <git@vger.kernel.org>; Sun, 26 Jan 2014 16:50:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=47lYF+74WVLAvY5yFbMfaIpCFaknQwwtcy3uCw2IcWM=;
        b=G4katvuqiqY0ICCmUDBIixm9LQb2BLKHANNOhRGDqIkinY7cXbwpWAFSn2Co/YjWMy
         uMzSCzEQDQh9BFJ3b4DIfbm/eQ8mvHDsNBPI5WPvAURh18QMMSDQJ4CAt7r341iLBqkr
         3zBSaYRVqvnZLKX5Sz2tmdsS3toPuUOdZjh2j3STx9aiEREB/r5xFxY1jqg6/0lS7/+y
         /VR6+OzVDmq++MgfIe58dfWvqum4Va2e9Xw8NFCgyZYSZmLN/DHE+cSC2j16ttz2Qhsk
         fEynBDcZeDwNiGhwOjH0xdAjdaXWMPIgL2N1cLBXTM60oslPmh4hnqscVXoS6+eT7r+5
         a5OA==
X-Received: by 10.229.56.200 with SMTP id z8mr38588421qcg.1.1390783813013;
 Sun, 26 Jan 2014 16:50:13 -0800 (PST)
Received: by 10.96.136.98 with HTTP; Sun, 26 Jan 2014 16:49:42 -0800 (PST)
In-Reply-To: <1390781250-20389-2-git-send-email-martinerikwerner@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241123>

On Mon, Jan 27, 2014 at 7:07 AM, Martin Erik Werner
<martinerikwerner@gmail.com> wrote:
> diff --git a/setup.c b/setup.c
> index 5432a31..0789a96 100644
> --- a/setup.c
> +++ b/setup.c
> @@ -22,11 +22,51 @@ char *prefix_path_gently(const char *prefix, int len,
>         const char *orig = path;
>         char *sanitized;
>         if (is_absolute_path(orig)) {
> -               const char *temp = real_path(path);
> -               sanitized = xmalloc(len + strlen(temp) + 1);
> -               strcpy(sanitized, temp);
> +               int i, match;
> +               size_t wtpartlen;
> +               char *npath, *wtpart;
> +               struct string_list list = STRING_LIST_INIT_DUP;
> +               const char *work_tree = get_git_work_tree();
> +               if (!work_tree)
> +                       return NULL;
> +               npath = xmalloc(strlen(path) + 1);
>                 if (remaining_prefix)
>                         *remaining_prefix = 0;
> +               if (normalize_path_copy_len(npath, path, remaining_prefix)) {
> +                       free(npath);
> +                       return NULL;
> +               }
> +
> +               string_list_split(&list, npath, '/', -1);
> +               wtpart = xmalloc(strlen(npath) + 1);
> +               i = 0;
> +               match = 0;

> +               strcpy(wtpart, list.items[i++].string);
> +               strcat(wtpart, "/");
> +               if (strcmp(real_path(wtpart), work_tree) == 0) {
> +                       match = 1;
> +               } else {

Could we remove this part and let the while loop handle the first path
component too? The only difference I see is if this code matches, we
have a trailing slash, while the "while" loop does not have a trailing
slash in wtpart.

> +                       while (i < list.nr) {
> +                               strcat(wtpart, list.items[i++].string);
> +                               if (strcmp(real_path(wtpart), work_tree) == 0) {
> +                                       match = 1;
> +                                       break;
> +                               }
> +                               strcat(wtpart, "/");
> +                       }
> +               }
> +               string_list_clear(&list, 0);
> +               if (!match) {
> +                       free(npath);
> +                       free(wtpart);
> +                       return NULL;
> +               }
> +
> +               wtpartlen = strlen(wtpart);
> +               sanitized = xmalloc(strlen(npath) - wtpartlen);
> +               strcpy(sanitized, npath + wtpartlen + 1);

This "+ 1" is to ignore '/', isn't it? If so we should not do if match
is set 1 outside "while" loop.

> +               free(npath);
> +               free(wtpart);

All this new code looks long enough to be a separate function with a
meaningful name. And we could travese through each path component in
npath without wtpart (replacing '/' with '\0' to terminate the string
temporarily for real_path()). But it's up to you. Whichever way is
easier to read to you.

>         } else {
>                 sanitized = xmalloc(len + strlen(path) + 1);
>                 if (len)
> @@ -34,26 +74,10 @@ char *prefix_path_gently(const char *prefix, int len,
>                 strcpy(sanitized + len, path);
>                 if (remaining_prefix)
>                         *remaining_prefix = len;
> -       }
> -       if (normalize_path_copy_len(sanitized, sanitized, remaining_prefix))
> -               goto error_out;
> -       if (is_absolute_path(orig)) {
> -               size_t root_len, len, total;
> -               const char *work_tree = get_git_work_tree();
> -               if (!work_tree)
> -                       goto error_out;
> -               len = strlen(work_tree);
> -               root_len = offset_1st_component(work_tree);
> -               total = strlen(sanitized) + 1;
> -               if (strncmp(sanitized, work_tree, len) ||
> -                   (len > root_len && sanitized[len] != '\0' && sanitized[len] != '/')) {
> -               error_out:
> +               if (normalize_path_copy_len(sanitized, sanitized, remaining_prefix)) {
>                         free(sanitized);
>                         return NULL;
>                 }
> -               if (sanitized[len] == '/')
> -                       len++;
> -               memmove(sanitized, sanitized + len, total - len);
>         }
>         return sanitized;
>  }
-- 
Duy
