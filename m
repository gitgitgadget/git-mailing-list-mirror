From: bdowning@lavos.net (Brian Downing)
Subject: Re: [PATCH 1/2] Make xdiff_outf_{init,release} interface
Date: Wed, 13 Aug 2008 21:06:14 -0500
Message-ID: <20080814020614.GD4396@lavos.net>
References: <20080813070508.GB4396@lavos.net> <7vljz0iftm.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 14 04:07:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KTSFL-0001kj-Hz
	for gcvg-git-2@gmane.org; Thu, 14 Aug 2008 04:07:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751946AbYHNCGV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Aug 2008 22:06:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751934AbYHNCGV
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Aug 2008 22:06:21 -0400
Received: from qmta04.westchester.pa.mail.comcast.net ([76.96.62.40]:48452
	"EHLO QMTA04.westchester.pa.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751784AbYHNCGV (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 13 Aug 2008 22:06:21 -0400
Received: from OMTA02.westchester.pa.mail.comcast.net ([76.96.62.19])
	by QMTA04.westchester.pa.mail.comcast.net with comcast
	id 1nNB1a0080QuhwU5426FQw; Thu, 14 Aug 2008 02:06:15 +0000
Received: from mnementh.lavos.net ([98.212.138.194])
	by OMTA02.westchester.pa.mail.comcast.net with comcast
	id 226F1a0094BqYqi3N26Ftk; Thu, 14 Aug 2008 02:06:15 +0000
X-Authority-Analysis: v=1.0 c=1 a=90hKlV7EDiYA:10 a=mbLt6yIQpawA:10
 a=zuFRn8y_ESSqb4kEZGYA:9 a=5E2lgxW02wN3V5MD-VsA:7
 a=YBMNz9E2VV8DXKN76gfF8R-qFZkA:4 a=GB4YReQY-hoA:10 a=LY0hPdMaydYA:10
Received: by mnementh.lavos.net (Postfix, from userid 1000)
	id E7C84309F23; Wed, 13 Aug 2008 21:06:14 -0500 (CDT)
Content-Disposition: inline
In-Reply-To: <7vljz0iftm.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92307>

On Wed, Aug 13, 2008 at 05:46:29PM -0700, Junio C Hamano wrote:
> Brian Downing <bdowning@lavos.net> writes:
> > @@ -103,6 +110,10 @@ int xdiff_outf(void *priv_, mmbuffer_t *mb, int nbuf)
> >  	return 0;
> >  }
> >  
> > +void xdiff_outf_release(void *priv_)
> > +{
> > +}
> > +
> 
> It might make it more clear to have this function take a pointer to
> "struct xdiff_emit_state", which is always the first member of the
> callback private data structure.

That makes the call sites (slightly) more complicated, in that instead
of:
	xdiff_outf_release(&state);
you'd want:
	xdiff_outf_release(&state.xm);

That was not the typical usage before, in that it said "ecb.priv =
&state" rather than "ecb.priv = &state.xm", and I used the void *
argument to mirror that, but I can change it if it'd be preferable.
 
> Although I wish xdi_diff() could do the necessary clean-up immediately
> before it returns (so that the caller did not have to do anything
> special), it is not possible to do so cleanly, because there are
> "outf" implementations other than xdiff_outf that do not even use
> "struct xdiff_emit_state" in their callbacks.  So I think your patch
> makes sense.

Well, I could do something like:

	if (xecb->outf == xdiff_outf)
		/* xdiff_outf cleanup */

at the end of xdi_diff, but that's... kind of horrible I think.

For that matter, I could just make an xdi_outf_diff function that would
take the state in addition to the other xdi_diff arguments and go ahead
and set it up, do the diff, and tear it down in one step.  Maybe that
would be better if it works for everywhere this style of diff needs to
be called.

Another question:  should I go ahead and make xdiff_outf itself static?

-bcd
