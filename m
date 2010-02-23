From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] add-interactive: fix bogus diff header line ordering
Date: Mon, 22 Feb 2010 19:56:45 -0500
Message-ID: <20100223005645.GB3254@coredump.intra.peff.net>
References: <20100222103256.GA10557@coredump.intra.peff.net>
 <7vbpfg6h80.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 23 01:56:50 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Njj50-0006hX-CX
	for gcvg-git-2@lo.gmane.org; Tue, 23 Feb 2010 01:56:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752382Ab0BWA4p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Feb 2010 19:56:45 -0500
Received: from peff.net ([208.65.91.99]:50836 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752239Ab0BWA4o (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Feb 2010 19:56:44 -0500
Received: (qmail 4009 invoked by uid 107); 23 Feb 2010 00:56:59 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Mon, 22 Feb 2010 19:56:59 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 22 Feb 2010 19:56:45 -0500
Content-Disposition: inline
In-Reply-To: <7vbpfg6h80.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140760>

On Mon, Feb 22, 2010 at 02:25:19PM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> >  git-add--interactive.perl |   17 ++++++++++++++++-
> >  t/t2016-checkout-patch.sh |    8 ++++++++
> >  2 files changed, 24 insertions(+), 1 deletions(-)
> >
> > diff --git a/git-add--interactive.perl b/git-add--interactive.perl
> > index bfd1003..4173200 100755
> > --- a/git-add--interactive.perl
> > +++ b/git-add--interactive.perl
> > @@ -979,6 +979,21 @@ sub coalesce_overlapping_hunks {
> >  	return @out;
> >  }
> >  
> > +sub reassemble_patch {
> > +	my $head = shift;
> > +	return (
> > +		# Include everything in the header except the beginning of the
> > +		# diff.
> > +		(grep { !/^[-+]{3}/ } @$head),
> > +		# Then include any other non-diff header lines from the hunks.
> > +		(grep { !/^[@ +-]/ } @_),
> > +		# Then begin the diff.
> > +		(grep { /^[-+]{3}/ } @$head),
> > +		# And then the hunk diff lines.
> > +		(grep { /^[@ +-]/ } @_)
> 
> Hmm.  Are you handling "\No newline at the end of the file" correctly?

Nope, good catch. Maybe this should specifically be hoisting known git
header lines back into the header? Or perhaps a better logic would be to
treat each hunk individually, but just take all lines before the "@@"
hunk header? Hmm. I am not sure we would even need to treat hunks
individually...the misplaced header lines should always be part of the
_first_ hunk.

-Peff
