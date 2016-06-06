From: Jeff King <peff@peff.net>
Subject: Re: [PATCH V2 3/3] strbuf: allow to use preallocated memory
Date: Mon, 6 Jun 2016 19:30:30 -0400
Message-ID: <20160606233030.GB23537@sigill.intra.peff.net>
References: <20160606151340.22424-1-william.duclot@ensimag.grenoble-inp.fr>
 <20160606151340.22424-4-william.duclot@ensimag.grenoble-inp.fr>
 <xmqqvb1mxmk4.fsf@gitster.mtv.corp.google.com>
 <20160606203901.GA7667@Messiaen>
 <xmqqfusquedk.fsf@gitster.mtv.corp.google.com>
 <20160606225847.GA22756@sigill.intra.peff.net>
 <xmqqbn3dvr22.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: William Duclot <william.duclot@ensimag.grenoble-inp.fr>,
	git@vger.kernel.org, antoine.queru@ensimag.grenoble-inp.fr,
	francois.beutin@ensimag.grenoble-inp.fr, mhagger@alum.mit.edu,
	Johannes.Schindelin@gmx.de, mh@glandium.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 07 01:30:59 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bA3z0-0001bC-H0
	for gcvg-git-2@plane.gmane.org; Tue, 07 Jun 2016 01:30:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753308AbcFFXao (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jun 2016 19:30:44 -0400
Received: from cloud.peff.net ([50.56.180.127]:50043 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752474AbcFFXad (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Jun 2016 19:30:33 -0400
Received: (qmail 1177 invoked by uid 102); 6 Jun 2016 23:30:33 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 06 Jun 2016 19:30:33 -0400
Received: (qmail 23794 invoked by uid 107); 6 Jun 2016 23:30:41 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 06 Jun 2016 19:30:41 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 06 Jun 2016 19:30:30 -0400
Content-Disposition: inline
In-Reply-To: <xmqqbn3dvr22.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296577>

On Mon, Jun 06, 2016 at 04:24:53PM -0700, Junio C Hamano wrote:

> This is not about stack vs heap or even "cheaper" (whatever your
> definition of cheap is).  The principle applies equally if the
> original buffer came from BSS.
> 
> Perhaps I made it clearer by using a more exaggerated example e.g. a
> typical expected buffer size of 128 bytes, but the third line of
> 1000 line input file was an anomaly that is 200k bytes long.  I do
> not want to keep that 200k bytes after finishing to process that
> third line while using its initial 80 bytes for the remaining 977
> lines.

Ah, I see. Yes, I can see that argument, though I'd counter that since
we _did_ see a 200k entry, perhaps the hint given in the code is not
actually very sensible. Having seen one big line, might we expect to see
more?

I dunno. I still feel like this whole thing is just micro-optimization
that is not even really going to be measurable outside of pathological
cases.

> By the way, William seemed to be unhappy with die(), but I actually
> think having a die() in the API may not be a bad thing if the check
> were about something more sensible.  For example, even if a strbuf
> that can grow dynamically, capping the maximum size and say "Hey
> this is a one-lne-at-a-time text interface; if we need to grow the
> buffer to 10MB, there is something wrong and a producer of such an
> input does not even deserve a nice error message" could be an
> entirely sensible attitude.  But that does not mean an initial
> allocation should be 10MB.  If the expected typical workload fits
> within a lot lower bound, starting from there and allowing it to
> grow up to that maximum would be the more natural thing to do.

Yes, I very much agree that "sensible limits" should not be the same
thing as "initial allocated sizes". It is easy to conflate the two when
using static buffers (because it lets you skip allocation entirely,
which is much simpler!), but that usually leads to "sensible limits"
being set way too low as a compromise.

-Peff
