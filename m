From: Josh Micich <josh.micich@gmail.com>
Subject: [PATCH 3/3] improved validation of entry type in mktree
Date: Thu, 14 May 2009 05:11:20 +0000 (UTC)
Message-ID: <loom.20090514T051052-920@post.gmane.org>
References: <loom.20090514T050424-673@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 14 07:15:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M4THq-0005Ca-PK
	for gcvg-git-2@gmane.org; Thu, 14 May 2009 07:15:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753450AbZENFPL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 May 2009 01:15:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753434AbZENFPK
	(ORCPT <rfc822;git-outgoing>); Thu, 14 May 2009 01:15:10 -0400
Received: from main.gmane.org ([80.91.229.2]:44607 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751058AbZENFPI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 May 2009 01:15:08 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1M4THa-0006ty-Op
	for git@vger.kernel.org; Thu, 14 May 2009 05:15:02 +0000
Received: from adsl-69-104-91-41.dsl.pltn13.pacbell.net ([69.104.91.41])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 14 May 2009 05:15:02 +0000
Received: from josh.micich by adsl-69-104-91-41.dsl.pltn13.pacbell.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 14 May 2009 05:15:02 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 69.104.91.41 (Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US) AppleWebKit/525.19 (KHTML, like Gecko) Chrome/1.0.154.65 Safari/525.19)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119138>

Previously mktree would accept tree entries which had a mismatch between the 
declared type and the actual type of object identified by the sha.

Signed-off-by: Josh Micich <josh.micich@gmail.com>
---
 builtin-mktree.c |   34 +++++++++++++++++++++-------------
 1 files changed, 21 insertions(+), 13 deletions(-)

diff --git a/builtin-mktree.c b/builtin-mktree.c
index a56c917..a37954a 100644
--- a/builtin-mktree.c
+++ b/builtin-mktree.c
@@ -71,7 +71,7 @@ static void mktree_line(char *buf, size_t len, int 
line_termination, int allow_m
 {
 	char *ptr, *ntr;
 	unsigned mode;
-	enum object_type type;
+	enum object_type mode_type;
 	char *path;
 	unsigned char sha1[20];
 
@@ -94,29 +94,37 @@ static void mktree_line(char *buf, size_t len, int 
line_termination, int allow_m
 	if (S_ISGITLINK(mode))
 		allow_missing = 1;
 
-	if (!allow_missing)
-		type = sha1_object_info(sha1, NULL);
-	else
-		type = object_type(mode);
-
-	if (type < 0)
-		die("object %s unavailable", sha1_to_hex(sha1));
 
 	*ntr++ = 0; /* now at the beginning of SHA1 */
-	if (type != type_from_string(ptr))
-		die("object type %s mismatch (%s)", ptr, typename(type));
 
 	path = ntr + 41;  /* at the beginning of name */
+	struct strbuf p_uq = STRBUF_INIT;
 	if (line_termination && path[0] == '"') {
-		struct strbuf p_uq = STRBUF_INIT;
 		if (unquote_c_style(&p_uq, path, NULL))
 			die("invalid quoting");
 		path = strbuf_detach(&p_uq, NULL);
 		append_to_tree(mode, sha1, path);
-		strbuf_release(&p_uq);
-		return;
 	}
+
+	mode_type = object_type(mode);
+	if (mode_type != type_from_string(ptr)) {
+		die("entry '%s' object type (%s) doesn't match mode type (%s)", 
path, ptr, typename(mode_type));
+	}
+
+	enum object_type obj_type = sha1_object_info(sha1, NULL);
+	if (obj_type < 0) {
+		if (!allow_missing) {
+			die("entry '%s' object %s is unavailable", path, 
sha1_to_hex(sha1));
+		}
+	} else {
+		if (obj_type != mode_type) {
+			die("entry '%s' object %s is a %s but specified type 
was (%s)",
+				path, sha1_to_hex(sha1), typename(obj_type), 
typename(mode_type));
+		}
+	}
+	
 	append_to_tree(mode, sha1, path);
+	strbuf_release(&p_uq); // safe to call on unused empty buffer
 }
 
 int cmd_mktree(int ac, const char **av, const char *prefix)
-- 
1.6.3.165.g2cce5.dirty
