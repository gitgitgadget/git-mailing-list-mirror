From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] read_in_full: always report errors
Date: Thu, 26 May 2011 17:04:24 -0400
Message-ID: <20110526210424.GD31340@sigill.intra.peff.net>
References: <87tych5zrh.fsf@rho.meyering.net>
 <20110526141130.GB18520@sigill.intra.peff.net>
 <87hb8h5y09.fsf@rho.meyering.net>
 <20110526163027.GC4049@sigill.intra.peff.net>
 <7vy61twbqw.fsf@alter.siamese.dyndns.org>
 <20110526184839.GA6910@sigill.intra.peff.net>
 <7vlixtw5e2.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jim Meyering <jim@meyering.net>, git list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 26 23:04:34 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QPhjN-0001zK-33
	for gcvg-git-2@lo.gmane.org; Thu, 26 May 2011 23:04:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758350Ab1EZVE2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 May 2011 17:04:28 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:39063
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755056Ab1EZVE1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 May 2011 17:04:27 -0400
Received: (qmail 17392 invoked by uid 107); 26 May 2011 21:04:27 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 26 May 2011 17:04:27 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 26 May 2011 17:04:24 -0400
Content-Disposition: inline
In-Reply-To: <7vlixtw5e2.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174570>

On Thu, May 26, 2011 at 01:53:09PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > The problem is that most callers are not careful enough to repeatedly
> > call read_in_full and find out that there might have been an error in
> > the previous result. They see a read shorter than what they asked, and
> > assume it was EOF.
> 
> I can buy that argument, but then shouldn't we change the "careful"
> callers to treat any short-read from read_in_full() as an error?

I don't think so. A short-read could still be EOF, and you can
distinguish between the two. Before, if you asked for n bytes, you would
get back an 'r' that was one of:

  r < 0: error on first read
  r < n: short read via EOF, or error on subsequent read
  r == n: OK, got n bytes

With my patch, you get:

  r < 0: error on any read
  r < n: short read via EOF
  r == n: OK, got n bytes

So any negative return is an error, and less than n now _always_ means a
short read. So your "careful" callers will now get the error
automatically. If you want to update any callers, it would be ones like:

  if (read_in_full(fd, buf, len) != len))
          die("unable to read %d bytes", len);

which are not _wrong_, but could be more specific in doing:

  ssize_t r = read_in_full(fd, buf, len);
  if (r < 0)
          die_errno("unable to read");
  else if (r < len)
          die("short read");

But that is just a quality-of-error-message issue, not a correctness
issue.

> diff --git a/combine-diff.c b/combine-diff.c
> index be67cfc..176231e 100644
> --- a/combine-diff.c
> +++ b/combine-diff.c
> @@ -845,11 +845,8 @@ static void show_patch_diff(struct combine_diff_path *elem, int num_parent,
>  			result = xmalloc(len + 1);
>  
>  			done = read_in_full(fd, result, len);
> -			if (done < 0)
> +			if (done != len)
>  				die_errno("read error '%s'", elem->path);
> -			else if (done < len)
> -				die("early EOF '%s'", elem->path);
> -

This is backwards. We now _can_ tell the two apart, so more callers
could be like this.

-Peff
