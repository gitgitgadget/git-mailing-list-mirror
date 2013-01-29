From: Jeff King <peff@peff.net>
Subject: [PATCH/RFC 0/6] commit caching
Date: Tue, 29 Jan 2013 04:14:34 -0500
Message-ID: <20130129091434.GA6975@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Duy Nguyen <pclouds@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 29 10:15:04 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U07HT-0007M6-87
	for gcvg-git-2@plane.gmane.org; Tue, 29 Jan 2013 10:15:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755162Ab3A2JOl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Jan 2013 04:14:41 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:53235 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751067Ab3A2JOi (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jan 2013 04:14:38 -0500
Received: (qmail 19910 invoked by uid 107); 29 Jan 2013 09:16:00 -0000
Received: from c-71-206-173-132.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.206.173.132)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 29 Jan 2013 04:16:00 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 29 Jan 2013 04:14:34 -0500
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214916>

This is the cleaned-up version of the commit caching patches I mentioned
here:

  http://article.gmane.org/gmane.comp.version-control.git/212329

The basic idea is to generate a cache file that sits alongside a
packfile and contains the timestamp, tree, and parents in a more compact
and easy-to-access format.

The timings from this one are roughly similar to what I posted earlier.
Unlike the earlier version, this one keeps the data for a single commit
together for better cache locality (though I don't think it made a big
difference in my tests, since my cold-cache timing test ends up touching
every commit anyway).  The short of it is that for an extra 31M of disk
space (~4%), I get a warm-cache speedup for "git rev-list --all" of
~4.2s to ~0.66s.

The big thing it does not (yet) do is use offsets to reference sha1s, as
Shawn suggested.  This would potentially drop the on-disk size from 84
bytes to 16 bytes per commit (or about 6M total for linux.git).

Coupled with using compression level 0 for trees (which do not compress
well at all, and yield only a 2% increase in size when left
uncompressed), my "git rev-list --objects --all" time drops from ~40s to
~25s. Perf reveals that we're spending most of the remaining time in
lookup_object. I've spent a fair bit of time trying to optimize that,
but with no luck; I think it's fairly close to optimal. The problem is
just that we call it a very large number of times, since it is the
mechanism by which we recognize that we have already processed each
sha1.

  [1/6]: csum-file: make sha1write const-correct
  [2/6]: strbuf: add string-chomping functions
  [3/6]: introduce pack metadata cache files
  [4/6]: introduce a commit metapack
  [5/6]: add git-metapack command
  [6/6]: commit: look up commit info in metapack

-Peff
