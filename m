From: "Bruce E. Robertson" <bruce.e.robertson@intel.com>
Subject: [PATCH 1/1] apply.c: reject patch without --(ex,in)clude and path outside.
Date: Wed,  9 Nov 2011 14:49:02 -0800
Message-ID: <1320878942-9811-1-git-send-email-bruce.e.robertson@intel.com>
Cc: "Bruce E. Robertson" <bruce.e.robertson@intel.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 09 23:49:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ROGxD-00006a-6Q
	for gcvg-git-2@lo.gmane.org; Wed, 09 Nov 2011 23:49:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756158Ab1KIWtF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Nov 2011 17:49:05 -0500
Received: from mga02.intel.com ([134.134.136.20]:23349 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751617Ab1KIWtE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Nov 2011 17:49:04 -0500
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP; 09 Nov 2011 14:49:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,352,1309762800"; 
   d="scan'208";a="73094571"
Received: from brucer42-tower.jf.intel.com ([10.7.197.61])
  by orsmga001.jf.intel.com with ESMTP; 09 Nov 2011 14:49:03 -0800
X-Mailer: git-send-email 1.7.7.1.432.gca458.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185176>

From: "Bruce E. Robertson" <bruce.e.robertson@intel.com>

Patches are silently ignored when applied with neither --include nor
--exclude options when the current working dir is not on patch's
path. This contravenes the principle of least surprise.

"make test" results for this change:
fixed   0
success 8032
failed  0
broken  58
total   8126

Signed-off-by: Bruce E. Robertson <bruce.e.robertson@intel.com>
---
 builtin/apply.c |   12 +++++++++---
 1 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index 84a8a0b..162e2aa 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -3619,6 +3619,7 @@ static struct lock_file lock_file;
 
 static struct string_list limit_by_name;
 static int has_include;
+static int has_exclude;
 static void add_name_limit(const char *name, int exclude)
 {
 	struct string_list_item *it;
@@ -3717,9 +3718,13 @@ static int apply_patch(int fd, const char *filename, int options)
 			listp = &patch->next;
 		}
 		else {
-			/* perhaps free it a bit better? */
-			free(patch);
-			skipped_patch++;
+			if ( !has_exclude && !has_include ) {
+				patch->rejected = 1;
+			} else {
+				/* perhaps free it a bit better? */
+				free(patch);
+				skipped_patch++;
+			}
 		}
 		offset += nr;
 	}
@@ -3773,6 +3778,7 @@ static int option_parse_exclude(const struct option *opt,
 				const char *arg, int unset)
 {
 	add_name_limit(arg, 1);
+	has_exclude = 1;
 	return 0;
 }
 
-- 
1.7.7.1.432.gca458.dirty
