From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] fsck: detect and warn a commit with embedded NUL
Date: Thu, 14 Apr 2016 14:21:03 -0400
Message-ID: <20160414182102.GB22068@sigill.intra.peff.net>
References: <20160414180709.28968-1-gitster@pobox.com>
 <20160414180709.28968-2-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 14 20:21:34 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aqltV-0004Mv-Gj
	for gcvg-git-2@plane.gmane.org; Thu, 14 Apr 2016 20:21:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932835AbcDNSVO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Apr 2016 14:21:14 -0400
Received: from cloud.peff.net ([50.56.180.127]:49556 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932675AbcDNSVL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Apr 2016 14:21:11 -0400
Received: (qmail 14781 invoked by uid 102); 14 Apr 2016 18:21:05 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 14 Apr 2016 14:21:05 -0400
Received: (qmail 1276 invoked by uid 107); 14 Apr 2016 18:21:11 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 14 Apr 2016 14:21:11 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 14 Apr 2016 14:21:03 -0400
Content-Disposition: inline
In-Reply-To: <20160414180709.28968-2-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291548>

On Thu, Apr 14, 2016 at 11:07:09AM -0700, Junio C Hamano wrote:

> Even though a Git commit object is designed to be capable of storing
> any binary data as its payload, in practice people use it to describe
> the changes in textual form, and tools like "git log" are designed to
> treat the payload as text.
> 
> Detect and warn when we see any commit object with a NUL byte in
> it.
> 
> Note that a NUL byte in the header part is already detected as a
> grave error.  This change is purely about the message part.
> 
> Signed-off-by: Junio C Hamano <gitster@pobox.com>

Thanks, I was just reading over some of the old threads, and wondering
if it was time to resurrect this idea.

> @@ -610,6 +611,7 @@ static int fsck_commit_buffer(struct commit *commit, const char *buffer,
>  	struct commit_graft *graft;
>  	unsigned parent_count, parent_line_count = 0, author_count;
>  	int err;
> +	const char *buffer_begin = buffer;
>  
>  	if (verify_headers(buffer, size, &commit->object, options))
>  		return -1;

You need this "buffer_begin" because we move the "buffer" pointer
forward as we parse. But perhaps whole-buffer checks should simply go at
the top (next to verify_headers) before we start advancing the pointer.
To me, that makes the function's flow more natural.

But alternatively...

> @@ -671,6 +673,12 @@ static int fsck_commit_buffer(struct commit *commit, const char *buffer,
>  		if (err)
>  			return err;
>  	}
> +	if (memchr(buffer_begin, '\0', size)) {
> +		err = report(options, &commit->object, FSCK_MSG_NUL_IN_COMMIT,
> +			     "NUL byte in the commit object body");
> +		if (err)
> +			return err;
> +	}

Here we've parsed to the end of the headers we know about. We know
there's no NUL there, because verify_headers() would have complained.
And because the individual header parsers would have complained. So I
actually think we could check from "buffer" (of course we do still need
to record the beginning of the buffer to adjust "size" appropriately).

It's a little more efficient (we don't have to memchr over the same
bytes again). But I'd worry a little that doing it that way would
introduce coupling between this check and verify_headers(), though (so
that if the latter ever changes, our check may start missing cases).

So yet another alternative would be to include this check in
verify_headers(). It would parse to the end of the headers as now, and
then from there additionally look for a NUL in the body.

Of the three approaches, I think I like that third one. It's the most
efficient, and I think the flow is pretty clear. We'd probably want to
rename verify_headers(), though. :)

-Peff
