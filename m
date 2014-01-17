From: Jeff King <peff@peff.net>
Subject: [PATCH 0/5] diff_filespec cleanups and optimizations
Date: Thu, 16 Jan 2014 20:18:45 -0500
Message-ID: <20140117011844.GA6870@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 17 02:18:52 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W3y5D-0006SJ-De
	for gcvg-git-2@plane.gmane.org; Fri, 17 Jan 2014 02:18:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751567AbaAQBSs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Jan 2014 20:18:48 -0500
Received: from cloud.peff.net ([50.56.180.127]:33875 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751271AbaAQBSr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Jan 2014 20:18:47 -0500
Received: (qmail 5723 invoked by uid 102); 17 Jan 2014 01:18:47 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 16 Jan 2014 19:18:47 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 16 Jan 2014 20:18:45 -0500
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240550>

I recently came across a repository with a commit containing 100 million
paths in its tree. Cleverly, the whole repo fits into a 1.5K packfile
(can you guess how it was done?). Not so cleverly, running "diff-tree
--root" on that commit uses a large amount of memory. :)

I do not think it is worth optimizing for such a pathological
repository. But I was curious how much it would want (it OOM'd on my
64-bit 16G machine). The answer is roughly:

   100,000,000 * (
      8 bytes per pointer to diff_filepair in the diff_queue
    + 32 bytes per diff_filepair struct
    +  2 * (
         96 bytes per diff_filespec struct
       + 12 bytes per filename (in this case)
     )
  )

which is about 25G. Plus malloc overhead. So obviously this example is
unreasonable. A more reasonable large case is something like WebKit at
~150K files, doing a diff against the empty tree. That's only 37M.

But while looking at it, I noticed a bunch of cleanups for
diff_filespec.  With the patches below, sizeof(struct diff_filespec) on
my 64-bit machine goes from 96 bytes down to 80. Compiling with "-m32"
goes from 64 bytes down to 52.

The first few patches have cleanup value aside from the struct size
improvement. The last two are pure optimization. I doubt the
optimization is noticeable for any real-life cases, so I don't mind if
they get dropped. But they're quite trivial and obvious.

  [1/5]: diff_filespec: reorder dirty_submodule macro definitions
  [2/5]: diff_filespec: drop funcname_pattern_ident field
  [3/5]: diff_filespec: drop xfrm_flags field
  [4/5]: diff_filespec: reorder is_binary field
  [5/5]: diff_filespec: use only 2 bits for is_binary flag

-Peff
