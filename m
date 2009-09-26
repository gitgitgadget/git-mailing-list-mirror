From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [PATCH] git branch -D: give a better error message when lockfile creation fails
Date: Sun, 27 Sep 2009 01:15:09 +0200
Message-ID: <1254006909-1862-1-git-send-email-vmiklos@frugalware.org>
References: <vpqy6o15v6m.fsf@bauges.imag.fr>
Cc: spearce@spearce.org, peff@peff.net, git@vger.kernel.org
To: Matthieu.Moy@grenoble-inp.fr
X-From: git-owner@vger.kernel.org Sun Sep 27 01:14:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MrgTU-0002bY-JF
	for gcvg-git-2@lo.gmane.org; Sun, 27 Sep 2009 01:14:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752123AbZIZXOc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Sep 2009 19:14:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751865AbZIZXOc
	(ORCPT <rfc822;git-outgoing>); Sat, 26 Sep 2009 19:14:32 -0400
Received: from yugo.dsd.sztaki.hu ([195.111.2.114]:35087 "EHLO
	yugo.frugalware.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751800AbZIZXOb (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Sep 2009 19:14:31 -0400
Received: from vmobile.example.net (catv-89-134-193-228.catv.broadband.hu [89.134.193.228])
	by yugo.frugalware.org (Postfix) with ESMTPA id 9646D1A405;
	Sun, 27 Sep 2009 01:14:34 +0200 (CEST)
Received: by vmobile.example.net (Postfix, from userid 1003)
	id 147B8183FAE; Sun, 27 Sep 2009 01:15:10 +0200 (CEST)
X-Mailer: git-send-email 1.6.5.rc1.44.ga1675.dirty
In-Reply-To: <vpqy6o15v6m.fsf@bauges.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129186>

Previously the old error message just told the user that it was not
possible to delete the ref from the packed-refs file. Give instructions
on how to resolve the problem.

Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
---

Changes since the previous one:

* unable_to_lock_index() renamed to unable_to_lock()
* NORETURN is back for unable_to_lock_index_die()

 cache.h    |    1 +
 lockfile.c |   23 ++++++++++++++++++-----
 refs.c     |    4 +++-
 3 files changed, 22 insertions(+), 6 deletions(-)

diff --git a/cache.h b/cache.h
index 1a6412d..797cc4c 100644
--- a/cache.h
+++ b/cache.h
@@ -489,6 +489,7 @@ struct lock_file {
 };
 #define LOCK_DIE_ON_ERROR 1
 #define LOCK_NODEREF 2
+extern int unable_to_lock(const char *path, int err, int noreturn);
 extern NORETURN void unable_to_lock_index_die(const char *path, int err);
 extern int hold_lock_file_for_update(struct lock_file *, const char *path, int);
 extern int hold_lock_file_for_append(struct lock_file *, const char *path, int);
diff --git a/lockfile.c b/lockfile.c
index eb931ed..3bacda4 100644
--- a/lockfile.c
+++ b/lockfile.c
@@ -156,17 +156,30 @@ static int lock_file(struct lock_file *lk, const char *path, int flags)
 }
 
 
-NORETURN void unable_to_lock_index_die(const char *path, int err)
+int unable_to_lock(const char *path, int err, int noreturn)
 {
+	struct strbuf buf = STRBUF_INIT;
+	int ret;
+
 	if (err == EEXIST) {
-		die("Unable to create '%s.lock': %s.\n\n"
+		strbuf_addf(&buf, "Unable to create '%s.lock': %s.\n\n"
 		    "If no other git process is currently running, this probably means a\n"
 		    "git process crashed in this repository earlier. Make sure no other git\n"
 		    "process is running and remove the file manually to continue.",
 		    path, strerror(err));
-	} else {
-		die("Unable to create '%s.lock': %s", path, strerror(err));
-	}
+	} else
+		strbuf_addf(&buf, "Unable to create '%s.lock': %s", path, strerror(err));
+	if (noreturn)
+		die(buf.buf);
+	ret = error(buf.buf);
+	strbuf_release(&buf);
+	return ret;
+}
+
+NORETURN void unable_to_lock_index_die(const char *path, int err)
+{
+	unable_to_lock(path, err, 1);
+	die("unable_to_lock() should have died already");
 }
 
 int hold_lock_file_for_update(struct lock_file *lk, const char *path, int flags)
diff --git a/refs.c b/refs.c
index 24865cf..3d635ae 100644
--- a/refs.c
+++ b/refs.c
@@ -972,8 +972,10 @@ static int repack_without_ref(const char *refname)
 	if (!found)
 		return 0;
 	fd = hold_lock_file_for_update(&packlock, git_path("packed-refs"), 0);
-	if (fd < 0)
+	if (fd < 0) {
+		unable_to_lock(git_path("packed-refs"), errno, 0);
 		return error("cannot delete '%s' from packed refs", refname);
+	}
 
 	for (list = packed_ref_list; list; list = list->next) {
 		char line[PATH_MAX + 100];
-- 
1.6.5.rc1.44.ga1675.dirty
