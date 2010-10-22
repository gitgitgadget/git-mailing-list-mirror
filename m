From: Jeff King <peff@peff.net>
Subject: Re: [RFC] Print diffs of UTF-16 to console / patches to email as
 UTF-8...?
Date: Fri, 22 Oct 2010 15:13:39 -0400
Message-ID: <20101022191339.GA13581@sigill.intra.peff.net>
References: <1287763608.31218.63.camel@drew-northup.unet.maine.edu>
 <20101022161851.GH9224@burratino>
 <E7645863-A3AD-4EE1-AF6B-71C50A859619@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Drew Northup <drew.northup@maine.edu>,
	Git mailing list <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Joshua Juran <jjuran@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 22 21:13:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P9N3P-0004qn-IQ
	for gcvg-git-2@lo.gmane.org; Fri, 22 Oct 2010 21:13:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759347Ab0JVTM7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Oct 2010 15:12:59 -0400
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:43592 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752672Ab0JVTM5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Oct 2010 15:12:57 -0400
Received: (qmail 22391 invoked by uid 111); 22 Oct 2010 19:12:54 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Fri, 22 Oct 2010 19:12:54 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 22 Oct 2010 15:13:39 -0400
Content-Disposition: inline
In-Reply-To: <E7645863-A3AD-4EE1-AF6B-71C50A859619@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159733>

On Fri, Oct 22, 2010 at 11:28:44AM -0700, Joshua Juran wrote:

> >What's wrong with .gitattributes for this use case?  I would think a
> >clean/smudge filter would produce very good behavior from most git
> >commands.
> 
> I wrote a Mac<->UTF-8 converter in C++ and set it as the clean/smudge
> filter for .r (Rez) files.  Checkouts were noticeably slower (on a
> real machine, not one of my antiques).  This would be much worse if I
> also applied it to C and C++ source files (most, but not all, of
> which are ASCII anyway).

Not surprising, as you were probably running your filter a lot. Clean
and smudge could perhaps benefit from the same notes-caching layer that
textconv uses (caching the "smudged" version of each clean file).

But that would only impact checkout. Most other operations use the
"clean" representation already, so they should be full-speed.

You could also cache the other way (mapping smudged sha1's into clean
sha1's). But I doubt that would do you any good. We generally see those
when updating the index with "git add", which means either the stat
information is clean (and we don't have the clean the file) or it isn't
(in which case you probably have new content that has not been seen
before, which means a cache miss).

And of course it doesn't help the other clean/smudge inconveniences you
ran into.

-Peff
