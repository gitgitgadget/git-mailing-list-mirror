From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 01/14] strbuf: introduce strbuf_prefixf()
Date: Wed, 3 Dec 2014 15:10:13 -0500
Message-ID: <CAPig+cS6Z=UW80sn6ru15W29Vko-f2g4CUq0EQtWGU7ZjoJcog@mail.gmail.com>
References: <1416262453-30349-1-git-send-email-sbeller@google.com>
	<20141117233525.GC4336@google.com>
	<CAGZ79kYU1f1COjtv+4MzgbPLi42m1JQsXsuuCr3WXsuR8XrO7w@mail.gmail.com>
	<20141118004841.GE4336@google.com>
	<CAGZ79kbF6JjxgHX2KZFhSh9QyGOXeS=cVK0z=CM4n9-ErRDJ8A@mail.gmail.com>
	<20141203050217.GJ6527@google.com>
	<20141203051016.GK6527@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Stefan Beller <sbeller@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git List <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Jeff King <peff@peff.net>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 03 21:10:24 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XwGFi-0006NE-RF
	for gcvg-git-2@plane.gmane.org; Wed, 03 Dec 2014 21:10:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751715AbaLCUKR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Dec 2014 15:10:17 -0500
Received: from mail-yh0-f43.google.com ([209.85.213.43]:38489 "EHLO
	mail-yh0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750833AbaLCUKO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Dec 2014 15:10:14 -0500
Received: by mail-yh0-f43.google.com with SMTP id z6so7494521yhz.2
        for <git@vger.kernel.org>; Wed, 03 Dec 2014 12:10:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=W/YeJGa08rpbBaVL2DHh/y7A4dHdfULWrU2HEt70aLY=;
        b=HwS4XpJxwJMog5KlbhiSoxjvsZyZ/UpbiyaUQz+KUa/BnGu1/Scgdw3B0SP3zd+D79
         UvomOoNPChRws1X8FMFd9aRTLMTjhqyDcmPJw9RnY1w5JpM5rTpcdXzadsU6A4IkU7bQ
         ZhITgAAYyCn/PgXNyEAMSdbkpWDfE+a6NvASC6h3w9Nl/dHavm1eaCNqwaVSi20o1jZo
         QGe8IdSTdpTkKFvux9z99yU0wb0d9ik6Th2/NebZFTC9qap8ZFjQ+fn4WT/lKqy6W9Jd
         qVNsCU1CqoZUv+Nx1klMpGwy+QY2ufrvtRfM4B1IdOc112aOXCKv8OrV2wPfGcjOCKJ7
         zHdA==
X-Received: by 10.236.8.100 with SMTP id 64mr8608372yhq.112.1417637413748;
 Wed, 03 Dec 2014 12:10:13 -0800 (PST)
Received: by 10.170.68.68 with HTTP; Wed, 3 Dec 2014 12:10:13 -0800 (PST)
In-Reply-To: <20141203051016.GK6527@google.com>
X-Google-Sender-Auth: gsaDrzEEP5vMFvsC0YB_YCItn8k
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260684>

On Wed, Dec 3, 2014 at 12:10 AM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> When preparing an error message in a strbuf, it can be convenient
> to add a formatted string to the beginning:
>
>         if (transaction_commit(&t, err)) {
>                 strbuf_prefixf(err, "cannot fetch '%s': ", remotename);
>                 return -1;
>         }
>
> The new strbuf_prefixf is like strbuf_addf, except it writes its
> result to the beginning of a strbuf instead of the end.
>
> The current implementation uses strlen(strfmt(fmt, ...)) extra bytes
> at the end of the strbuf as temporary scratch space for convenience
> and simplicity.  A later patch can optimize if needed.
>
> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
> ---
> diff --git a/strbuf.c b/strbuf.c
> index 0346e74..3f4aaa3 100644
> --- a/strbuf.c
> +++ b/strbuf.c
> @@ -219,6 +219,22 @@ void strbuf_addf(struct strbuf *sb, const char *fmt, ...)
>         va_end(ap);
>  }
>
> +void strbuf_prefixf(struct strbuf *sb, const char *fmt, ...)
> +{
> +       va_list ap;
> +       size_t pos, len;
> +
> +       pos = sb->len;
> +
> +       va_start(ap, fmt);
> +       strbuf_vaddf(sb, fmt, ap);
> +       va_end(ap);
> +
> +       len = sb->len - pos;
> +       strbuf_insert(sb, 0, sb->buf + pos, len);
> +       strbuf_remove(sb, pos + len, len);

Would a strbuf_setlen(sb, pos), rather than strbuf_remove(), make it
clearer to the reader that this is merely performing a truncation?

> +}
> +
>  static void add_lines(struct strbuf *out,
>                         const char *prefix1,
>                         const char *prefix2,
