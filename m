From: Jim Meyering <jim@meyering.net>
Subject: [PATCH] fast-import: Don't use a maybe-clobbered errno value
Date: Fri, 18 Jan 2008 19:35:49 +0100
Message-ID: <8763xrgewq.fsf@rho.meyering.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jan 18 19:37:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JFw5i-0007RS-5H
	for gcvg-git-2@gmane.org; Fri, 18 Jan 2008 19:37:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764649AbYARSf4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Jan 2008 13:35:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763597AbYARSfy
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Jan 2008 13:35:54 -0500
Received: from smtp3-g19.free.fr ([212.27.42.29]:57427 "EHLO smtp3-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1764569AbYARSfv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Jan 2008 13:35:51 -0500
Received: from smtp3-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp3-g19.free.fr (Postfix) with ESMTP id BD79017B5B2
	for <git@vger.kernel.org>; Fri, 18 Jan 2008 19:35:49 +0100 (CET)
Received: from mx.meyering.net (mx.meyering.net [82.230.74.64])
	by smtp3-g19.free.fr (Postfix) with ESMTP id 851BC17B5D2
	for <git@vger.kernel.org>; Fri, 18 Jan 2008 19:35:49 +0100 (CET)
Received: from rho.meyering.net (localhost.localdomain [127.0.0.1])
	by rho.meyering.net (Acme Bit-Twister) with ESMTP id 41A5A3470A
	for <git@vger.kernel.org>; Fri, 18 Jan 2008 19:35:49 +0100 (CET)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71047>


Without this change, each diagnostic could use an errno value
clobbered by the close or unlink in rollback_lock_file.

Signed-off-by: Jim Meyering <meyering@redhat.com>
---
 fast-import.c |    9 ++++++---
 1 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/fast-import.c b/fast-import.c
index 5e89eef..45b4edf 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -1541,9 +1541,10 @@ static void dump_marks(void)

 	f = fdopen(mark_fd, "w");
 	if (!f) {
+		int saved_errno = errno;
 		rollback_lock_file(&mark_lock);
 		failure |= error("Unable to write marks file %s: %s",
-			mark_file, strerror(errno));
+			mark_file, strerror(saved_errno));
 		return;
 	}

@@ -1556,16 +1557,18 @@ static void dump_marks(void)

 	dump_marks_helper(f, 0, marks);
 	if (ferror(f) || fclose(f)) {
+		int saved_errno = errno;
 		rollback_lock_file(&mark_lock);
 		failure |= error("Unable to write marks file %s: %s",
-			mark_file, strerror(errno));
+			mark_file, strerror(saved_errno));
 		return;
 	}

 	if (commit_lock_file(&mark_lock)) {
+		int saved_errno = errno;
 		rollback_lock_file(&mark_lock);
 		failure |= error("Unable to commit marks file %s: %s",
-			mark_file, strerror(errno));
+			mark_file, strerror(saved_errno));
 		return;
 	}
 }
--
1.5.4.rc3.31.g669237
