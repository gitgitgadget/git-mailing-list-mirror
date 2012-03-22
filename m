From: Jeff King <peff@peff.net>
Subject: Re: Strange effect merging empty file
Date: Thu, 22 Mar 2012 15:03:03 -0400
Message-ID: <20120322190303.GA32756@sigill.intra.peff.net>
References: <4F69AD3C.4070203@ericsson.com>
 <4F69B375.5050205@in.waw.pl>
 <86iphwomnq.fsf@red.stonehenge.com>
 <4F6B1F48.3040007@in.waw.pl>
 <20120322140140.GA8803@sigill.intra.peff.net>
 <7vty1gy3eh.fsf@alter.siamese.dyndns.org>
 <20120322175952.GA13069@sigill.intra.peff.net>
 <20120322182533.GA20360@sigill.intra.peff.net>
 <7v62dwxybd.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>,
	"Randal L. Schwartz" <merlyn@stonehenge.com>,
	Ralf Nyren <ralf.nyren@ericsson.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 22 20:03:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SAnI3-00073a-Sm
	for gcvg-git-2@plane.gmane.org; Thu, 22 Mar 2012 20:03:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759202Ab2CVTDI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Mar 2012 15:03:08 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:56849
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755116Ab2CVTDG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Mar 2012 15:03:06 -0400
Received: (qmail 4087 invoked by uid 107); 22 Mar 2012 19:03:21 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 22 Mar 2012 15:03:21 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 22 Mar 2012 15:03:03 -0400
Content-Disposition: inline
In-Reply-To: <7v62dwxybd.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193689>

On Thu, Mar 22, 2012 at 11:52:54AM -0700, Junio C Hamano wrote:

> I still wonder why checking only the preimage side is sufficient, though.
> Shouldn't we check both sides?
> [...]
> > +		if (pair->status != 'R' || is_empty_blob_sha1(pair->one->sha1)) {

If the source is an empty file, then the other side must be an empty
file, too, no? Otherwise it would not be a rename. It could not be
exact, for obvious reasons. And it could not be inexact, because there
is no content to analyze on the source side.

Ditto for the destination side. How could something be renamed to an
empty file, but not be empty on the source side?

That is a slight layering violation, in that we are making assumptions
about how the diffcore-rename subsystem works. In theory diffcore-rename
could learn to read rename annotations from the commit message or
something (bleh!). But then, we'd probably want to update
merge-recursive in that instance to accept those "yes, it's definitely a
rename" markers, even for an empty file.

I think it would be slightly cleaner to tell diffcore-rename "be
conservative, and don't use empty files as sources" via an option. It's
not as trivial as this one-liner, but it shouldn't be much more than the
small patch you posted in the earlier thread.

-Peff
