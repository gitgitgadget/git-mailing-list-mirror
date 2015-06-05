From: Jeff King <peff@peff.net>
Subject: Re: Pack files, standards compliance, and efficiency
Date: Fri, 5 Jun 2015 05:45:45 -0400
Message-ID: <20150605094545.GB11855@peff.net>
References: <20150605014120.GE305479@vauxhall.crustytoothpaste.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	git@vger.kernel.org, Stefan Beller <sbeller@google.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 05 11:46:00 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z0oCH-0006ay-9R
	for gcvg-git-2@plane.gmane.org; Fri, 05 Jun 2015 11:45:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753450AbbFEJpt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Jun 2015 05:45:49 -0400
Received: from cloud.peff.net ([50.56.180.127]:41538 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751394AbbFEJps (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Jun 2015 05:45:48 -0400
Received: (qmail 24173 invoked by uid 102); 5 Jun 2015 09:45:48 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 05 Jun 2015 04:45:48 -0500
Received: (qmail 7529 invoked by uid 107); 5 Jun 2015 09:45:49 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 05 Jun 2015 05:45:49 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 05 Jun 2015 05:45:45 -0400
Content-Disposition: inline
In-Reply-To: <20150605014120.GE305479@vauxhall.crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270821>

On Fri, Jun 05, 2015 at 01:41:21AM +0000, brian m. carlson wrote:

> However, with the object_id conversion, we run into a problem: casting
> those unsigned char * values into struct object_id * values is not
> allowed by the C standard.  There are two possible solutions: copying;
> and the just-do-it solution, where we cast and hope for the best.

I'm not sure if it does violate the standard. The address of the first
element of a struct is guaranteed to match the address of the struct
itself. The object_id.hash member is an array of unsigned char, so there
are no alignment issues. It might run afoul of rules about casting
between pointer types (i.e., pointers for all types are not guaranteed
to be the same size). The standard dictates that "char *" and "void *"
are the same size, and big enough to hold a pointer to anything, so I
think it might even be OK.

But I'm not even sure that line of thinking is all that interesting.
Even if we are violating some dark corner of the standard, this
definitely falls into the "it's useful and works on all sane machines"
category. We also do much worse things with struct-casting mmap'd data
elsewhere (e.g., see the use of "struct pack_header"). It works fine in
practice as long as you are careful about alignment and padding issues.

So my vote would be to retain the cast. This is very low-level,
performance-sensitive code. I did some very naive timings and didn't see
any measurable change from your patch, but I also don't think we are
seeing a real portability benefit to moving to the copy, so I'd prefer
to keep the status quo.

> It looks like we use the latter in nth_packed_object_offset, where we
> cast an unsigned char * value to uint32_t *, which is clearly not
> allowed.

Yes, this one is definitely dubious by the standard. However, it works
in practice because the index format is designed to be 4-byte aligned.
By contrast, the .bitmap format is not, and we have to use get_be32, etc
(which is really not the end of the world, but I do not think there is
any real reason to change the .idx code at this point).

> I'm to the point where I need to make a decision on how to
> proceed, and I've included a patch with the copying conversion of
> nth_packed_object_sha1 below for comparison.  The casting solution is
> obviously more straightforward.  I haven't tested either implementation
> for performance.

The test I did was just running "git rev-list --use-bitmap-index --count
HEAD" on a bitmapped linux.git repo. That's where I'd expect it to show
the most, because we are not doing much other work. But I think even
still, the timing is dominated by loading the bitmap file.

-Peff
