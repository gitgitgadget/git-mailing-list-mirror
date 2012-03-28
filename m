From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] git: continue alias lookup on EACCES errors
Date: Wed, 28 Mar 2012 13:48:42 -0400
Message-ID: <20120328174841.GA27876@sigill.intra.peff.net>
References: <20120327175933.GA1716@sigill.intra.peff.net>
 <20120327180503.GB4659@sigill.intra.peff.net>
 <7v4nt9j1m3.fsf@alter.siamese.dyndns.org>
 <20120328043058.GD30251@sigill.intra.peff.net>
 <7vaa30wrjx.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: James Pickens <jepicken@gmail.com>, Git ML <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 28 19:48:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SCwzN-0001FW-2d
	for gcvg-git-2@plane.gmane.org; Wed, 28 Mar 2012 19:48:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932487Ab2C1Rss (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Mar 2012 13:48:48 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:36172
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932434Ab2C1Rss (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Mar 2012 13:48:48 -0400
Received: (qmail 19281 invoked by uid 107); 28 Mar 2012 17:49:05 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 28 Mar 2012 13:49:05 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 28 Mar 2012 13:48:42 -0400
Content-Disposition: inline
In-Reply-To: <7vaa30wrjx.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194151>

On Wed, Mar 28, 2012 at 10:42:26AM -0700, Junio C Hamano wrote:

> > Yes, though I held back on writing tests, because I don't think we've
> > quite decided what the behavior _should_ be. Should we be
> > differentiating "chmod -x /bin/ls" from "chmod -x /bin"? Should we be
> > continuing alias lookup on EACCES? Should we print edit-distance
> > suggestions on EACCES?
> 
> I am leaning to think that it would be the least surprising if we treat as
> if /bin/ls does not even exist if /bin is not searchable.  If /bin/ls is
> unreadable or unexecutable but /bin is searchable, then we _know_ it
> exists, and we follow the usual exec*p() rule to ignore it so "git ls"
> would try to find an alias and when all else fails will give the edit
> distance suggestions but should exclude /bin/ls from candidates.  If /bin
> itself is unsearchable, we do not even know what it contains, so it is
> needless to say that /bin/ls will not be part of suggestion candidates.

That sounds sensible to me. I think it involves writing our own
execvp, though, right? If we use stock execvp, we can't tell the
difference between the two cases. OTOH, I think we already have an
implementation in compat/mingw.

> That way, the only thing people _could_ complain about is "I have a
> directory $HOME/sillybin in my $PATH but do not have an executable bit on
> it.  When I try to run 'git stupid', 'git-stupid' in that diretory is not
> executed, and I do not even get an error message to point out that I am
> missing the executable bit on $HOME/sillybin directory".  And you can say
> "Ah, just like the shell.  So make sure you have necessary permission bits
> on things".  Very easy and straightforward to explain and understand.

Agreed.

-Peff
