From: Thomas Rast <trast@student.ethz.ch>
Subject: [git wiki PATCH 2/3] "Designing a faster index format" project
Date: Fri, 2 Mar 2012 12:05:46 +0100
Message-ID: <afdfa68348d8d98f2cb604d9c17dad6cd764066e.1330686331.git.trast@student.ethz.ch>
References: <57e8b4eb7a98af33982c2f3a763e18f62b1d6d6d.1330686331.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Mar 02 12:06:06 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S3QJK-0001Lb-20
	for gcvg-git-2@plane.gmane.org; Fri, 02 Mar 2012 12:06:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932216Ab2CBLFw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Mar 2012 06:05:52 -0500
Received: from edge20.ethz.ch ([82.130.99.26]:18526 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932189Ab2CBLFu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Mar 2012 06:05:50 -0500
Received: from CAS20.d.ethz.ch (172.31.51.110) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.1.355.2; Fri, 2 Mar
 2012 12:05:43 +0100
Received: from thomas.inf.ethz.ch (129.132.153.233) by CAS20.d.ethz.ch
 (172.31.51.110) with Microsoft SMTP Server (TLS) id 14.1.355.2; Fri, 2 Mar
 2012 12:05:47 +0100
X-Mailer: git-send-email 1.7.9.2.467.g7fee4
In-Reply-To: <57e8b4eb7a98af33982c2f3a763e18f62b1d6d6d.1330686331.git.trast@student.ethz.ch>
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192025>

---
 SoC-2012-Ideas.md |   41 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/SoC-2012-Ideas.md b/SoC-2012-Ideas.md
index 145b379..59d1baf 100644
--- a/SoC-2012-Ideas.md
+++ b/SoC-2012-Ideas.md
@@ -99,3 +99,44 @@ computers is a plus.
 
 Proposed by: Thomas Rast
 Possible mentor(s): Thomas Rast
+
+Designing a faster index format
+-------------------------------
+
+Git is pretty slow when managing huge repositories in terms of files
+in any given tree, as it needs to rewrite the index (in full) on
+pretty much every operation.  For example, even though _logically_
+`git add already_tracked_file` only changes a single blob SHA-1 in the
+index, Git will verify index correctness during loading and recompute
+the new hash during writing _over the whole index_.  It thus ends up
+spending a large amount of time simply on hashing the index.
+
+A carefully designed index format could help in several ways.  (For the
+complexity estimates below, let n be the number of index entries or
+the size of the index, which is roughly the same.)
+
+ * The work needed for something as simple as entering a new blob into
+   the index, which is possibly the most common operation in git
+   (think `git add -p` etc.) should be at most log(n).
+
+ * The work needed for a more complex operation that changes the
+   number of index entries will have to be larger unless we get into
+   database land.  However the amount of data that we SHA-1 over
+   should still be log(n).
+
+ * It may be possible to store the cache-tree data directly as part of
+   the index, always keeping it valid, and using that to validate
+   index consistency throughout.  If so, this would be a big boost to
+   other git operations that currently suffer from frequent cache-tree
+   invalidation.
+
+Note that there are other criteria than speed: the format should also
+be as easy to parse as possible, so as to simplify work for the other
+.git-reading programs (such as jgit and libgit2).  For the same
+reason, you will also have to show a significant speed boost as
+otherwise the break in compatibility is not worth the fallout.
+
+The programming work will be in C, as it replaces a core part of git.
+
+Proposed by: Thomas Rast
+Possible mentor(s): Thomas Rast
-- 
1.7.9.2.467.g7fee4
