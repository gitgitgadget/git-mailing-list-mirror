From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 4/6] introduce a commit metapack
Date: Mon, 18 Mar 2013 08:20:11 -0400
Message-ID: <20130318122011.GE14789@sigill.intra.peff.net>
References: <20130129091434.GA6975@sigill.intra.peff.net>
 <20130129091610.GD9999@sigill.intra.peff.net>
 <20130130135607.GA23154@lanh>
 <CACsJy8Bqg6knVtddwaGSqtiXzVDgbO1JjbFOPMbF_RqrxM2rFQ@mail.gmail.com>
 <20130131110656.GA28093@lanh>
 <CACsJy8CPXFhUYz2f1wuxJvqwknJr5VFNFrs3b_4pS14cxf=3Wg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 18 13:20:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UHZ3a-0006Cz-Bs
	for gcvg-git-2@plane.gmane.org; Mon, 18 Mar 2013 13:20:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751644Ab3CRMUP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Mar 2013 08:20:15 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:55970 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751001Ab3CRMUO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Mar 2013 08:20:14 -0400
Received: (qmail 16000 invoked by uid 107); 18 Mar 2013 12:21:57 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 18 Mar 2013 08:21:57 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 18 Mar 2013 08:20:11 -0400
Content-Disposition: inline
In-Reply-To: <CACsJy8CPXFhUYz2f1wuxJvqwknJr5VFNFrs3b_4pS14cxf=3Wg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218407>

On Sun, Mar 17, 2013 at 08:21:13PM +0700, Nguyen Thai Ngoc Duy wrote:

> On Thu, Jan 31, 2013 at 6:06 PM, Duy Nguyen <pclouds@gmail.com> wrote:
> > On Wed, Jan 30, 2013 at 09:16:29PM +0700, Duy Nguyen wrote:
> >> Perhaps we could store abbrev sha-1 instead of full sha-1. Nice
> >> space/time trade-off.
> >
> > Following the on-disk format experiment yesterday, I changed the
> > format to:
> >
> >  - a list a _short_ SHA-1 of cached commits
> > ..
> >
> > The length of SHA-1 is chosen to be able to unambiguously identify any
> > cached commits. Full SHA-1 check is done after to catch false
> > positives. For linux-2.6, SHA-1 length is 6 bytes, git and many
> > moderate-sized projects are 4 bytes.
> 
> And if we are going to create index v3, the same trick could be used
> for the sha-1 table in the index. We use the short sha-1 table for
> binary search and put the rest of sha-1 in a following table (just
> like file offset table). The advantage is a denser search space, about
> 1/4-1/3 the size of full sha-1 table.

You can make it even smaller at some (potential) run-time cost.

Keep in mind you are just repeating information that is in the full sha1
list in the index. So you could store a fixed-size offset into that list
(e.g., 32-bit), and then instead of comparing sha1s during a binary
search, you would dereference the offset to the real sha1s and compare
those.

The run-time cost is not any worse in a big-O sense, but your cache
locality is much worse (you hit a second random page for each sha1
comparison), which might be noticeable. You'd have to benchmark to see
how big an impact.

-Peff
