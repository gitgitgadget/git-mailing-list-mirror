From: Jeff King <peff@peff.net>
Subject: [PATCH v3 16/21] repack: handle optional files created by
 pack-objects
Date: Thu, 14 Nov 2013 07:46:05 -0500
Message-ID: <20131114124605.GP10757@sigill.intra.peff.net>
References: <20131114124157.GA23784@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Vicent =?utf-8?B?TWFydMOt?= <vicent@github.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 14 13:46:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VgwJL-0001bU-02
	for gcvg-git-2@plane.gmane.org; Thu, 14 Nov 2013 13:46:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753986Ab3KNMqH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Nov 2013 07:46:07 -0500
Received: from cloud.peff.net ([50.56.180.127]:39146 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753559Ab3KNMqG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Nov 2013 07:46:06 -0500
Received: (qmail 11652 invoked by uid 102); 14 Nov 2013 12:46:06 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 14 Nov 2013 06:46:06 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 14 Nov 2013 07:46:05 -0500
Content-Disposition: inline
In-Reply-To: <20131114124157.GA23784@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237840>

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
1.8.5.rc0.443.g2df7f3f
