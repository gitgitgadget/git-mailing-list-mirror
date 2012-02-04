From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 0/9] respect binary attribute in grep
Date: Sat, 4 Feb 2012 18:18:25 -0500
Message-ID: <20120204231825.GA1170@sigill.intra.peff.net>
References: <20120201221437.GA19044@sigill.intra.peff.net>
 <20120201232109.GA2652@sigill.intra.peff.net>
 <7vhaza12ol.fsf@alter.siamese.dyndns.org>
 <20120202005209.GA6883@sigill.intra.peff.net>
 <20120202081747.GA10271@sigill.intra.peff.net>
 <20120204192252.GA15319@padd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>,
	Conrad Irwin <conrad.irwin@gmail.com>, git@vger.kernel.org,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Dov Grobgeld <dov.grobgeld@gmail.com>
To: Pete Wyckoff <pw@padd.com>
X-From: git-owner@vger.kernel.org Sun Feb 05 00:18:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RtosL-0005ER-4Z
	for gcvg-git-2@plane.gmane.org; Sun, 05 Feb 2012 00:18:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753509Ab2BDXS2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 Feb 2012 18:18:28 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:57849
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750815Ab2BDXS2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Feb 2012 18:18:28 -0500
Received: (qmail 13206 invoked by uid 107); 4 Feb 2012 23:25:34 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 04 Feb 2012 18:25:34 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 04 Feb 2012 18:18:25 -0500
Content-Disposition: inline
In-Reply-To: <20120204192252.GA15319@padd.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189919>

On Sat, Feb 04, 2012 at 02:22:52PM -0500, Pete Wyckoff wrote:

> I took a look at this series.  It's nice.  My worry was that the
> extra open() of non-existent .gitattributes files in all the
> directories would cause performance problems across networked
> filesystems like NFS.

Yeah, I was able to measure a small slow-down on a quick grep even with
a warm cache. So it does take some extra effort, but I think the
correctness is worth it (and note that the slow down is in the tens of
milliseconds if you have a reasonable stat()).

If people have big trees on NFS (or some other slow-stat system) where
these lookups are actually a problem, I'd rather see a global option to
disable .gitattributes lookups for both diff and grep (i.e., a "trust
me, I'm not using gitattributes, and don't bother with stat" flag). In
practice, though, I think such a thing is not necessary because the
stat() is local to the file being examined (e.g., for "foo/bar/baz", we
look only at "foo/bar/.gitattributes", "foo/.gitattributes", and
".gitattributes", without having to touch other parts of the tree).

Anyway, thanks for doing some performance testing. More data is always
good.

> It could be plausible that deep directory structures with few
> grep-able files will suffer with this change.  For example, many
> big binary blobs in deep directory hierarchies, but also some
> useful files here and there.
>
> One could argue that with the use of .gitattributes to specify
> which blobs should not be searched, this series makes this faster
> by not having to to read the binary blobs at all.  And I'd be
> okay with that.

Yes, exactly. I think this will end up being a big win for such cases,
because the cost of loading even one large binary file from disk will
dwarf all of the stats. But it does depend on people marking their
binaries and using "-I".

-Peff
