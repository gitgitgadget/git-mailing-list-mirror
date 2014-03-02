From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2] implemented strbuf_write_or_die()
Date: Sat, 1 Mar 2014 21:47:27 -0500
Message-ID: <CAPig+cR0gTeB1oUUPQ=W_wWGPMDaY4gkG7+531HT-ktnwn5L-Q@mail.gmail.com>
References: <53126051.7030904@alum.mit.edu>
	<1393719527-24221-1-git-send-email-faiz.off93@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Johannes Sixt <j6t@kdbg.org>, He Sun <sunheehnus@gmail.com>
To: Faiz Kothari <faiz.off93@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 02 03:47:33 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WJwRA-00073l-9Q
	for gcvg-git-2@plane.gmane.org; Sun, 02 Mar 2014 03:47:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753445AbaCBCr3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Mar 2014 21:47:29 -0500
Received: from mail-yh0-f42.google.com ([209.85.213.42]:57819 "EHLO
	mail-yh0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753419AbaCBCr2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Mar 2014 21:47:28 -0500
Received: by mail-yh0-f42.google.com with SMTP id a41so2377398yho.15
        for <git@vger.kernel.org>; Sat, 01 Mar 2014 18:47:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=THmQkVx1GEeS8nazn4vpwt+Tr7c0RpFU12CilppeuW4=;
        b=lMzitJ4s+ciraWWrdwZ/VeAfqo5m9abixQqr6K/P8Bd+ZN66Q7r4ITNFOznmFSASi0
         MFOI5IWmG3psSpDEZwo5plRByiYK3csVE4uUHlhHqsD1vuc9oHmsTTohIRmSyST8FjS1
         Z2HKV4e8UOW1uWgZbn2MrEuJ0opz3n3Pqpm44iX4liuD0YxEaaXz/CZQY4QwVdLBVJqg
         e/BrlV2RxmZOkUhnRBjIyo34kcb+p/FaRJZ7kZpIXG9fiFmcove8c3MqpnE0xBQlBwcu
         PvRchIMdUiMkaFqXi0K3tk57qFpE3qVXKK3yK9mzuWrMyvgDIQmKY6bFInZN852omizU
         PLPA==
X-Received: by 10.236.137.14 with SMTP id x14mr12736315yhi.4.1393728447397;
 Sat, 01 Mar 2014 18:47:27 -0800 (PST)
Received: by 10.170.180.195 with HTTP; Sat, 1 Mar 2014 18:47:27 -0800 (PST)
In-Reply-To: <1393719527-24221-1-git-send-email-faiz.off93@gmail.com>
X-Google-Sender-Auth: YWTMNWTrMyKkB1T3-X2KOr4XI4k
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243120>

On Sat, Mar 1, 2014 at 7:18 PM, Faiz Kothari <faiz.off93@gmail.com> wrote:
> Subject: implemented strbuf_write_or_die()

Imperative tone is preferred. The commit message tells what it is
doing, not what it did.

  Subject: introduce strbuf_write_or_die()

> Signed-off-by: Faiz Kothari <faiz.off93@gmail.com>
> ---
> Implementing this clearly distinguishes between writing a normal buffer
> and writing a strbuf. Also, it provides an interface to write strbuf
> directly without knowing the private members of strbuf, making strbuf
> completely opaque. Also, makes the code more readable.

These three sentences which justify the change should go above the
"---" line so they are recorded in the project history for future
readers to understand why the change was made. As for their actual
value, the first and third sentences are nebulous; the second sentence
may be suitable (although strbuf's buf and len are actually considered
public, so the justification not be supportable).

A couple other comments:

Justification is important because many topics are in-flight at any
given time. Changes like this one which touch an arbitrary number of
files may conflict with other in-flight topics, which places extra
burden on the project maintainer (Junio). The justification needs to
be strong enough to outweigh that added burden.

Introduction of a new function is conceptually distinct from the act
of updating existing callers to invoke it, thus this submission should
probably be decomposed into two or more patches where the first patch
introduces the function, and following patches convert existing
callers.

More below.

> diff --git a/cache.h b/cache.h
> index db223e8..8898bf4 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -1227,6 +1227,7 @@ extern int copy_fd(int ifd, int ofd);
>  extern int copy_file(const char *dst, const char *src, int mode);
>  extern int copy_file_with_time(const char *dst, const char *src, int mode);
>  extern void write_or_die(int fd, const void *buf, size_t count);
> +extern void strbuf_write_or_die(const struct strbuf *sbuf, int fd);

You still have the layering violation here mentioned by both Johannes
and Michael. This declaration belongs in strbuf.h, not cache.h

Also, for bonus points, you should document this new function in
Documentation/technical/api-strbuf.txt.

>  extern int write_or_whine(int fd, const void *buf, size_t count, const char *msg);
>  extern int write_or_whine_pipe(int fd, const void *buf, size_t count, const char *msg);
>  extern void fsync_or_die(int fd, const char *);
> diff --git a/write_or_die.c b/write_or_die.c
> index b50f99a..373450e 100644
> --- a/write_or_die.c
> +++ b/write_or_die.c
> @@ -64,6 +64,16 @@ void write_or_die(int fd, const void *buf, size_t count)
>         }
>  }
>
> +void strbuf_write_or_die(const struct strbuf *sbuf, int fd)

Ditto regarding the layering violation. This implementation belongs in strbuf.c.

> +{
> +       if(!sbuf)
> +               fprintf(stderr, "write error\n");

This is a programmer error, rather than a run-time I/O error. As such,
an assertion would be appropriate:

    assert(sbuf);

> +       else if (write_in_full(fd, sbuf->buf, sbuf->len) < 0) {
> +               check_pipe(errno);
> +               die_errno("write error");

He Sun correctly pointed out in his review that you should simply
invoke the lower-level write_or_die() here rather than copying/pasting
its functionality. (You fixed it in an earlier version of the patch
but somehow reverted that fix when sending this version.)

> +       }
> +}
