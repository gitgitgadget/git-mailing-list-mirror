From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH] notes_merge_commit(): do not pass temporary buffer to other function
Date: Tue, 27 Sep 2011 06:46:53 +0200
Message-ID: <1317098813-30839-1-git-send-email-mhagger@alum.mit.edu>
Cc: Johan Herland <johan@herland.net>,
	Junio C Hamano <gitster@pobox.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 27 06:47:12 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R8PZY-00023F-A6
	for gcvg-git-2@lo.gmane.org; Tue, 27 Sep 2011 06:47:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752134Ab1I0ErH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Sep 2011 00:47:07 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:58905 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751861Ab1I0ErF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Sep 2011 00:47:05 -0400
X-Envelope-From: mhagger@alum.mit.edu
Received: from michael.fritz.box (p54BEB231.dip.t-dialin.net [84.190.178.49])
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id p8R4kxEJ024061;
	Tue, 27 Sep 2011 06:46:59 +0200
X-Mailer: git-send-email 1.7.7.rc2
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182212>

It is unsafe to pass a temporary buffer as an argument to
read_directory().

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---

I discovered this problem when an innocent modification to unrelated
code triggered test failures.

 notes-merge.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git notes-merge.c notes-merge.c
index e1aaf43..baaf31f 100644
--- notes-merge.c
+++ notes-merge.c
@@ -680,7 +680,7 @@ int notes_merge_commit(struct notes_merge_options *o,
 	 * Finally store the new commit object SHA1 into 'result_sha1'.
 	 */
 	struct dir_struct dir;
-	const char *path = git_path(NOTES_MERGE_WORKTREE "/");
+	char *path = xstrdup(git_path(NOTES_MERGE_WORKTREE "/"));
 	int path_len = strlen(path), i;
 	const char *msg = strstr(partial_commit->buffer, "\n\n");
 
@@ -720,6 +720,7 @@ int notes_merge_commit(struct notes_merge_options *o,
 			    result_sha1);
 	OUTPUT(o, 4, "Finalized notes merge commit: %s",
 	       sha1_to_hex(result_sha1));
+	free(path);
 	return 0;
 }
 
-- 
1.7.7.rc2
