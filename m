From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v5 4/4] convert: Stream from fd to required clean filter
 instead of mmap
Date: Mon, 25 Aug 2014 08:43:23 -0400
Message-ID: <20140825124323.GB17288@peff.net>
References: <1408896466-23149-1-git-send-email-prohaska@zib.de>
 <1408896466-23149-5-git-send-email-prohaska@zib.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	pclouds@gmail.com, john@keeping.me.uk, schacon@gmail.com
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Mon Aug 25 14:43:30 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XLtcQ-0007kZ-Bm
	for gcvg-git-2@plane.gmane.org; Mon, 25 Aug 2014 14:43:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755859AbaHYMn0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Aug 2014 08:43:26 -0400
Received: from cloud.peff.net ([50.56.180.127]:58368 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755855AbaHYMnZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Aug 2014 08:43:25 -0400
Received: (qmail 9875 invoked by uid 102); 25 Aug 2014 12:43:25 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 25 Aug 2014 07:43:25 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 25 Aug 2014 08:43:23 -0400
Content-Disposition: inline
In-Reply-To: <1408896466-23149-5-git-send-email-prohaska@zib.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255821>

On Sun, Aug 24, 2014 at 06:07:46PM +0200, Steffen Prohaska wrote:

> The data is streamed to the filter process anyway.  Better avoid mapping
> the file if possible.  This is especially useful if a clean filter
> reduces the size, for example if it computes a sha1 for binary data,
> like git media.  The file size that the previous implementation could
> handle was limited by the available address space; large files for
> example could not be handled with (32-bit) msysgit.  The new
> implementation can filter files of any size as long as the filter output
> is small enough.
> 
> The new code path is only taken if the filter is required.  The filter
> consumes data directly from the fd.  The original data is not available
> to git, so it must fail if the filter fails.

Can you clarify this second paragraph a bit more? If I understand
correctly, we handle a non-required filter failing by just reading the
data again (which we can do because we either read it into memory
ourselves, or mmap it). With the streaming approach, we will read the
whole file through our stream; if that fails we would then want to read
the stream from the start.

Couldn't we do that with an lseek (or even an mmap with offset 0)? That
obviously would not work for non-file inputs, but I think we address
that already in index_fd: we push non-seekable things off to index_pipe,
where we spool them to memory.

So it seems like the ideal strategy would be:

  1. If it's seekable, try streaming. If not, fall back to lseek/mmap.

  2. If it's not seekable and the filter is required, try streaming. We
     die anyway if we fail.

  3. If it's not seekable and the filter is not required, decide based
     on file size:

       a. If it's small, spool to memory and proceed as we do now.

       b. If it's big, spool to a seekable tempfile.

Your patch implements part 2. But I would think part 1 is the most common
case. And while part 3b seems unpleasant, it is better than the current
code (with or without your patch), which will do 3a on a large file.

Hmm. Though I guess in (3) we do not have the size up front, so it's
complicated (we could spool N bytes to memory, then start dumping to a
file after that). I do not think we necessarily need to implement that
part, though. It seems like (1) is the thing I would expect to hit the
most (i.e., people do not always mark their filters are "required").

> -	write_err = (write_in_full(child_process.in, params->src, params->size) < 0);
> +	if (params->src) {
> +	    write_err = (write_in_full(child_process.in, params->src, params->size) < 0);

Style: 4-space indentation (rather than a tab). There's more of it in
this function (and in would_convert...) that I didn't mark.

> +	} else {
> +	    /* dup(), because copy_fd() closes the input fd. */
> +	    fd = dup(params->fd);

Not a problem you are introducing, but this seem kind of like a
misfeature in copy_fd. Is it worth fixing? The function only has two
existing callers.

> +	/* Apply a filter to an fd only if the filter is required to succeed.
> +	 * We must die if the filter fails, because the original data before
> +	 * filtering is not available.
> +	 */

Style nit:

  /*
   * We have a blank line at the top of our
   * multi-line comments.
   */

-Peff
