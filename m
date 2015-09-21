From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCHv3 02/13] xread: poll on non blocking fds
Date: Mon, 21 Sep 2015 19:56:56 -0400
Message-ID: <CAPig+cQKOEYYR3j-uEeFzF3-qAfqq4SdQrH8LPmSP0VmAOCtzw@mail.gmail.com>
References: <1442875159-13027-1-git-send-email-sbeller@google.com>
	<1442875159-13027-3-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Jacob Keller <jacob.keller@gmail.com>,
	Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Vitali Lovich <vlovich@gmail.com>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Tue Sep 22 01:57:04 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZeAxB-0002pl-E4
	for gcvg-git-2@plane.gmane.org; Tue, 22 Sep 2015 01:57:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933130AbbIUX45 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Sep 2015 19:56:57 -0400
Received: from mail-vk0-f50.google.com ([209.85.213.50]:34284 "EHLO
	mail-vk0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932961AbbIUX45 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Sep 2015 19:56:57 -0400
Received: by vkhf67 with SMTP id f67so75814032vkh.1
        for <git@vger.kernel.org>; Mon, 21 Sep 2015 16:56:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=f1f/MrD0iEEVP6R1LZRkglkYLdDIOLpp+U3nG+Bh27o=;
        b=l5+07VLe7IsYyTwvS3SmZLAju75u3QCAyCkUKVU+wHcSghmhwn8v6NkzXvYNM6mE+R
         F88g4TT9oP4qvEfYT6qW+ekPCytEb8ImjIq2ksXZ7w0qHu+zPvLnOi4LcLD5cUWsIscO
         VTlhR1t7FiCSUdWXr70q4Zup9zoaxGGysyIqojONpVlZSMRxjMjTgJNRY7liSuJ4mYfJ
         49Pyl3MhdloUS2TsFrKKBVajF+beaaA3tx1L3gfWSUeXRLVXRIp/VTDdkmVNb6nX41aN
         z5fEApc0k/R0Ben93FypIvPtUua5wLmunCW3mBmZ09GCAHxpUgL83adr7egRwVijtllg
         S4AA==
X-Received: by 10.31.178.3 with SMTP id b3mr7378087vkf.19.1442879816376; Mon,
 21 Sep 2015 16:56:56 -0700 (PDT)
Received: by 10.31.224.68 with HTTP; Mon, 21 Sep 2015 16:56:56 -0700 (PDT)
In-Reply-To: <1442875159-13027-3-git-send-email-sbeller@google.com>
X-Google-Sender-Auth: yk1RBd29JB7w8n8M4kmSsvhBKMA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278363>

On Mon, Sep 21, 2015 at 6:39 PM, Stefan Beller <sbeller@google.com> wrote:
> From the man page:
> [...]
> So if we get an EAGAIN or EWOULDBLOCK error the fd must be nonblocking.

s/So/&,/
s/error/&,/

> As the intend of xread is to read as much as possible either until the

s/intend/intent/

> fd is EOF or an actual error occurs, we can ease the feeder of the fd
> by not spinning the whole time, but rather wait for it politely by not
> busy waiting.
>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
> --- a/wrapper.c
> +++ b/wrapper.c
> @@ -201,8 +201,23 @@ ssize_t xread(int fd, void *buf, size_t len)
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
> +                               int i;
> +                               pfd.events = POLLIN;
> +                               pfd.fd = fd;
> +                               i = poll(&pfd, 1, 100);

Why is this poll() using a timeout? Isn't that still a busy wait of
sorts (even if less aggressive)?

> +                               if (i < 0) {
> +                                       if (errno == EINTR || errno == ENOMEM)
> +                                               continue;
> +                                       else
> +                                               die_errno("poll");
> +                               }
> +                       }
> +               }
>                 return nr;
>         }
>  }
> --
> 2.5.0.275.ge015d2a
