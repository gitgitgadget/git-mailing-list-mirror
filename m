From: Jeff King <peff@peff.net>
Subject: [PATCH v2 1/3] cache.h: drop LOCAL_REPO_ENV_SIZE
Date: Fri, 8 Mar 2013 04:29:08 -0500
Message-ID: <20130308092907.GA1923@sigill.intra.peff.net>
References: <20130308092824.GA9127@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Junio C Hamano <gitster@pobox.com>,
	Mark Lodato <lodatom@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 08 10:29:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UDtcS-0005bn-Ui
	for gcvg-git-2@plane.gmane.org; Fri, 08 Mar 2013 10:29:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933954Ab3CHJ3M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Mar 2013 04:29:12 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:40782 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933331Ab3CHJ3L (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Mar 2013 04:29:11 -0500
Received: (qmail 15079 invoked by uid 107); 8 Mar 2013 09:30:49 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 08 Mar 2013 04:30:49 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 08 Mar 2013 04:29:08 -0500
Content-Disposition: inline
In-Reply-To: <20130308092824.GA9127@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217651>

We keep a static array of variables that should be cleared
when invoking a sub-process on another repo. We statically
size the array with the LOCAL_REPO_ENV_SIZE macro so that
any readers do not have to count it themselves.

As it turns out, no readers actually use the macro, and it
creates a maintenance headache, as modifications to the
array need to happen in two places (one to add the new
element, and another to bump the size).

Since it's NULL-terminated, we can just drop the size macro
entirely. While we're at it, we'll clean up some comments
around it, and add a new mention of it at the top of the
list of environment variable macros. Even though
local_repo_env is right below that list, it's easy to miss,
and additions to that list should consider local_repo_env.

Signed-off-by: Jeff King <peff@peff.net>
---
 cache.h       | 12 ++++++------
 environment.c |  6 ++----
 2 files changed, 8 insertions(+), 10 deletions(-)

diff --git a/cache.h b/cache.h
index e493563..b90044a 100644
--- a/cache.h
+++ b/cache.h
@@ -341,6 +341,7 @@ static inline enum object_type object_type(unsigned int mode)
 		OBJ_BLOB;
 }
 
+/* Double-check local_repo_env below if you add to this list. */
 #define GIT_DIR_ENVIRONMENT "GIT_DIR"
 #define GIT_NAMESPACE_ENVIRONMENT "GIT_NAMESPACE"
 #define GIT_WORK_TREE_ENVIRONMENT "GIT_WORK_TREE"
@@ -365,13 +366,12 @@ static inline enum object_type object_type(unsigned int mode)
 #define GIT_LITERAL_PATHSPECS_ENVIRONMENT "GIT_LITERAL_PATHSPECS"
 
 /*
- * Repository-local GIT_* environment variables
- * The array is NULL-terminated to simplify its usage in contexts such
- * environment creation or simple walk of the list.
- * The number of non-NULL entries is available as a macro.
+ * Repository-local GIT_* environment variables; these will be cleared
+ * when git spawns a sub-process that runs inside another repository.
+ * The array is NULL-terminated, which makes it easy to pass in the "env"
+ * parameter of a run-command invocation, or to do a simple walk.
  */
-#define LOCAL_REPO_ENV_SIZE 9
-extern const char *const local_repo_env[LOCAL_REPO_ENV_SIZE + 1];
+extern const char * const local_repo_env[];
 
 extern int is_bare_repository_cfg;
 extern int is_bare_repository(void);
diff --git a/environment.c b/environment.c
index 89d6c70..dc73927 100644
--- a/environment.c
+++ b/environment.c
@@ -83,11 +83,9 @@ static char *git_object_dir, *git_index_file, *git_graft_file;
 static char *git_object_dir, *git_index_file, *git_graft_file;
 
 /*
- * Repository-local GIT_* environment variables
- * Remember to update local_repo_env_size in cache.h when
- * the size of the list changes
+ * Repository-local GIT_* environment variables; see cache.h for details.
  */
-const char * const local_repo_env[LOCAL_REPO_ENV_SIZE + 1] = {
+const char * const local_repo_env[] = {
 	ALTERNATE_DB_ENVIRONMENT,
 	CONFIG_ENVIRONMENT,
 	CONFIG_DATA_ENVIRONMENT,
-- 
1.8.2.rc2.4.g3e774bb
