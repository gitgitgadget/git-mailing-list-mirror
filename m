From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: [PATCH v5 4/4] convert: Stream from fd to required clean filter instead of mmap
Date: Mon, 25 Aug 2014 18:55:51 +0200
Message-ID: <E23693B7-0D9D-477D-A303-4A68433EAB79@zib.de>
References: <1408896466-23149-1-git-send-email-prohaska@zib.de> <1408896466-23149-5-git-send-email-prohaska@zib.de> <20140825124323.GB17288@peff.net>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>, pclouds@gmail.com,
	john@keeping.me.uk, schacon@gmail.com
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Aug 25 18:56:53 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XLxZW-0000ir-47
	for gcvg-git-2@plane.gmane.org; Mon, 25 Aug 2014 18:56:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932193AbaHYQ4l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Aug 2014 12:56:41 -0400
Received: from mailer.zib.de ([130.73.108.11]:58028 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932185AbaHYQ4j (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Aug 2014 12:56:39 -0400
Received: from mailsrv2.zib.de (mailsrv2.zib.de [130.73.108.14])
	by mailer.zib.de (8.14.5/8.14.5) with ESMTP id s7PGu0fJ001444;
	Mon, 25 Aug 2014 18:56:00 +0200 (CEST)
Received: from [192.168.1.200] (ip5f5bd082.dynamic.kabel-deutschland.de [95.91.208.130] (may be forged))
	(authenticated bits=0)
	by mailsrv2.zib.de (8.14.5/8.14.5) with ESMTP id s7PGtv8v012122
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Mon, 25 Aug 2014 18:55:58 +0200 (CEST)
In-Reply-To: <20140825124323.GB17288@peff.net>
X-Mailer: Apple Mail (2.1878.6)
X-Miltered: at mailer.zib.de with ID 53FB6AA0.000 by Joe's j-chkmail (http : // j-chkmail dot ensmp dot fr)!
X-j-chkmail-Enveloppe: 53FB6AA0.000 from mailsrv2.zib.de/mailsrv2.zib.de/null/mailsrv2.zib.de/<prohaska@zib.de>
X-j-chkmail-Score: MSGID : 53FB6AA0.000 on mailer.zib.de : j-chkmail score : . : R=. U=. O=. B=0.000 -> S=0.000
X-j-chkmail-Status: Ham
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255834>


On Aug 25, 2014, at 2:43 PM, Jeff King <peff@peff.net> wrote:

> On Sun, Aug 24, 2014 at 06:07:46PM +0200, Steffen Prohaska wrote:
> 
>> The data is streamed to the filter process anyway.  Better avoid mapping
>> the file if possible.  This is especially useful if a clean filter
>> reduces the size, for example if it computes a sha1 for binary data,
>> like git media.  The file size that the previous implementation could
>> handle was limited by the available address space; large files for
>> example could not be handled with (32-bit) msysgit.  The new
>> implementation can filter files of any size as long as the filter output
>> is small enough.
>> 
>> The new code path is only taken if the filter is required.  The filter
>> consumes data directly from the fd.  The original data is not available
>> to git, so it must fail if the filter fails.
> 
> Can you clarify this second paragraph a bit more? If I understand
> correctly, we handle a non-required filter failing by just reading the
> data again (which we can do because we either read it into memory
> ourselves, or mmap it).

We don't read the data again.  convert_to_git() assumes that it is already
in memory and simply keeps the original buffer if the filter fails.


> With the streaming approach, we will read the
> whole file through our stream; if that fails we would then want to read
> the stream from the start.
> 
> Couldn't we do that with an lseek (or even an mmap with offset 0)? That
> obviously would not work for non-file inputs, but I think we address
> that already in index_fd: we push non-seekable things off to index_pipe,
> where we spool them to memory.

It could be handled that way, but we would be back to the original problem
that 32-bit git fails for large files.  The convert code path currently
assumes that all data is available in a single buffer at some point to apply
crlf and ident filters.

If the initial filter, which is assumed to reduce the file size, fails, we
could seek to 0 and read the entire file.  But git would then fail for large
files with out-of-memory.  We would not gain anything for the use case that
I describe in the commit message's first paragraph.

To implement something like the ideal strategy below, the entire convert 
machinery for crlf and ident would have to be converted to a streaming
approach.  Another option would be to detect that only the clean filter
would be applied and not crlf and ident.  Maybe we could get away with
something simpler then.

But I think that if the clean filter's purpose is to reduce file size, it
does not make sense to try to handle the case of a failing filter with a 
fallback plan.  The filter should simply be marked "required", because
any sane operation requires it.


> So it seems like the ideal strategy would be:
> 
>  1. If it's seekable, try streaming. If not, fall back to lseek/mmap.
> 
>  2. If it's not seekable and the filter is required, try streaming. We
>     die anyway if we fail.
> 
>  3. If it's not seekable and the filter is not required, decide based
>     on file size:
> 
>       a. If it's small, spool to memory and proceed as we do now.
> 
>       b. If it's big, spool to a seekable tempfile.
> 
> Your patch implements part 2. But I would think part 1 is the most common
> case. And while part 3b seems unpleasant, it is better than the current
> code (with or without your patch), which will do 3a on a large file.
> 
> Hmm. Though I guess in (3) we do not have the size up front, so it's
> complicated (we could spool N bytes to memory, then start dumping to a
> file after that). I do not think we necessarily need to implement that
> part, though. It seems like (1) is the thing I would expect to hit the
> most (i.e., people do not always mark their filters are "required").

Well, I think they have to mark it if the filter's purpose is to reduce size.

I'll add a bit of the discussion to the commit message.  I'm not convinced
that we should do more at this point.


>> +	} else {
>> +	    /* dup(), because copy_fd() closes the input fd. */
>> +	    fd = dup(params->fd);
> 
> Not a problem you are introducing, but this seem kind of like a
> misfeature in copy_fd. Is it worth fixing? The function only has two
> existing callers.

I found it confusing.  I think it's worth fixing.

	Steffen
