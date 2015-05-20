From: Jeff King <peff@peff.net>
Subject: Re: [PUB]corrupt repos does not return error with `git fsck`
Date: Wed, 20 May 2015 14:31:15 -0400
Message-ID: <20150520183115.GB7142@peff.net>
References: <alpine.DEB.2.11.1505202142540.9343@orwell.homelinux.org>
 <vpq382rkvzf.fsf@anie.imag.fr>
 <d21002e0fa92b03c3d417c8996328563@www.dscho.org>
 <CAGZ79kZY68HFDipxLVas9Dg9+NfpOGmywpWfwFL31A0EpLmJFw@mail.gmail.com>
 <20150520182218.GD14561@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Faheem Mitha <faheem@faheem.info>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Wed May 20 20:31:24 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yv8m3-0006hH-KD
	for gcvg-git-2@plane.gmane.org; Wed, 20 May 2015 20:31:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932137AbbETSbT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 May 2015 14:31:19 -0400
Received: from cloud.peff.net ([50.56.180.127]:33308 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932115AbbETSbS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 May 2015 14:31:18 -0400
Received: (qmail 13346 invoked by uid 102); 20 May 2015 18:31:17 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 20 May 2015 13:31:17 -0500
Received: (qmail 25378 invoked by uid 107); 20 May 2015 18:31:19 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 20 May 2015 14:31:19 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 20 May 2015 14:31:15 -0400
Content-Disposition: inline
In-Reply-To: <20150520182218.GD14561@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269491>

On Wed, May 20, 2015 at 02:22:19PM -0400, Jeff King wrote:

> On Wed, May 20, 2015 at 11:02:14AM -0700, Stefan Beller wrote:
> 
> > $ git clone https://github.com/fmitha/SICL
> > cd SICL
> > $ git show 280c12ab49223c64c6f914944287a7d049cf4dd0
> > fatal: bad object 280c12ab49223c64c6f914944287a7d049cf4dd0
> > $ git show 12323213123 # just to be sure to have a different error
> > message for non existing objects.
> > fatal: ambiguous argument '12323213123': unknown revision or path not
> > in the working tree.
> 
> Yeah, this is well-known. If you give a partial hash, the error comes
> from get_sha1(), which says "hey, this doesn't look like anything I know
> about". If you feed a whole hash, we skip all that and say "well, you
> _definitely_ meant this sha1", and then later code complains when it
> cannot be read.
> 
> We could add a has_sha1_file() check in get_sha1 for this case. I can't
> think offhand of any reason it would need to be called with a
> non-existent object, but there may be some lurking corner case (e.g.,
> "cat-file -e" or something).

I should have looked before replying. It would indeed break "cat-file
-e" horribly. So the right answer may be to just improve the "bad
object" message (probably by checking has_sha1_file there and diagnosing
it either as missing or corrupted).

-Peff
