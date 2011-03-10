From: Julius Plenz <plenz@cis.fu-berlin.de>
Subject: [PATCH] clean cached refs when calling set_git_dir()
Date: Thu, 10 Mar 2011 16:19:05 +0100
Message-ID: <1299770345-32055-1-git-send-email-plenz@cis.fu-berlin.de>
Cc: Julius Plenz <plenz@cis.fu-berlin.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 10 16:42:04 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pxhzz-0003Yu-Ok
	for gcvg-git-2@lo.gmane.org; Thu, 10 Mar 2011 16:42:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753175Ab1CJPlg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Mar 2011 10:41:36 -0500
Received: from outpost1.zedat.fu-berlin.de ([130.133.4.66]:52253 "EHLO
	outpost1.zedat.fu-berlin.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752932Ab1CJPlf (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 10 Mar 2011 10:41:35 -0500
X-Greylist: delayed 1255 seconds by postgrey-1.27 at vger.kernel.org; Thu, 10 Mar 2011 10:41:35 EST
Received: from relay1.zedat.fu-berlin.de ([130.133.4.67])
          by outpost1.zedat.fu-berlin.de (Exim 4.69)
          for git@vger.kernel.org with esmtp
          (envelope-from <plenz@zedat.fu-berlin.de>)
          id <1PxhfL-00042Y-3r>; Thu, 10 Mar 2011 16:20:39 +0100
Received: from oesterreich.zedat.fu-berlin.de ([130.133.10.19])
          by relay1.zedat.fu-berlin.de (Exim 4.69)
          with esmtp
          (envelope-from <plenz@zedat.fu-berlin.de>)
          id <1PxhfK-0002a9-Vu>; Thu, 10 Mar 2011 16:20:39 +0100
Received: from plenz by oesterreich.zedat.fu-berlin.de with local (Exim 4.69)
	(envelope-from <plenz@zedat.fu-berlin.de>)
	id 1PxhfK-000227-Sp; Thu, 10 Mar 2011 16:20:38 +0100
X-Mailer: git-send-email 1.7.3.1
X-Originating-IP: 130.133.10.19
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168827>

If you use libgit.a to perform reference resolutions on two or more
repositories that contain packed refs, cached_refs will store the packed
refs for the first repository to contain a packed-refs file only.

Subsequent calls to get_packed_refs() will return the *cached* list,
even when you changed to a different repository with set_git_dir().
Thus, references will almost certainly resolve to non-existent commits.

The patch explicitly invalidates the cached list when calling
set_git_dir() which calls setup_git_env().

Signed-off-by: Julius Plenz <plenz@cis.fu-berlin.de>
---
 cache.h       |    1 +
 environment.c |    1 +
 refs.c        |    2 +-
 3 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/cache.h b/cache.h
index 08a9022..95491fe 100644
--- a/cache.h
+++ b/cache.h
@@ -881,6 +881,7 @@ extern int check_leading_path(const char *name, int len);
 extern int has_dirs_only_path(const char *name, int len, int prefix_len);
 extern void schedule_dir_for_removal(const char *name, int len);
 extern void remove_scheduled_dirs(void);
+extern void invalidate_cached_refs(void);
 
 extern struct alternate_object_database {
 	struct alternate_object_database *next;
diff --git a/environment.c b/environment.c
index 9564475..3a7e1dc 100644
--- a/environment.c
+++ b/environment.c
@@ -110,6 +110,7 @@ static void setup_git_env(void)
 		git_graft_file = git_pathdup("info/grafts");
 	if (getenv(NO_REPLACE_OBJECTS_ENVIRONMENT))
 		read_replace_refs = 0;
+	invalidate_cached_refs();
 }
 
 int is_bare_repository(void)
diff --git a/refs.c b/refs.c
index e3c0511..bbe34fb 100644
--- a/refs.c
+++ b/refs.c
@@ -171,7 +171,7 @@ static void free_ref_list(struct ref_list *list)
 	}
 }
 
-static void invalidate_cached_refs(void)
+void invalidate_cached_refs(void)
 {
 	struct cached_refs *ca = &cached_refs;
 
-- 
1.7.3.1
