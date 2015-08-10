From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 10/16] write_shared_index(): use tempfile module
Date: Mon, 10 Aug 2015 11:47:45 +0200
Message-ID: <b3c03fa2da76ef5e968115c6b2a73f6033aecf8c.1439198011.git.mhagger@alum.mit.edu>
References: <cover.1439198011.git.mhagger@alum.mit.edu>
Cc: Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 10 11:48:56 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZOjhN-0002HS-Tk
	for gcvg-git-2@plane.gmane.org; Mon, 10 Aug 2015 11:48:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754772AbbHJJsp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Aug 2015 05:48:45 -0400
Received: from alum-mailsec-scanner-7.mit.edu ([18.7.68.19]:57226 "EHLO
	alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754260AbbHJJsI (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 10 Aug 2015 05:48:08 -0400
X-AuditID: 12074413-f79bd6d000007ac2-9a-55c873576dd8
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id E4.87.31426.75378C55; Mon, 10 Aug 2015 05:48:07 -0400 (EDT)
Received: from michael.fritz.box (p4FC97D4D.dip0.t-ipconnect.de [79.201.125.77])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t7A9lsx0021057
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Mon, 10 Aug 2015 05:48:06 -0400
X-Mailer: git-send-email 2.5.0
In-Reply-To: <cover.1439198011.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrIIsWRmVeSWpSXmKPExsUixO6iqBtefCLUYOcvHYuuK91MFg29V5gt
	nsy9y2xxe8V8ZgcWj7/vPzB5PHzVxe5x8ZKyx+dNcgEsUdw2SYklZcGZ6Xn6dgncGf/mTmcs
	6BSqOPT9BlMD4xT+LkZODgkBE4l3MxpYIWwxiQv31rOB2EIClxkl/sys72LkArJPMEmsmPcI
	LMEmoCuxqKeZCcQWEVCTmNh2iAXEZhZIlzixoB3MFhZwllj84z2YzSKgKnHgyydmEJtXIEri
	4PFHQL0cQMvkJBZcSAcJcwpYSGxv3MAKsddc4vG88+wTGHkXMDKsYpRLzCnN1c1NzMwpTk3W
	LU5OzMtLLdI118vNLNFLTSndxAgJHuEdjLtOyh1iFOBgVOLhnbH5eKgQa2JZcWXuIUZJDiYl
	UV6L/BOhQnxJ+SmVGYnFGfFFpTmpxYcYJTiYlUR44zOAcrwpiZVVqUX5MClpDhYlcV61Jep+
	QgLpiSWp2ampBalFMFkZDg4lCd57hUCNgkWp6akVaZk5JQhpJg5OkOFcUiLFqXkpqUWJpSUZ
	8aC4iC8GRgZIigdo7xGQdt7igsRcoChE6ylGRSlx3n0gCQGQREZpHtxYWEp4xSgO9KUw7x6Q
	Kh5gOoHrfgU0mAlosF0g2OCSRISUVAOjg/7FyZ7vNjzglzpRZbrN3O/67CvrQo08thVVzc95
	n/rus/+95fovTkQ3/N6xSZm3IoPpjyrzvyMuRRocrD3VC4MPh288sbKvyS/6YNqu8wbM8lOW
	7A7debzj8YydPx7dPPhryts/83Tu6RhO6s7/x3H9+97Du9ZucDHz7fxas/La4ftP 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275601>

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 read-cache.c | 38 ++++++--------------------------------
 1 file changed, 6 insertions(+), 32 deletions(-)

diff --git a/read-cache.c b/read-cache.c
index 96cb9a3..89be226 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -5,6 +5,7 @@
  */
 #define NO_THE_INDEX_COMPATIBILITY_MACROS
 #include "cache.h"
+#include "tempfile.h"
 #include "lockfile.h"
 #include "cache-tree.h"
 #include "refs.h"
@@ -2136,54 +2137,27 @@ static int write_split_index(struct index_state *istate,
 	return ret;
 }
 
-static char *temporary_sharedindex;
-
-static void remove_temporary_sharedindex(void)
-{
-	if (temporary_sharedindex) {
-		unlink_or_warn(temporary_sharedindex);
-		free(temporary_sharedindex);
-		temporary_sharedindex = NULL;
-	}
-}
-
-static void remove_temporary_sharedindex_on_signal(int signo)
-{
-	remove_temporary_sharedindex();
-	sigchain_pop(signo);
-	raise(signo);
-}
+static struct tempfile temporary_sharedindex;
 
 static int write_shared_index(struct index_state *istate,
 			      struct lock_file *lock, unsigned flags)
 {
 	struct split_index *si = istate->split_index;
-	static int installed_handler;
 	int fd, ret;
 
-	temporary_sharedindex = git_pathdup("sharedindex_XXXXXX");
-	fd = mkstemp(temporary_sharedindex);
+	fd = mks_tempfile(&temporary_sharedindex, git_path("sharedindex_XXXXXX"));
 	if (fd < 0) {
-		free(temporary_sharedindex);
-		temporary_sharedindex = NULL;
 		hashclr(si->base_sha1);
 		return do_write_locked_index(istate, lock, flags);
 	}
-	if (!installed_handler) {
-		atexit(remove_temporary_sharedindex);
-		sigchain_push_common(remove_temporary_sharedindex_on_signal);
-	}
 	move_cache_to_base_index(istate);
 	ret = do_write_index(si->base, fd, 1);
-	close(fd);
 	if (ret) {
-		remove_temporary_sharedindex();
+		delete_tempfile(&temporary_sharedindex);
 		return ret;
 	}
-	ret = rename(temporary_sharedindex,
-		     git_path("sharedindex.%s", sha1_to_hex(si->base->sha1)));
-	free(temporary_sharedindex);
-	temporary_sharedindex = NULL;
+	ret = rename_tempfile(&temporary_sharedindex,
+			      git_path("sharedindex.%s", sha1_to_hex(si->base->sha1)));
 	if (!ret)
 		hashcpy(si->base_sha1, si->base->sha1);
 	return ret;
-- 
2.5.0
