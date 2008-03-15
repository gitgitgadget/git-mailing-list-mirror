From: Eyvind Bernhardsen <eyvind-git@orakel.ntnu.no>
Subject: [PATCH/RFC] fast-import: allow "reset" without "from" to delete a branch
Date: Sat, 15 Mar 2008 15:59:49 +0100
Message-ID: <7AFA021C-062D-4FC2-85EB-1DD6C054BEA4@orakel.ntnu.no>
Mime-Version: 1.0 (Apple Message framework v919.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sat Mar 15 16:00:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JaXsT-0001Ks-3j
	for gcvg-git-2@gmane.org; Sat, 15 Mar 2008 16:00:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751918AbYCOO7x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Mar 2008 10:59:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751907AbYCOO7x
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Mar 2008 10:59:53 -0400
Received: from 97.84-49-228.nextgentel.com ([84.49.228.97]:49399 "EHLO
	eyvind.bernhardsens.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751842AbYCOO7w (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Mar 2008 10:59:52 -0400
Received: from vredefort.d.eyvind.bernhardsens.net (vredefort.d.eyvind.bernhardsens.net [172.16.3.223])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by eyvind.bernhardsens.net (Postfix) with ESMTP id 9C181142879;
	Sat, 15 Mar 2008 15:59:49 +0100 (CET)
X-Mailer: Apple Mail (2.919.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77331>

Resetting a branch without "from" and not making any further commits
to it currently causes fast-import to fail with an error message.

This patch prevents the error, allowing "reset" to be used to delete
a branch.

Signed-off-by: Eyvind Bernhardsen <eyvind-git@orakel.ntnu.no>
---
Since commit c3b0dec ("Be more careful about updating refs"), git fast- 
import has given the following error message on every import from  
cvs2svn:

	error: Trying to write ref refs/heads/TAG.FIXUP with nonexistant  
object 0000000000000000000000000000000000000000
	error: Unable to update refs/heads/TAG.FIXUP

The imported repository is fine, but the error message finally bugged  
me enough to figure out what was going on, and the explanation is  
simple.  If a branch is reset in fast-import, and no further commits  
are made on that branch, the final dump_branches() call in fast- 
import.c fails.

cvs2svn creates a TAG.FIXUP branch for every tag and then resets it  
after the tag has been set. The intent is that TAG.FIXUP should be  
deleted, and this patch makes that work without error (the branch is  
actually deleted even without this patch).

It's a small change and the test suite passes, but I'm not sure if  
using reset to delete a branch is desired behaviour, so I would  
appreciate it if someone who actually knows what they are doing could  
take a look at it :)

  fast-import.c |    5 +++--
  1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/fast-import.c b/fast-import.c
index 655913d..989ba94 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -1539,8 +1539,9 @@ static int update_branch(struct branch *b)
  			return -1;
  		}
  	}
-	if (write_ref_sha1(lock, b->sha1, msg) < 0)
-		return error("Unable to update %s", b->name);
+	if (!is_null_sha1(b->sha1))
+		if (write_ref_sha1(lock, b->sha1, msg) < 0)
+			return error("Unable to update %s", b->name);
  	return 0;
  }

-- 
1.5.4.4.555.ga98c.dirty
