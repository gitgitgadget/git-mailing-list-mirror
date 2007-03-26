From: Jeff King <peff@peff.net>
Subject: [PATCH] git-rm: don't remove newly added file without -f
Date: Mon, 26 Mar 2007 14:55:39 -0400
Message-ID: <20070326185539.GA1650@coredump.intra.peff.net>
References: <8aa486160703260759v438d445ev82161600d8e8bf02@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Santi =?iso-8859-1?Q?B=E9jar?= <sbejar@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 26 20:55:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HVuM7-00057j-9Q
	for gcvg-git@gmane.org; Mon, 26 Mar 2007 20:55:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753695AbXCZSzo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 26 Mar 2007 14:55:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753697AbXCZSzn
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Mar 2007 14:55:43 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:2754 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753695AbXCZSzm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Mar 2007 14:55:42 -0400
Received: (qmail 22966 invoked from network); 26 Mar 2007 18:56:11 -0000
Received: from coredump.intra.peff.net (10.0.0.2)
  by peff.net with (DHE-RSA-AES128-SHA encrypted) SMTP; 26 Mar 2007 18:56:11 -0000
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 26 Mar 2007 14:55:39 -0400
Content-Disposition: inline
In-Reply-To: <8aa486160703260759v438d445ev82161600d8e8bf02@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43175>

Given this set of commands:

  $ echo "newly added file" >new
  $ git add new
  $ git rm new

the file "new" was previously removed from the working
directory and the index. Because it was not in HEAD, it is
available only by searching for unreachable objects.

Instead, we now err on the safe side and refuse to remove
a file which is not referenced by HEAD.

Signed-off-by: Jeff King <peff@peff.net>
---
> I think that the "git rm new" should remove "new" from the index or
> should fail, maybe with:

Something like this?

I think there are still some issues with the safety valve, though; this
triggers on 'git rm --cached new' which should be a perfectly safe
operation. However, that is not new to this change; we already
erroneously trigger the valve on a --cached removal of a file with
matching index and working directory, but mismatch with HEAD. Example:

  git-add foo
  git-commit -m 'added foo'
  echo changes >>foo
  git-add foo
  git-rm --cached foo ;# should be OK because we have working copy

I think the logic for "safe to remove" and "safe to remove --cached"
needs to be separate. I will take a look.

Also, this just implements "error, try -f" when it would be safe to drop
back to --cached for that file. Is there any interest in trying to make
git-rm more clever in this way, or is simple and predictable preferred?

 builtin-rm.c |   18 ++++--------------
 1 files changed, 4 insertions(+), 14 deletions(-)

diff --git a/builtin-rm.c b/builtin-rm.c
index 00dbe39..bf42003 100644
--- a/builtin-rm.c
+++ b/builtin-rm.c
@@ -89,20 +89,10 @@ static int check_local_mod(unsigned char *head)
 		if (ce_match_stat(ce, &st, 0))
 			errs = error("'%s' has local modifications "
 				     "(hint: try -f)", ce->name);
-		if (no_head)
-			continue;
-		/*
-		 * It is Ok to remove a newly added path, as long as
-		 * it is cache-clean.
-		 */
-		if (get_tree_entry(head, name, sha1, &mode))
-			continue;
-		/*
-		 * Otherwise make sure the version from the HEAD
-		 * matches the index.
-		 */
-		if (ce->ce_mode != create_ce_mode(mode) ||
-		    hashcmp(ce->sha1, sha1))
+		if (no_head
+		     || get_tree_entry(head, name, sha1, &mode)
+		     || ce->ce_mode != create_ce_mode(mode)
+		     || hashcmp(ce->sha1, sha1))
 			errs = error("'%s' has changes staged in the index "
 				     "(hint: try -f)", name);
 	}
-- 
1.5.1.rc2.615.g992d-dirty
