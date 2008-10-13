From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/4] diff: introduce diff.<driver>.binary
Date: Mon, 13 Oct 2008 00:15:25 -0400
Message-ID: <20081013041525.GA32629@coredump.intra.peff.net>
References: <20081005214114.GA21875@coredump.intra.peff.net> <20081005214336.GC21925@coredump.intra.peff.net> <48EB7D74.40302@viscovery.net> <20081007153543.GA26531@coredump.intra.peff.net> <7vabdaidwj.fsf@gitster.siamese.dyndns.org> <20081013012311.GE3768@coredump.intra.peff.net> <7vk5cddtzh.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Matthieu Moy <Matthieu.Moy@imag.fr>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Oct 13 06:16:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KpErI-0001r1-MB
	for gcvg-git-2@gmane.org; Mon, 13 Oct 2008 06:16:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751166AbYJMEP3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Oct 2008 00:15:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751280AbYJMEP3
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Oct 2008 00:15:29 -0400
Received: from peff.net ([208.65.91.99]:4226 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750858AbYJMEP2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Oct 2008 00:15:28 -0400
Received: (qmail 11443 invoked by uid 111); 13 Oct 2008 04:15:26 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Mon, 13 Oct 2008 00:15:26 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 13 Oct 2008 00:15:25 -0400
Content-Disposition: inline
In-Reply-To: <7vk5cddtzh.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98080>

On Sun, Oct 12, 2008 at 09:00:50PM -0700, Junio C Hamano wrote:

> exchange workflow?  There needs either one or both of the following:
> 
>  - A command line option to Porcelains to override textconv so that an
>    applicable binary diff can be obtained upon request (or format-patch
>    always disables textconv); and/or

format-patch should always disable textconv. I admit that I didn't test
it, but assumed it was covered under the same code path as external
diff (i.e., just not reading in the config). But it doesn't seem to be.

So that is definitely broken in my patch series. But even once that is
fixed, I agree there should be a porcelain switch for turning this off.
I sometimes do "git diff >patch" and read the result into my MUA.
Obviously I would not want textconv'ing there.

>  - You teach git-apply to use a reverse transformation of textconv, so
>    that it does, upon reception of a textconv diff:
> 
>    (1) pass existing preimage through textconv;
>    (2) apply the patch;
>    (3) convert the result back to binary.

The problem with this approach is that it requires that the textconv be
a reversible mapping. And the two motivating examples (dumping exif tags
and converting word processor documents to text) are not; they are lossy
conversions.

It's possible that one could, given the binary preimage and the two
lossy textconv'd versions, produce a custom binary merge that would just
munge the tags, or just munge the text, or whatever. But that is an
order of magnitude more work than writing a textconv, which is usually
as simple as "/path/to/existing/conversion-script".

And the whole point of this exercise was to make it simple to set this
conversion up.

> I'd say that format-patch should always disable textconv so that we won't
> have to worry about it for now.

Agreed, if you remove "for now". I had never intended for these to be
anything but a human-readable display (and while I am generally OK with
generalizing functionality when we can, I think there is real value in
the simplicity here).

If somebody really wants to send patches with converted text for
reference, I would suggest producing a patch with the textconv'd output
as a comment, and including the full binary patch to actually be
applied (and yes, obviously they a malicious attacker could make them
not match, but given the binary patch, we can trivially regenerate the
textconv'd version and confirm it).

-Peff
