From: Pete Wyckoff <pw@padd.com>
Subject: Re: [PATCH 0/9] respect binary attribute in grep
Date: Sat, 4 Feb 2012 14:22:52 -0500
Message-ID: <20120204192252.GA15319@padd.com>
References: <20120201221437.GA19044@sigill.intra.peff.net>
 <20120201232109.GA2652@sigill.intra.peff.net>
 <7vhaza12ol.fsf@alter.siamese.dyndns.org>
 <20120202005209.GA6883@sigill.intra.peff.net>
 <20120202081747.GA10271@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>,
	Conrad Irwin <conrad.irwin@gmail.com>, git@vger.kernel.org,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Dov Grobgeld <dov.grobgeld@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Feb 04 20:23:29 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RtlCq-0001UV-Qo
	for gcvg-git-2@plane.gmane.org; Sat, 04 Feb 2012 20:23:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754219Ab2BDTW4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 Feb 2012 14:22:56 -0500
Received: from honk.padd.com ([74.3.171.149]:57955 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753601Ab2BDTW4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Feb 2012 14:22:56 -0500
Received: from arf.padd.com (unknown [50.55.145.32])
	by honk.padd.com (Postfix) with ESMTPSA id BC89F20D2;
	Sat,  4 Feb 2012 11:22:54 -0800 (PST)
Received: by arf.padd.com (Postfix, from userid 7770)
	id 8F5A631453; Sat,  4 Feb 2012 14:22:52 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <20120202081747.GA10271@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189893>

I took a look at this series.  It's nice.  My worry was that the
extra open() of non-existent .gitattributes files in all the
directories would cause performance problems across networked
filesystems like NFS.

My usual (non-public) repository has order:

    100k files
     10k directories

and no files marked as binary.  The grep string is such that it
is disk-bound, and not expected to match in any file (or binary):
"time ~/src/git/bin-wrappers/git grep unfindable-string".

With your change, there are 10k new open() calls looking for
.gitattributes in each directory, all of which return ENOENT.
This turns out to have an insignificant impact on performance due
to the much bigger time sink of stat()-ing all the files.

I think this happens to be true because the gitattributes lookups
run in parallel to all the file stat work, as the main thread
dispatches file work while doing its own gitattributes lookups.

It could be plausible that deep directory structures with few
grep-able files will suffer with this change.  For example, many
big binary blobs in deep directory hierarchies, but also some
useful files here and there.

One could argue that with the use of .gitattributes to specify
which blobs should not be searched, this series makes this faster
by not having to to read the binary blobs at all.  And I'd be
okay with that.

Just FYI that there may be a performance impact on certain
repositories.

		-- Pete
