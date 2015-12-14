From: Eric Sunshine <ericsunshine@gmail.com>
Subject: Re: [PATCH 3/8] xread_nonblock: add functionality to read from fds
 without blocking
Date: Mon, 14 Dec 2015 18:03:15 -0500
Message-ID: <CAPig+cSiE8rJD8ohgW99SBJMFE8cJ6UrHKeAucj4fTEmUW7Ntg@mail.gmail.com>
References: <1450121838-7069-1-git-send-email-sbeller@google.com>
	<1450121838-7069-4-git-send-email-sbeller@google.com>
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
X-From: git-owner@vger.kernel.org Tue Dec 15 00:03:29 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a8c9I-0008SF-Iu
	for gcvg-git-2@plane.gmane.org; Tue, 15 Dec 2015 00:03:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753628AbbLNXDQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Dec 2015 18:03:16 -0500
Received: from mail-vk0-f43.google.com ([209.85.213.43]:35711 "EHLO
	mail-vk0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753453AbbLNXDQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Dec 2015 18:03:16 -0500
Received: by vkha189 with SMTP id a189so164274086vkh.2
        for <git@vger.kernel.org>; Mon, 14 Dec 2015 15:03:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:reply-to:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=GrM6a0UzsKn2MvOoGJ2b0tpfBDuX6X/SYNzfkRRQOYc=;
        b=eGj0DLd9JxaanR0TIQVCOfF5271r2JZplw5p1ChXMSbowb9pPRu6fnaQo6FcRVnn0P
         jdeK31peuwgkYIirjd1z/au1xy+anbcc8cR2Opfn55xFPWwpp6EfK7nDI1eeTwbDfBF4
         j5PFwPeeV7nikfWMPw88cx2eIXfimeZUzq9lkZiLuccEm6zPXtzEkt3rlxBIFGD/gn7r
         ExFWbrJRUkUBk+SHG3lpUKKiyL4R/69lmrw/6pL1OPU4VX5il3z26RInqUbdREsgs2Iz
         7B1osbugoTxrda4SrQjwRbNBsqEGRzRuh0AU1et6pHsfBJQJwPjZpAvAvv6JOZXXmqyc
         YZfA==
X-Received: by 10.31.52.82 with SMTP id b79mr26766636vka.84.1450134195267;
 Mon, 14 Dec 2015 15:03:15 -0800 (PST)
Received: by 10.31.62.203 with HTTP; Mon, 14 Dec 2015 15:03:15 -0800 (PST)
In-Reply-To: <1450121838-7069-4-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282444>

On Mon, Dec 14, 2015 at 2:37 PM, Stefan Beller <sbeller@google.com> wrote:
> Provide a wrapper to read(), similar to xread(), that restarts on
> EINTR but not EAGAIN (or EWOULDBLOCK). This enables the caller to
> handle polling itself, possibly polling multiple sockets or performing
> some other action.
>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
> diff --git a/wrapper.c b/wrapper.c
> @@ -252,6 +252,28 @@ ssize_t xread(int fd, void *buf, size_t len)
> + * xread_nonblock() is the same a read(), but it automatically restarts read()
> + * interrupted operations (EINTR). xread_nonblock() DOES NOT GUARANTEE that
> + * "len" bytes is read. EWOULDBLOCK is turned into EAGAIN.

The last sentence is confusing. From the commit message, we learn that
this function doesn't care about EAGAIN or EWOULDBLOCK, yet the above
comment seems to imply that it does. What it really ought to be saying
is that "as a convenience, errno is transformed from EWOULDBLOCK to
EAGAIN so that the caller only has to check for EAGAIN".

(It also feels weird that this should be messing with errno at all,
but that's a different issue...)

> + */
> +ssize_t xread_nonblock(int fd, void *buf, size_t len)
> +{
> +       ssize_t nr;
> +       if (len > MAX_IO_SIZE)
> +               len = MAX_IO_SIZE;
> +       while (1) {
> +               nr = read(fd, buf, len);
> +               if (nr < 0) {
> +                       if (errno == EINTR)
> +                               continue;
> +                       if (errno == EWOULDBLOCK)
> +                               errno = EAGAIN;
> +               }
> +               return nr;
> +       }
> +}
