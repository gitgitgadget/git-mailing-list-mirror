From: Jeff King <peff@peff.net>
Subject: Re: Git on Windows, CRLF issues
Date: Wed, 23 Apr 2008 17:47:45 -0400
Message-ID: <20080423214745.GA30057@sigill.intra.peff.net>
References: <alpine.DEB.1.00.0804212145570.21181@perkele.intern.softwolves.pp.se> <alpine.DEB.1.00.0804212104560.2298@eeepc-johanness> <32541b130804211453x77f3fd49hef645a417a9919ca@mail.gmail.com> <20080422023918.GA5402@sigill.intra.peff.net> <32541b130804220951p224c9be7ya4e8de5056481fd1@mail.gmail.com> <20080423080826.GA11935@sigill.intra.peff.net> <480F1671.2060602@viscovery.net> <20080423110402.GA27437@sigill.intra.peff.net> <480F218C.3060703@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Avery Pennarun <apenwarr@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Peter Karlsson <peter@softwolves.pp.se>, git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Wed Apr 23 23:48:35 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JompO-0002mn-UB
	for gcvg-git-2@gmane.org; Wed, 23 Apr 2008 23:48:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752937AbYDWVrq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Apr 2008 17:47:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752517AbYDWVrq
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Apr 2008 17:47:46 -0400
Received: from peff.net ([208.65.91.99]:3205 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751860AbYDWVro (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Apr 2008 17:47:44 -0400
Received: (qmail 30159 invoked by uid 111); 23 Apr 2008 21:47:42 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Wed, 23 Apr 2008 17:47:42 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 23 Apr 2008 17:47:45 -0400
Content-Disposition: inline
In-Reply-To: <480F218C.3060703@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80262>

On Wed, Apr 23, 2008 at 01:46:20PM +0200, Johannes Sixt wrote:

> > I assume you are wanting to do something like:
> > 
> >   git filter-branch --blob-filter '
> >     case "$1" in
> >       *.jpg) cat ;;
> >           *) tr a-z A-Z ;;
> >     esac
> >   '
> > 
> > Obviously it is unlikely to get the same blob sha1 as "foo.jpg" and
> > "foo.txt", but it just feels a little wrong.
> 
> Yes, that's how I intended it to work. What's wrong here? The fact that a
> user might name a JPEG foo.txt instead of foo.jpg? Or that the same blob
> might appear with entirely different names, including different suffixes?
> Well, tough luck. Use an index filter. But without any sort of hint what
> the blob is about, your original --blob-filter is useless except for the
> most simplistic repositories.

Yes, the script produces incorrect results if you have the same blob
with different names. IOW, if I accidentally add a JPEG as 'foo', and
then later rename it to 'foo.jpg', it will munge the blob the first time
it sees it, and then use the munged value for 'foo.jpg', since we never
even run the case statement. Yes, this is not terribly likely, but it
does seem like an awful (and hard to diagnose!) bug to have hiding in
the script.

The correct fix is either:

  - the blob cache needs to take into account sha1 _and_ path

  - the cache lookup needs to be _inside_ the path filter. In that case
    you would either have to support it in the script (e.g.,
    --blob-ignore jpg), or you could make the caching an optional part
    of the blob filter (the way you can call 'map' explicitly from your
    filters).

-Peff
