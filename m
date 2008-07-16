From: Petr Baudis <pasky@suse.cz>
Subject: [PATCH 1/7] git-mv: Remove dead code branch
Date: Wed, 16 Jul 2008 21:11:08 +0200
Message-ID: <20080716191107.19772.90413.stgit@localhost>
References: <20080716190753.19772.93357.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 16 21:13:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJCQG-0000ru-Gj
	for gcvg-git-2@gmane.org; Wed, 16 Jul 2008 21:12:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754149AbYGPTLO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jul 2008 15:11:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754403AbYGPTLO
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Jul 2008 15:11:14 -0400
Received: from 159-162.104-92.cust.bluewin.ch ([92.104.162.159]:64253 "EHLO
	pixie.suse.cz" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751045AbYGPTLN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jul 2008 15:11:13 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by pixie.suse.cz (Postfix) with ESMTP id 36CBA2ACC76
	for <git@vger.kernel.org>; Wed, 16 Jul 2008 21:11:08 +0200 (CEST)
In-Reply-To: <20080716190753.19772.93357.stgit@localhost>
User-Agent: StGIT/0.14.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88722>

The path list builder had a branch for the case the source is not in index, but
this can happen only if the source was a directory. However, in that case we
have already expanded the list to the directory contents and set mode
to WORKING_DIRECTORY, which is tested earlier.

The patch removes the superfluous branch and adds an assert() instead. git-mv
testsuite still passes.

Signed-off-by: Petr Baudis <pasky@suse.cz>
---

 builtin-mv.c |   16 +++++++---------
 1 files changed, 7 insertions(+), 9 deletions(-)

diff --git a/builtin-mv.c b/builtin-mv.c
index 5530e11..158a83d 100644
--- a/builtin-mv.c
+++ b/builtin-mv.c
@@ -227,15 +227,13 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
 		if (mode == WORKING_DIRECTORY)
 			continue;
 
-		if (cache_name_pos(src, strlen(src)) >= 0) {
-			path_list_insert(src, &deleted);
-
-			/* destination can be a directory with 1 file inside */
-			if (path_list_has_path(&overwritten, dst))
-				path_list_insert(dst, &changed);
-			else
-				path_list_insert(dst, &added);
-		} else
+		assert(cache_name_pos(src, strlen(src)) >= 0);
+
+		path_list_insert(src, &deleted);
+		/* destination can be a directory with 1 file inside */
+		if (path_list_has_path(&overwritten, dst))
+			path_list_insert(dst, &changed);
+		else
 			path_list_insert(dst, &added);
 	}
 
