From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 1/5] xfdopen(): if first attempt fails, free memory and
 try again
Date: Thu, 5 Mar 2015 08:59:03 -0800
Message-ID: <CAGZ79kZx5HgQyzkGQ6ggdVwGZKkkLNn5YLQHFbTR-i4QafyurA@mail.gmail.com>
References: <1425571669-22800-1-git-send-email-mhagger@alum.mit.edu>
	<1425571669-22800-2-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Thu Mar 05 17:59:12 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YTZ7A-0004o2-33
	for gcvg-git-2@plane.gmane.org; Thu, 05 Mar 2015 17:59:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757979AbbCEQ7H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Mar 2015 11:59:07 -0500
Received: from mail-ie0-f181.google.com ([209.85.223.181]:43466 "EHLO
	mail-ie0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757924AbbCEQ7E (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Mar 2015 11:59:04 -0500
Received: by iecrp18 with SMTP id rp18so10283751iec.10
        for <git@vger.kernel.org>; Thu, 05 Mar 2015 08:59:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=OSnodq5QDag7Z/A700jkeZHKS4ANJz2Cy1vEK79GwqY=;
        b=YnNfuy6D73tv4a9GHb/1WUReLxGiZTOWyOaWVY5O7W/XZjIewrLk3LMgHKbO8Hgcoq
         yibxFUWAniQ8G2T3TTA1UGPrJGuB+tY+RVgv+ikbyBSiGbLcRCdsm62SWiOKzxFyudcX
         o0d1Es/xeuX8JRdmsVhmEr38sPWDDt21BrJERAbzfgzHpN5np+AaRJMwG4TlJnMuxMJn
         llNgo8HYV+pJKkvkRSnk/kA+TDyKgj/hkI41Eg+6zt2zG66Epu6f+lJfWYbs2g1qEADC
         p+1YOWDQmzmoY6BXsrWU84PPTizxCAlQyeS8s/Nmx62WBPJato3XDab4ePDc6mhIrqyq
         cP3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=OSnodq5QDag7Z/A700jkeZHKS4ANJz2Cy1vEK79GwqY=;
        b=mOBk3L9AMp/u1tcY3A7O5ajTug/hpqWXM4lxurQ8sMr2c5A/LC7dVC16EzPFYzPNEi
         irYcb4VErCHUuTbIQd9iVajeZA1bICXM1zu0eZyM9A96Yy3GHBudGd+0n8nFWcMfK2yz
         kD9G6CQR5Rpif15B8AVCN8rLershisx5ixlvT1MEfqDtON4xpP/81cZq3ogqzOTPqRXE
         cwrov4ZbbPkePMqEIR5KRSRorpQjVTaNH5cqpqSO8Hpm4+1ujsdvoLZEj8L4QRMNLx+z
         CwKSs+U+ICJGpWGK/PFGuCu+EhAsiEDHgjKY9JAlMh6558GIcsneuFU3B8cX11UvJoly
         Dx7w==
X-Gm-Message-State: ALoCoQn6qWMu1VuiPgyo4WapyKVvBsSlnmXrIZ0XGQ5W6OZnynmqHgJt1+Iv19jO0FURwLHa3O4k
X-Received: by 10.107.15.155 with SMTP id 27mr3012834iop.49.1425574743740;
 Thu, 05 Mar 2015 08:59:03 -0800 (PST)
Received: by 10.107.46.31 with HTTP; Thu, 5 Mar 2015 08:59:03 -0800 (PST)
In-Reply-To: <1425571669-22800-2-git-send-email-mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264851>

On Thu, Mar 5, 2015 at 8:07 AM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
> One likely reason for the failure of fdopen() is a lack of free
> memory.
>
> Also expose a new function, fdopen_with_retry(), which retries on
> ENOMEM but doesn't die() on errors. In a moment this function will be
> used elsewhere.
>
> Suggested-by: Jonathan Nieder <jrnieder@gmail.com>
> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
> ---
>  git-compat-util.h | 11 +++++++++++
>  wrapper.c         | 28 +++++++++++++++++++++++++---
>  2 files changed, 36 insertions(+), 3 deletions(-)
>
> diff --git a/git-compat-util.h b/git-compat-util.h
> index 3455c5e..a5652a7 100644
> --- a/git-compat-util.h
> +++ b/git-compat-util.h
> @@ -672,7 +672,18 @@ extern ssize_t xread(int fd, void *buf, size_t len);
>  extern ssize_t xwrite(int fd, const void *buf, size_t len);
>  extern ssize_t xpread(int fd, void *buf, size_t len, off_t offset);
>  extern int xdup(int fd);
> +
> +/*
> + * Like fdopen(), but if the first attempt fails with ENOMEM, try to
> + * free up some memory and try again.
> + */
> +extern FILE *fdopen_with_retry(int fd, const char *mode);
> +
> +/*
> + * Like fdopen_with_retry(), but die on errors.

"Rather like fdopen, but die on errors"?
When reading this before looking at the implementation below,
I thought this would behave like
FILE *xfdopen() {
       FILE *stream = fdopen(fd, mode);
       if (stream == NULL)
              die_errno("Out of memory? fdopen failed");
      return stream;
}
which has no retrying. I kind of read that comment that way.
Maybe
    This opens a FILE* handle, but tries
    to deal with some errors. If unsuccessful it dies,
    which guarantees to have a valid FILE* if returning.
?

I dunno.

> + */
>  extern FILE *xfdopen(int fd, const char *mode);
> +
>  extern int xmkstemp(char *template);
>  extern int xmkstemp_mode(char *template, int mode);
>  extern int odb_mkstemp(char *template, size_t limit, const char *pattern);
> diff --git a/wrapper.c b/wrapper.c
> index d5a6cef..b60cc03 100644
> --- a/wrapper.c
> +++ b/wrapper.c
> @@ -311,14 +311,36 @@ int xdup(int fd)
>         return ret;
>  }
>
> -FILE *xfdopen(int fd, const char *mode)
> +FILE *fdopen_with_retry(int fd, const char *mode)
>  {
>         FILE *stream = fdopen(fd, mode);
> -       if (stream == NULL)
> -               die_errno("Out of memory? fdopen failed");
> +
> +       if (!stream && errno == ENOMEM) {
> +               /*
> +                * Try to free up some memory, then try again. We
> +                * would prefer to use sizeof(FILE) here, but that is
> +                * not guaranteed to be defined (e.g., FILE might be
> +                * an incomplete type).
> +                */
> +               try_to_free_routine(1000);
> +               stream = fdopen(fd, mode);
> +       }
> +
>         return stream;
>  }
>
> +FILE *xfdopen(int fd, const char *mode)
> +{
> +       FILE *stream = fdopen_with_retry(fd, mode);
> +
> +       if (stream)
> +               return stream;
> +       else if (errno == ENOMEM)
> +               die_errno("Out of memory? fdopen failed");
> +       else
> +               die_errno("fdopen failed");

My gut feeling dislikes the distinction of different errors here just
to pass in a different string to die. The die_errno will already print
an appropriate message depending on the errno set. So I'd
rather have no distinction here.

If you want to have a different message for the case of ENOMEM,
I'd rather put it into fdopen_with_retry, which then uses a loop or
counted goto [ I've seen that in the refs code:
    if (nr_retries < MAX_RETRIES)
        goto retry_again;
]


> +}
> +
>  int xmkstemp(char *template)
>  {
>         int fd;
> --
> 2.1.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
