From: Trevor Saunders <tbsaunde@tbsaunde.org>
Subject: [PATCH, RFC] checkout: Attempt to checkout submodules
Date: Wed, 18 Mar 2015 08:27:23 -0400
Message-ID: <1426681643-7516-1-git-send-email-tbsaunde@tbsaunde.org>
Cc: Trevor Saunders <tbsaunde@tbsaunde.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 18 13:27:56 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YYD4l-0007YH-2Q
	for gcvg-git-2@plane.gmane.org; Wed, 18 Mar 2015 13:27:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932810AbbCRM1v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Mar 2015 08:27:51 -0400
Received: from tbsaunde.org ([66.228.47.254]:56582 "EHLO
	paperclip.tbsaunde.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932754AbbCRM1u (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Mar 2015 08:27:50 -0400
Received: from iceball.corp.tor1.mozilla.com (unknown [23.233.68.71])
	by paperclip.tbsaunde.org (Postfix) with ESMTPSA id 718C1C072;
	Wed, 18 Mar 2015 12:27:49 +0000 (UTC)
X-Mailer: git-send-email 2.1.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265724>

If a user does git checkout HEAD -- path/to/submodule they'd expect the
submodule to be checked out to the commit that submodule is at in HEAD.
This is the most brute force possible way of try to do that, and so its
probably broken in some cases.  However I'm not terribly familiar with
git's internals and I'm not sure if this is even wanted so I'm starting
simple.  If people want this to work I can try and do something better.

Signed-off-by: Trevor Saunders <tbsaunde@tbsaunde.org>
---
 entry.c | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/entry.c b/entry.c
index 1eda8e9..2dbf5b9 100644
--- a/entry.c
+++ b/entry.c
@@ -1,6 +1,8 @@
 #include "cache.h"
+#include "argv-array.h"
 #include "blob.h"
 #include "dir.h"
+#include "run-command.h"
 #include "streaming.h"
 
 static void create_directories(const char *path, int path_len,
@@ -277,9 +279,25 @@ int checkout_entry(struct cache_entry *ce,
 		 * just do the right thing)
 		 */
 		if (S_ISDIR(st.st_mode)) {
-			/* If it is a gitlink, leave it alone! */
-			if (S_ISGITLINK(ce->ce_mode))
+			if (S_ISGITLINK(ce->ce_mode)) {
+				struct argv_array args = ARGV_ARRAY_INIT;
+				char sha1[41];
+
+				argv_array_push(&args, "checkout");
+
+				if (state->force)
+					argv_array_push(&args, "-f");
+
+				memcpy(sha1, sha1_to_hex(ce->sha1), 41);
+				argv_array_push(&args, sha1);
+				
+				run_command_v_opt_cd_env(args.argv,
+					       		 RUN_GIT_CMD, ce->name,
+							 NULL);
+				argv_array_clear(&args);
+
 				return 0;
+			}
 			if (!state->force)
 				return error("%s is a directory", path.buf);
 			remove_subtree(&path);
-- 
2.1.4
