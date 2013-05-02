From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH v2] sha1_name: reorganize get_sha1_basic()
Date: Fri, 3 May 2013 00:25:01 +0530
Message-ID: <CALkWK0k4YisL0Nc6906FRsx7556UVqy_DD9Wo=1j4OWMkwqK-A@mail.gmail.com>
References: <1367516919-4735-1-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Duy Nguyen <pclouds@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Thomas Rast <trast@student.ethz.ch>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 02 20:55:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UXyfW-0006cx-73
	for gcvg-git-2@plane.gmane.org; Thu, 02 May 2013 20:55:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932811Ab3EBSzn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 May 2013 14:55:43 -0400
Received: from mail-ie0-f170.google.com ([209.85.223.170]:62564 "EHLO
	mail-ie0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932805Ab3EBSzm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 May 2013 14:55:42 -0400
Received: by mail-ie0-f170.google.com with SMTP id aq17so1049490iec.1
        for <git@vger.kernel.org>; Thu, 02 May 2013 11:55:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=EshnoYqD7/scfbJ2bzrgNv9dgmkcOZEekiEIC3n5q+o=;
        b=KzPZszNwjjU66G5n1gVf5pCKaCVMFH4PhCLy/BatTo0KZk8HBVl74fbIMj5vyZ/mFB
         HZRd5IqwQHUmIv4UYmbTQL2vWnp7foK1/5kjTFQX411abXuSZIMwm+ScdRyUV76ZPjaq
         XBeoWDw8605FZR0TJ6K1P7JPmWW7VeTNUBN2dP2dJi5+TqFyM1+MDEkFH7atBTcZIkhB
         C6arfUpUSQ2AseBDRR0q4494N920ld+TVyQDyCfsLH47k1sVrHqyjlq6xB4um9SwC3Ze
         M90N5rPiQe/aQQ3zED1EXDzUxIWQVa3WK9HmoeOy5DFel3umWEtcpDm+ZM3BFAPUE054
         foeQ==
X-Received: by 10.50.73.65 with SMTP id j1mr4399384igv.49.1367520942185; Thu,
 02 May 2013 11:55:42 -0700 (PDT)
Received: by 10.64.46.1 with HTTP; Thu, 2 May 2013 11:55:01 -0700 (PDT)
In-Reply-To: <1367516919-4735-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223247>

Felipe Contreras wrote:
> [...]

Okay, you used nth_prior in this one.

> There is no need to call this function recursively with the branch of
> @{-N} substituted because dwim_{ref,log} already replaces it.

I figured that the recursion is because dwim_{ref,log} didn't exist
when this was written.

> However, there's one corner-case where @{-N} resolves to a detached
> HEAD, in which case we wouldn't get any ref back.
>
> So we parse the nth-prior manually, and deal with it depending on
> weather it's a SHA-1, or a ref.

Right.  _This_ is the special case, which the old logic didn't quite
convey.  The end-user version of this is: 'git checkout -' won't bring
you back to the branch if you said git checkout HEAD~1 earlier.

> diff --git a/sha1_name.c b/sha1_name.c
> index 3820f28..6428001 100644
> --- a/sha1_name.c
> +++ b/sha1_name.c
> @@ -431,13 +431,14 @@ static inline int upstream_mark(const char *string, int len)
>  }
>
>  static int get_sha1_1(const char *name, int len, unsigned char *sha1, unsigned lookup_flags);
> +static int interpret_nth_prior_checkout(const char *name, struct strbuf *buf);

It didn't strike me to use interpret_nth_prior_checkout() directly.  I
was still stuck at interpret_branch_name() returning a positive value.

>  static int get_sha1_basic(const char *str, int len, unsigned char *sha1)
>  {
>         static const char *warn_msg = "refname '%.*s' is ambiguous.";
>         char *real_ref = NULL;
>         int refs_found = 0;
> -       int at, reflog_len;
> +       int at, reflog_len, nth_prior = 0;
>
>         if (len == 40 && !get_sha1_hex(str, sha1))
>                 return 0;
> @@ -447,6 +448,10 @@ static int get_sha1_basic(const char *str, int len, unsigned char *sha1)
>         if (len && str[len-1] == '}') {
>                 for (at = len-2; at >= 0; at--) {
>                         if (str[at] == '@' && str[at+1] == '{') {
> +                               if (at == 0 && str[2] == '-') {
> +                                       nth_prior = 1;
> +                                       continue;
> +                               }

Looking at this closely once again.
You've already hit the beginning.  What are you continuing?  Take the
example of a compound expression with @{-

@{-1}@{0}
     ^ at is here
     "@{-" is not matched

@{-1}@{0}
^ at is here
"@{-" is matched
What's to continue? at is already at 0

On another note, I think you've fixed a bug: @{-1}{0} was parsing to
the same value as @{-1}@{0} before your patch.

> @@ -460,20 +465,22 @@ static int get_sha1_basic(const char *str, int len, unsigned char *sha1)
>         if (len && ambiguous_path(str, len))
>                 return -1;
>
> -       if (!len && reflog_len) {
> +       if (nth_prior) {

nth_prior makes this much cleaner overall.

>                 struct strbuf buf = STRBUF_INIT;
> -               int ret;
> -               /* try the @{-N} syntax for n-th checkout */
> -               ret = interpret_branch_name(str+at, &buf);
> -               if (ret > 0) {
> -                       /* substitute this branch name and restart */
> -                       return get_sha1_1(buf.buf, buf.len, sha1, 0);
> -               } else if (ret == 0) {
> -                       return -1;
> +               int detached;
> +
> +               if (interpret_nth_prior_checkout(str, &buf) > 0) {
> +                       detached = (buf.len == 40 && !get_sha1_hex(buf.buf, sha1));
> +                       strbuf_release(&buf);
> +                       if (detached)
> +                               return 0;

Neat.  I'd set reflog_len to zero and made sure that the last part of
the function wouldn't be executed.  How did you get away without
setting refs_found to 1 though?

>                 }
> +       }
> +
> +       if (!len && reflog_len)
>                 /* allow "@{...}" to mean the current branch reflog */
>                 refs_found = dwim_ref("HEAD", 4, sha1, &real_ref);

I got this part wrong too: I said dwim_log() instead of dwim_ref().

> -       } else if (reflog_len)
> +       else if (reflog_len)
>                 refs_found = dwim_log(str, len, sha1, &real_ref);
>         else
>                 refs_found = dwim_ref(str, len, sha1, &real_ref);
> --
> 1.8.3.rc0.401.g45bba44
>
