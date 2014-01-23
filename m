From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v4 08/23] ewah: compressed bitmap implementation
Date: Thu, 23 Jan 2014 15:38:31 -0500
Message-ID: <20140123203830.GA4365@sigill.intra.peff.net>
References: <20131221135651.GA20818@sigill.intra.peff.net>
 <20131221135953.GH21145@sigill.intra.peff.net>
 <20140123020536.GP18964@google.com>
 <20140123183320.GA22995@sigill.intra.peff.net>
 <20140123195206.GU18964@google.com>
 <20140123200311.GA31920@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 23 21:38:37 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W6R2q-0007b8-9L
	for gcvg-git-2@plane.gmane.org; Thu, 23 Jan 2014 21:38:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752139AbaAWUid (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Jan 2014 15:38:33 -0500
Received: from cloud.peff.net ([50.56.180.127]:37753 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751488AbaAWUic (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Jan 2014 15:38:32 -0500
Received: (qmail 30388 invoked by uid 102); 23 Jan 2014 20:38:32 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 23 Jan 2014 14:38:32 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 23 Jan 2014 15:38:31 -0500
Content-Disposition: inline
In-Reply-To: <20140123200311.GA31920@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240949>

On Thu, Jan 23, 2014 at 03:03:11PM -0500, Jeff King wrote:

> > My main worry about the patches is that they will probably run into
> > an analagous problem to the one that v1.7.12-rc0~1^2~2 (block-sha1:
> > avoid pointer conversion that violates alignment constraints,
> > 2012-07-22) solved.  By casting the pointer to (uint32_t *) we are
> > telling the compiler it is 32-bit aligned (C99 section 6.3.2.3).
> 
> Yeah, maybe. We go via memcpy, which takes a "void *", so that part is
> good. However, the new code looks like:
> 
>   foo = align_ntohl(*(uint32_t *)ptr);
> 
> I think this probably works in practice because align_ntohl is inlined,
> and any sane compiler will never actually load the variable. If we
> change the signature of align_ntohl, we can do this:

Actually, it is a little trickier than that. We actually take the
address in the macro. So even without inlining, we end up casting to
void. I still think this:

>   uint32_t align_ntohl(void *ptr)
>   {
>           uint32_t x;
>           memcpy(x, ptr, sizeof(x));
>           return ntohl(x);
>   }

is a little more obvious, though. It does mean that everybody has to
pass a pointer, though, and on platforms where non-aligned reads are OK,
we do the cast ourselves. That means that:

  foo = align_ntohl(&bar);

will not be able to do any type-checking for "bar" (say, when we are
pulling "bar" straight out of a packed struct). I don't know how much
we care.

-Peff
