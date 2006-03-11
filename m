From: Nick Hengeveld <nickh@reactrix.com>
Subject: [PATCH 1/6] http-push: fix revision walk
Date: Fri, 10 Mar 2006 20:17:55 -0800
Message-ID: <20060311041755.GC3997@reactrix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sat Mar 11 05:18:15 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FHvYQ-0004ss-BT
	for gcvg-git@gmane.org; Sat, 11 Mar 2006 05:18:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932398AbWCKER5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 10 Mar 2006 23:17:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932392AbWCKER5
	(ORCPT <rfc822;git-outgoing>); Fri, 10 Mar 2006 23:17:57 -0500
Received: from 193.37.26.69.virtela.com ([69.26.37.193]:57806 "EHLO
	teapot.corp.reactrix.com") by vger.kernel.org with ESMTP
	id S1752340AbWCKER4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Mar 2006 23:17:56 -0500
Received: from teapot.corp.reactrix.com (localhost.localdomain [127.0.0.1])
	by teapot.corp.reactrix.com (8.12.11/8.12.11) with ESMTP id k2B4HtTB007626
	for <git@vger.kernel.org>; Fri, 10 Mar 2006 20:17:55 -0800
Received: (from nickh@localhost)
	by teapot.corp.reactrix.com (8.12.11/8.12.11/Submit) id k2B4HtGp007624
	for git@vger.kernel.org; Fri, 10 Mar 2006 20:17:55 -0800
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17488>

The revision walk was not including tags because setup_revisions zeroes out
the revs flags.  Pass --objects so it picks up all the necessary bits.

---

 http-push.c |   13 +++++--------
 1 files changed, 5 insertions(+), 8 deletions(-)

4bff87736bfc51313e7e23ebd9b99bc476c00616
diff --git a/http-push.c b/http-push.c
index 226d719..4c1b0c3 100644
--- a/http-push.c
+++ b/http-push.c
@@ -1752,23 +1752,20 @@ int main(int argc, char **argv)
 		}
 
 		/* Set up revision info for this refspec */
-		const char *commit_argv[3];
-		int commit_argc = 2;
+		const char *commit_argv[4];
+		int commit_argc = 3;
 		char *new_sha1_hex = strdup(sha1_to_hex(ref->new_sha1));
 		char *old_sha1_hex = NULL;
-		commit_argv[1] = new_sha1_hex;
+		commit_argv[1] = "--objects";
+		commit_argv[2] = new_sha1_hex;
 		if (!push_all && !is_zero_sha1(ref->old_sha1)) {
 			old_sha1_hex = xmalloc(42);
 			sprintf(old_sha1_hex, "^%s",
 				sha1_to_hex(ref->old_sha1));
-			commit_argv[2] = old_sha1_hex;
+			commit_argv[3] = old_sha1_hex;
 			commit_argc++;
 		}
-		revs.commits = NULL;
 		setup_revisions(commit_argc, commit_argv, &revs, NULL);
-		revs.tag_objects = 1;
-		revs.tree_objects = 1;
-		revs.blob_objects = 1;
 		free(new_sha1_hex);
 		if (old_sha1_hex) {
 			free(old_sha1_hex);
-- 
1.2.4.g8e81-dirty
