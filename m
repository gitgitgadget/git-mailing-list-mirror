From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 3/5] sha1_name.c: simplify @-parsing in get_sha1_basic()
Date: Wed, 1 May 2013 13:09:52 -0500
Message-ID: <CAMP44s1tHC+i+Wug_UuPnprZNvaPgLMNBX9MZi49SFv4iO62SQ@mail.gmail.com>
References: <1367425235-14998-1-git-send-email-artagnon@gmail.com>
	<1367425235-14998-4-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>, Duy Nguyen <pclouds@gmail.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 01 20:10:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UXbTa-0002CE-O4
	for gcvg-git-2@plane.gmane.org; Wed, 01 May 2013 20:09:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753794Ab3EASJz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 May 2013 14:09:55 -0400
Received: from mail-la0-f50.google.com ([209.85.215.50]:63716 "EHLO
	mail-la0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752073Ab3EASJy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 May 2013 14:09:54 -0400
Received: by mail-la0-f50.google.com with SMTP id fl20so1514204lab.23
        for <git@vger.kernel.org>; Wed, 01 May 2013 11:09:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=iQr1rd3InISAGP7jMm4Y9MgHYNrpVg+o7pwCJRDKRVA=;
        b=hj6C+cLbVJtumXQB+COkqe8YNC2DwnqbBsQ2IersO1EC3bbKk2pAFZPQJJVtXaRDnd
         EVD78Xf7AArKcx992lQ9uqjWuAhGEZa+HhzJrcUrK8PdVBYBBGy26junxfYdqHBFFj8Y
         ONggdJFlFjrdKkwRLsyX4tYKtPts5cba7mG56JXQMEqCgRt1z7t2kAZ+fiHO5ggoPeS8
         KLjq20Rr63W0PTI0EGZcJvU7LNgBemIyYtY8ialL3mA2cm7ScCMps9uVUeOobub4SQRA
         LN8D7xxt771ijX3cta/qA2z0nUWY7VR92Y9meH6evRNwlBG6DMshZXCc0Brwg8s2ws3D
         EWnA==
X-Received: by 10.152.29.132 with SMTP id k4mr1299447lah.46.1367431792304;
 Wed, 01 May 2013 11:09:52 -0700 (PDT)
Received: by 10.114.83.167 with HTTP; Wed, 1 May 2013 11:09:52 -0700 (PDT)
In-Reply-To: <1367425235-14998-4-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223108>

On Wed, May 1, 2013 at 11:20 AM, Ramkumar Ramachandra
<artagnon@gmail.com> wrote:
> Presently, the logic for @-parsing is horribly convoluted.  Prove that
> it is very straightforward by laying out the three cases (@{N},
> @{u[upstream], and @{-N}) and explaining how each case should be
> handled in comments.  All tests pass, and no functional changes have
> been introduced.

> @@ -463,9 +463,26 @@ static int get_sha1_basic(const char *str, int len, unsigned char *sha1)
>                  */
>                 for (at = len - 4; at >= 0; at--) {
>                         if (str[at] == '@' && str[at+1] == '{') {
> +                               /* Set reflog_len only if we
> +                                * don't see a @{u[pstream]}.  The
> +                                * @{N} and @{-N} forms have to do
> +                                * with reflog digging.
> +                                */
> +
> +                               /* Setting len to at means that we are
> +                                * only going to process the part
> +                                * before the @ until we reach "if
> +                                * (reflog)" at the end of the
> +                                * function.  That is only applicable
> +                                * in the @{N} case; in the @{-N} and
> +                                * @{u[pstream]} cases, we will run it
> +                                * through interpret_branch_name().
> +                                */
> +

Overkill.

/* set reflog_len when using the form: @{N} */

> @@ -476,22 +493,34 @@ static int get_sha1_basic(const char *str, int len, unsigned char *sha1)
>         if (len && ambiguous_path(str, len))
>                 return -1;
>
> -       if (!len && reflog_len) {
> -               struct strbuf buf = STRBUF_INIT;
> -               int ret;
> -               /* try the @{-N} syntax for n-th checkout */
> -               ret = interpret_branch_name(str+at, &buf);
> -               if (ret > 0) {
> -                       /* substitute this branch name and restart */
> -                       return get_sha1_1(buf.buf, buf.len, sha1, 0);
> -               } else if (ret == 0) {
> -                       return -1;
> +       if (reflog_len) {
> +               if (!len)
> +                       /* In the @{N} case where there's nothing
> +                        * before the @.
> +                        */

I think !len makes it clear.

> +                       refs_found = dwim_log("HEAD", 4, sha1, &real_ref);
> +               else {
> +                       /* The @{N} case where there is something
> +                        * before the @ for dwim_log to figure out,
> +                        * and the @{-N} case.
> +                        */

I think 'else' makes it clear.

> +                       refs_found = dwim_log(str, len, sha1, &real_ref);
> +
> +                       if (!refs_found && str[2] == '-') {

You are changing the behavior, there's no need for that in this
reorganization patch.

> +                               /* The @{-N} case that resolves to a
> +                                * detached HEAD (ie. not a ref)
> +                                */

This is not true, it resolves to a ref.

git rev-parse --symbolic-full-name @{-1}

Also, you removed a useful comment:

/* try the @{-N} syntax for n-th checkout */

> +                               struct strbuf buf = STRBUF_INIT;
> +                               if (interpret_branch_name(str, &buf) > 0) {
> +                                       get_sha1_hex(buf.buf, sha1);
> +                                       refs_found = 1;
> +                                       reflog_len = 0;
> +                               }
> +                               strbuf_release(&buf);

I'm pretty sure this is doing something totally different now. This is
certainly not "no functional changes".

> +                       }
>                 }
> -               /* allow "@{...}" to mean the current branch reflog */
> -               refs_found = dwim_ref("HEAD", 4, sha1, &real_ref);
> -       } else if (reflog_len)
> -               refs_found = dwim_log(str, len, sha1, &real_ref);
> -       else
> +       } else
> +               /* The @{u[pstream]} case */

It's not true, there might not be any @{u} in there.

Some of these changes might be good, but I would do them truly without
introducing functional changes, without removing useful comments, and
without adding paragraphs of explanation for what you are doing.

With the principle of self-documenting code, if you need paragraphs to
explain what you are doing, you already lost.

Cheers.

-- 
Felipe Contreras
