From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v4 08/23] ewah: compressed bitmap implementation
Date: Thu, 23 Jan 2014 17:26:32 -0500
Message-ID: <20140123222632.GA2311@sigill.intra.peff.net>
References: <20131221135651.GA20818@sigill.intra.peff.net>
 <20131221135953.GH21145@sigill.intra.peff.net>
 <20140123020536.GP18964@google.com>
 <20140123183320.GA22995@sigill.intra.peff.net>
 <CAJo=hJtQG_u4=SjPAgU8h4Wew9LjaXUxnHqTT3Q9E1=_5LJ6Sw@mail.gmail.com>
 <20140123202645.GA329@sigill.intra.peff.net>
 <20140123215325.GA28829@vauxhall.crustytoothpaste.net>
 <20140123220742.GA29357@sigill.intra.peff.net>
 <20140123221755.GA18964@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Shawn Pearce <spearce@spearce.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 23 23:26:39 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W6SjN-0003mz-Rh
	for gcvg-git-2@plane.gmane.org; Thu, 23 Jan 2014 23:26:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753337AbaAWW0e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Jan 2014 17:26:34 -0500
Received: from cloud.peff.net ([50.56.180.127]:37834 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751696AbaAWW0d (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Jan 2014 17:26:33 -0500
Received: (qmail 4700 invoked by uid 102); 23 Jan 2014 22:26:33 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 23 Jan 2014 16:26:33 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 23 Jan 2014 17:26:32 -0500
Content-Disposition: inline
In-Reply-To: <20140123221755.GA18964@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240967>

On Thu, Jan 23, 2014 at 02:17:55PM -0800, Jonathan Nieder wrote:

> Jeff King wrote:
> > On Thu, Jan 23, 2014 at 09:53:26PM +0000, brian m. carlson wrote:
> 
> >> Yes, it will.  SPARC requires all loads be naturally aligned (4-byte to
> >> an address that's a multiple of 4, 8-byte to a multiple of 8, and so
> >> on).  In general, architectures that do not support unaligned access
> >> require natural alignment for all quantities.
> >
> > In that case, I think we cannot even blame Shawn. The ewah serialization
> > format itself (which JGit inherited from the javaewah library) has 8
> > bytes of header and 4 bytes of trailer. So packed serialized ewahs
> > wouldn't be 8-byte aligned
> 
> I don't think that's a big issue.  A pair of 4-byte reads would not be
> too slow.

The header is actually two separate 4-byte values, so that's fine. But
between the header and trailer are a series of 8-byte data values, and
that is what we need the 8-byte alignment for. So the _first_ ewah's
data is 8-byte aligned, but then it offsets the alignment with a single
4-byte trailer. So the next ewah, if they are packed in a sequence, is
will have its data misaligned.

You could solve it by putting an empty 4-byte pad at the end of each
ewah (and of course making sure the first one is 8-byte aligned).

Anyway, this is all academic until we are designing bitmap v2, which I
do not plan on doing anytime soon.

-Peff
