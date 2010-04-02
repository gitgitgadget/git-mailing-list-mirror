From: Jeff King <peff@peff.net>
Subject: [PATCH 0/7] textconv caching
Date: Thu, 1 Apr 2010 20:01:59 -0400
Message-ID: <20100402000159.GA15101@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 02 02:02:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NxUL4-0007Ng-N7
	for gcvg-git-2@lo.gmane.org; Fri, 02 Apr 2010 02:02:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755289Ab0DBACN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Apr 2010 20:02:13 -0400
Received: from peff.net ([208.65.91.99]:33403 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758969Ab0DBACM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Apr 2010 20:02:12 -0400
Received: (qmail 5101 invoked by uid 107); 2 Apr 2010 00:02:46 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Thu, 01 Apr 2010 20:02:46 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 01 Apr 2010 20:01:59 -0400
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143761>

This is replacement for my fast-textconv series from a week ago. It's
much faster, and doesn't require the user to do any additional work when
writing or configuring a textconv helper. The cache is stored as a notes
tree.

On my sample commit, 45 jpegs and avi files with their metadata changed,
and a textconv helper that extracts the metadata, the speedup is:

  [before]
  $ time git show >/dev/null
  real    0m13.724s
  user    0m12.057s
  sys     0m1.624s

  [after (with cache primed)]
  $ time git show >/dev/null
  real    0m0.009s
  user    0m0.004s
  sys     0m0.004s

If you just blinked at those numbers, yes, it really is that much
faster.  The caching dropped it to about .35 seconds, which I showed in
an earlier "how about this" patch. The rest of it comes from patch 7/7,
where we can avoid even opening the binary blobs at all (in my sample,
they total about 180M).

The patches are:

  [1/7]: fix const-correctness of write_sha1_file
  [2/7]: fix textconv leak in emit_rewrite_diff
  [3/7]: make commit_tree a library function
  [4/7]: introduce notes-cache interface
  [5/7]: textconv: refactor calls to run_textconv
  [6/7]: diff: cache textconv output
  [7/7]: diff: avoid useless filespec population

-Peff
