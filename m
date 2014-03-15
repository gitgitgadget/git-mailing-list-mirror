From: Akshay Aurora <akshayaurora@yahoo.com>
Subject: Re: [PATCH] Rewrite diff-no-index.c:read_directory() to use
 is_dot_or_dotdot() and rename it to read_dir()
Date: Sat, 15 Mar 2014 12:14:18 +0530
Message-ID: <CAPGnZZn_Wz=LywVevmuXWQX4nO67EKMPazB8jKv-jTZ178=HdQ@mail.gmail.com>
References: <1394800759-87648-1-git-send-email-akshayaurora@yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 15 07:51:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WOiRm-0002E1-Ly
	for gcvg-git-2@plane.gmane.org; Sat, 15 Mar 2014 07:51:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751599AbaCOGvu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Mar 2014 02:51:50 -0400
Received: from mail-pd0-f171.google.com ([209.85.192.171]:39935 "EHLO
	mail-pd0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751339AbaCOGvt (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Mar 2014 02:51:49 -0400
Received: by mail-pd0-f171.google.com with SMTP id r10so3459592pdi.2
        for <git@vger.kernel.org>; Fri, 14 Mar 2014 23:51:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:content-type;
        bh=kqYEpEtJNH+m1B2wrI2VpSll2HWGOgqUij89P0bHslI=;
        b=KeNdiSTI4AB7OD18T/xF/X7BA7QsEePiI/dzc/aFNvvMlnKrtCscy6IPNnKJJ3ZvcY
         9K1n64BI1xlFePYvZo5DJms8nRLSKB9n4qL2sIRUtxouRDgiiN/BAw9aKsF5ClsRFdpM
         kSWb94+BZmWuDSUaE6IQkMutQQhCvwAj/CV0pB5UkFa1nROer792X2ovhl2MDEPvmXXt
         rVu6wkDXb8V1FarV/9zkDLSlBkIgy/tVZAGvGXdZCvOYZkp4Q2qTWOjxk6j85Fz20XaK
         bPFzY4Xluh15fh3DEi4+QLi6EXgLlAII6TVHU7hvJAgl9Io8wZldwkFK67SAvdUisbmv
         SxNw==
X-Received: by 10.66.142.42 with SMTP id rt10mr13655015pab.1.1394865859026;
 Fri, 14 Mar 2014 23:44:19 -0700 (PDT)
Received: by 10.70.81.228 with HTTP; Fri, 14 Mar 2014 23:44:18 -0700 (PDT)
In-Reply-To: <1394800759-87648-1-git-send-email-akshayaurora@yahoo.com>
X-Google-Sender-Auth: DvJEIPQAJRGB7FOU6EqTz03vcUU
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244140>

Forgot to mention, this is one of the microprojects for GSoC this
year. Would be great to have some feedback.

On Fri, Mar 14, 2014 at 6:09 PM, Akshay Aurora <akshayaurora@yahoo.com> wrote:
> I have renamed diff-no-index.c:read_directory() to read_dir() to avoid name collision with dir.c:read_directory()
>
> Signed-off-by: Akshay Aurora <akshayaurora@yahoo.com>
> ---
>  diff-no-index.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/diff-no-index.c b/diff-no-index.c
> index 8e10bff..2a17c9f 100644
> --- a/diff-no-index.c
> +++ b/diff-no-index.c
> @@ -10,13 +10,14 @@
>  #include "blob.h"
>  #include "tag.h"
>  #include "diff.h"
> +#include "dir.h"
>  #include "diffcore.h"
>  #include "revision.h"
>  #include "log-tree.h"
>  #include "builtin.h"
>  #include "string-list.h"
>
> -static int read_directory(const char *path, struct string_list *list)
> +static int read_dir(const char *path, struct string_list *list)
>  {
>         DIR *dir;
>         struct dirent *e;
> @@ -25,7 +26,7 @@ static int read_directory(const char *path, struct string_list *list)
>                 return error("Could not open directory %s", path);
>
>         while ((e = readdir(dir)))
> -               if (strcmp(".", e->d_name) && strcmp("..", e->d_name))
> +               if (!is_dot_or_dotdot(e->d_name))
>                         string_list_insert(list, e->d_name);
>
>         closedir(dir);
> @@ -107,9 +108,9 @@ static int queue_diff(struct diff_options *o,
>                 int i1, i2, ret = 0;
>                 size_t len1 = 0, len2 = 0;
>
> -               if (name1 && read_directory(name1, &p1))
> +               if (name1 && read_dir(name1, &p1))
>                         return -1;
> -               if (name2 && read_directory(name2, &p2)) {
> +               if (name2 && read_dir(name2, &p2)) {
>                         string_list_clear(&p1, 0);
>                         return -1;
>                 }
> --
> 1.8.5.3
>



-- 
With Thanks & Warm Regards
Akshay Aurora
iakshay.net
