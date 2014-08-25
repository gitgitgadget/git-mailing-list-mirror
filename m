From: Ronnie Sahlberg <sahlberg@google.com>
Subject: Re: [PATCH 4/5] fast-import: fix buffer overflow in dump_tags
Date: Mon, 25 Aug 2014 10:11:06 -0700
Message-ID: <CAL=YDW=-9Kkv4+Vp9+=TWNia0wcgq5ubNDgELvcxUvvuqFiJRw@mail.gmail.com>
References: <20140823052334.GA17813@peff.net>
	<20140823053237.GD18075@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Aug 25 19:11:15 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XLxnX-00077k-1C
	for gcvg-git-2@plane.gmane.org; Mon, 25 Aug 2014 19:11:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932883AbaHYRLK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Aug 2014 13:11:10 -0400
Received: from mail-vc0-f177.google.com ([209.85.220.177]:43556 "EHLO
	mail-vc0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932185AbaHYRLJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Aug 2014 13:11:09 -0400
Received: by mail-vc0-f177.google.com with SMTP id hy4so15447369vcb.36
        for <git@vger.kernel.org>; Mon, 25 Aug 2014 10:11:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=FD6PSv/YVob7zlrQnG4a9rWXVkvyuBlgTc13boNZbwY=;
        b=BEsCM+70ikPkh4FlAb9cHThK1hOvAU8BjhIfV96T6uqMgqgU+22+pfJuKnHcx+EtjN
         pVt23R1jMaVE1Dng0ERMPGiwHYMdNCh2EABSdPKzPnC4uAEax3Gfib5+08XoGWEubIS9
         znUCwdYua2tPLubrrGTbQYXgPmH8OeCI0D3gOUiw47QfGb5E0mvThBH5z10SVyn3XpG/
         v4R4naO/I3U9HHWUixrHcxDVSZfCcEHSf/9g4OXFfLT1hPSV3Vb9owqXQ+A5tJ2wkwsa
         R2kIZKBAXZv8z/45sKITs/iTP7jdU+pdsI62lQvHWjEc4p2n8OYoFyLExMaX6wMuUoky
         Ielw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=FD6PSv/YVob7zlrQnG4a9rWXVkvyuBlgTc13boNZbwY=;
        b=VivH7pmEXn+5ykJjHNM9IspkwSYj9YNYmnOElGRGa09YLhqbChoZzy+Lt0owBvLI7b
         ZzUXWNWd4OEmUd1QGvC8jilU7dbRduQTFCs0jBsTpg8c0r8z2tW39mRqLwhsAAOjUAEM
         DhQdXXL35Bd+DTQbzueH7NWVVc4a2/qugUbNsEVOmw+R9SyyRXi3JASDeR5JaSSTJ0Zp
         mNcvCEyapTPLzfOxNHJsNJhEsQxlH1quB6BC2J8W7puNMyt7faO7BUrSGH5mMKp5D+Tm
         pPCaFJztXWPmTxN52vZWFaL5Z4vHA7n5N2qpYR8LLK+WQa6PngnwyBZLujtJVsMQ5ucw
         dBjA==
X-Gm-Message-State: ALoCoQnaLWdxjFY4Gxn/ZTJuYHMmPDeYUhAi0qKJh4r8kJCRgrl9mUeEfY6qgwy3nhh7o3ROgrrd
X-Received: by 10.52.32.66 with SMTP id g2mr5819211vdi.49.1408986666302; Mon,
 25 Aug 2014 10:11:06 -0700 (PDT)
Received: by 10.52.69.136 with HTTP; Mon, 25 Aug 2014 10:11:06 -0700 (PDT)
In-Reply-To: <20140823053237.GD18075@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255835>

Jeff,
We have a fix like this in the next set of transaction updates.
https://code-review.googlesource.com/#/c/1012/13/fast-import.c

However, if your concerns are the integrity of the servers and not
taking any chances
you might not want to wait for my patches to graduate.


ronnie sahlberg

On Fri, Aug 22, 2014 at 10:32 PM, Jeff King <peff@peff.net> wrote:
> When creating a new annotated tag, we sprintf the refname
> into a static-sized buffer. If we have an absurdly long
> tagname, like:
>
>   git init repo &&
>   cd repo &&
>   git commit --allow-empty -m foo &&
>   git tag -m message mytag &&
>   git fast-export mytag |
>   perl -lpe '/^tag/ and s/mytag/"a" x 8192/e' |
>   git fast-import <input
>
> we'll overflow the buffer. We can fix it by using a strbuf.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> I'm not sure how easily exploitable this is. The buffer is on the stack,
> and we definitely demolish the return address. But we never actually
> return from the function, since lock_ref_sha1 will fail in such a case
> and die (it cannot succeed because the name is longer than PATH_MAX,
> which we check when concatenating it with $GIT_DIR).
>
> Still, there is no limit to the size of buffer you can feed it, so it's
> entirely possible you can overwrite something else and cause some
> mischief. So I wouldn't call it trivially exploitable, but I would not
> bet my servers that it is not (and of course it is easy to trigger if
> you can convince somebody to run fast-import a stream, so any remote
> helpers produce a potentially vulnerable situation).
>
>  fast-import.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
>
> diff --git a/fast-import.c b/fast-import.c
> index f25a4ae..a1479e9 100644
> --- a/fast-import.c
> +++ b/fast-import.c
> @@ -1734,14 +1734,16 @@ static void dump_tags(void)
>         static const char *msg = "fast-import";
>         struct tag *t;
>         struct ref_lock *lock;
> -       char ref_name[PATH_MAX];
> +       struct strbuf ref_name = STRBUF_INIT;
>
>         for (t = first_tag; t; t = t->next_tag) {
> -               sprintf(ref_name, "tags/%s", t->name);
> -               lock = lock_ref_sha1(ref_name, NULL);
> +               strbuf_reset(&ref_name);
> +               strbuf_addf(&ref_name, "tags/%s", t->name);
> +               lock = lock_ref_sha1(ref_name.buf, NULL);
>                 if (!lock || write_ref_sha1(lock, t->sha1, msg) < 0)
> -                       failure |= error("Unable to update %s", ref_name);
> +                       failure |= error("Unable to update %s", ref_name.buf);
>         }
> +       strbuf_release(&ref_name);
>  }
>
>  static void dump_marks_helper(FILE *f,
> --
> 2.1.0.346.ga0367b9
>
