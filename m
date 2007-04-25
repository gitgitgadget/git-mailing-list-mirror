From: Alex Riesen <raa.lkml@gmail.com>
Subject: [PATCH] Fix handle leak in write_tree
Date: Thu, 26 Apr 2007 00:28:17 +0200
Message-ID: <20070425222817.GI30061@steel.home>
References: <20070423194925.GA5163@steel.home>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 26 00:28:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HgpyN-0003aM-2W
	for gcvg-git@gmane.org; Thu, 26 Apr 2007 00:28:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422838AbXDYW2U (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 25 Apr 2007 18:28:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423387AbXDYW2U
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Apr 2007 18:28:20 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.189]:38878 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422838AbXDYW2T (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Apr 2007 18:28:19 -0400
Received: from tigra.home (Fac4b.f.strato-dslnet.de [195.4.172.75])
	by post.webmailer.de (fruni mo29) (RZmta 5.6)
	with ESMTP id H015c3j3PHmCaV ; Thu, 26 Apr 2007 00:28:17 +0200 (MEST)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 791D2277BD;
	Thu, 26 Apr 2007 00:28:17 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id 59F0ABDDE; Thu, 26 Apr 2007 00:28:17 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20070423194925.GA5163@steel.home>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-RZG-AUTH: z4gQVF2k5XWuW3CculzzcFqtlg==
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45587>

This is a quick and dirty fix for the broken "git cherry-pick -n" on
some broken OS, which does not remove the directory entry after unlink
succeeded(!) if the file is still open somewher.
The entry is left but "protected": no open, no unlink, no stat.
Very annoying.

Signed-off-by: Alex Riesen <raa.lkml@gmail.com>
---
Alex Riesen, Mon, Apr 23, 2007 21:49:25 +0200:
> diff --git a/builtin-write-tree.c b/builtin-write-tree.c
> index c88bbd1..d8284b4 100644
> --- a/builtin-write-tree.c
> +++ b/builtin-write-tree.c
> @@ -29,6 +29,7 @@ int write_tree(unsigned char *sha1, int missing_ok, const char *prefix)
>  
>  	was_valid = cache_tree_fully_valid(active_cache_tree);
>  
> +	close(newfd);
>  	if (!was_valid) {
>  		if (cache_tree_update(active_cache_tree,
>  				      active_cache, active_nr,

BTW, can someone explain this hunk? And how does it manage to
pass the tests?! And HOW did it manage to pass me?!!!

 builtin-write-tree.c |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/builtin-write-tree.c b/builtin-write-tree.c
index c88bbd1..391de53 100644
--- a/builtin-write-tree.c
+++ b/builtin-write-tree.c
@@ -36,8 +36,10 @@ int write_tree(unsigned char *sha1, int missing_ok, const char *prefix)
 			die("git-write-tree: error building trees");
 		if (0 <= newfd) {
 			if (!write_cache(newfd, active_cache, active_nr)
-					&& !close(newfd))
+					&& !close(newfd)) {
 				commit_lock_file(lock_file);
+				newfd = -1;
+			}
 		}
 		/* Not being able to write is fine -- we are only interested
 		 * in updating the cache-tree part, and if the next caller
@@ -55,6 +57,8 @@ int write_tree(unsigned char *sha1, int missing_ok, const char *prefix)
 	else
 		hashcpy(sha1, active_cache_tree->sha1);
 
+	if (0 <= newfd)
+		close(newfd);
 	rollback_lock_file(lock_file);
 
 	return 0;
-- 
1.5.2.rc0.65.gd296e
