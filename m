From: Jeff King <peff@peff.net>
Subject: Re: Fwd: Git and Large Binaries: A Proposed Solution
Date: Thu, 10 Mar 2011 17:24:43 -0500
Message-ID: <20110310222443.GC15828@sigill.intra.peff.net>
References: <AANLkTin=UySutWLS0Y7OmuvkE=T=+YB8G8aUCxLH=GKa@mail.gmail.com>
 <AANLkTimPua_kz2w33BRPeTtOEWOKDCsJzf0sqxm=db68@mail.gmail.com>
 <20110121222440.GA1837@sigill.intra.peff.net>
 <20110123141417.GA6133@mew.padd.com>
 <4D793C7D.1000502@miseler.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Pete Wyckoff <pw@padd.com>, git@vger.kernel.org,
	emontellese@gmail.com, schacon@gmail.com, joey@kitenet.net
To: Alexander Miseler <alexander@miseler.de>
X-From: git-owner@vger.kernel.org Thu Mar 10 23:24:52 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PxoHr-0003YT-2A
	for gcvg-git-2@lo.gmane.org; Thu, 10 Mar 2011 23:24:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753437Ab1CJWYo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Mar 2011 17:24:44 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:36346
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750980Ab1CJWYn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Mar 2011 17:24:43 -0500
Received: (qmail 31663 invoked by uid 107); 10 Mar 2011 22:25:14 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 10 Mar 2011 17:25:14 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 10 Mar 2011 17:24:43 -0500
Content-Disposition: inline
In-Reply-To: <4D793C7D.1000502@miseler.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168857>

On Thu, Mar 10, 2011 at 10:02:53PM +0100, Alexander Miseler wrote:

> I've been debating whether to resurrect this thread, but since it has
> been referenced by the SoC2011Ideas wiki article I will just go ahead.
> I've spent a few hours trying to make this work to make git with big
> files usable under Windows.
> 
> > Just a quick aside.  Since (a2b665d, 2011-01-05) you can provide
> > the filename as an argument to the filter script:
> > 
> >     git config --global filter.huge.clean huge-clean %f
> > 
> > then use it in place:
> > 
> >     $ cat >huge-clean 
> >     #!/bin/sh
> >     f="$1"
> >     echo orig file is "$f" >&2
> >     sha1=`sha1sum "$f" | cut -d' ' -f1`
> >     cp "$f" /tmp/big_storage/$sha1
> >     rm -f "$f"
> >     echo $sha1
> > 
> > 		-- Pete

After thinking about this strategy more (the "convert big binary files
into a hash via clean/smudge filter" strategy), it feels like a hack.
That is, I don't see any reason that git can't give you the equivalent
behavior without having to resort to bolted-on scripts.

For example, with this strategy you are giving up meaningful diffs in
favor of just showing a diff of the hashes. But git _already_ can do
this for binary diffs.  The problem is that git unnecessarily uses a
bunch of memory to come up with that answer because of assumptions in
the diff code. So we should be fixing those assumptions. Any place that
this smudge/clean filter solution could avoid looking at the blobs, we
should be able to do the same inside git.

Of course that leaves the storage question; Scott's git-media script has
pluggable storage that is backed by http, s3, or whatever. But again,
that is a feature that might be worth putting into git (even if it is
just a pluggable script at the object-db level).

-Peff
