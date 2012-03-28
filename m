From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] git: continue alias lookup on EACCES errors
Date: Wed, 28 Mar 2012 15:38:11 -0400
Message-ID: <20120328193811.GA29019@sigill.intra.peff.net>
References: <20120327175933.GA1716@sigill.intra.peff.net>
 <20120327180503.GB4659@sigill.intra.peff.net>
 <7v4nt9j1m3.fsf@alter.siamese.dyndns.org>
 <20120328043058.GD30251@sigill.intra.peff.net>
 <7vaa30wrjx.fsf@alter.siamese.dyndns.org>
 <20120328174841.GA27876@sigill.intra.peff.net>
 <20120328180404.GA9052@burratino>
 <7v1uocwpap.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	James Pickens <jepicken@gmail.com>,
	Git ML <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 28 21:38:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SCyhH-0007NQ-88
	for gcvg-git-2@plane.gmane.org; Wed, 28 Mar 2012 21:38:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758119Ab2C1TiO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Mar 2012 15:38:14 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:36267
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758027Ab2C1TiN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Mar 2012 15:38:13 -0400
Received: (qmail 20530 invoked by uid 107); 28 Mar 2012 19:38:32 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 28 Mar 2012 15:38:32 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 28 Mar 2012 15:38:11 -0400
Content-Disposition: inline
In-Reply-To: <7v1uocwpap.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194170>

On Wed, Mar 28, 2012 at 11:31:10AM -0700, Junio C Hamano wrote:

> > If I understood Junio correctly, then checking for ENOENT and EACCES
> > should be enough.
> >
> > Example: when I try
> >
> >  :; mkdir $HOME/cannotread
> >  :; chmod -x $HOME/cannotread
> >  :; echo nonsense >$HOME/bin/cat
> >  :; chmod -x $HOME/bin/cat
> >  :; PATH=$HOME/cannotread:$HOME/bin/cat:/usr/local/bin:/usr/bin:/bin
> >  :; cat /etc/fstab
> >
> > the shell uses /bin/cat without complaint.
> 
> Yeah, but I think that the case Peff is worried about is:
> 
>         $ >~/bin/nosuch
>         $ nosuch
>         nosuch: Permission denied

Right. My reading of your suggestion was that we would differentiate
those two cases, which one cannot do simply from the return value and
errno after execvp. The former case (inaccessible directory) is common
and probably harmless. The latter (non-executable file) is rare and
probably an actual error we should point out.

I'd also be OK with saying that the latter is too rare to worry about,
and simply accept it as collateral damage (or we could even flag it with
test_expect_failure and leave it for somebody else to work on later if
they care).

-Peff
