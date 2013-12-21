From: Jeff King <peff@peff.net>
Subject: [PATCH v4 17/23] repack: handle optional files created by
 pack-objects
Date: Sat, 21 Dec 2013 09:00:27 -0500
Message-ID: <20131221140027.GQ21145@sigill.intra.peff.net>
References: <20131221135651.GA20818@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 21 15:00:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VuN6c-0005e2-4u
	for gcvg-git-2@plane.gmane.org; Sat, 21 Dec 2013 15:00:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755487Ab3LUOAa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Dec 2013 09:00:30 -0500
Received: from cloud.peff.net ([50.56.180.127]:48497 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755415Ab3LUOA2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Dec 2013 09:00:28 -0500
Received: (qmail 7533 invoked by uid 102); 21 Dec 2013 14:00:28 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 21 Dec 2013 08:00:28 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 21 Dec 2013 09:00:27 -0500
Content-Disposition: inline
In-Reply-To: <20131221135651.GA20818@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239610>

We ask pack-objects to pack to a set of temporary files, and
then rename them into place. Some files that pack-objects
creates may be optional (like a .bitmap file), in which case
we would not want to call rename(). We already call stat()
and make the chmod optional if the file cannot be accessed.
We could simply skip the rename step in this case, but that
would be a minor regression in noticing problems with
non-optional files (like the .pack and .idx files).

Instead, we can now annotate extensions as optional, and
skip them if they don't exist (and otherwise rely on
rename() to barf).

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/repack.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/builtin/repack.c b/builtin/repack.c
index a176de2..8b7dfd0 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -117,6 +117,7 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 {
 	struct {
 		const char *name;
+		unsigned optional:1;
 	} exts[] = {
 		{".pack"},
 		{".idx"},
@@ -323,6 +324,7 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 		for (ext = 0; ext < ARRAY_SIZE(exts); ext++) {
 			char *fname, *fname_old;
 			struct stat statbuffer;
+			int exists = 0;
 			fname = mkpathdup("%s/pack-%s%s",
 					packdir, item->string, exts[ext].name);
 			fname_old = mkpathdup("%s-%s%s",
@@ -330,9 +332,12 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 			if (!stat(fname_old, &statbuffer)) {
 				statbuffer.st_mode &= ~(S_IWUSR | S_IWGRP | S_IWOTH);
 				chmod(fname_old, statbuffer.st_mode);
+				exists = 1;
+			}
+			if (exists || !exts[ext].optional) {
+				if (rename(fname_old, fname))
+					die_errno(_("renaming '%s' failed"), fname_old);
 			}
-			if (rename(fname_old, fname))
-				die_errno(_("renaming '%s' failed"), fname_old);
 			free(fname);
 			free(fname_old);
 		}
-- 
1.8.5.1.399.g900e7cd
