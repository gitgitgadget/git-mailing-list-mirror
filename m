From: Jeff King <peff@peff.net>
Subject: [RFC] http clone does not checkout working tree
Date: Wed, 4 Jun 2008 14:38:58 -0400
Message-ID: <20080604183858.GA7095@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Daniel Barkalow <barkalow@iabervon.org>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Jun 04 20:40:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K3xtv-00024I-4e
	for gcvg-git-2@gmane.org; Wed, 04 Jun 2008 20:39:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756457AbYFDSjF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Jun 2008 14:39:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755776AbYFDSjE
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Jun 2008 14:39:04 -0400
Received: from peff.net ([208.65.91.99]:3422 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753101AbYFDSjD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Jun 2008 14:39:03 -0400
Received: (qmail 18161 invoked by uid 111); 4 Jun 2008 18:39:00 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Wed, 04 Jun 2008 14:39:00 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 04 Jun 2008 14:38:58 -0400
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83806>

If I try cloning a repository by http with the current 'master', I end
up with a proper git directory, but nothing gets checked out in the
working tree [I see the problem with any repository; I randomly picked
the one in the example below because it is small, and http clone can be
painfully slow]:

  $ git clone http://repo.or.cz/r/bigint.git
  [...]
  $ cd bigint
  $ ls
  $

I think the problem is that the builtin-clone now does the http commit
walking and the tree unpacking in the same process, and the commit
walker leaves the in-core objects in a funny state.

Specifically, the top-level tree object has its "parsed" flag set to 1,
but the buffer and size members are set to NULL and 0, respectively.
This happens in walker.c:process_tree, where we free the tree buffer
after walking it. It seems like we are violating the meaning of "parsed"
here, which implies that those other members are valid.

The following patch fixes it for me, but I really have no idea if there
isn't something more subtle at work. Sending to Linus, since "git blame"
points the surrounding code to you, and to Daniel, since the new clone
and the commit walker are your areas.

---
diff --git a/walker.c b/walker.c
index 31de6c1..0e68ee6 100644
--- a/walker.c
+++ b/walker.c
@@ -59,6 +59,7 @@ static int process_tree(struct walker *walker, struct tree *tree)
 	free(tree->buffer);
 	tree->buffer = NULL;
 	tree->size = 0;
+	tree->object.parsed = 0;
 	return 0;
 }
 
