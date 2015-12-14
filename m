From: Eric Sunshine <ericsunshine@gmail.com>
Subject: Re: [PATCH 2/8] xread: poll on non blocking fds
Date: Mon, 14 Dec 2015 17:58:28 -0500
Message-ID: <CAPig+cQoranAhJKSZm6jP-hYutkoXkf6461sY1v5NseQVTNL_g@mail.gmail.com>
References: <1450121838-7069-1-git-send-email-sbeller@google.com>
	<1450121838-7069-3-git-send-email-sbeller@google.com>
Reply-To: Eric Sunshine <sunshine@sunshineco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Johannes Sixt <j6t@kdbg.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Mon Dec 14 23:58:40 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a8c4g-00075E-F0
	for gcvg-git-2@plane.gmane.org; Mon, 14 Dec 2015 23:58:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932826AbbLNW63 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Dec 2015 17:58:29 -0500
Received: from mail-vk0-f53.google.com ([209.85.213.53]:36402 "EHLO
	mail-vk0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932479AbbLNW62 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Dec 2015 17:58:28 -0500
Received: by vkay187 with SMTP id y187so164131234vka.3
        for <git@vger.kernel.org>; Mon, 14 Dec 2015 14:58:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:reply-to:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=8UNklLenh/Q6THPWmRgUyIrG/8BjTgKf2C5C8716AOI=;
        b=vsQmt6v2zeqFV4b5dWPm3obzDFQ//v3mhgf2TtwvdtQQihwXeG1LhgF0DnHE5xQfQr
         l9a2M5uZ3Gx8y+kX2Z7L4emnvpabmmpwDPrjzIw2K6aPcdab+jE8V+JpNxki94ZOclmT
         a6yOPgT8QehD4o3FPjqd0cW/LvKUyRyZu0Z4TDLh51mZm91WkQJG1aA8ogrfx31sBDE7
         7l22l8j5cPfFHx2JBFxDV5YmioQ53iCbbRV/eNOnSS/1qWHtAznlOEtuMww9f6r1IQg0
         RS/irtaKQ006bjp0z9zbShH5ZhtbhxejLiUzVUC8yIdh5g1ggKqbSFuKCIskp2Xz7gZ5
         N93w==
X-Received: by 10.31.13.205 with SMTP id 196mr27406939vkn.37.1450133908236;
 Mon, 14 Dec 2015 14:58:28 -0800 (PST)
Received: by 10.31.62.203 with HTTP; Mon, 14 Dec 2015 14:58:28 -0800 (PST)
In-Reply-To: <1450121838-7069-3-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282443>

On Mon, Dec 14, 2015 at 2:37 PM, Stefan Beller <sbeller@google.com> wrote:
> From the man page:
> EAGAIN The file descriptor fd refers to a file other than a socket
>        and has been marked nonblocking (O_NONBLOCK), and the read
>        would block.
>
> EAGAIN or EWOULDBLOCK
>        The file descriptor fd refers to a socket and has been marked
>        nonblocking (O_NONBLOCK), and the read would block.  POSIX.1-2001
>        allows either error to be returned for this case, and does not
>        require these constants to have the same value, so a portable
>        application should check for both possibilities.
>
> If we get an EAGAIN or EWOULDBLOCK the fd must have set O_NONBLOCK.
> As the intent of xread is to read as much as possible either until the
> fd is EOF or an actual error occurs, we can ease the feeder of the fd
> by not spinning the whole time, but rather wait for it politely by not
> busy waiting.
>
> We should not care if the call to poll failed, as we're in an infinite
> loop and can only get out with the correct read().
>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
> diff --git a/wrapper.c b/wrapper.c
> index 6fcaa4d..4f720fe 100644
> --- a/wrapper.c
> +++ b/wrapper.c
> @@ -236,8 +236,17 @@ ssize_t xread(int fd, void *buf, size_t len)
>             len = MAX_IO_SIZE;
>         while (1) {
>                 nr = read(fd, buf, len);
> -               if ((nr < 0) && (errno == EAGAIN || errno == EINTR))
> -                       continue;
> +               if (nr < 0) {
> +                       if (errno == EINTR)
> +                               continue;
> +                       if (errno == EAGAIN || errno == EWOULDBLOCK) {
> +                               struct pollfd pfd;
> +                               pfd.events = POLLIN;
> +                               pfd.fd = fd;
> +                               /* We deliberately ignore the return value */

This comment tells us what the code itself already says, but not why
the value is being ignored. The reader still has to consult the commit
message to learn that detail, which makes the value of the comment
questionable.

> +                               poll(&pfd, 1, -1);
> +                       }
> +               }
>                 return nr;
>         }
>  }
> --
> 2.6.4.443.ge094245.dirty
>
