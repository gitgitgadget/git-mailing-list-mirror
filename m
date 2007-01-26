From: Nicolas Pitre <nico@cam.org>
Subject: [PATCH 3/7] enable separate reflog for HEAD
Date: Fri, 26 Jan 2007 17:26:07 -0500
Message-ID: <11698503712998-git-send-email-nico@cam.org>
References: <1169850371517-git-send-email-nico@cam.org>
 <11698503712588-git-send-email-nico@cam.org>
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, Nicolas Pitre <nico@cam.org>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Fri Jan 26 23:26:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HAZWU-0004Os-Qq
	for gcvg-git@gmane.org; Fri, 26 Jan 2007 23:26:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752159AbXAZW0Q (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 26 Jan 2007 17:26:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751721AbXAZW0P
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Jan 2007 17:26:15 -0500
Received: from relais.videotron.ca ([24.201.245.36]:60997 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752146AbXAZW0N (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Jan 2007 17:26:13 -0500
Received: from localhost.localdomain ([74.56.106.175])
 by VL-MH-MR001.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JCH00AEPYBNA4H0@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Fri, 26 Jan 2007 17:26:12 -0500 (EST)
In-reply-to: <11698503712588-git-send-email-nico@cam.org>
X-Mailer: git-send-email 1.5.0.rc2.g6e2c
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37888>

If HEAD is tied to a branch then both logs/HEAD and logs/heads/<branch> are
updated.  This is also true for any symbolic refs in general, but only HEAD
will see its reflog created automatically.

Signed-off-by: Nicolas Pitre <nico@cam.org>
---
 refs.c |    7 +++++--
 1 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/refs.c b/refs.c
index 9641fad..92fa2e4 100644
--- a/refs.c
+++ b/refs.c
@@ -935,7 +935,8 @@ static int log_ref_write(const char *ref_name, const unsigned char *old_sha1,
 
 	if (log_all_ref_updates &&
 	    (!strncmp(ref_name, "refs/heads/", 11) ||
-	     !strncmp(ref_name, "refs/remotes/", 13))) {
+	     !strncmp(ref_name, "refs/remotes/", 13) ||
+	     !strcmp(ref_name, "HEAD"))) {
 		if (safe_create_leading_directories(log_file) < 0)
 			return error("unable to create directory for %s",
 				     log_file);
@@ -1005,7 +1006,9 @@ int write_ref_sha1(struct ref_lock *lock,
 		return -1;
 	}
 	invalidate_cached_refs();
-	if (log_ref_write(lock->ref_name, lock->old_sha1, sha1, logmsg) < 0) {
+	if (log_ref_write(lock->ref_name, lock->old_sha1, sha1, logmsg) < 0 ||
+	    (strcmp(lock->ref_name, lock->orig_ref_name) &&
+	     log_ref_write(lock->orig_ref_name, lock->old_sha1, sha1, logmsg) < 0)) {
 		unlock_ref(lock);
 		return -1;
 	}
-- 
1.5.0.rc2.g6e2c
