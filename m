From: Sam Vilain <sam.vilain@catalyst.net.nz>
Subject: [PATCH] setup/rev-parse: allow HEAD to be spelled 'head'
Date: Fri,  5 Oct 2007 16:09:10 +1300
Message-ID: <1191553750-25562-1-git-send-email-sam.vilain@catalyst.net.nz>
Cc: Sam Vilain <sam.vilain@catalyst.net.nz>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 05 05:09:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IddZR-0007eZ-QU
	for gcvg-git-2@gmane.org; Fri, 05 Oct 2007 05:09:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751484AbXJEDJP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Oct 2007 23:09:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755306AbXJEDJO
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Oct 2007 23:09:14 -0400
Received: from godel.catalyst.net.nz ([202.78.240.40]:37710 "EHLO
	mail1.catalyst.net.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755062AbXJEDJN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Oct 2007 23:09:13 -0400
Received: from leibniz.catalyst.net.nz ([202.78.240.7] helo=wilber.wgtn.cat-it.co.nz)
	by mail1.catalyst.net.nz with esmtp (Exim 4.63)
	(envelope-from <samv@wilber.wgtn.cat-it.co.nz>)
	id 1IddYs-0001gm-9p; Fri, 05 Oct 2007 16:09:10 +1300
Received: by wilber.wgtn.cat-it.co.nz (Postfix, from userid 1000)
	id 3FABB20033; Fri,  5 Oct 2007 16:09:10 +1300 (NZDT)
X-Mailer: git-send-email 1.5.3.2.3.g2f2dcc-dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60032>

If the repository got mangled by FAT capitalization rules, then a ref
such as "HEAD" will become "head" once it is back on a non-FAT FS.
Check for this condition in resolve_refs and in the setup code.

Suggested-by: Francois Marier <francois@debian.org>
Signed-off-by: Sam Vilain <sam.vilain@catalyst.net.nz>
---
  This should probably help people putting their git repos on
  FAT USB sticks.

 refs.c  |   28 ++++++++++++++++++++++++----
 setup.c |    7 +++++--
 2 files changed, 29 insertions(+), 6 deletions(-)

diff --git a/refs.c b/refs.c
index 09a2c87..89ffb15 100644
--- a/refs.c
+++ b/refs.c
@@ -400,10 +400,30 @@ const char *resolve_ref(const char *ref, unsigned char *sha1, int reading, int *
 				}
 				list = list->next;
 			}
-			if (reading || errno != ENOENT)
-				return NULL;
-			hashclr(sha1);
-			return ref;
+			if (reading || errno != ENOENT) {
+				/*
+				 * Hack for FAT-mangled ref filenames
+				 */
+				if (strlen(ref) <= 8) {
+					char lc_name[9];
+					char* i;
+					strncpy(&lc_name, ref, 9);
+					for (i = lc_name; *i; i++) {
+						*i = tolower(*i);
+					}
+					path = git_path("%s", lc_name);
+					if (lstat(path, &st) < 0) {
+						return NULL;
+					}
+				}
+				else {
+					return NULL;
+				}
+			}
+			else {
+				hashclr(sha1);
+				return ref;
+			}
 		}
 
 		/* Follow "normalized" - ie "refs/.." symlinks by hand */
diff --git a/setup.c b/setup.c
index 06004f1..284d7b9 100644
--- a/setup.c
+++ b/setup.c
@@ -168,8 +168,11 @@ static int is_git_directory(const char *suspect)
 		return 0;
 
 	strcpy(path + len, "/HEAD");
-	if (validate_headref(path))
-		return 0;
+	if (validate_headref(path)) {
+		strcpy(path + len, "/head");
+		if (validate_headref(path))
+			return 0;
+	}
 
 	return 1;
 }
-- 
1.5.3.2.3.g2f2dcc-dirty
