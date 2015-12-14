From: Eric Sunshine <ericsunshine@gmail.com>
Subject: Re: [PATCH 4/8] strbuf: add strbuf_read_once to read without blocking
Date: Mon, 14 Dec 2015 18:16:39 -0500
Message-ID: <CAPig+cQUGCFZnOxjuFaYNNhLqfdS7thrUQKqNkr5=0Hr4OkyMw@mail.gmail.com>
References: <1450121838-7069-1-git-send-email-sbeller@google.com>
	<1450121838-7069-5-git-send-email-sbeller@google.com>
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
X-From: git-owner@vger.kernel.org Tue Dec 15 00:16:45 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a8cMH-0002vl-1w
	for gcvg-git-2@plane.gmane.org; Tue, 15 Dec 2015 00:16:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753654AbbLNXQl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Dec 2015 18:16:41 -0500
Received: from mail-vk0-f52.google.com ([209.85.213.52]:35793 "EHLO
	mail-vk0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753630AbbLNXQk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Dec 2015 18:16:40 -0500
Received: by vkha189 with SMTP id a189so164459370vkh.2
        for <git@vger.kernel.org>; Mon, 14 Dec 2015 15:16:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:reply-to:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=47If1sxJwHRMCl85x3v72lcklpJ0DbOdGQymPbIepHw=;
        b=NKlrJHnu10jdVw5cA2TZ6Z6gwt2t3T96GKeQfVAY5/uAwpxa6a8Nej8ukGa4b8jc5c
         6KsyLK10Db/sdA3t8T9RcqSngF9JSI8+KA5HqUnhAz90fjT5rHIyxSdL1sejHGCoBoYJ
         viI575ydkCDog68+SPeLMQ+fE2Qce01w0d4EkOQvPO/U+z6BF3Iv9AkNzUisfGd42sut
         vBoqXY73KyakKbCuk5NIyZGPS5Gl7s7ar6FGFvtroHO86CXxrlGCtOGV2BsLJfvTFMFo
         qMGGPuczc9F6BYgLfTPrw4ZORU0ktRdsdxLjJ0S8vb0jJG62VJ+RU9g27a9deMXHhkIo
         a3iA==
X-Received: by 10.31.134.3 with SMTP id i3mr27890424vkd.14.1450134999748; Mon,
 14 Dec 2015 15:16:39 -0800 (PST)
Received: by 10.31.62.203 with HTTP; Mon, 14 Dec 2015 15:16:39 -0800 (PST)
In-Reply-To: <1450121838-7069-5-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282451>

On Mon, Dec 14, 2015 at 2:37 PM, Stefan Beller <sbeller@google.com> wrote:
> The new call will read from a file descriptor into a strbuf once. The
> underlying call xread_nonblock is meant to execute without blocking if
> the file descriptor is set to O_NONBLOCK. It is a bug to call
> strbuf_read_once on a file descriptor which would block.
>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
> diff --git a/strbuf.h b/strbuf.h
> @@ -367,6 +367,14 @@ extern size_t strbuf_fread(struct strbuf *, size_t, FILE *);
>  extern ssize_t strbuf_read(struct strbuf *, int fd, size_t hint);
>
>  /**
> + * Returns the number of new bytes appended to the sb.
> + * Negative return value signals there was an error returned from
> + * underlying read(2), in which case the caller should check errno.
> + * e.g. errno == EAGAIN when the read may have blocked.
> + */
> +extern ssize_t strbuf_read_once(struct strbuf *, int fd, size_t hint);

strbuf_read_once() is a rather opaque name; without reading the
documentation, it's difficult to figure out what it means. I wonder if
strbuf_read_nonblock() or something would be clearer?
