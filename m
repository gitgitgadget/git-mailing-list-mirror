From: Pierre Habouzit <madcoder@debian.org>
Subject: [PATCH] fix git branch -m in presence of cross devices
Date: Wed, 7 Jul 2010 09:47:20 +0200
Message-ID: <20100707074720.GB26033@madism.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>
To: Git ML <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jul 07 09:54:58 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OWPT7-00079s-Ve
	for gcvg-git-2@lo.gmane.org; Wed, 07 Jul 2010 09:54:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753195Ab0GGHyq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Jul 2010 03:54:46 -0400
Received: from pan.madism.org ([88.191.52.104]:56507 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752834Ab0GGHyp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Jul 2010 03:54:45 -0400
X-Greylist: delayed 443 seconds by postgrey-1.27 at vger.kernel.org; Wed, 07 Jul 2010 03:54:45 EDT
Received: from madism.org (unknown [94.228.180.170])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (verified OK))
	by hermes.madism.org (Postfix) with ESMTPS id 2895E4EF46;
	Wed,  7 Jul 2010 09:47:21 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id 519692B0B8E; Wed,  7 Jul 2010 09:47:20 +0200 (CEST)
Content-Disposition: inline
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150457>

When you have for example a bare repository stored on NFS, and that you
create new workdirs locally (using contrib's git-new-workdir), logs/refs
is a symlink to a different device. Hence when the reflogs are renamed,
all must happen below logs/refs or one gets cross device rename errors
like:

  git branch -m foo
  error: unable to move logfile logs/refs/heads/master to tmp-renamed-log: Invalid cross-device link
  fatal: Branch rename failed

The fix is hence to use logs/refs/.tmp-renamed-log as a temporary log
name, instead of just tmp-renamed-log.

Signed-off-by: Pierre Habouzit <madcoder@debian.org>
---
 refs.c |   21 +++++++++++++++------
 1 files changed, 15 insertions(+), 6 deletions(-)

diff --git a/refs.c b/refs.c
index 6f486ae..b540067 100644
--- a/refs.c
+++ b/refs.c
@@ -1090,6 +1090,15 @@ int delete_ref(const char *refname, const unsigned char *sha1, int delopt)
 	return ret;
 }
 
+/*
+ * People using contrib's git-new-workdir have .git/logs/refs ->
+ * /some/other/path/.git/logs/refs, and that may live on another device.
+ *
+ * IOW, to avoid cross device rename errors, the temporary renamed log must
+ * live into logs/refs.
+ */
+#define TMP_RENAMED_LOG  "logs/refs/.tmp-renamed-log"
+
 int rename_ref(const char *oldref, const char *newref, const char *logmsg)
 {
 	static const char renamed_ref[] = "RENAMED-REF";
@@ -1123,8 +1132,8 @@ int rename_ref(const char *oldref, const char *newref, const char *logmsg)
 	if (write_ref_sha1(lock, orig_sha1, logmsg))
 		return error("unable to save current sha1 in %s", renamed_ref);
 
-	if (log && rename(git_path("logs/%s", oldref), git_path("tmp-renamed-log")))
-		return error("unable to move logfile logs/%s to tmp-renamed-log: %s",
+	if (log && rename(git_path("logs/%s", oldref), git_path(TMP_RENAMED_LOG)))
+		return error("unable to move logfile logs/%s to "TMP_RENAMED_LOG": %s",
 			oldref, strerror(errno));
 
 	if (delete_ref(oldref, orig_sha1, REF_NODEREF)) {
@@ -1150,7 +1159,7 @@ int rename_ref(const char *oldref, const char *newref, const char *logmsg)
 	}
 
  retry:
-	if (log && rename(git_path("tmp-renamed-log"), git_path("logs/%s", newref))) {
+	if (log && rename(git_path(TMP_RENAMED_LOG), git_path("logs/%s", newref))) {
 		if (errno==EISDIR || errno==ENOTDIR) {
 			/*
 			 * rename(a, b) when b is an existing
@@ -1163,7 +1172,7 @@ int rename_ref(const char *oldref, const char *newref, const char *logmsg)
 			}
 			goto retry;
 		} else {
-			error("unable to move logfile tmp-renamed-log to logs/%s: %s",
+			error("unable to move logfile "TMP_RENAMED_LOG" to logs/%s: %s",
 				newref, strerror(errno));
 			goto rollback;
 		}
@@ -1203,8 +1212,8 @@ int rename_ref(const char *oldref, const char *newref, const char *logmsg)
 		error("unable to restore logfile %s from %s: %s",
 			oldref, newref, strerror(errno));
 	if (!logmoved && log &&
-	    rename(git_path("tmp-renamed-log"), git_path("logs/%s", oldref)))
-		error("unable to restore logfile %s from tmp-renamed-log: %s",
+	    rename(git_path(TMP_RENAMED_LOG), git_path("logs/%s", oldref)))
+		error("unable to restore logfile %s from "TMP_RENAMED_LOG": %s",
 			oldref, strerror(errno));
 
 	return 1;
-- 
1.7.2.rc1.212.g850a.dirty
