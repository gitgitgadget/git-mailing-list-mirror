From: Jeff King <peff@peff.net>
Subject: [tig PATCH] fix off-by-one on parent selection
Date: Mon, 10 May 2010 04:55:04 -0400
Message-ID: <20100510085504.GA2283@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Jonas Fonseca <fonseca@diku.dk>
X-From: git-owner@vger.kernel.org Mon May 10 10:55:13 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OBOlc-0004Xi-Jg
	for gcvg-git-2@lo.gmane.org; Mon, 10 May 2010 10:55:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755620Ab0EJIzI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 May 2010 04:55:08 -0400
Received: from peff.net ([208.65.91.99]:37307 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753567Ab0EJIzG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 May 2010 04:55:06 -0400
Received: (qmail 1952 invoked by uid 107); 10 May 2010 08:55:22 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Mon, 10 May 2010 04:55:22 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 10 May 2010 04:55:04 -0400
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146775>

Originally, we use "git rev-list -1 --parents" to get the
list of parents, and therefore the 0th slot was the commit
in question, the 1st slot was the 1st parent, and so forth.

Commit 0a46941 switched this to use --pretty=format:%P, so
that the menu-selection code could be easily used (which
counts items starting from 0). However, we only use the menu
code in the case of multiple parents.  For a single parent,
this introduced an off-by-one where we look just past the
parent we want.

This patch fixes it by explicitly selecting the 0th parent
for the single parent case.

Signed-off-by: Jeff King <peff@peff.net>
---
This is an old bug, but I finally got a chance to track it down.

There is a related buglet elsewhere in select_commit_parent. Now that we
ask git to print only the parents, we will get no output at all for a
parent-less commit. This will cause iobuf_read to return an error, and
we will print "Failed to get parent information" instead of "The
selected commit has no parents" (or "Path '%s' does not exist" if we are
blaming the parent of a commit that introduced a file).

AFAICT, fixing it would mean improving iobuf_read to differentiate "no
output" from "there were errors". I'll leave that sort of infrastructure
refactoring to you if you want to do it. The resulting bug is quite
minor.

 tig.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/tig.c b/tig.c
index 074e414..60932d4 100644
--- a/tig.c
+++ b/tig.c
@@ -4012,7 +4012,9 @@ select_commit_parent(const char *id, char rev[SIZEOF_REV], const char *path)
 		return FALSE;
 	}
 
-	if (parents > 1 && !open_commit_parent_menu(buf, &parents))
+	if (parents == 1)
+		parents = 0;
+	else if (!open_commit_parent_menu(buf, &parents))
 		return FALSE;
 
 	string_copy_rev(rev, &buf[41 * parents]);
-- 
1.7.1.248.gf52fc
