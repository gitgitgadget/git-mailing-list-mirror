From: Jeff King <peff@peff.net>
Subject: Re: [PATCHv2 06/10] pkt-line: share buffer/descriptor reading
 implementation
Date: Mon, 18 Feb 2013 05:48:04 -0500
Message-ID: <20130218104804.GB16408@sigill.intra.peff.net>
References: <20130218091203.GB17003@sigill.intra.peff.net>
 <20130218092612.GF5096@sigill.intra.peff.net>
 <20130218104350.GF7049@elie.Belkin>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 18 11:48:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U7OGt-0001EE-Qu
	for gcvg-git-2@plane.gmane.org; Mon, 18 Feb 2013 11:48:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751282Ab3BRKsI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Feb 2013 05:48:08 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:51805 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751048Ab3BRKsH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Feb 2013 05:48:07 -0500
Received: (qmail 18631 invoked by uid 107); 18 Feb 2013 10:49:38 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 18 Feb 2013 05:49:38 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 18 Feb 2013 05:48:04 -0500
Content-Disposition: inline
In-Reply-To: <20130218104350.GF7049@elie.Belkin>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216474>

On Mon, Feb 18, 2013 at 02:43:50AM -0800, Jonathan Nieder wrote:

> Jeff King wrote:
> 
> > The packet_read function reads from a descriptor.
> 
> Ah, so this introduces a new analagous helper that reads from
> a strbuf, to avoid the copy-from-async-procedure hack?

Not from a strbuf, but basically, yes.

> > +		ret = read_in_full(fd, dst, size);
> > +		if (ret < 0)
> > +			die_errno("read error");
> 
> This is noisy about upstream pipe gone missing, which makes sense
> since this is transport-related.  Maybe that deserves a comment.

That is not new code; it is just reindented from the original safe_read.
But is it noisy about a missing pipe? We do not get EPIPE for reading.
We should just get a short read or EOF, both of which is handled later.

> > +		len = packet_read_from_buf(line, sizeof(line), &last->buf, &last->len);
> > +		if (len && line[len - 1] == '\n')
> > +			len--;
> 
> Was anything guaranteeing that buffer.len < 1000 before this change?

No. That's discussed in point (3) of the "implications" in the commit
message.

-Peff
