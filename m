From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 0/2] optimizing pack access on "read only" fetch repos
Date: Tue, 29 Jan 2013 03:29:40 -0500
Message-ID: <20130129082939.GB6396@sigill.intra.peff.net>
References: <20130126224011.GA20675@sigill.intra.peff.net>
 <7vlibfxhit.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 29 09:30:08 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U06Zy-0007dP-8F
	for gcvg-git-2@plane.gmane.org; Tue, 29 Jan 2013 09:30:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754649Ab3A2I3o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Jan 2013 03:29:44 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:53216 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753190Ab3A2I3n (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jan 2013 03:29:43 -0500
Received: (qmail 19641 invoked by uid 107); 29 Jan 2013 08:31:05 -0000
Received: from c-71-206-173-132.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.206.173.132)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 29 Jan 2013 03:31:05 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 29 Jan 2013 03:29:40 -0500
Content-Disposition: inline
In-Reply-To: <7vlibfxhit.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214914>

On Sat, Jan 26, 2013 at 10:32:42PM -0800, Junio C Hamano wrote:

> Both makes sense to me.
> 
> I also wonder if we would be helped by another "repack" mode that
> coalesces small packs into a single one with minimum overhead, and
> run that often from "gc --auto", so that we do not end up having to
> have 50 packfiles.
> 
> When we have 2 or more small and young packs, we could:
> 
>  - iterate over idx files for these packs to enumerate the objects
>    to be packed, replacing read_object_list_from_stdin() step;
> 
>  - always choose to copy the data we have in these existing packs,
>    instead of doing a full prepare_pack(); and
> 
>  - use the order the objects appear in the original packs, bypassing
>    compute_write_order().

I'm not sure. If I understand you correctly, it would basically just be
concatenating packs without trying to do delta compression between the
objects which are ending up in the same pack. So it would save us from
having to do (up to) 50 binary searches to find an object in a pack, but
would not actually save us much space.

I would be interested to see the timing on how quick it is compared to a
real repack, as the I/O that happens during a repack is non-trivial
(although if you are leaving aside the big "main" pack, then it is
probably not bad).

But how do these somewhat mediocre concatenated packs get turned into
real packs? Pack-objects does not consider deltas between objects in the
same pack. And when would you decide to make a real pack? How do you
know you have 50 young and small packs, and not 50 mediocre coalesced
packs?

-Peff
