From: Jeff King <peff@peff.net>
Subject: [PATCH 0/3] fast textconv
Date: Sun, 28 Mar 2010 10:53:02 -0400
Message-ID: <20100328145301.GA26213@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 28 16:53:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nvtrq-0000sf-8R
	for gcvg-git-2@lo.gmane.org; Sun, 28 Mar 2010 16:53:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754701Ab0C1OxS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Mar 2010 10:53:18 -0400
Received: from peff.net ([208.65.91.99]:60636 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754687Ab0C1OxR (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Mar 2010 10:53:17 -0400
Received: (qmail 24120 invoked by uid 107); 28 Mar 2010 14:53:44 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sun, 28 Mar 2010 10:53:44 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 28 Mar 2010 10:53:02 -0400
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143389>

The normal textconv procedure is to dump the binary file to a tempfile
(optionally using a working tree file if available), then run the
textconv helper to produce a textual version on stdout. This is a very
convenient interface, as helpers don't need to be aware of git at all
and many standard commands can be used without wrappers.

Unfortunately, it can be slow for large binary files. We spool the file
to disk before invoking the textconv helper, so the helper has no way to
do any optimizations. For example, the helper may need only part of the
file (e.g., when showing metadata at the beginning of a media file), or
it may implement a caching scheme to avoid repeating expensive
conversions.

This series introduces a "fast textconv", which does not automatically
spool a tempfile, but instead gives the helper program the sha1 of the
blob to be converted.

Here are some timings from my photo repository, on a commit with 37
JPEGs and 8 AVIs. Each file had two lines added to its exif metadata.
My textconv helper is a perl script that dumps the exif tags, and
implements its own caching scheme.

  $ time git show >/dev/null ;# before patch
  real    0m13.818s
  user    0m12.137s
  sys     0m1.552s

  $ time git show >/dev/null ;# after patch, first run
  real    0m15.076s
  user    0m13.321s
  sys     0m1.772s

  $ time git show >/dev/null ;# after patch, subsequent runs
  real    0m2.502s
  user    0m1.820s
  sys     0m0.592s

So you can see a 5.5x speedup. The first run is a little bit slower,
presumably due to the extra git-cat-file calls by the helper.

The speedup is purely from caching; I am not using the "we only need to
read the first part of the file" optimization. My files are only a few
megabytes. Probably that would be more useful for people storing files
in the hundreds of megabytes, where a full cat-file will cause a lot of
unwanted I/O.

There are two things I'm still not 100% happy with:

 1. 2.5 seconds is still a little slower than I would like. The slowness
    comes from the fact that my helper is written in perl, and therefore
    perl gets invoked for each diff. I could try collecting all of the
    to-be-textconv'd files at the beginning of the diff process and just
    invoking the helper once. But that means we need to store the
    results in core, and they could potentially be long (in my case,
    they are only a few hundred bytes, but somebody could potentially be
    textconv'ing a large documents).

 2. It is up to the helper to implement a caching layer. This offers a
    lot of flexibility, but it means each helper must implement its own.
    It also means we have to run the helper even for a cache hit, which
    causes slowness.

    An alternative would be for git to support textconv caching
    natively, probably by using the notes mechanism to map blob sha1's
    to their textconv'd contents. But that opens a whole can of worms
    with how the cache is managed. If I change my textconv helper to
    produce different results, how do I invalidate the cache? Should it
    happen automatically if I change the contents of
    diff.$method.textconv? Or do I need to do it manually (you will
    still need to do it manually if, e.g., you upgrade your textconv
    helper. Git can't know about that). How do I evict entries if the
    cache gets too large when notes are stored as a history?

So I'm not sure. This series works and is simple from git's perspective.
But caching textconv results in notes would be faster, and easier for
people to write helper scripts.

The patches are:

  [1/3]: textconv: refactor calls to run_textconv
  [2/3]: textconv: refactor to handle multiple textconv types
  [3/3]: diff: add "fasttextconv" config option

-Peff
