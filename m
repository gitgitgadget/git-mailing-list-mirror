From: Jeff King <peff@peff.net>
Subject: [PATCH 1/4] read-cache.c: drop PROT_WRITE from mmap of index
Date: Thu, 28 May 2015 03:54:00 -0400
Message-ID: <20150528075400.GA23395@peff.net>
References: <20150528075142.GB3688@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jorge <griffin@gmx.es>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 28 09:54:09 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yxsdl-00088q-5P
	for gcvg-git-2@plane.gmane.org; Thu, 28 May 2015 09:54:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751871AbbE1HyF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 May 2015 03:54:05 -0400
Received: from cloud.peff.net ([50.56.180.127]:37096 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751415AbbE1HyD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 May 2015 03:54:03 -0400
Received: (qmail 15880 invoked by uid 102); 28 May 2015 07:54:03 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 28 May 2015 02:54:03 -0500
Received: (qmail 14076 invoked by uid 107); 28 May 2015 07:54:01 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 28 May 2015 03:54:01 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 28 May 2015 03:54:00 -0400
Content-Disposition: inline
In-Reply-To: <20150528075142.GB3688@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270129>

Once upon a time, git's in-memory representation of a cache
entry actually pointed to the mmap'd on-disk data. So in
520fc24 (Allow writing to the private index file mapping.,
2005-04-26), we specified PROT_WRITE so that we could tweak
the entries while we run (in our own MAP_PRIVATE copy-on-write
version, of course).

Later, 7a51ed6 (Make on-disk index representation separate
from in-core one, 2008-01-14) stopped doing this; we copy
the data into our in-core representation, and then drop the
mmap immediately. We can therefore drop the PROT_WRITE flag.
It's probably not hurting anything as it is, but it's
potentially confusing.

Note that we could also mark the mapping as "const" to
verify that we never write to it. However, we don't
typically do that for our other maps, as it then requires
casting to munmap() it.

Signed-off-by: Jeff King <peff@peff.net>
---
This one obviously is not necessary for the rest of it, but just
something I noticed while writing my response to you. But read to the
end of the series; there might be a twist ending that brings it back!

 read-cache.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/read-cache.c b/read-cache.c
index 723d48d..5dee4e2 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1562,7 +1562,7 @@ int do_read_index(struct index_state *istate, const char *path, int must_exist)
 	if (mmap_size < sizeof(struct cache_header) + 20)
 		die("index file smaller than expected");
 
-	mmap = xmmap(NULL, mmap_size, PROT_READ | PROT_WRITE, MAP_PRIVATE, fd, 0);
+	mmap = xmmap(NULL, mmap_size, PROT_READ, MAP_PRIVATE, fd, 0);
 	if (mmap == MAP_FAILED)
 		die_errno("unable to map index file");
 	close(fd);
-- 
2.4.2.668.gc3b1ade.dirty
