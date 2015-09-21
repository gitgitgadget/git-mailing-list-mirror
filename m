From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 66/67] use strbuf_complete to conditionally append slash
Date: Sun, 20 Sep 2015 21:50:28 -0400
Message-ID: <CAPig+cS=SQxPVGg9XGmo-SqZ71dkZ9uWrtM4AQ8kMN1e2KUKcQ@mail.gmail.com>
References: <20150915152125.GA27504@sigill.intra.peff.net>
	<20150915161619.GN29753@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Sep 21 03:50:58 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZdqFs-0006lW-AD
	for gcvg-git-2@plane.gmane.org; Mon, 21 Sep 2015 03:50:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755696AbbIUBua (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Sep 2015 21:50:30 -0400
Received: from mail-vk0-f49.google.com ([209.85.213.49]:34296 "EHLO
	mail-vk0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755597AbbIUBu3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Sep 2015 21:50:29 -0400
Received: by vkhf67 with SMTP id f67so56762028vkh.1
        for <git@vger.kernel.org>; Sun, 20 Sep 2015 18:50:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=tyx9+SYxtc4dD6Rrt+hEMUrwJH2gfO6On2zx7wEy/78=;
        b=njJdx69YXDlK43Yud6AeR/zzXIbGnbyLTZA1vFOSlb4lYscBjgb1AQm21yr4vjmIPx
         VLHE6CO0+yNZqiE/S4ne2xb6fgnmCYRyOszI0b7Cz0rCSMsDDyuppXpiM3v1I+Cvjowb
         GcTNRxYvc4dBhydk5J4c/3VrLtDqu/sjLJKPvvawXjkLbQ278oUsStZ3Nf5R+zKgPR9l
         oqpepmZaC6oy9xknCa1C/Vdy42S3/pW5A73TvCGFBMaBhHyrNv3dLJCdBo8+ECEWUP9T
         cwd3Ebv+cQr6tH3cSs3h/cDMiBNYfBUqYHduwB9hWeQrPapFVf2bwU6Q/7aaO2ynD+Wk
         W1bg==
X-Received: by 10.31.11.202 with SMTP id 193mr11679202vkl.84.1442800228872;
 Sun, 20 Sep 2015 18:50:28 -0700 (PDT)
Received: by 10.31.224.68 with HTTP; Sun, 20 Sep 2015 18:50:28 -0700 (PDT)
In-Reply-To: <20150915161619.GN29753@sigill.intra.peff.net>
X-Google-Sender-Auth: e8-b99RVDY0_ikrIVVeyXM9MzAQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278275>

On Tue, Sep 15, 2015 at 12:16 PM, Jeff King <peff@peff.net> wrote:
> When working with paths in strbufs, we frequently want to
> ensure that a directory contains a trailing slash before
> appending to it. We can shorten this code (and make the
> intent more obvious) by calling strbuf_complete.
>
> Most of these cases are trivially identical conversions, but
> there are two things to note:
>
>   - in a few cases we did not check that the strbuf is
>     non-empty (which would lead to an out-of-bounds memory
>     access). These were generally not triggerable in
>     practice, either from earlier assertions, or typically
>     because we would have just fed the strbuf to opendir(),
>     which would choke on an empty path.
>
>   - in a few cases we indexed the buffer with "original_len"
>     or similar, rather than the current sb->len, and it is
>     not immediately obvious from the diff that they are the
>     same. In all of these cases, I manually verified that
>     the strbuf does not change between the assignment and
>     the strbuf_complete call.
>
> This does not convert cases which look like:
>
>   if (sb->len && !is_dir_sep(sb->buf[sb->len - 1]))
>           strbuf_addch(sb, '/');
>
> as those are obviously semantically different. Some of these
> cases arguably should be doing that, but that is out of
> scope for this change, which aims purely for cleanup with no
> behavior change (and at least it will make such sites easier
> to find and examine in the future, as we can grep for
> strbuf_complete).
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> diff --git a/builtin/clean.c b/builtin/clean.c
> index df53def..d7acb94 100644
> --- a/builtin/clean.c
> +++ b/builtin/clean.c
> @@ -159,8 +159,7 @@ static int is_git_repository(struct strbuf *path)
>         int gitfile_error;
>         size_t orig_path_len = path->len;
>         assert(orig_path_len != 0);
> -       if (path->buf[orig_path_len - 1] != '/')
> -               strbuf_addch(path, '/');
> +       strbuf_complete(path, '/');

Does the above assert() still have value following this change? I
recall, when reviewing this code, specifically asking[1,2] for an
assert() or some other check to show that accessing buf[orig_path_len
- 1] was safe. Since this patch removes the code in question, the
assert() may no longer have meaning.

[1]: http://thread.gmane.org/gmane.comp.version-control.git/266839/focus=266892
[2]: http://thread.gmane.org/gmane.comp.version-control.git/266839/focus=266974

>         strbuf_addstr(path, ".git");
>         if (read_gitfile_gently(path->buf, &gitfile_error) || is_git_directory(path->buf))
>                 ret = 1;
