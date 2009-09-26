From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [PATCH] git branch -D: give a better error message when lockfile creation fails
Date: Sat, 26 Sep 2009 15:34:11 +0200
Message-ID: <1253972051-31980-1-git-send-email-vmiklos@frugalware.org>
References: <20090926033143.GA9917@coredump.intra.peff.net>
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Sep 26 15:33:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MrXPH-0000MY-5L
	for gcvg-git-2@lo.gmane.org; Sat, 26 Sep 2009 15:33:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752194AbZIZNdg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Sep 2009 09:33:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752175AbZIZNdg
	(ORCPT <rfc822;git-outgoing>); Sat, 26 Sep 2009 09:33:36 -0400
Received: from yugo.dsd.sztaki.hu ([195.111.2.114]:56011 "EHLO
	yugo.frugalware.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752156AbZIZNdg (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Sep 2009 09:33:36 -0400
Received: from vmobile.example.net (dsl4E5C5F16.pool.t-online.hu [78.92.95.22])
	by yugo.frugalware.org (Postfix) with ESMTPA id 143DD1A405;
	Sat, 26 Sep 2009 15:33:39 +0200 (CEST)
Received: by vmobile.example.net (Postfix, from userid 1003)
	id DB153183FAE; Sat, 26 Sep 2009 15:34:11 +0200 (CEST)
X-Mailer: git-send-email 1.6.5.rc1.44.ga1675.dirty
In-Reply-To: <20090926033143.GA9917@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129154>

Previously the old error message just told the user that it was not
possible to delete the ref from the packed-refs file. Give instructions
on how to resolve the problem.

Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
---

On Fri, Sep 25, 2009 at 11:31:43PM -0400, Jeff King <peff@peff.net> wrote:
> afterwards). So probably you would need to first refactor
> unable_to_lock_index_die() to handle just printing the error without
> dying.

Agreed, I forgot builtin-remote. What about this?

I removed the NORETURN macro as otherwise gcc would issue a warning, as
it does not realise that unable_to_lock_index_die() never returns.

 cache.h    |    3 ++-
 lockfile.c |   22 +++++++++++++++++-----
 refs.c     |    4 +++-
 3 files changed, 22 insertions(+), 7 deletions(-)

diff --git a/cache.h b/cache.h
index 1a6412d..ffec86b 100644
--- a/cache.h
+++ b/cache.h
@@ -489,7 +489,8 @@ struct lock_file {
 };
 #define LOCK_DIE_ON_ERROR 1
 #define LOCK_NODEREF 2
-extern NORETURN void unable_to_lock_index_die(const char *path, int err);
+extern int unable_to_lock_index(const char *path, int err, int noreturn);
+extern void unable_to_lock_index_die(const char *path, int err);
 extern int hold_lock_file_for_update(struct lock_file *, const char *path, int);
 extern int hold_lock_file_for_append(struct lock_file *, const char *path, int);
 extern int commit_lock_file(struct lock_file *);
diff --git a/lockfile.c b/lockfile.c
index eb931ed..aa8c444 100644
--- a/lockfile.c
+++ b/lockfile.c
@@ -156,17 +156,29 @@ static int lock_file(struct lock_file *lk, const char *path, int flags)
 }
 
 
-NORETURN void unable_to_lock_index_die(const char *path, int err)
+int unable_to_lock_index(const char *path, int err, int noreturn)
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
+void unable_to_lock_index_die(const char *path, int err)
+{
+	unable_to_lock_index(path, err, 1);
 }
 
 int hold_lock_file_for_update(struct lock_file *lk, const char *path, int flags)
diff --git a/refs.c b/refs.c
index 24865cf..4eb4fc7 100644
--- a/refs.c
+++ b/refs.c
@@ -972,8 +972,10 @@ static int repack_without_ref(const char *refname)
 	if (!found)
 		return 0;
 	fd = hold_lock_file_for_update(&packlock, git_path("packed-refs"), 0);
-	if (fd < 0)
+	if (fd < 0) {
+		unable_to_lock_index(git_path("packed-refs"), errno, 0);
 		return error("cannot delete '%s' from packed refs", refname);
+	}
 
 	for (list = packed_ref_list; list; list = list->next) {
 		char line[PATH_MAX + 100];
-- 
1.6.5.rc1.44.ga1675.dirty
