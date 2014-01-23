From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v4 08/23] ewah: compressed bitmap implementation
Date: Thu, 23 Jan 2014 13:33:20 -0500
Message-ID: <20140123183320.GA22995@sigill.intra.peff.net>
References: <20131221135651.GA20818@sigill.intra.peff.net>
 <20131221135953.GH21145@sigill.intra.peff.net>
 <20140123020536.GP18964@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 23 19:33:41 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W6P5v-0003DB-WE
	for gcvg-git-2@plane.gmane.org; Thu, 23 Jan 2014 19:33:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751755AbaAWSdf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Jan 2014 13:33:35 -0500
Received: from cloud.peff.net ([50.56.180.127]:37644 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751806AbaAWSdW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Jan 2014 13:33:22 -0500
Received: (qmail 22485 invoked by uid 102); 23 Jan 2014 18:33:21 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 23 Jan 2014 12:33:21 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 23 Jan 2014 13:33:20 -0500
Content-Disposition: inline
In-Reply-To: <20140123020536.GP18964@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240924>

On Wed, Jan 22, 2014 at 06:05:36PM -0800, Jonathan Nieder wrote:

> Jeff King wrote:
> 
> > EWAH is a word-aligned compressed variant of a bitset (i.e. a data
> > structure that acts as a 0-indexed boolean array for many entries).
> 
> I suspect that for some callers it's not word-aligned.

Yes, the mmap'd buffers aren't necessarily word-aligned. I don't think
we can fix that easily without changing the on-disk format (which comes
from JGit anyway). However, since we are memcpying the bulk of the data
into a newly allocated buffer (which must be aligned), we can do that
first, and then fix the endian-ness in place.

The only SPARC machine I have access to is running Solaris, but after
some slight wrestling with the BYTE_ORDER macros, I managed to get it to
compile and reproduced the bus error.

Here's a patch series (on top of jk/pack-bitmap, naturally) that lets
t5310 pass there. I assume the ARM problem is the same, though seeing
the failure in realloc() is unexpected. Can you try it on both your
platforms with these patches?

  [1/2]: compat: move unaligned helpers to bswap.h
  [2/2]: ewah: support platforms that require aligned reads

> Hopefully it's possible to get the alignment right in the caller
> and tweak the signature to require that instead of using unaligned
> reads like this.  There's still something wrong after this patch ---
> the new result is a NULL pointer dereference in t5310.7 "enumerate
> --objects (full bitmap)".

After my patches, t5310 runs fine for me. I didn't try your patch, but
mine are similar. Let me know if you still see the problem (there may
simply be a bug in yours, but I didn't see it).

-Peff
