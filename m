From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 02/12] remote.c: drop "remote" pointer from "struct branch"
Date: Sat, 2 May 2015 23:34:25 -0400
Message-ID: <CAPig+cQny16Jei9AtDWVY3ADbPGshFw7CYofD_TnyA+GL58AOg@mail.gmail.com>
References: <20150501224414.GA25551@peff.net>
	<20150501224515.GB1534@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun May 03 05:38:34 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yokjg-00055a-RZ
	for gcvg-git-2@plane.gmane.org; Sun, 03 May 2015 05:38:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751348AbbECDe1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 May 2015 23:34:27 -0400
Received: from mail-ig0-f173.google.com ([209.85.213.173]:38854 "EHLO
	mail-ig0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750807AbbECDe0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 May 2015 23:34:26 -0400
Received: by igbhj9 with SMTP id hj9so62739084igb.1
        for <git@vger.kernel.org>; Sat, 02 May 2015 20:34:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=hRh3ES1lOIndIApLxawBl68IMiU6d3lQfQZw/5Uv8tg=;
        b=insJxdNH9d+/RLIer5G6KzYN8S+Dr9PWvD9hyJnT5Zj/QkrfkP7oUGTySZ+y4xnKvc
         /UQMSz5qt8lCTfFMX6wdcTTPuig4NKNFLvdBqcW14VrrXHnQvSLCOCx5rq13fqdGgc7H
         BLYQvIjyO8AcnfOE34lM8inschAXGzXgziznc7uaVnlmSB5ErIzDUuc6Y2NB9YkIKWej
         yUi3OeJoklM35Q/qNMXdjHr20HVsEtU8VhZA1PjP4Ntd/wDgMfyaxqKZ6KWlC05175n5
         n2q9THAaBZOWwcH2vtMq8usfbmDDIkH04PiruDqlshmwGg6YphFREujwaIVbxXuJixZK
         UdLA==
X-Received: by 10.50.66.230 with SMTP id i6mr6128735igt.22.1430624065274; Sat,
 02 May 2015 20:34:25 -0700 (PDT)
Received: by 10.107.28.132 with HTTP; Sat, 2 May 2015 20:34:25 -0700 (PDT)
In-Reply-To: <20150501224515.GB1534@peff.net>
X-Google-Sender-Auth: e51OUtSrFF_qfyo6w_iRavx-SaI
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268257>

On Fri, May 1, 2015 at 6:45 PM, Jeff King <peff@peff.net> wrote:
> When we create each branch struct, we fill in the
> "remote_name" field from the config, and then fill in the
> actual "remote" field (with a "struct remote") based on that
> name. However, it turns out that nobody really cares about
> the latter field. The only two sites that access it at all
> are:
>
>   1. git-merge, which uses it to notice when the branch does
>      not have a remote defined. But we can easily replace this
>      with looking at remote_name instead.
>
>   2. remote.c itself, when setting up the @{upstream} merge
>      config. But we don't need to save the "remote" in the
>      "struct branch" for that; we can just look it up for
>      the duration of the operation.
>
> So there is no need to have both fields; they are redundant
> with each other (the struct remote contains the name, or you
> can look up the struct from the name). It would be nice to
> simplify this, especially as we are going to add matching
> pushremote config in a future patch (and it would be nice to
> keep them consistent).
> [...]

Nice clear explanation, but...

> Signed-off-by: Jeff King <peff@peff.net>
> ---
> diff --git a/remote.c b/remote.c
> index bec8b31..c85ecef 100644
> --- a/remote.c
> +++ b/remote.c
> @@ -1632,15 +1632,20 @@ void set_ref_status_for_push(struct ref *remote_refs, int send_mirror,
>
>  static void set_merge(struct branch *ret)
>  {
> +       struct remote *remote;
>         char *ref;
>         unsigned char sha1[20];
>         int i;
>
> +       if (!ret->remote_name || !ret->merge_nr)
> +               return;
> +       remote = remote_get(ret->remote_name);
> +
>         ret->merge = xcalloc(ret->merge_nr, sizeof(*ret->merge));
>         for (i = 0; i < ret->merge_nr; i++) {
>                 ret->merge[i] = xcalloc(1, sizeof(**ret->merge));
>                 ret->merge[i]->src = xstrdup(ret->merge_name[i]);
> -               if (!remote_find_tracking(ret->remote, ret->merge[i]) ||
> +               if (!remote_find_tracking(remote, ret->merge[i]) ||
>                     strcmp(ret->remote_name, "."))
>                         continue;
>                 if (dwim_ref(ret->merge_name[i], strlen(ret->merge_name[i]),
> @@ -1660,11 +1665,8 @@ struct branch *branch_get(const char *name)
>                 ret = current_branch;
>         else
>                 ret = make_branch(name, 0);
> -       if (ret && ret->remote_name) {
> -               ret->remote = remote_get(ret->remote_name);
> -               if (ret->merge_nr)
> -                       set_merge(ret);
> -       }
> +       if (ret)
> +              set_merge(ret);

When reading the actual patch, I was surprised to see unmentioned
changes to the reg->merge_nr check. Although the merge_nr
simplification seems sensible, it appears to be unrelated to the
stated purpose of the patch, and made the review more difficult since
it required keeping track of two distinct (yet textually intertwined)
changes. I wonder if it would make more sense to apply the merge_nr
simplification as a separate preparatory patch?

>         return ret;
>  }
