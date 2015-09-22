From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv3 04/13] strbuf: add strbuf_read_once to read without blocking
Date: Mon, 21 Sep 2015 17:17:31 -0700
Message-ID: <xmqqoagv71es.fsf@gitster.mtv.corp.google.com>
References: <1442875159-13027-1-git-send-email-sbeller@google.com>
	<1442875159-13027-5-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, jacob.keller@gmail.com, peff@peff.net,
	jrnieder@gmail.com, johannes.schindelin@gmail.com,
	Jens.Lehmann@web.de, vlovich@gmail.com
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Tue Sep 22 02:17:39 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZeBH8-0005vR-Bt
	for gcvg-git-2@plane.gmane.org; Tue, 22 Sep 2015 02:17:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756529AbbIVARe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Sep 2015 20:17:34 -0400
Received: from mail-pa0-f47.google.com ([209.85.220.47]:35365 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754613AbbIVARd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Sep 2015 20:17:33 -0400
Received: by pacfv12 with SMTP id fv12so133217756pac.2
        for <git@vger.kernel.org>; Mon, 21 Sep 2015 17:17:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=VC5nWINW4j0b0Vbzq7MmLVc5Jg+67a8YGouYwYsML08=;
        b=0gKwBoSxu/TGkXmOnYavUiQdBocpUx9y+tVKZEleLx4hTT/O3WhPye68T9bW5gcCvp
         s0t3jDI6BnHaehFSCm434JxetOw0aIk/RQtHLbF5pIgu1lPmJgT0qDl500VrrehsTQtv
         5eH7v+Ia6Jr33UeRPax5OO3I4wP4TXRZbIMGWs9o0JSTz2d12aU/aIkWsy1/PrH1fp2w
         GZI2dNJ3RTv9rjrSx3jMCYl8TOQn63hBrK0/A9bWkGqBkcQSVcCB60K761Bf3kruSr0H
         cF7TBdX6C8t5gw92XSy41YUh9e6nc3+G2zC2uiJOzS2F+tGYAD8kIVsuf4iKJmr/VY9k
         1SRQ==
X-Received: by 10.68.102.225 with SMTP id fr1mr28085565pbb.65.1442881052970;
        Mon, 21 Sep 2015 17:17:32 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:89f8:25c:a9fe:f701])
        by smtp.gmail.com with ESMTPSA id pi9sm26701108pbb.96.2015.09.21.17.17.32
        (version=TLS1_2 cipher=AES128-SHA256 bits=128/128);
        Mon, 21 Sep 2015 17:17:32 -0700 (PDT)
In-Reply-To: <1442875159-13027-5-git-send-email-sbeller@google.com> (Stefan
	Beller's message of "Mon, 21 Sep 2015 15:39:10 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278367>

Stefan Beller <sbeller@google.com> writes:

> The new call will read a fd into a strbuf once. The underlying call

"read from a fd"

> xread_nonblock is meant to execute non blockingly if the fd is set to
> O_NONBLOCK.

The latter sentence adds more questions than it answers.  If the
file descriptor is not set to non-blocking, what happens?  Is it a
bug in the caller, and if so do we give help to diagnose such a bug?



> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>  strbuf.c | 11 +++++++++++
>  strbuf.h |  6 ++++++
>  2 files changed, 17 insertions(+)
>
> diff --git a/strbuf.c b/strbuf.c
> index cce5eed..35e71b8 100644
> --- a/strbuf.c
> +++ b/strbuf.c
> @@ -384,6 +384,17 @@ ssize_t strbuf_read(struct strbuf *sb, int fd, size_t hint)
>  	return sb->len - oldlen;
>  }
>  
> +ssize_t strbuf_read_once(struct strbuf *sb, int fd, size_t hint)
> +{
> +	ssize_t cnt;
> +
> +	strbuf_grow(sb, hint ? hint : 8192);
> +	cnt = xread_nonblock(fd, sb->buf + sb->len, sb->alloc - sb->len - 1);
> +	if (cnt > 0)
> +		strbuf_setlen(sb, sb->len + cnt);
> +	return cnt;

OK.  So the caller that receives a negative value can check errno to
see if we got EAGAIN.  How would the caller tell when it got an EOF?

>  /**
> + * Same as strbuf_read, just returns non-blockingly by ignoring EAGAIN.

I do not think you want to say "same as" for this one.
strbuf_read() is about reading thru to the end, but this is about
making some progress without blocking.

    Read from a file descriptor that is marked as O_NONBLOCK without
    blocking.  Returns the number of new bytes appended to the sb.
    Negative return value signals there was an error returned from
    underlying read(2), in which case the caller should check errno.
    e.g. errno == EAGAIN when the read may have blocked.

or something?  Again, how would a caller tell when it got an EOF?

> + * The fd must have set O_NONBLOCK.
> + */
> +extern ssize_t strbuf_read_once(struct strbuf *, int fd, size_t hint);
> +
> +/**
>   * Read the contents of a file, specified by its path. The third argument
>   * can be used to give a hint about the file size, to avoid reallocs.
>   */
