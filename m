From: Eyvind Bernhardsen <eyvind-git@orakel.ntnu.no>
Subject: [PATCH] fast-import: Allow "reset" to delete a new branch without error
Date: Sun, 16 Mar 2008 20:49:09 +0100
Message-ID: <283B81B0-4493-41DC-A575-F72910B1EFFA@orakel.ntnu.no>
References: <7AFA021C-062D-4FC2-85EB-1DD6C054BEA4@orakel.ntnu.no> <20080316041240.GH8410@spearce.org>
Mime-Version: 1.0 (Apple Message framework v919.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sun Mar 16 20:49:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jayrg-00078A-5O
	for gcvg-git-2@gmane.org; Sun, 16 Mar 2008 20:49:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752522AbYCPTtM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Mar 2008 15:49:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752472AbYCPTtM
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Mar 2008 15:49:12 -0400
Received: from 97.84-49-228.nextgentel.com ([84.49.228.97]:53134 "EHLO
	eyvind.bernhardsens.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752436AbYCPTtL (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Mar 2008 15:49:11 -0400
Received: from vredefort.d.eyvind.bernhardsens.net (vredefort.d.eyvind.bernhardsens.net [172.16.3.223])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by eyvind.bernhardsens.net (Postfix) with ESMTP id B0769142E6A;
	Sun, 16 Mar 2008 20:49:09 +0100 (CET)
In-Reply-To: <20080316041240.GH8410@spearce.org>
X-Mailer: Apple Mail (2.919.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77377>

Creating a branch in fast-import and then resetting it without making
any further commits to it currently causes an error message at the
end of the import.

This error is triggered by cvs2svn's git backend, which uses a
temporary fixup branch when it creates tags, because the fixup branch
is reset after each tag.

This patch prevents the error, allowing "reset" to be used to delete
temporary branches.

Signed-off-by: Eyvind Bernhardsen <eyvind-git@orakel.ntnu.no>
---
On 16. mars. 2008, at 05.12, Shawn O. Pearce wrote:

> I think this is a slightly better patch, as it avoids creating a
> lock file around the ref if we aren't going to actually alter it.


Yes, that's a much better patch, and since you pointed out that  
existing branches won't be deleted, here it is again with a better  
commit message.  Thanks!

  fast-import.c |    2 ++
  1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/fast-import.c b/fast-import.c
index 655913d..73e5439 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -1516,6 +1516,8 @@ static int update_branch(struct branch *b)
  	struct ref_lock *lock;
  	unsigned char old_sha1[20];

+	if (is_null_sha1(b->sha1))
+		return 0;
  	if (read_ref(b->name, old_sha1))
  		hashclr(old_sha1);
  	lock = lock_any_ref_for_update(b->name, old_sha1, 0);
-- 
1.5.4.4.608.gc20d.dirty
