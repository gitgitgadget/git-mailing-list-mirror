From: Jeff King <peff@peff.net>
Subject: Re: Bug: .gitconfig folder
Date: Wed, 27 May 2015 18:18:13 -0400
Message-ID: <20150527221813.GF23259@peff.net>
References: <5565C6A7.60007@gmx.es>
 <xmqq7frtlq56.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jorge <griffin@gmx.es>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 28 00:18:24 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YxjeX-0004hq-80
	for gcvg-git-2@plane.gmane.org; Thu, 28 May 2015 00:18:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751662AbbE0WSQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 May 2015 18:18:16 -0400
Received: from cloud.peff.net ([50.56.180.127]:36963 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751630AbbE0WSQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 May 2015 18:18:16 -0400
Received: (qmail 18164 invoked by uid 102); 27 May 2015 22:18:16 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 27 May 2015 17:18:16 -0500
Received: (qmail 11222 invoked by uid 107); 27 May 2015 22:18:20 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 27 May 2015 18:18:20 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 27 May 2015 18:18:13 -0400
Content-Disposition: inline
In-Reply-To: <xmqq7frtlq56.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270111>

On Wed, May 27, 2015 at 01:30:29PM -0700, Junio C Hamano wrote:

> Jorge <griffin@gmx.es> writes:
> 
> > If you have a folder named ~/.gitconfig instead of a file with that
> > name, when you try to run some global config editing command it will
> > fail with a wrong error message:
> >
> >     "fatal: Out of memory? mmap failed: No such device"
> 
> That indeed is a funny error message.
> 
> How about this patch?
> 
> -- >8 --
> We show that message with die_errno(), but the OS is ought to know
> why mmap(2) failed much better than we do.  There is no reason for
> us to say "Out of memory?" here.
> 
> Note that mmap(2) fails with ENODEV when the file you specify is not
> something that can be mmap'ed, so you still need to know that "No
> such device" can include cases like having a directory when a
> regular file is expected, but we can expect that a user who creates
> a directory to a location where a regular file is expected to be
> would know what s/he is doing, hopefully ;-)
> 
>  sha1_file.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/sha1_file.c b/sha1_file.c
> index ccc6dac..551a9e9 100644
> --- a/sha1_file.c
> +++ b/sha1_file.c
> @@ -720,7 +720,7 @@ void *xmmap(void *start, size_t length,
>  		release_pack_memory(length);
>  		ret = mmap(start, length, prot, flags, fd, offset);
>  		if (ret == MAP_FAILED)
> -			die_errno("Out of memory? mmap failed");
> +			die_errno("mmap failed");
>  	}

This is definitely an improvement, but the real failing of that error
message is that it does not tell us that "~/.gitconfig" is the culprit.
I don't think we can do much from xmmap, though; it does not have the
filename. It would be nice if we got EISDIR from open() in the first
place, but I don't think we can implement that efficiently (if we added
an "xopen" that checked that, it would have to stat() every file we
opened).

-Peff
