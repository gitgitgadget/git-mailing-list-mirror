From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 4/5] remote.c: teach branch_get() to treat symrefs other
 than HEAD
Date: Wed, 1 May 2013 13:16:05 -0500
Message-ID: <CAMP44s20F-QALd18VPHLF4Fj=eFFvXmkhC4XK__kxNhMoeN=ug@mail.gmail.com>
References: <1367425235-14998-1-git-send-email-artagnon@gmail.com>
	<1367425235-14998-5-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>, Duy Nguyen <pclouds@gmail.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 01 20:16:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UXbZd-00086F-Gs
	for gcvg-git-2@plane.gmane.org; Wed, 01 May 2013 20:16:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752703Ab3EASQK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 May 2013 14:16:10 -0400
Received: from mail-lb0-f175.google.com ([209.85.217.175]:61575 "EHLO
	mail-lb0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752079Ab3EASQH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 May 2013 14:16:07 -0400
Received: by mail-lb0-f175.google.com with SMTP id w20so1690239lbh.34
        for <git@vger.kernel.org>; Wed, 01 May 2013 11:16:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=x5ynj/SkrHVpLK2dtsFTkJE1C6/JzouHHVdp0+2i808=;
        b=yb4tLDSeSzjTSCJr42Kz1CS/u5+kJgYZAxKgM/lG2IogcJj6abPPwD7u6sfA63FMYd
         xn+MC0P8s4045f7NqDDcMon2fIGI4Lt1TJfwC65bAnifLHsMr84h1tKuAKq1x0OQ1iwN
         OoBKZ7qgK3HMm+Bt8W3I5dIxf9z0VrwM3htbnKU81vUY58ShWBKGQzlD/r3n+TanGSWU
         ADFEbmYLuL4TlSaNh6yGApQwOdxvKLnuTDubt72Z2fXozvMWPupfWQvU/BHLmPXZifAZ
         CoxoaNabY7+hZpVsThcLnp+nYUONdFjcvgMOHZbm1aNjR3tK9odoOwoecZ9/7G96utGr
         eoeQ==
X-Received: by 10.152.3.137 with SMTP id c9mr1362101lac.5.1367432165148; Wed,
 01 May 2013 11:16:05 -0700 (PDT)
Received: by 10.114.83.167 with HTTP; Wed, 1 May 2013 11:16:05 -0700 (PDT)
In-Reply-To: <1367425235-14998-5-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223109>

On Wed, May 1, 2013 at 11:20 AM, Ramkumar Ramachandra
<artagnon@gmail.com> wrote:
> Currently, branch_get() either accepts either a branch name, empty
> string, or the magic four-letter word "HEAD".  Make it additionally
> handle symbolic refs that point to a branch.
>
> Update sha1_name.c:interpret_branch_name() to look for "@{", not '@'
> (since '@' is a valid symbolic ref).
>
> These two changes together make the failing test in t1508
> (at-combinations) pass.  In other words, you can now do:
>
>     $ git symbolic-ref @ HEAD
>
> And expect the following to work:
>
>     $ git rev-parse @@{u}
>
> Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
> ---
>  remote.c                   | 14 ++++++++++++++
>  sha1_name.c                |  2 +-
>  t/t1508-at-combinations.sh |  2 +-
>  3 files changed, 16 insertions(+), 2 deletions(-)
>
> diff --git a/remote.c b/remote.c
> index 68eb99b..0f44e2e 100644
> --- a/remote.c
> +++ b/remote.c
> @@ -1470,6 +1470,20 @@ struct branch *branch_get(const char *name)
>                 ret = current_branch;
>         else
>                 ret = make_branch(name, 0);
> +
> +       if (name && *name && (!ret || !ret->remote_name)) {
> +               /* Is this a symref pointing to a valid branch, other
> +                * than HEAD?
> +                */
> +               const char *this_ref;
> +               unsigned char sha1[20];
> +               int flag;
> +
> +               this_ref = resolve_ref_unsafe(name, sha1, 0, &flag);
> +               if (this_ref && (flag & REF_ISSYMREF) &&
> +                       !prefixcmp(this_ref, "refs/heads/"))
> +                       ret = make_branch(this_ref + strlen("refs/heads/"), 0);
> +       }

But why? I'm not familiar with branch_get, but my intuition tells me
you are changing the behavior, and now branch_get() is doing something
it wasn't intended to do. And for what?

Your rationale is that it fixes the test cases below, but that's not
reason enough, since there are other ways to fix them, as my patch
series shows.

>         if (ret && ret->remote_name) {
>                 ret->remote = remote_get(ret->remote_name);
>                 if (ret->merge_nr) {
> diff --git a/sha1_name.c b/sha1_name.c
> index f30e344..c4a3a54 100644
> --- a/sha1_name.c
> +++ b/sha1_name.c
> @@ -1060,7 +1060,7 @@ int interpret_branch_name(const char *name, struct strbuf *buf)
>                 return ret - used + len;
>         }
>
> -       cp = strchr(name, '@');
> +       cp = strstr(name, "@{");

This might make sense, but it feels totally sneaked in.

>         if (!cp)
>                 return -1;
>         tmp_len = upstream_mark(cp, namelen - (cp - name));

I think these are two patches should be introduced separately, and
with a reason for them to exist independent of each other.

Cheers.

-- 
Felipe Contreras
