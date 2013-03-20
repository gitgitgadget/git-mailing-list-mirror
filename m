From: Jeff King <peff@peff.net>
Subject: Re: USE_NSEC bug?
Date: Wed, 20 Mar 2013 13:09:57 -0400
Message-ID: <20130320170957.GA21350@sigill.intra.peff.net>
References: <CABFQKmP6=Thhph4Ug+4LOBmzsVK42qBQYW2QHw87QD3019n+Kw@mail.gmail.com>
 <20130320075344.GA8159@sigill.intra.peff.net>
 <7vppyuf1f5.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Andrew Rodland <andrew@cleverdomain.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 20 18:10:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UIMX4-0008HG-Gt
	for gcvg-git-2@plane.gmane.org; Wed, 20 Mar 2013 18:10:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932312Ab3CTRKE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Mar 2013 13:10:04 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:60248 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932082Ab3CTRKD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Mar 2013 13:10:03 -0400
Received: (qmail 9543 invoked by uid 107); 20 Mar 2013 17:11:47 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 20 Mar 2013 13:11:47 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 20 Mar 2013 13:09:57 -0400
Content-Disposition: inline
In-Reply-To: <7vppyuf1f5.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218620>

On Wed, Mar 20, 2013 at 10:04:14AM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > But maybe there is some subtle reason I'm missing for having the two
> > options separate.
> 
> The closest I found was c06ff4908bf9 (Record ns-timestamps if
> possible, but do not use it without USE_NSEC, 2009-03-04).
> 
> commit c06ff4908bf9ad8bf2448439a3574321c9399b17
> Author: Kjetil Barvik <barvik@broadpark.no>
> Date:   Wed Mar 4 18:47:40 2009 +0100
> 
>     Record ns-timestamps if possible, but do not use it without USE_NSEC
>     
>     Traditionally, the lack of USE_NSEC meant "do not record nor use the
>     nanosecond resolution part of the file timestamps".  To avoid problems on
>     filesystems that lose the ns part when the metadata is flushed to the disk
>     and then later read back in, disabling USE_NSEC has been a good idea in
>     general.
>     
>     If you are on a filesystem without such an issue, it does not hurt to read
>     and store them in the cached stat data in the index entries even if your
>     git is compiled without USE_NSEC.  The index left with such a version of
>     git can be read by git compiled with USE_NSEC and it can make use of the
>     nanosecond part to optimize the check to see if the path on the filesystem
>     hsa been modified since we last looked at.

Thanks, I suspected that might be the reason. IMHO it is not a big win,
as you would just refresh the index when using the version compiled with
USE_NSEC (so it really only helps you if you are frequently switching
between the two versions, which seems silly).

And the cost is that we have another Makefile knob people need to tweak
that would not otherwise need to be there. Which can be annoying, but is
also not that huge a cost to deal with (we might want to improve the
configure script or something, though).

I admit I don't care too much either way.

-Peff
