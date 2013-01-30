From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 4/6] introduce a commit metapack
Date: Wed, 30 Jan 2013 02:12:09 -0500
Message-ID: <20130130071209.GD11147@sigill.intra.peff.net>
References: <20130129091434.GA6975@sigill.intra.peff.net>
 <20130129091610.GD9999@sigill.intra.peff.net>
 <7vy5fbq48t.fsf@alter.siamese.dyndns.org>
 <7vtxpzq2uv.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Duy Nguyen <pclouds@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 30 08:12:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U0RqV-0004LM-SQ
	for gcvg-git-2@plane.gmane.org; Wed, 30 Jan 2013 08:12:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753399Ab3A3HMO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Jan 2013 02:12:14 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:53824 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753292Ab3A3HMM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Jan 2013 02:12:12 -0500
Received: (qmail 27462 invoked by uid 107); 30 Jan 2013 07:13:35 -0000
Received: from c-71-206-173-132.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.206.173.132)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 30 Jan 2013 02:13:35 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 30 Jan 2013 02:12:09 -0500
Content-Disposition: inline
In-Reply-To: <7vtxpzq2uv.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214999>

On Tue, Jan 29, 2013 at 10:08:08AM -0800, Junio C Hamano wrote:

> > In order to reduce the disk footprint and I/O cost, the future
> > direction for this mechanism may want to point into an existing
> > store of SHA-1 hashes with a shorter file offset, and the .idx file
> > could be such a store, and in order to move in that direction, you
> > cannot avoid tying a metapack to a pack.
> 
> Have you considered if we can extend the .idx format version 2
> without actually having to bump the version number?  My quick
> reading of check_packed_git_idx() tells me that we have a gap after
> the "large offset table" that we can place extensions, but I may be
> mistaken.  If we indeed can, then perhaps adding a series of
> 
> 	4-byte "id" header
>         4-byte extension length (or 8-byte)
>         ... N-byte worth of extension data ...
> 
> followed by
> 
> 	20-byte SHA-1 checksum of all the extension sections
> 	8-byte file offset to the first extension section

I considered it, but didn't look into it closely. My feeling was that it
added extra complexity, without adding any real advantage that a
separate file would not.

>From this:

> Then it will be very natural for the extension data that store the
> commit metainfo to name objects in the pack the .idx file describes
> by the offset in the SHA-1 table.

I guess your argument is that putting it all in the same file makes it
more natural for there to be a data dependency.

> As we always say, .idx is a local cache and bumping its version is
> not a huge headache compared to other longer term storage items.

True, but it is even less headache if the file is totally separate and
optional.

-Peff
