From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v4 08/23] ewah: compressed bitmap implementation
Date: Thu, 23 Jan 2014 15:03:11 -0500
Message-ID: <20140123200311.GA31920@sigill.intra.peff.net>
References: <20131221135651.GA20818@sigill.intra.peff.net>
 <20131221135953.GH21145@sigill.intra.peff.net>
 <20140123020536.GP18964@google.com>
 <20140123183320.GA22995@sigill.intra.peff.net>
 <20140123195206.GU18964@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 23 21:03:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W6QUm-0000PW-Tx
	for gcvg-git-2@plane.gmane.org; Thu, 23 Jan 2014 21:03:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752743AbaAWUDO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Jan 2014 15:03:14 -0500
Received: from cloud.peff.net ([50.56.180.127]:37699 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752225AbaAWUDM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Jan 2014 15:03:12 -0500
Received: (qmail 27750 invoked by uid 102); 23 Jan 2014 20:03:12 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 23 Jan 2014 14:03:12 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 23 Jan 2014 15:03:11 -0500
Content-Disposition: inline
In-Reply-To: <20140123195206.GU18964@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240937>

On Thu, Jan 23, 2014 at 11:52:06AM -0800, Jonathan Nieder wrote:

> > After my patches, t5310 runs fine for me. I didn't try your patch, but
> > mine are similar. Let me know if you still see the problem (there may
> > simply be a bug in yours, but I didn't see it).
> 
> I had left out a cast to unsigned, producing an overflow.
> 
> My main worry about the patches is that they will probably run into
> an analagous problem to the one that v1.7.12-rc0~1^2~2 (block-sha1:
> avoid pointer conversion that violates alignment constraints,
> 2012-07-22) solved.  By casting the pointer to (uint32_t *) we are
> telling the compiler it is 32-bit aligned (C99 section 6.3.2.3).

Yeah, maybe. We go via memcpy, which takes a "void *", so that part is
good. However, the new code looks like:

  foo = align_ntohl(*(uint32_t *)ptr);

I think this probably works in practice because align_ntohl is inlined,
and any sane compiler will never actually load the variable. If we
change the signature of align_ntohl, we can do this:

  uint32_t align_ntohl(void *ptr)
  {
          uint32_t x;
          memcpy(x, ptr, sizeof(x));
          return ntohl(x);
  }

  ...

  foo = align_ntohl(ptr);

The memcpy solution is taken from read-cache.c, but as we noted, it
probably hasn't been used a lot. The blk_sha1 get_be may be faster, as
it converts as it reads. However, the bulk of the data is copied via
a single memcpy and then modified in place. I don't know if that would
be faster or not (for a big-endian system it probably is, since we can
omit the modification loop entirely).

-Peff
