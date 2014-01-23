From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v4 08/23] ewah: compressed bitmap implementation
Date: Thu, 23 Jan 2014 17:07:43 -0500
Message-ID: <20140123220742.GA29357@sigill.intra.peff.net>
References: <20131221135651.GA20818@sigill.intra.peff.net>
 <20131221135953.GH21145@sigill.intra.peff.net>
 <20140123020536.GP18964@google.com>
 <20140123183320.GA22995@sigill.intra.peff.net>
 <CAJo=hJtQG_u4=SjPAgU8h4Wew9LjaXUxnHqTT3Q9E1=_5LJ6Sw@mail.gmail.com>
 <20140123202645.GA329@sigill.intra.peff.net>
 <20140123215325.GA28829@vauxhall.crustytoothpaste.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Shawn Pearce <spearce@spearce.org>,
	Jonathan Nieder <jrnieder@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 23 23:07:49 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W6SRB-0004Pc-80
	for gcvg-git-2@plane.gmane.org; Thu, 23 Jan 2014 23:07:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753034AbaAWWHp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Jan 2014 17:07:45 -0500
Received: from cloud.peff.net ([50.56.180.127]:37821 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751490AbaAWWHo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Jan 2014 17:07:44 -0500
Received: (qmail 3644 invoked by uid 102); 23 Jan 2014 22:07:44 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 23 Jan 2014 16:07:44 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 23 Jan 2014 17:07:43 -0500
Content-Disposition: inline
In-Reply-To: <20140123215325.GA28829@vauxhall.crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240965>

On Thu, Jan 23, 2014 at 09:53:26PM +0000, brian m. carlson wrote:

> On Thu, Jan 23, 2014 at 03:26:45PM -0500, Jeff King wrote:
> > Looking over the format, I think the only thing preventing 4-byte
> > alignment is the 1-byte XOR-offset and 1-byte flags field for each
> > bitmap. If we ever have a v2, we could pad the sum of those out to 4
> > bytes. Is 4-byte alignment enough? We do treat the actual data as 64-bit
> > integers. I wonder if that would have problems on Sparc64, for example.
> 
> Yes, it will.  SPARC requires all loads be naturally aligned (4-byte to
> an address that's a multiple of 4, 8-byte to a multiple of 8, and so
> on).  In general, architectures that do not support unaligned access
> require natural alignment for all quantities.

In that case, I think we cannot even blame Shawn. The ewah serialization
format itself (which JGit inherited from the javaewah library) has 8
bytes of header and 4 bytes of trailer. So packed serialized ewahs
wouldn't be 8-byte aligned (though of course he could have added his own
padding to each when we have a sequence of them).

-Peff
