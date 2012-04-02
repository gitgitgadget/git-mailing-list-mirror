From: Jeff King <peff@peff.net>
Subject: Re: GSoC - Some questions on the idea of
Date: Mon, 2 Apr 2012 17:07:08 -0400
Message-ID: <20120402210708.GA28926@sigill.intra.peff.net>
References: <CA+M5ThS2iS-NMNDosk2oR25N=PMJJVTi1D=zg7MnMCUiRoX4BQ@mail.gmail.com>
 <CACsJy8APtMsMJ=FrZjOP=DbzuFoemSLJTmkjaiK5Wkq9XtA4rg@mail.gmail.com>
 <loom.20120328T131530-717@post.gmane.org>
 <CA+M5ThTPyic=RhFL2SvuNB0xBWOHxNTaUZrYMB144UjpjCiLoQ@mail.gmail.com>
 <20120330203430.GB20376@sigill.intra.peff.net>
 <CA+M5ThR6jtxqs0-Kz-8fcRuOFRbLr-GvsJcTmrOQ7_geNspDLg@mail.gmail.com>
 <4F76E430.6020605@gmail.com>
 <4F772E48.3030708@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Sergio Callegari <sergio.callegari@gmail.com>,
	Bo Chen <chen@chenirvine.org>, git@vger.kernel.org
To: Neal Kreitzinger <nkreitzinger@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 02 23:07:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SEoT6-00089x-Pg
	for gcvg-git-2@plane.gmane.org; Mon, 02 Apr 2012 23:07:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752554Ab2DBVHL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Apr 2012 17:07:11 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:43564
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750962Ab2DBVHK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Apr 2012 17:07:10 -0400
Received: (qmail 21788 invoked by uid 107); 2 Apr 2012 21:07:11 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 02 Apr 2012 17:07:11 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 02 Apr 2012 17:07:08 -0400
Content-Disposition: inline
In-Reply-To: <4F772E48.3030708@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194564>

On Sat, Mar 31, 2012 at 11:18:16AM -0500, Neal Kreitzinger wrote:

> On 3/31/2012 6:02 AM, Sergio Callegari wrote:
> >I wonder if it could make sense to have some pluggable mechanism for
> > file splitting. Something under the lines of filters, so to say.
> >Bupsplit can be a rather general mechanism, but large binaries that
> >are containers (zip, jar, docx, tgz, pdf - seen as a collection of
> >streams) may possibly be more conveniently split by their inherent
> >components.
> >
> 
> gitattributes or gitconfig could configure the big-file handler for
> specified files.  Known/supported filetypes like gif, png, zip, pdf,
> etc., could be auto-configured by git.  Any
> yet-unknown/yet-unsupported filetypes could be configured manually by
> the user, e.g.
> *.zgp=bigcontainer

This is a tempting route (and one I've even suggested myself before),
but I think ultimately it is a bad way to go. The problem is that
splitting is only half of the equation. Once you have split contents,
you have to use them intelligently, which means looking at the sha1s of
each split chunk and discarding whole chunks as "the same" without even
looking at the contents.

Which means that it is very important that your chunking algorithm
remain stable from version to version. A change in the algorithm is
going to completely negate the benefits of chunking in the first place.
So something configurable, or something that is not applied consistently
(because it depends on each user's git config, or even on the specific
version of a tool used) can end up being no help at all.

Properly applied, I think a content-aware chunking algorithm could
out-perform a generic one. But I think we need to first find out exactly
how well the generic algorithm can perform. It may be "good enough"
compared to the hassle that inconsistent application of a content-aware
algorithm will cause.  So I wouldn't rule it out, but I'd rather try the
bup-style splitting first, and see how good (or bad) it is.

-Peff
