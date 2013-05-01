From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 1/2] help: add help_unknown_ref
Date: Wed, 1 May 2013 17:53:35 +0530
Message-ID: <CALkWK0nMMi-nmAMUGXCaJDCV29G3dOzYTosKqSw+bFzc0osiaA@mail.gmail.com>
References: <1367407327-5216-1-git-send-email-vikrant.varma94@gmail.com> <1367407327-5216-2-git-send-email-vikrant.varma94@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Vikrant Varma <vikrant.varma94@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 01 14:24:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UXW5F-0000Ap-CL
	for gcvg-git-2@plane.gmane.org; Wed, 01 May 2013 14:24:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752657Ab3EAMYR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 May 2013 08:24:17 -0400
Received: from mail-ie0-f181.google.com ([209.85.223.181]:41801 "EHLO
	mail-ie0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750928Ab3EAMYQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 May 2013 08:24:16 -0400
Received: by mail-ie0-f181.google.com with SMTP id tp5so1769059ieb.40
        for <git@vger.kernel.org>; Wed, 01 May 2013 05:24:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=YoUxxJz0v0R5QnDkf12cohDIOPD4EnKtKw5YgS8ByIo=;
        b=X/NS0wGM8vdrCgUpElh5cGZQE+LkOWzS6fz/Xo8XBFgiMU1No4tmeOBJLlYTcKSfkh
         6NgFIBnSgGKKMyJobTRqZ6XPfWC9/nC/zZBkKSmGu+4tQnZFpt5rqdng/nxXt05Kobz2
         6OIRKCu3XwNuYQ/8Ypx8H5Sc01Jv4WQOyDrcTFF5tDNswvGXU/vgmNdKzu8qffNKkh45
         8KnLQGKkpduH3FS5s7tBYaw2XvzVZ0mzkt4iFwtbz6/iUFxsmcOM218sDkDRPVjt+dDG
         I+2XSVoXT5XGYNbjSN4c6SoXnRIeck6kDcdxkS7oBtoV/ZIQ2e6MmxrwDxLpokwVVzSR
         LuTg==
X-Received: by 10.50.72.65 with SMTP id b1mr1516448igv.63.1367411055573; Wed,
 01 May 2013 05:24:15 -0700 (PDT)
Received: by 10.64.46.1 with HTTP; Wed, 1 May 2013 05:23:35 -0700 (PDT)
In-Reply-To: <1367407327-5216-2-git-send-email-vikrant.varma94@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223089>

Vikrant Varma wrote:
> Give better advice when trying to merge a branch that doesn't exist. If
> the branch exists in any remotes, display a list of suggestions.

Interesting.  Thanks for working on this.

You say advice, but you're not invoking advise() or guarding the
advice with an advice.* -- the advice is undoubtedly helpful, but not
everyone wants to see it.

> diff --git a/help.c b/help.c
> index 02ba043..faf18b9 100644
> --- a/help.c
> +++ b/help.c
> @@ -7,6 +7,7 @@
>  #include "string-list.h"
>  #include "column.h"
>  #include "version.h"
> +#include "refs.h"
>
>  void add_cmdname(struct cmdnames *cmds, const char *name, int len)
>  {
> @@ -404,3 +405,46 @@ int cmd_version(int argc, const char **argv, const char *prefix)
>         printf("git version %s\n", git_version_string);
>         return 0;
>  }
> +
> +struct similar_ref_cb {

I see that there are other structs in our codebase suffixing _cb, to
indicate "callback data".  I normally reserve _cb for callback
functions.

> +        const char *base_ref;
> +        struct string_list similar_refs;

Okay, so you might have more than one matching candidate.

> +static int append_similar_ref(const char* refname, const unsigned char *sha1, int flags, void *cb_data)
> +{
> +        int i;
> +        struct similar_ref_cb *cb = (struct similar_ref_cb *)(cb_data);
> +        for (i = strlen(refname); refname[i] != '/'; i--)
> +               ;

Er, what is this?  A re-implementation of strrchr()?

> +        /* A remote branch of the same name is deemed similar */
> +        if (!prefixcmp(refname, "refs/remotes/") && !strcmp(refname + i + 1, cb->base_ref))
> +               string_list_append(&(cb->similar_refs), refname + 13);

What is 13?  Please use strlen("refs/remotes/") for readability.

I don't like the + i + 1 thing, but you should be able to get rid of
it with strrchr().

> +void help_unknown_ref(const char* ref) {
> +        int i;
> +        struct similar_ref_cb ref_cb;
> +        ref_cb.similar_refs = (struct string_list)STRING_LIST_INIT_NODUP;

Why are you casting STRING_LIST_INIT_NODUP?

> +        ref_cb.base_ref = ref;
> +
> +        for_each_ref(append_similar_ref, &ref_cb);
> +
> +        fprintf_ln(stderr, _("fatal: %s - not something we can merge"), ref);

Hm, "fatal: " was emitted by die() earlier.  I wonder if something
like error() will be nicer than hard-coding "fatal: ".

> +        if (ref_cb.similar_refs.nr > 0) {
> +               fprintf_ln(stderr,
> +                          Q_("\nDid you mean this?",
> +                             "\nDid you mean one of these?",
> +                             ref_cb.similar_refs.nr));

Hm, why did you use Q_?

> +               for (i = 0; i < ref_cb.similar_refs.nr; i++)
> +                       fprintf(stderr, "\t%s\n", ref_cb.similar_refs.items[i].string);
> +        }
> +        exit(1);

die() exits with 128, no?  Why are you exiting with 1 now?
