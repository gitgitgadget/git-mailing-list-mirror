From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 2/2] Fix git rev-list --bisect and git bisect visualize
 when the bisection is done in old/new mode.
Date: Fri, 5 Jun 2015 16:24:29 -0400
Message-ID: <CAPig+cQ0W_Jw-1b+ghX6N9NYPfb_4KmDnLyCE=SEPAXFrP+egA@mail.gmail.com>
References: <1433522061-14532-1-git-send-email-stuberl@ensimag.grenoble-inp.fr>
	<1433522061-14532-2-git-send-email-stuberl@ensimag.grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	=?UTF-8?Q?Galan_R=C3=A9mi?= 
	<remi.galan-alfonso@ensimag.grenoble-inp.fr>,
	Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>,
	Matthieu Moy <matthieu.moy@grenoble-inp.fr>,
	Guillaume Pages <guillaume.pages@ensimag.grenoble-inp.fr>,
	Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>,
	j_franck7@msn.com, valentinduperray@gmail.com,
	thomasxnguy@gmail.com, lucienkong@hotmail.com,
	Christian Couder <chriscool@tuxfamily.org>
To: Louis Stuber <stuberl@ensimag.grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Fri Jun 05 22:24:40 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z0yAM-0003r7-Jp
	for gcvg-git-2@plane.gmane.org; Fri, 05 Jun 2015 22:24:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751330AbbFEUYa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Jun 2015 16:24:30 -0400
Received: from mail-ig0-f177.google.com ([209.85.213.177]:34814 "EHLO
	mail-ig0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750754AbbFEUY3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Jun 2015 16:24:29 -0400
Received: by igbhj9 with SMTP id hj9so23810096igb.1
        for <git@vger.kernel.org>; Fri, 05 Jun 2015 13:24:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=i/2Lrzn3hnjRBI7RCrvs0uLozIFVmgOdJakv8jCpxyQ=;
        b=jaoUJMj8oPz1d13m2rIb/saepE2tN4tE3AXYm/G2cnY++c6SPaeOp86Rcex1JO0nrH
         g+FK5rSjrwbVfYC3AbWB9UZwhAY2QxeeVCnGmbvIq+TcebUEt2P/c6RV3/yPhGWgoVUL
         rFC4AMv/1B9siunG7kMFEkQnNzOoE5tpezTJ+LH2V1qLkbNL81M+D7l7Lz3zN9lTk2mk
         BtEKa2spHUkFd8nICoFWl1QsMFhiLPePIH3DxQRKHVPK+ps7vRZgNxr3MWKDDfLLYsWh
         CwPXYuMwYYx1LG9d+wOLke62qjEWLMz4mCQWUIWLsM7cuGVHJ7t2p7ORrMtrGSf5nVoU
         2cJA==
X-Received: by 10.107.151.75 with SMTP id z72mr6830063iod.46.1433535869102;
 Fri, 05 Jun 2015 13:24:29 -0700 (PDT)
Received: by 10.107.28.132 with HTTP; Fri, 5 Jun 2015 13:24:29 -0700 (PDT)
In-Reply-To: <1433522061-14532-2-git-send-email-stuberl@ensimag.grenoble-inp.fr>
X-Google-Sender-Auth: ZAUPbB15Lz9hzGG8zto18eAZegs
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270889>

On Fri, Jun 5, 2015 at 12:34 PM, Louis Stuber
<stuberl@ensimag.grenoble-inp.fr> wrote:
> Fix git rev-list --bisect and git bisect visualize when the bisection
> is done in old/new mode.

See my review of patch 1/2 regarding writing a good commit message. In
particular, explain what is broken about "git rev-list --bisect" and
"git bisect visualize" so that the reader can understand what this
patch is actually fixing.

> Signed-off-by: Louis Stuber <stuberl@ensimag.grenoble-inp.fr>
> Signed-off-by: Antoine Delaite <antoine.delaite@ensimag.grenoble-inp.fr>
> ---
> diff --git a/revision.c b/revision.c
> index 7ddbaa0..b631596 100644
> --- a/revision.c
> +++ b/revision.c
> @@ -2075,12 +2075,23 @@ void parse_revision_opt(struct rev_info *revs, struct parse_opt_ctx_t *ctx,
>
>  static int for_each_bad_bisect_ref(const char *submodule, each_ref_fn fn, void *cb_data)
>  {
> -       return for_each_ref_in_submodule(submodule, "refs/bisect/bad", fn, cb_data);
> +       /*
> +        * if BISECT_OLDNEWMODE exists, this is an old/new bisect and the path is different
> +        */

Comments which merely repeat what the code itself already clearly says
don't add value, and are thus noise which impede comprehension by
distracting the reader from digesting the underlying logic flow.

> +       struct stat st;
> +       if (stat(git_path("BISECT_OLDNEWMODE"), &st))
> +               return for_each_ref_in_submodule(submodule, "refs/bisect/bad", fn, cb_data);
> +       else
> +               return for_each_ref_in_submodule(submodule, "refs/bisect/new", fn, cb_data);

Since the two for_each_ref_in_submodule() calls are identical except
for the second argument, the more natural and easier to comprehend way
to phrase this would be be to assign "refs/bisect/bad" or
"refs/bisect/new" to a variable, and then have just a single
invocation of for_each_ref_in_submodule() which uses that variable as
its second argument.

Stepping back a moment: My reading of these two patches is that
BISECT_OLDNEWMODE is introduced as a simple way to detect if "old/new"
mode is being used rather than gleaning that knowledge from the
existing BISECT_TERMS file. Is that correct?

If so, then these changes are likely going in the wrong direction. The
ominous final sentence of the commit message of patch 1/2 is already a
good clue that this approach won't scale well. Further, the approach
taken here undesirably emphasizes ease of implementation and its
attendant fragility over well thought out design.

>  }
>
>  static int for_each_good_bisect_ref(const char *submodule, each_ref_fn fn, void *cb_data)
>  {
> -       return for_each_ref_in_submodule(submodule, "refs/bisect/good", fn, cb_data);
> +       struct stat st;
> +       if (stat(git_path("BISECT_OLDNEWMODE"), &st))
> +               return for_each_ref_in_submodule(submodule, "refs/bisect/good", fn, cb_data);
> +       else
> +               return for_each_ref_in_submodule(submodule, "refs/bisect/old", fn, cb_data);
>  }
>
>  static int handle_revision_pseudo_opt(const char *submodule,
> --
> 1.7.1
