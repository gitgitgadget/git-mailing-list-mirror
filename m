From: Jeff King <peff@peff.net>
Subject: Re: Segmentation fault found while fuzzing .pack file under 2.7.0.rc3
Date: Wed, 6 Jan 2016 02:23:22 -0500
Message-ID: <20160106072321.GA18477@sigill.intra.peff.net>
References: <568BC8D1.3080201@gmail.com>
 <20160105152436.GA1205@sigill.intra.peff.net>
 <20160106002333.GA16090@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jacek Wielemborek <d33tah@gmail.com>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 06 08:23:33 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aGiRN-0005MO-Ub
	for gcvg-git-2@plane.gmane.org; Wed, 06 Jan 2016 08:23:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752091AbcAFHX0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Jan 2016 02:23:26 -0500
Received: from cloud.peff.net ([50.56.180.127]:49316 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751989AbcAFHXZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jan 2016 02:23:25 -0500
Received: (qmail 23572 invoked by uid 102); 6 Jan 2016 07:23:25 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 06 Jan 2016 02:23:25 -0500
Received: (qmail 24832 invoked by uid 107); 6 Jan 2016 07:23:39 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 06 Jan 2016 02:23:39 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 06 Jan 2016 02:23:22 -0500
Content-Disposition: inline
In-Reply-To: <20160106002333.GA16090@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283417>

On Tue, Jan 05, 2016 at 04:23:33PM -0800, Jonathan Nieder wrote:

> > Git packfiles come from two places:
> >
> >   1. Local maintenance repacks loose and already-packed objects into a
> >      new packfile. We trust the local repack process to generate a valid
> >      packfile (though the contents of individual objects may be
> >      untrusted, of course).
> 
> I think we should reconsider such trust.  If one user creates a
> malicious pack, if another user uses read-only git commands to access
> the repository (after inspecting .git/config to make sure it doesn't
> contain anything scary) the result should not be arbitrary code
> execution.
> 
> Producing bogus output or aborting is okay; arbitrary code execution
> less so.

I agree it is better if we can meet this standard, and I didn't mean to
discourage fixes in the area. But I do think it is worth classifying
them differently than bugs that can be triggered via the network. The
attack surface for on-disk attacks is much larger, and the number of
people affected is much smaller.

Regarding your example, I'm not sure it's the best motivating example,
as I imagine hardly anyone examines .git/config. :) A simplified one
might be that:

  git fetch me@shared-server:/home/you/foo.git

is running git-upload-pack as me on packfiles created by you (on the
server). We normally expect that to be a "safe" operation (and it is if
done over git:// or similar).

-Peff
