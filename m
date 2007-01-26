From: Nicolas Pitre <nico@cam.org>
Subject: [PATCH 2/7] lock_ref_sha1_basic(): remember the original name of a ref
 when resolving it
Date: Fri, 26 Jan 2007 17:26:06 -0500
Message-ID: <11698503712588-git-send-email-nico@cam.org>
References: <1169850371517-git-send-email-nico@cam.org>
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, Nicolas Pitre <nico@cam.org>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Fri Jan 26 23:26:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HAZWU-0004Os-9w
	for gcvg-git@gmane.org; Fri, 26 Jan 2007 23:26:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751720AbXAZW0O (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 26 Jan 2007 17:26:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751721AbXAZW0O
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Jan 2007 17:26:14 -0500
Received: from relais.videotron.ca ([24.201.245.36]:60997 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751719AbXAZW0N (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Jan 2007 17:26:13 -0500
Received: from localhost.localdomain ([74.56.106.175])
 by VL-MH-MR001.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JCH00AEPYBNA4H0@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Fri, 26 Jan 2007 17:26:11 -0500 (EST)
In-reply-to: <1169850371517-git-send-email-nico@cam.org>
X-Mailer: git-send-email 1.5.0.rc2.g6e2c
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37889>

A ref might be pointing to another ref but only the name of the last ref
is remembered.  Let's remember about the first name as well.

Signed-off-by: Nicolas Pitre <nico@cam.org>
---
 refs.c |    2 ++
 refs.h |    1 +
 2 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/refs.c b/refs.c
index 9395677..9641fad 100644
--- a/refs.c
+++ b/refs.c
@@ -676,6 +676,7 @@ static struct ref_lock *lock_ref_sha1_basic(const char *ref, const unsigned char
 	lock->lk = xcalloc(1, sizeof(struct lock_file));
 
 	lock->ref_name = xstrdup(ref);
+	lock->orig_ref_name = xstrdup(orig_ref);
 	ref_file = git_path("%s", ref);
 	lock->force_write = lstat(ref_file, &st) && errno == ENOENT;
 
@@ -915,6 +916,7 @@ void unlock_ref(struct ref_lock *lock)
 			rollback_lock_file(lock->lk);
 	}
 	free(lock->ref_name);
+	free(lock->orig_ref_name);
 	free(lock);
 }
 
diff --git a/refs.h b/refs.h
index 2d2ba14..94a58b4 100644
--- a/refs.h
+++ b/refs.h
@@ -3,6 +3,7 @@
 
 struct ref_lock {
 	char *ref_name;
+	char *orig_ref_name;
 	struct lock_file *lk;
 	unsigned char old_sha1[20];
 	int lock_fd;
-- 
1.5.0.rc2.g6e2c
