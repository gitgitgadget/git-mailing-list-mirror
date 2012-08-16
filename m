From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH/RFC v4 12/13] update-index.c: rewrite index when index-version is given
Date: Thu, 16 Aug 2012 11:58:48 +0200
Message-ID: <1345111129-6925-13-git-send-email-t.gummerer@gmail.com>
References: <1345111129-6925-1-git-send-email-t.gummerer@gmail.com>
Cc: trast@student.ethz.ch, pclouds@gmail.com, mhagger@alum.mit.edu,
	gitster@pobox.com, robin.rosenberg@dewire.com, t.gummerer@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 16 11:59:34 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T1wrV-0008Ge-L0
	for gcvg-git-2@plane.gmane.org; Thu, 16 Aug 2012 11:59:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756460Ab2HPJ7W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Aug 2012 05:59:22 -0400
Received: from li348-43.members.linode.com ([178.79.179.43]:48209 "EHLO
	tgummerer.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756364Ab2HPJ7R (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Aug 2012 05:59:17 -0400
Received: by tgummerer.com (Postfix, from userid 1001)
	id A3D464EFF5; Thu, 16 Aug 2012 11:59:10 +0200 (CEST)
X-Mailer: git-send-email 1.7.10.GIT
In-Reply-To: <1345111129-6925-1-git-send-email-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Make update-index always rewrite the index when a index-version
is given, even if the index already has the right version.
This option is used for performance testing the writer and
reader.

Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
 builtin/update-index.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/builtin/update-index.c b/builtin/update-index.c
index 4ce341c..c31d176 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -6,6 +6,7 @@
 #include "cache.h"
 #include "quote.h"
 #include "cache-tree.h"
+#include "read-cache.h"
 #include "tree-walk.h"
 #include "builtin.h"
 #include "refs.h"
@@ -861,6 +862,7 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
 		if (the_index.version != preferred_index_format)
 			active_cache_changed = 1;
 		the_index.version = preferred_index_format;
+		set_istate_ops(&the_index);
 	}
 
 	if (read_from_stdin) {
@@ -886,7 +888,7 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
 		strbuf_release(&buf);
 	}
 
-	if (active_cache_changed) {
+	if (active_cache_changed || preferred_index_format) {
 		if (newfd < 0) {
 			if (refresh_args.flags & REFRESH_QUIET)
 				exit(128);
-- 
1.7.11.2
