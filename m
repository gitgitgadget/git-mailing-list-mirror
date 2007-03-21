From: Nicolas Pitre <nico@cam.org>
Subject: [PATCH] update HEAD reflog when branch pointed to by HEAD is directly
 modified
Date: Wed, 21 Mar 2007 17:11:44 -0400 (EDT)
Message-ID: <alpine.LFD.0.83.0703211650360.18328@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Wed Mar 21 22:12:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HU86G-0002Te-NQ
	for gcvg-git@gmane.org; Wed, 21 Mar 2007 22:12:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964983AbXCUVLq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 21 Mar 2007 17:11:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965013AbXCUVLq
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Mar 2007 17:11:46 -0400
Received: from relais.videotron.ca ([24.201.245.36]:12237 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964983AbXCUVLp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Mar 2007 17:11:45 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JF9008VGUVKQH70@VL-MH-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 21 Mar 2007 17:11:44 -0400 (EDT)
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42817>

The HEAD reflog is updated as well as the reflog for the branch pointed 
to by HEAD whenever it is referenced with "HEAD".

There are some cases where a specific branch may be modified directly.  
In those cases, the HEAD reflog should be updated as well if it is a 
symref to that branch in order to be consistent.

Signed-off-by: Nicolas Pitre <nico@cam.org>
---

diff --git a/refs.c b/refs.c
index 9f1fb68..435eeca 100644
--- a/refs.c
+++ b/refs.c
@@ -980,6 +980,27 @@ int write_ref_sha1(struct ref_lock *lock,
 		unlock_ref(lock);
 		return -1;
 	}
+	if (strcmp(lock->orig_ref_name, "HEAD") != 0) {
+		/*
+		 * Special hack: If a branch is updated directly and HEAD
+		 * points to it (may happen on the remote side of a push
+		 * for example) then logically the HEAD reflog should be
+		 * updated too. 
+		 * A generic solution implies reverse symref information, 
+		 * but finding all symrefs pointing to the given branch
+		 * would be rather costly for this rare event (the direct
+		 * update of a branch) to be worth it.  So let's cheat and
+		 * check with HEAD only which should cover 99% of all usage
+		 * scenarios (even 100% of the default ones).
+		 */
+		unsigned char head_sha1[20];
+		int head_flag;
+		const char *head_ref;
+		head_ref = resolve_ref("HEAD", head_sha1, 1, &head_flag);
+		if (head_ref && (head_flag & REF_ISSYMREF) &&
+		    !strcmp(head_ref, lock->ref_name))
+			log_ref_write("HEAD", lock->old_sha1, sha1, logmsg);
+	}
 	if (commit_lock_file(lock->lk)) {
 		error("Couldn't set %s", lock->ref_name);
 		unlock_ref(lock);
