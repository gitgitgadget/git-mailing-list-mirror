From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH/RFC] fast-import: allow "reset" without "from" to delete a branch
Date: Sun, 16 Mar 2008 00:12:40 -0400
Message-ID: <20080316041240.GH8410@spearce.org>
References: <7AFA021C-062D-4FC2-85EB-1DD6C054BEA4@orakel.ntnu.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Eyvind Bernhardsen <eyvind-git@orakel.ntnu.no>
X-From: git-owner@vger.kernel.org Sun Mar 16 05:13:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JakFu-0003J1-2V
	for gcvg-git-2@gmane.org; Sun, 16 Mar 2008 05:13:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750758AbYCPEMp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Mar 2008 00:12:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750757AbYCPEMp
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Mar 2008 00:12:45 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:34535 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750747AbYCPEMo (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Mar 2008 00:12:44 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1JakEl-0005ui-P9; Sun, 16 Mar 2008 00:12:43 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 7B9DF20FBAE; Sun, 16 Mar 2008 00:12:41 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <7AFA021C-062D-4FC2-85EB-1DD6C054BEA4@orakel.ntnu.no>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77350>

Eyvind Bernhardsen <eyvind-git@orakel.ntnu.no> wrote:
> It's a small change and the test suite passes, but I'm not sure if  
> using reset to delete a branch is desired behaviour, so I would  
> appreciate it if someone who actually knows what they are doing could  
> take a look at it :)

I think this is a slightly better patch, as it avoids creating a
lock file around the ref if we aren't going to actually alter it.

At present fast-import does not allow an application to delete a
branch that existed when fast-import started, but if the branch
was strictly transient within the fast-import process (like the
cvs2svn TAG.FIXUP) then there is no problem.

Is this patch acceptable?  Note it is from you, I carried in your
commit message, SBO, etc.
 
--8>--
From: Eyvind Bernhardsen <eyvind-git@orakel.ntnu.no>
Subject: [PATCH] fast-import: allow "reset" without "from" to delete temporary branch

Resetting a branch without "from" and not making any further commits
to it currently causes fast-import to fail with an error message.

This patch prevents the error, allowing "reset" to be used to delete
a branch.

Signed-off-by: Eyvind Bernhardsen <eyvind-git@orakel.ntnu.no>
Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
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
1.5.4.4.640.g8ae62

-- 
Shawn.
