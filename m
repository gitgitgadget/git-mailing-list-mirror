From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 5/7] enforce `xfuncname` precedence over `funcname`
Date: Wed, 23 Jul 2014 17:04:52 -0400
Message-ID: <CAPig+cRwtWMwDOxQEhLDy_eZbPuYRhiag4SwJ+A0OOu44un5MA@mail.gmail.com>
References: <1406140978-9472-1-git-send-email-tanayabh@gmail.com>
	<1406140978-9472-6-git-send-email-tanayabh@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Tanay Abhra <tanayabh@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 23 23:05:01 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XA3ib-0004rv-V4
	for gcvg-git-2@plane.gmane.org; Wed, 23 Jul 2014 23:04:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933431AbaGWVEy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jul 2014 17:04:54 -0400
Received: from mail-yh0-f53.google.com ([209.85.213.53]:61319 "EHLO
	mail-yh0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933388AbaGWVEx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jul 2014 17:04:53 -0400
Received: by mail-yh0-f53.google.com with SMTP id c41so1219880yho.40
        for <git@vger.kernel.org>; Wed, 23 Jul 2014 14:04:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=+hFjeOVX5omK7isH1y1f1Ma9lE6RWwZT4pe/Sf3V2wQ=;
        b=xS1QOyhoKGK+waqQbkjS9efgoKnuDorlM1yEKFS1KK3H6+UbqSdRrFmRJLndIahedP
         wBxwC2+DcSzKv5pQIpinvbvwZOKleybJdFaiQqGWDYLfPeKDzV06nMR5j5z6YUk/b0Is
         8Yzv7xwON5O2cxoc1I+sBZh97ptJ4DFdGGDCNV281dTlxpEHtnuuAr32yCG5dad+IUH7
         tZt2k7CmO+HaCPvTPXxJ1HV9oWQb52INArCU5X52uqLSoz0ZL0azHGCzOFlls4RMrSWj
         cx/YTrQDSc8ac5Co21a3mlOAyoi4fmxelyPmc+5BCz6ubEx9TORC6q+tOuLc2DVf2MVJ
         rDSQ==
X-Received: by 10.236.57.232 with SMTP id o68mr2611583yhc.75.1406149492932;
 Wed, 23 Jul 2014 14:04:52 -0700 (PDT)
Received: by 10.170.163.5 with HTTP; Wed, 23 Jul 2014 14:04:52 -0700 (PDT)
In-Reply-To: <1406140978-9472-6-git-send-email-tanayabh@gmail.com>
X-Google-Sender-Auth: SSiQ6WjpmvT5QUQGWsDZkzmBUg0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254121>

On Wed, Jul 23, 2014 at 2:42 PM, Tanay Abhra <tanayabh@gmail.com> wrote:
> t4018-diff-funcname.sh fails for the new `git_config()` which uses the
> configuration files caching layer internally.
> The test introduced in commit d64d6cdc checks that whether `xfuncname` takes

s/that//

> precedence over `funcname` variable which was not guaranteed by config API
> previously and worked only because values were parsed and fed in order. The
> new  `git_config()` only guarantees precedence order for variables with the

s/\s+/ /

> same name.
>
> Also `funcname` variable is deprecated and not documented properly.
> `xfuncname` is mentioned in the docs and takes precedence over `funcname`.
> Instead of removing `funcname` variable, enforce `xfuncname` precedence over
> `funcname` when the variables have the same subsection. Remove dependency
> that required values to be fed to userdiff_config() in parsing order for the
> test to succeed.
>
> Signed-off-by: Tanay Abhra <tanayabh@gmail.com>
> ---
> Note: this the only test that failed for the new git_config() rewrite.
>
>  userdiff.c | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
>
> diff --git a/userdiff.c b/userdiff.c
> index fad52d6..a51bc89 100644
> --- a/userdiff.c
> +++ b/userdiff.c
> @@ -2,6 +2,7 @@
>  #include "userdiff.h"
>  #include "cache.h"
>  #include "attr.h"
> +#include "string-list.h"
>
>  static struct userdiff_driver *drivers;
>  static int ndrivers;
> @@ -211,9 +212,12 @@ int userdiff_config(const char *k, const char *v)
>         struct userdiff_driver *drv;
>         const char *name, *type;
>         int namelen;
> +       char *subsection = NULL;
> +       static struct string_list xflag = STRING_LIST_INIT_DUP;
>
>         if (parse_config_key(k, "diff", &name, &namelen, &type) || !name)
>                 return 0;
> +       subsection = xstrndup(name, namelen);
>
>         drv = userdiff_find_by_namelen(name, namelen);
>         if (!drv) {
> @@ -224,10 +228,16 @@ int userdiff_config(const char *k, const char *v)
>                 drv->binary = -1;
>         }
>
> -       if (!strcmp(type, "funcname"))
> +       if (!strcmp(type, "funcname") && !unsorted_string_list_has_string(&xflag, subsection)) {
> +               free (subsection);
>                 return parse_funcname(&drv->funcname, k, v, 0);
> -       if (!strcmp(type, "xfuncname"))
> +       }
> +       if (!strcmp(type, "xfuncname")) {
> +               string_list_append(&xflag, subsection);
> +               free (subsection);
>                 return parse_funcname(&drv->funcname, k, v, REG_EXTENDED);
> +       }
> +       free(subsection);
>         if (!strcmp(type, "binary"))
>                 return parse_tristate(&drv->binary, k, v);
>         if (!strcmp(type, "command"))
> --
> 1.9.0.GIT
