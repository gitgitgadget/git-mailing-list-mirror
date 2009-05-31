From: Clemens Buchacher <drizzd@aon.at>
Subject: [PATCH] http-push: reuse existing is_null_ref
Date: Sun, 31 May 2009 12:36:10 +0200
Message-ID: <20090531103610.GA7913@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Tay Ray Chuan <rctay89@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun May 31 12:36:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MAiP8-00087Y-CV
	for gcvg-git-2@gmane.org; Sun, 31 May 2009 12:36:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756545AbZEaKg2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 May 2009 06:36:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755989AbZEaKg2
	(ORCPT <rfc822;git-outgoing>); Sun, 31 May 2009 06:36:28 -0400
Received: from postman.fh-hagenberg.at ([193.170.124.96]:8538 "EHLO
	mail.fh-hagenberg.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751737AbZEaKg1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 May 2009 06:36:27 -0400
Received: from darc.dnsalias.org ([80.123.242.182]) by mail.fh-hagenberg.at over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Sun, 31 May 2009 12:36:27 +0200
Received: from drizzd by darc.dnsalias.org with local (Exim 4.69)
	(envelope-from <drizzd@aon.at>)
	id 1MAiOg-0001r2-Nu; Sun, 31 May 2009 12:36:10 +0200
Content-Disposition: inline
User-Agent: Mutt/1.5.18 (2008-05-17)
X-OriginalArrivalTime: 31 May 2009 10:36:27.0377 (UTC) FILETIME=[A7110E10:01C9E1DB]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120395>

Signed-off-by: Clemens Buchacher <drizzd@aon.at>
---

While we're at it, here's a trivial cleanup for http-push. Applies to both
master and pu.

Clemens

 http-push.c |   21 +++++----------------
 1 files changed, 5 insertions(+), 16 deletions(-)

diff --git a/http-push.c b/http-push.c
index 45e8a69..43e2dda 100644
--- a/http-push.c
+++ b/http-push.c
@@ -1884,17 +1884,6 @@ static void get_dav_remote_heads(void)
 	remote_ls("refs/", (PROCESS_FILES | PROCESS_DIRS | RECURSIVE), process_ls_ref, NULL);
 }
 
-static int is_zero_sha1(const unsigned char *sha1)
-{
-	int i;
-
-	for (i = 0; i < 20; i++) {
-		if (*sha1++)
-			return 0;
-	}
-	return 1;
-}
-
 static void add_remote_info_ref(struct remote_ls_ctx *ls)
 {
 	struct strbuf *buf = (struct strbuf *)ls->userData;
@@ -2120,13 +2109,13 @@ static int delete_remote_branch(char *pattern, int force)
 		/* Remote HEAD must resolve to a known object */
 		if (symref)
 			return error("Remote HEAD symrefs too deep");
-		if (is_zero_sha1(head_sha1))
+		if (is_null_sha1(head_sha1))
 			return error("Unable to resolve remote HEAD");
 		if (!has_sha1_file(head_sha1))
 			return error("Remote HEAD resolves to object %s\nwhich does not exist locally, perhaps you need to fetch?", sha1_to_hex(head_sha1));
 
 		/* Remote branch must resolve to a known object */
-		if (is_zero_sha1(remote_ref->old_sha1))
+		if (is_null_sha1(remote_ref->old_sha1))
 			return error("Unable to resolve remote branch %s",
 				     remote_ref->name);
 		if (!has_sha1_file(remote_ref->old_sha1))
@@ -2334,7 +2323,7 @@ int main(int argc, char **argv)
 		if (!ref->peer_ref)
 			continue;
 
-		if (is_zero_sha1(ref->peer_ref->new_sha1)) {
+		if (is_null_sha1(ref->peer_ref->new_sha1)) {
 			if (delete_remote_branch(ref->name, 1) == -1) {
 				error("Could not remove %s", ref->name);
 				rc = -4;
@@ -2350,7 +2339,7 @@ int main(int argc, char **argv)
 		}
 
 		if (!force_all &&
-		    !is_zero_sha1(ref->old_sha1) &&
+		    !is_null_sha1(ref->old_sha1) &&
 		    !ref->force) {
 			if (!has_sha1_file(ref->old_sha1) ||
 			    !ref_newer(ref->peer_ref->new_sha1,
@@ -2400,7 +2389,7 @@ int main(int argc, char **argv)
 		old_sha1_hex = NULL;
 		commit_argv[1] = "--objects";
 		commit_argv[2] = new_sha1_hex;
-		if (!push_all && !is_zero_sha1(ref->old_sha1)) {
+		if (!push_all && !is_null_sha1(ref->old_sha1)) {
 			old_sha1_hex = xmalloc(42);
 			sprintf(old_sha1_hex, "^%s",
 				sha1_to_hex(ref->old_sha1));
-- 
1.6.3.1.147.g637c3
